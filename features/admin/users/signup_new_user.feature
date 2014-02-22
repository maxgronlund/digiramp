#cucumber features/admin/users/signup_new_user.feature -r features

@admin_site

Feature: As an guest I can sign up

  
  Background:
    
    
  
  @javascript  
  Scenario: When I'm selecting a site from the admin page, Then I can CRUD pages
    When I visit the digiramp home page
    Then I can fill in the sign up form
    Then Does it look right?