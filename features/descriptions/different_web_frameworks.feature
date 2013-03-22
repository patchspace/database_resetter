Feature: Different web frameworks
  In order to enjoy the magic of an automatically-reset database on all my projects
  As a promiscuous web framework fly-by-night
  I want to reset databases in Rails, Merb, Sinatra and all that crazy shit

  Scenario: Rails-type project
    Given a Rails-type project

    When I run a test case
    Then the database should be reset

    When I touch a migration
    And I run a test case again
    Then the database should be reset
  
  Scenario: Merb-type project
    Given a Merb-type project

    When I run a test case
    Then the database should be reset for the current Merb environment

    When I touch a migration
    And I run a test case again
    Then the database should be reset for the current Merb environment
