class Ascap::Login
  @@url = "https://members.ascap.com/"
  
  def self.url
    @@url
  end
  
  def Ascap::Login username: nil, password: nil, browser: nil
    browser.text_field(:id, "login")    .set  username
    browser.text_field(:id, "password") .set  password
    browser.link(      :id, "buttonOK") .click
  end
end