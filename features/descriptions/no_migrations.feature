Feature: No migrations
  So that I don't have to decipher an incomprehensible backtrace
  As a bone idle and/or forgetful database-backed app developer
  I want database_resetter to tell me when I forgot to make any migrations

  # TODO Rails-specific issues need highlighting

  Scenario: No migrations directory
    Given an empty project called "empty-project"
    When I run a test case
    Then I should see "No migrations"
  
  Scenario: No migrations in migration directory
    Given an empty project called "empty-project"
    And an empty Rails migration directory
    When I run a test case
    Then I should see "No migrations"

  