Feature: Open Web Browser
  In order to go to the websites to scrape
  As a programmer
  I Want to open a web browser
  
  Scenario: Blank Firefox Browser Session
    When I open the browser Firefox
    And go to "google.com"
    Then I should see the text: "Google"
    And the browser should close
  
  Scenario: Firefox Browser Session with start url
    When I open the browser Firefox with the url "google.com"
    Then I should see the text: "Google"
    And the browser should close