Feature: Ascap Member Login
  As a programmer
  
  Scenario: Login with correct username and password
    Given the login username "peterrafelson"
    And the login password "ascapascap"
    When I open the ascap login page
    Then I should see the login form
    When I login
    Then I should be on the member dashboard
  
  Scenario: Login with incorrect username and password
    Given the username "username"
    And the password "1234"
    When I open the ascap login page
    Then I should see the login form
    When I login
    Then I should see the login error message
    