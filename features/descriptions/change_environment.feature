Feature: Change environment
  So that I don't obliterate my Cucumber database when running RSpec
  As a wise developer who maintains separate testing environments
  I want to specify the environment that gets reset
  
  Scenario: Using environment "test"
    Given a Rails-type project
    And a fake test case for the "test" environment
    When I run a test case
    Then the database should be reset for the "test" environment
  
  Scenario: Using environment "cucumber"
    Given a Rails-type project
    And a fake test case for the "cucumber" environment
    When I run a test case
    Then the database should be reset for the "cucumber" environment
  