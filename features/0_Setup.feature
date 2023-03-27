Feature: Standard Business
  As a user
  I want to be able to view certain information
  So I can have confidence in the system
  
  Background:
  
  Scenario: Do not see the default rails page
    When I go to the home page
    Then I should not see "Rails version: 7.0.4"
    And I should not see "Ruby version: ruby 3.1.2"
  
  Scenario: View 'About Us'
    When I go to the About Us page
    Then I should see "About" within "#main_content"
    And I should see "About" within "#footer"
    When I click on the link "About"
    Then I should see "About the Cafe23 Management System"
  
  Scenario: View 'Contact Us'
    When I go to the Contact Us page
    Then I should see "Contact" within "#main_content"
    And I should see "Contact" within "#footer"
  
  Scenario: View 'Privacy Policy'
    When I go to the Privacy page
    Then I should see "Privacy" within "#main_content"
    And I should see "Privacy" within "#footer"
    When I click on the link "Privacy"
    Then I should see "Cafe23 Privacy Policy"

  
  Scenario: View webmaster information in footer
    When I go to the home page
    Then I should see "Webmaster" within "#footer"
