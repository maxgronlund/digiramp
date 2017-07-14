require 'watir-webdriver'

class WebBrowser

  def initialize url: nil, browser: :firefox
    @rails_in_production = Rails.env.production? rescue false
    go_headless if @rails_in_production
    @profile = Selenium::WebDriver::Firefox::Profile.new
    @client  = Selenium::WebDriver::Remote::Http::Default.new
    @client.timeout = 180 # seconds – default is 60
    @browser = url ? create_browser_with_url(browser, url) : create_browser(browser)
    at_exit { close }
  end

  def method_missing method_name, *args
    if @browser.respond_to? method_name
      @browser.public_send method_name, *args
    else
      super method_name, *args
    end
  end

  def close
    @browser.close
    @headless.destroy if @headless
  end

  class << self
    alias open new
  end


private


  def go_headless
    @headless = Headless.new
    @headless.start
  end

  def create_browser_with_url browser, url; Watir::Browser.start url, browser, profile: @profile, http_client: @client  end
  def create_browser          browser;      Watir::Browser.new        browser, profile: @profile, http_client: @client  end
end