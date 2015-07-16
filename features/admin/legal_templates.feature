# cucumber features/admin/legal_templates.feature -r features


Feature:
As an administrator I can manage legal templates

  Background:
    Given I am logged in as administrator

  @javascript  
  Scenario: As an administrator i CRUD legal tamplates
    When I'm on the "Templates for legal documents page"
    Then I can see "New document template"
    Then I clik on the link with the id "new-document-template"
    Then I can see "New template for a legal document"
    When I fill in the new template for a legal document form with the name "Recording end user agreement" and save
    Then I can see "Add default signatures"
    Then I can see "Recording end user agreement"
    Then I clik on the link with the id "back"
    Then I clik on the link with the id "edit-recording-end-user-agreement"
    Then I can see "Edit template for legal a document"
    When I update the new template for a legal document form with the name "Recording license agreement" and save
    Then I can see "Templates for legal documents"
    Then I can see "Recording license agreement"
    Then I clik on the link with the id "delete-recording-license-agreement"
    Then I confirm popup
    Then I can see "Templates for legal documents"
    Then I can not see "Recording license agreement"
    
  

    