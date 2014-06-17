class Scraper::AscapMemberScrape::AscapMemberLogin
  def initialize username, password
    @username, @password = username, password
  end
  
  def execute browser
    browser.text_field(:id, "login").set(@username)
    browser.text_field(:id, "password").set(@password)
    browser.link(:id, "buttonOK").click
  end
end