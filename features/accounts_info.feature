# cucumber features/accounts_info.feature -r features

#@guest

Feature:
As an guest I can se the front page

  Background:
    Given the fields for the front pages is filled in
    
  #Before('@guest') do
  #  user = create_user(:admin => true)
  #  login_as user
  #end
    
  #@javascript  
  #Scenario: a guest user visit the front page and go to the social account info page and read info
  #  When I'm on the "Front Page"
  #  When I scroll page to position "3.4"
  #  Then I wait for "3" seconds
  #  Then I clik on an item with id "get_social_account_info"
  #  Then I can see "Social Account"
    
    
