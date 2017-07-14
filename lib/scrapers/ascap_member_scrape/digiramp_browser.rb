require 'watir'
require 'watir-webdriver'
#require 'headless'

class Scraper::AscapMemberScrape::DigirampBrowser

  def initialize url=nil
    @rails_in_production = Rails.env.production? rescue false
    go_headless if @rails_in_production
    @profile = Selenium::WebDriver::Firefox::Profile.new
    @client = Selenium::WebDriver::Remote::Http::Default.new
    @client.timeout = 180 # seconds – default is 60
    @browser = url ? create_browser_with_url(url) : create_browser
  end

  def method_missing *args
    @browser.send *args
  end

  def close
    @browser.close
    @headless.destroy if @headless
  end


private


  def go_headless
    @headless = Headless.new
    @headless.start
  end

  def create_browser_with_url url;  Watir::Browser.start url, :firefox, profile: @profile, http_client: @client   end
  def create_browser;               Watir::Browser.new        :firefox, profile: @profile, http_client: @client   end
end