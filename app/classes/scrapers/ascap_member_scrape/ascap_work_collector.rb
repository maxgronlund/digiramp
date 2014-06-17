class Scraper::AscapMemberScrape::AscapWorkCollector
  attr_reader :html_work_tbodies, :html_work_detail_tbodies
  def initialize browser
    @browser = browser
  end
  
  def get_works
    @html_work_tbodies = []
    collect_works
    while next_page_button.exist?
      next_page_button.click
      collect_works
    end
    @html_work_tbodies
  end
  
  def get_work_details block
    @block = block
    @html_work_detail_tbodies = []
    first_page_button.click if first_page_button.exist?
    #collect_row_info get_work_rows[0] # I use this one for lazy debugging
    collect_work_data_details
    while next_page_button.exist?
      next_page_button.click
      collect_work_data_details
    end
    @html_work_detail_tbodies
  end
  
private
  
  def collect_works
    @html_work_tbodies << work_tbody_element.html
  end
  
  def work_tbody_element
    @browser.span(:text, 'Work Title').daisy_chain :parent, times: 7
  end
  
  def next_page_button
    @browser.img(:alt, "Next")
  end
  
  def first_page_button
    @browser.img(:alt, "First")
  end
  
  def collect_work_data_details
    _index = 0
    rows = get_works_rows
    
    until _index >= rows.length
      collect_row_info rows[_index]
      _index += 1
      rows = get_works_rows
    end
  end
  
  def collect_row_info row
    if row.trs[1].a.exist?
      row.trs[1].a.click
      details = {}
      details[:share_list] = share_list_tbody_element.html if share_list_tbody_element.exist?
      if @browser.img(:alt, 'Details').parent.tag_name == "a"
        @browser.img(:alt, 'Details').parent.click
        details[:details] = details_tbody_element.html rescue nil
      end
      if @browser.img(:name, 'PerformOther').parent.tag_name == "a"
        @browser.img(:name, 'PerformOther').parent.click
        details[:other] = other_tbody_element.html rescue nil
      end
      back_to_list_button.click
      
      unless details.values_all_contain_nothing?
        @block.call html_work_detail_tbodies: details if @block
        @html_work_detail_tbodies << details
      end
    end
  ensure
    back_to_list_button.click if @browser.img(:alt, "Back to List").exist?
  end
  
  def get_works_rows
    work_tbody_element.rows.to_a.all_except_first
  end
  
  def share_list_tbody_element
    @browser.span(:text, "Interested Party").daisy_chain :parent, times: 15
  end
  
  def details_tbody_element
    @browser.span(:text, 'Work Details').daisy_chain :parent, times: 11
  end
  
  def other_tbody_element
    @browser.span(:text, 'Performers').daisy_chain :parent, times: 11
  end
  
  def back_to_list_button
    @browser.img(:alt, "Back to List").parent
  end
end