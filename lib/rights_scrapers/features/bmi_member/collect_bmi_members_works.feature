Feature: Collect BMI member's works
  As a programmer
  
  Background: Collect BMI Works
    Given the username "everstar"
    And the password "Bmibmi1234"
    When I have collected the works from the Bmi member
  
  Scenario Outline: Find scraped BMI work
    * I should be able to find the work matching all these info:
      | Work title   | BMI Work ID   | ISWC   | Registration Date   |
      | <Work title> | <BMI Work ID> | <ISWC> | <Registration Date> |
    
    Examples:
      | Work title      | BMI Work ID | ISWC            | Registration Date |
      | SHOTS ALL NIGHT | 15767613    | T-913.056.759-8 | 10/10/2013        |
