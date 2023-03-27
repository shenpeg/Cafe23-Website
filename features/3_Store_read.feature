Feature: Manage stores
  As an administrator
  I want to be able to manage store information
  So I can connect employee activity to particular stores

  Background:
    Given a logged in admin
  
  # READ METHODS
  Scenario: View all stores
    When I go to the stores page
    Then I should see "Active Stores owned by Cafe23"
    And I should see "Name"
    And I should see "Current Assignments"
    And I should see "Phone"
    And I should see "CMU"
    And I should see "Oakland"
    And I should see "2"
    And I should see "412-268-8211"
    And I should see "Inactive Stores"
    And I should not see "true"
    And I should not see "True"
    And I should not see "false"
    And I should not see "False"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"
  