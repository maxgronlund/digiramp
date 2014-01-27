Feature: Collect Ascap Member Works
  As a programmer
  
  Background: Collect Ascap Works
    Given the username "4sepublishing"
    And the password "ascapascap"
    When I have collected the works from the Ascap member
    #When I collect the works from the Ascap member
  
  Scenario Outline: Find scraped Ascap work
    * I should be able to find the work matching all these info:
      | Work title   | Ascap Work ID   | Duration   | ISWC   | Genre   | Registration Date   | Intended Purpose   | Alternate Titles   | Recording's Album Title   | Performers   |
      | <Work title> | <Ascap Work ID> | <Duration> | <ISWC> | <Genre> | <Registration Date> | <Intended Purpose> | <Alternate Titles> | <Recording's Album Title> | <Performers> |
    
    Examples:
      | Work title                | Ascap Work ID | Duration | ISWC        | Genre   | Registration Date | Intended Purpose                    | Alternate Titles     | Recording's Album Title | Performers      |
      | ARE YOU IN                | 881923246     |          | T9052386308 | Popular | 09/21/2010        |                                     |                      |                         |                 |
      | AZ UTOLSO BOLDOG NYAR     | 882042101     |          |             | Popular | 10/15/2010        |                                     |                      |                         |                 |
      | CALL IT A DAY             | 334176093     | 00:03:18 | T9115100157 | Popular | 03/14/2009        | Film                                |                      |                         |                 |
      | DONE WITH YOU             | 881922999     | 00:03:07 | T9052375607 | Popular | 09/21/2010        |                                     |                      |                         |                 |
      | HARD UP                   | 881927004     | 00:03:47 | T9052453233 | Popular | 09/22/2010        |                                     |                      |                         |                 |
      | HARD UP (CLUB REMIX)      | 881926863     | 00:05:34 | T9052379370 | Popular | 09/22/2010        |                                     |                      |                         |                 |
      | I WANT AN AMERICAN SUMMER | 886049442     | 00:02:45 |             | Popular | 10/25/2013        | Commercial (Jingle, Promo, Trailer) | POOL BOYS THEME SONG | BEST OF ZEBULON         | RAPHAEL ZEBULON |
      | I'M NOT ANGRY             | 882123325     | 00:03:20 | T9053644249 | Popular | 11/05/2010        |                                     |                      |                         | LOMBARDI SAM    |
      | KEEP IT ALL               | 410926619     |          |             | Popular | 04/09/2009        |                                     |                      |                         |                 |
      | KEEP IT ALL               | 881923087     |          |             | Popular | 09/21/2010        |                                     |                      |                         |                 |
      | LOVELY DISEASE            | 423621236     |          | T9020173528 | Popular | 04/09/2009        |                                     |                      |                         |                 |
      | LOVELY DISEASE            | 881922809     |          |             | Popular | 09/21/2010        |                                     |                      |                         |                 |
      | PATHETICALLY INTO YOU     | 881922810     |          | T9052418710 | Popular | 09/21/2010        |                                     |                      |                         |                 |
      | REST OF MY LIFE           | 482359017     |          | T9020177382 | Popular | 04/09/2009        |                                     |                      |                         |                 |
      | REST OF MY LIFE           | 881922905     |          |             | Popular | 09/21/2010        |                                     |                      |                         |                 |
      | THINGS ARE GETTING BETTER | 505962230     |          | T9020186441 | Popular | 04/09/2009        |                                     |                      |                         |                 |
  
  Scenario Outline: Check IPIs on scraped work
    Given the Ascap Work ID <Ascap Work ID>
    And the IPI <Ipi Number>
    Then I should see:
      | Ascap Work ID   | Name   | Role   | Ipi Number   | Society   | Own   | Collect   | Status   | Agreement   |
      | <Ascap Work ID> | <Name> | <Role> | <Ipi Number> | <Society> | <Own> | <Collect> | <Status> | <Agreement> |
    
    Examples:
      | Ascap Work ID | Name                 | Role               | Ipi Number | Society | Own   | Collect | Status                     | Agreement |
      | 881923246     | LOMBARDI, SAMANTHA   | Composer/Author    | 464421465  | APRA    | 25.00 | 25.00   | Ascap Member               | N         |
      | 881923246     | RAFELSON, PETER CARR | Composer/Author    | 122623706  | ASCAP   | 25.00 | 25.00   | Authoritative Ascap Member | N         |
      | 881923246     | 4SE PUBLISHING       | Original Publisher | 572205958  | ASCAP   | 25.00 | 25.00   | Ascap Member               | N         |
      | 881923246     | RAFELSON MUSIC       | Original Publisher | 122654498  | ASCAP   | 25.00 | 25.00   | Authoritative Ascap Member | N         |
      | 882042101     | LOMBARDI, SAMANTHA   | Composer/Author    | 464421465  | APRA    | 22.50 | 22.50   | Ascap Member               | N         |
      | 882042101     | RAFELSON, PETER CARR | Composer/Author    | 122623706  | ASCAP   | 22.50 | 22.50   | Authoritative Ascap Member | N         |
      | 882042101     | ORBAN, TAMAS         | Author Of Lyrics   | 0          | NS      | 05.00 | 05.00   | No Member ID               | N         |
      | 882042101     | 4SE PUBLISHING       | Original Publisher | 572205958  | ASCAP   | 22.50 | 22.50   | Ascap Member               | N         |
      | 882042101     | RAFELSON MUSIC       | Original Publisher | 122654498  | ASCAP   | 22.50 | 22.50   | Authoritative Ascap Member | N         |
      | 882042101     | UNKNOWN PUBLISHER    | Original Publisher | 0          | NS      | 05.00 | 05.00   | No Member ID               | N         |
