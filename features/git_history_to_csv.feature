#encoding utf-8
Feature: Translate git history into csv with touch counts for stories and defects
  Scenario: Non-existent repository
    Given "no_repository" is not a git repository
    When I run `python ../../src/bad_touch.py no_repository`
    Then the exit status should be 1
    And the stdout should contain exactly "'no_repository' is not a valid git repository\n"

  Scenario: Empty repository
    Given "empty_repository" is an empty git repository
    When I run `python ../../src/bad_touch.py empty_repository`
    Then the exit status should be 0
    And the stdout from "python ../../src/bad_touch.py empty_repository" should contain exactly "'empty_repository' is empty\n"

  Scenario: Repository with one defect commit to one file
    Given "one_defect" is a git repository with a defect commit to one file
    When I run `python ../../src/bad_touch.py one_defect`
    Then the exit status should be 0
    And the stdout from "python ../../src/bad_touch.py one_defect" should contain exactly "one_defect/defect_fix.txt,0,1\n"

  Scenario: Repository with one story commit to one file
    Given "one_story" is a git repository with a story commit to one file
    When I run `python ../../src/bad_touch.py one_story`
    Then the exit status should be 0
    And the stdout from "python ../../src/bad_touch.py one_story" should contain exactly "one_story/story_work.txt,1,0\n"

  Scenario: Repository with one uncategorized commit to one file
    Given "one_uncategorized" is a git repository with an uncategorized commit to one file
    When I run `python ../../src/bad_touch.py one_uncategorized`
    Then the exit status should be 0
    And the stdout from "python ../../src/bad_touch.py one_uncategorized" should contain exactly "one_uncategorized/uncategorized_work.txt,0,0\n"

  Scenario: Repository with two commits to two different files
    Given "two_commits" is a git repository with two commits to two files
    When I run `python ../../src/bad_touch.py two_commits`
    Then the exit status should be 0
    And the stdout from "python ../../src/bad_touch.py two_commits" should contain exactly "two_commits/file2.txt,0,1\ntwo_commits/file1.txt,1,0\n"

  Scenario: Repository with one uncategorized, defect, and story commit to one file
    Given "one_of_each" is a git repository with 3 commits to one file
    When I run `python ../../src/bad_touch.py one_of_each`
    Then the exit status should be 0
    And the stdout from "python ../../src/bad_touch.py one_of_each" should contain exactly "one_of_each/one_of_each.txt,1,1\n"

  Scenario: Repository with two story commits to the same file
    Given "two_story_commits" is a git repository with two story commits to one file
    When I run `python ../../src/bad_touch.py two_story_commits`
    Then the exit status should be 0
    And the stdout from "python ../../src/bad_touch.py two_story_commits" should contain exactly "two_story_commits/story_work.txt,2,0\n"

  Scenario: Repository with two matching defect commits to the same file
    Given "two_matching_commits" is a git repository with two matching defect commits to one file
    When I run `python ../../src/bad_touch.py two_matching_commits`
    Then the exit status should be 0
    And the stdout from "python ../../src/bad_touch.py two_matching_commits" should contain exactly "two_matching_commits/defect_work.txt,0,1\n"
