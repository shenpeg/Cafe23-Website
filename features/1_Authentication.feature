Feature: Authentication
	As an administrator
	I want to create and access an account on the system
	In order to manage the system as an authenticated user

  Scenario: Login successful
    Given an initial setup
    When I go to the login page
    And I fill in "username" with "alex"
    And I fill in "password" with "secret"
    And I press "Log In"
    Then I should see "Logged in!"
		
  Scenario: Login failed
    Given an initial setup
    When I go to the login page
    And I fill in "username" with "alex"
    And I fill in "password" with "notsecret"
    And I press "Log In"
    Then I should see "Username and/or password is invalid"
		
  Scenario: Logout
    Given a logged in admin
    When I go to the home page
    And I click on the link "Logout"
    Then I should see "Logged out!"
	
	Scenario: Admin navigation exists to link resources
		Given a logged in admin
	  When I go to the home page
		And I click on the link "Stores"
	  Then I should see "Active Stores owned by Cafe23"
	  When I go to the home page
		And I click on the link "Employees"
	  Then I should see "Active Employees at Cafe23"
    When I go to the home page
		And I click on the link "Assignments"
	  Then I should see "Current Assignments"
    When I go to the home page
    And I click on the link "Shifts"
	  Then I should see "Upcoming Shifts"
    And I should see "Completed Shifts"

  Scenario: Employee navigation exists to link resources
    Given a logged in employee
	  When I go to the home page
    Then I should see "Upcoming Shifts"
    And I should not see "Employees"
    And I should not see "Assignments"

