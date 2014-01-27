require 'mechanize'
require_relative 'writer_request'

class Scraper::BmiScraper::WriterFormBot < Scraper::BmiScraper::WriterRequest  
  def initialize name
    @agent = Mechanize.new
    @name = name
  end
  
  def start
    get_form "http://repertoire.bmi.com/startpage.asp"
    fill_form @name
    submit_form
    #display_results
  end
  
  def get_form url
    @search_page = @agent.get url
    @form = @search_page.form
  end
  
  def fill_form name
    search_type "writer"
    search_for name
  end
  
  def search_type type
    @form.field_with(name: "TypeofSearch").options.find{|o| o.to_s == type}.select
  end
  
  def search_for text
    @form.field_with(name: "SearchFor").value = text
  end
  
  def submit_form
    @page = @form.submit
    accept_terms_and_conditions
  end
end