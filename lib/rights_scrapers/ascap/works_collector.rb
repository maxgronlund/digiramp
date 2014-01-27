require_relative '../../daisy_chain'
require_relative '../../all_except'
require_relative '../../contains_nothing'

class Ascap::WorksCollector
  
  def Ascap::WorksCollector browser, &block
    @instance = Ascap::WorksCollector.new browser
    html_work_detail_tbodies = @instance.get_work_details block
    html_work_detail_tbodies
  end
  
  def initialize browser
    @browser = browser
  end
  
  def get_work_details block
    @block = block
    
    first_page
    collect_work_data_details
    collect_work_data_details while next_page_button.exist? and next_page_button.click    
  end
  
private
  
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
    link = work_link_from(row)
    if link.exist?
      link.click
      raw_details = {}
      raw_details[:share_list] = share_list_tbody_element.html if share_list_tbody_element.exist?
      raw_details[:details] = details_details
      raw_details[:other]   = details_other
      raw_details[:recording_info] = details_recording
      back_to_list
      yield_details raw_details
    end
  ensure
    back_to_list
  end
  
  def work_link_from row
    row.trs[1].a
  end
  
  def get_works_rows
    work_tbody_element.rows.to_a.all_except_first
  end
  
  def first_page;   first_page_button   .click  if first_page_button                  .exist?   end
  def back_to_list; back_to_list_button .click  if @browser.img(:alt, "Back to List") .exist?   end
  
  def next_page_button;     @browser.img(:alt, "Next")                  end
  def first_page_button;    @browser.img(:alt, "First")                 end
  def back_to_list_button;  @browser.img(:alt, "Back to List").parent   end
  
  def details_details
    if @browser.img(:alt, 'Details').parent.tag_name == "a"
      @browser.img(:alt, 'Details').parent.click
      return details_tbody_element.html rescue nil
    end
  end
  
  def details_other
    if @browser.img(:name, 'PerformOther').parent.tag_name == "a"
      @browser.img( :name, 'PerformOther').parent.click
      return other_tbody_element.html rescue nil
    end
  end
  
  def details_recording
    if @browser.img(:name, 'InstrDur').parent.tag_name == "a"
      @browser.img( :name, 'InstrDur').parent.click
      return recording_tbody_element.html rescue nil
    end
  end
  
  def yield_details raw_details
    unless raw_details.values_all_contain_nothing?
      @block.call Ascap::WorkTbodyParser(raw_details) if @block
    end
  end
  
  def work_tbody_element;       @browser.span(:text, 'Work Title')        .daisy_chain :parent, times: 7    end
  def share_list_tbody_element; @browser.span(:text, "Interested Party")  .daisy_chain :parent, times: 15   end
  def details_tbody_element;    @browser.span(:text, 'Work Details')      .daisy_chain :parent, times: 11   end
  def other_tbody_element;      @browser.span(:text, 'Performers')        .daisy_chain :parent, times: 11   end
  def recording_tbody_element;  @browser.span(:text, 'Duration')          .daisy_chain :parent, times: 3    end
  
end