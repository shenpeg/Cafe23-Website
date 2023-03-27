Feature: Manage assignments
  As an administrator
  I want to be able manage assignments
  So employees are correctly connected to stores

  Background:
    Given a logged in admin
  
  # READ METHODS
  Scenario: View all assignments
    When I go to the assignments page
    Then I should see "Current Assignments"
    And I should see "Start Date"
    And I should see "Store"
    And I should see "Employee"
    And I should see "Pay Grade"
    And I should see "Shift Count"
    And I should see "08/17/21"
    And I should see "CMU"
    And I should see "Ben Sisko"
    And I should see "M2"
    And I should see "0"
    And I should see "05/21/22"
    And I should see "Oakland"
    And I should see "Ralph Wilson"
    And I should see "C1"
    And I should see "4"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"
