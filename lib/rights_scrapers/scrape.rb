require_relative 'ascap'
require 'pp'


@browser = WebBrowser.open url: Ascap::Login.url
Ascap::Login browser: @browser, username: @username, password: @password
Ascap::WorksPage @browser
@details = []
Ascap::WorksCollector @browser do |details|
  @details << details
  ## Pretty print progress
  pp details
  pp "-------------------------------------------------------------------------"
end