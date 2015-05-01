# cucumber features/admin/coupon.feature -r features

Feature:
As an administrator manage coupons

  Background:
    Given I am the administrator
    And I am logged in
    
  @javascript  
  Scenario: As an administrator i can view the coupon page
    When I'm on the "Admin coupons page"
    Then I can see "Coupons"
    
  @javascript  
  Scenario: As an administrator i create a new coupon 
    When I'm on the "Admin coupons page"
    Then I create a new coupon named "FREE-FUN"
    Then I can see "FREE-FUN"
    