Feature: Reset a database
  In order to reduce time wasted manually running migrations
  As a database-backed app developer
  I want my databases rebuilt when I change the migrations

  Scenario: Initial run
    Given a Rails-type project
    When I run a test case
    Then the database should be reset
  
  Scenario: Clean re-run
    Given a Rails-type project
    When I run a test case
    And I run a test case again
    Then the database should not be reset
  
  Scenario: Dirty re-run
    Given a Rails-type project
    When I run a test case
    And I touch a migration
    And I run a test case again
    Then the database should be reset
  
  