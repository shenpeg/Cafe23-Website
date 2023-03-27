Feature: Manage employees
  As an administrator
  I want to be able to manage employee information
  So employees can have an employment history with the creamery

  Background:
    Given a logged in admin
  
  # READ METHODS
  Scenario: View all employees
    When I go to the employees page
    Then I should see "Active Employees at Cafe23"
    And I should see "Name"
    And I should see "Current Assignment"
    And I should see "Phone"
    And I should see "Sisko, Ben"
    And I should see "CMU"
    And I should see "412-268-2323"
    And I should see "Gruberman, Ed"
    And I should see "n/a"
    And I should see "Janeway, Kathryn"
    And I should see "Oakland"
    And I should see "Inactive Employees"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  
