require_relative '../web_browser'

class BMIMemberWorkCollect
  class UnableToLoginError < RuntimeError; end
  class VerifyEmailError < UnableToLoginError; end
  class InvalidUsernameOrPasswordError < UnableToLoginError; end
  class ErrorBoxPopupError < RuntimeError; end
  
    
  def self.scrape username, password, &block
    @collector = BMIMemberWorkCollect.new
    @collector.login username, password, &block
    @collector.check_is_multipage &block
  ensure
    @collector.close
  end
  
  attr_reader :works
  
  def login username, password
    @browser = WebBrowser.open url: "https://applications.bmi.com/security/Login.aspx"
    @browser.text_field(id: "txtUserName").set username
    @browser.text_field(id: "txtPassword").set password
    @browser.checkbox(id: "checkBoxDisclaimer").set true
    @browser.button(id: "btnLogin").click
    raise InvalidUsernameOrPassword if @browser.text.include? "Invalid Username/Password"
    raise VerifyEmailError if @browser.text.include? "Please confirm the email address"
    @browser.a(text: "Works Catalog").click  
  end

  def check_is_multipage &block
    @works = {}
    
    if @browser.select_list(id: "ddlAccts").exist?
      @works = {}
      
      options.length.times do |i|
        options[i].select
        @current_catalog_name = options[i].text
        @works[@current_catalog_name] = collect! &block
      end
    else
      @works["Main catalog"] = collect! &block
    end
    
    @works
    #works_count = @browser.span(id: "lbCount").text.split(':').last.to_s.strip.to_i
    #actual_works_on_page = @browser.table(id: "tblWorks").trs.length
    #raise "Count doesn't match amount of works on page! Implement paginate bot here." if works_count != actual_works_on_page #!!!
  end
  
  def options
    @browser.select_list(id: "ddlAccts").options.to_a.reject { |option| option.text.match /Please Select|Search All Accounts/i }
  end
  
  def close
    @browser.close if @browser
  end
  
  def collect! &block
    works = []
    @browser.table(id: "tblWorks").trs.each do |tr|
      open_work_tr tr
      
      @writers = []
      @publishers = []
      
      get_ipis(:writers)
      get_ipis(:publishers)
      
      work = {
        title:              get_work_title,
        bmi_work_id:        get_bmi_work_id,
        registration_date:  get_registration_date,
        iswc:               get_iswc,
        registration_origin: get_registration_origin,
        writers:            @writers,
        publishers:         @publishers
      }
      wrapped_work = {catalog: @current_catalog_name, work: work}
      yield wrapped_work if block_given?
      works << work
    end
    works
  end

  #def open_work_index index
  #  tr = @browser.table(id: "tblWorks").trs[index]
  #  open_work_tr tr
  #end

  def open_work_tr tr
    bmi_work_id = tr.tds[2].text
    tr.a(class: "titleList").click
    @browser.div(id: "detailsdiv").wait_until_present
    Watir::Wait.until {
      raise ErrorBoxPopupError if @browser.div(id: "divError").present?
      get_bmi_work_id  == bmi_work_id
    }
  end
  
  def get_registration_origin
    @browser.span(id: "lbRegType").text
  end

  def get_work_title
    @browser.span(id: "lbWorkTitle").text
  end

  def get_bmi_work_id
    @browser.span(id: "lbWorkNo").text
  end

  def get_registration_date
    @browser.span(id: "lbdatereg").text
  end

  def get_iswc
    @browser.span(id: "lbISWC").text
  end

  def get_ipis type, start_index=nil
    case type
    when :writers;    id = "tblWriters"; ipis = @writers
    when :publishers; id = "tblPubs"   ; ipis = @publishers
    end
  
    
    trs = @browser.table(id: id).trs.to_a
    trs = trs[start_index..-1] if start_index
    @tr_index = nil
    @ipis ||= []
    
    trs.each_with_index do |tr, tr_index|
      @tr_index = tr_index
      ipi = tr.tds.map &:text
      @ipis << {name: ipi[0], society: ipi[1], share: ipi[2], ipi_number: ipi[3]}
    end
    
    ipis.push *@ipis
    result = @ipis
    @ipis = nil
    return result
  rescue Selenium::WebDriver::Error::StaleElementReferenceError
    if @tr_index
      return get_ipis type, @tr_index
    else
      raise
    end
  end
end