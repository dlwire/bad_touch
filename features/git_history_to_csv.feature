#encoding utf-8
Feature: Translate git history into csv with touch counts for stories and defects
  Scenario: Non-existent repository
    Given "no_repository" is not a git repository
    When I run bad_touch on "no_repository"
    Then the exit status should be 1
    And the output for "no_repository" should be "'no_repository' is not a valid git repository\n"

  Scenario: Empty repository
    Given "empty_repository" is an empty git repository
    When I run bad_touch on "empty_repository"
    Then the exit status should be 0
    And the output for "empty_repository" should be "'empty_repository' is empty\n"

  Scenario: Repository with one defect commit to one file
    Given "one_defect" is a git repository with a defect commit to one file
    When I run bad_touch on "one_defect"
    Then the exit status should be 0
    And the output for "one_defect" should be "one_defect/defect_fix.txt,0,1\n"

  Scenario: Repository with one story commit to one file
    Given "one_story" is a git repository with a story commit to one file
    When I run bad_touch on "one_story"
    Then the exit status should be 0
    And the output for "one_story" should be "one_story/story_work.txt,1,0\n"

  Scenario: Repository with one uncategorized commit to one file
    Given "one_uncategorized" is a git repository with an uncategorized commit to one file
    When I run bad_touch on "one_uncategorized"
    Then the exit status should be 0
    And the output for "one_uncategorized" should be "one_uncategorized/uncategorized_work.txt,0,0\n"

  Scenario: Repository with two commits to two different files
    Given "two_commits" is a git repository with two commits to two files
    When I run bad_touch on "two_commits"
    Then the exit status should be 0
    And the output for "two_commits" should be "two_commits/file2.txt,0,1\ntwo_commits/file1.txt,1,0\n"

  Scenario: Repository with one uncategorized, defect, and story commit to one file
    Given "one_of_each" is a git repository with 3 commits to one file
    When I run bad_touch on "one_of_each"
    Then the exit status should be 0
    And the output for "one_of_each" should be "one_of_each/one_of_each.txt,1,1\n"

  Scenario: Repository with two story commits to the same file
    Given "two_story_commits" is a git repository with two story commits to one file
    When I run bad_touch on "two_story_commits"
    Then the exit status should be 0
    And the output for "two_story_commits" should be "two_story_commits/story_work.txt,2,0\n"

  Scenario: Repository with two matching defect commits to the same file
    Given "two_matching_commits" is a git repository with two matching defect commits to one file
    When I run bad_touch on "two_matching_commits"
    Then the exit status should be 0
    And the output for "two_matching_commits" should be "two_matching_commits/defect_work.txt,0,1\n"

  Scenario: Repository with one commit touching two files
    Given "two_files_one_commit" is a git repository with one commit to two files
    When I run bad_touch on "two_files_one_commit"
    Then the exit status should be 0
    And the output for "two_files_one_commit" should be "two_files_one_commit/file2.txt,1,0\ntwo_files_one_commit/file1.txt,1,0\n"

  Scenario: Repository with a subdirectory
    Given "subdirectory" is a git repository with a subdirectory
    When I run bad_touch on "subdirectory"
    Then the exit status should be 0
    And the output for "subdirectory" should be "subdirectory/dir/file1.txt,0,1\n"
