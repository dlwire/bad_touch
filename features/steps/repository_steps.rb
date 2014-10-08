Given(/^"([^"]*)" is not a git repository$/) do |repo_name|
  step 'a directory named "' + repo_name + '"'
end

Given(/^"([^"]*)" is an empty git repository$/) do |repo_name|
  step 'I run `git init ' + repo_name + '`'
end

Given(/^"([^"]*)" is a git repository with a defect commit to one file$/) do |repo_name|
  step '"' + repo_name + '" is an empty git repository'
  step 'I run `touch ' + repo_name + '/defect_fix.txt`'
  step 'I commit a change to "' + repo_name + '/defect_fix.txt" with comment "DE1"'
end

Given(/^"([^"]*)" is a git repository with a story commit to one file$/) do |repo_name|
  step '"' + repo_name + '" is an empty git repository'
  step 'I run `touch ' + repo_name + '/story_work.txt`'
  step 'I commit a change to "' + repo_name + '/story_work.txt" with comment "S1"'
end

Given(/^"([^"]*)" is a git repository with an uncategorized commit to one file$/) do |repo_name|
  step '"' + repo_name + '" is an empty git repository'
  step 'I run `touch ' + repo_name + '/uncategorized_work.txt`'
  step 'I commit a change to "' + repo_name + '/uncategorized_work.txt" with comment "anything else"'
end

Given(/^"([^"]*)" is a git repository with two commits to two files$/) do |repo_name|
  step '"' + repo_name + '" is an empty git repository'
  step 'I run `touch ' + repo_name + '/file1.txt`'
  step 'I commit a change to "' + repo_name + '/file1.txt" with comment "S2"'
  step 'I run `touch ' + repo_name + '/file2.txt`'
  step 'I commit a change to "' + repo_name + '/file2.txt" with comment "DE2"'
end

Given(/^"([^"]*)" is a git repository with 3 commits to one file$/) do |repo_name|
  step '"' + repo_name + '" is an empty git repository'
  step 'I run `touch ' + repo_name + '/one_of_each.txt`'
  step 'I commit a change to "' + repo_name + '/one_of_each.txt" with comment "S1"'
  step 'I commit a change to "' + repo_name + '/one_of_each.txt" with comment "DE1"'
  step 'I commit a change to "' + repo_name + '/one_of_each.txt" with comment "uncategorized"'
end

Given(/^"([^"]*)" is a git repository with two story commits to one file$/) do |repo_name|
  step '"' + repo_name + '" is an empty git repository'
  step 'I run `touch ' + repo_name + '/story_work.txt`'
  step 'I commit a change to "' + repo_name + '/story_work.txt" with comment "S1"'
  step 'I commit a change to "' + repo_name + '/story_work.txt" with comment "S2"'
end

Given(/^"([^"]*)" is a git repository with two matching defect commits to one file$/) do |repo_name|
  step '"' + repo_name + '" is an empty git repository'
  step 'I run `touch ' + repo_name + '/defect_work.txt`'
  step 'I commit a change to "' + repo_name + '/defect_work.txt" with comment "DE1"'
  step 'I commit a change to "' + repo_name + '/defect_work.txt" with comment "DE1"'
end

Given(/^"([^"]*)" is a git repository with one commit to two files$/) do |repo_name|
  step '"' + repo_name + '" is an empty git repository'
  step 'I run `touch ' + repo_name + '/file1.txt`'
  step 'I run `touch ' + repo_name + '/file2.txt`'
  step 'I commit all changes to "' + repo_name + '" with comment "S1"'
end

Given(/^I commit a change to "([^"]*)\/([^"]*)" with comment "([^"]*)"$/) do |repo_name, filename, comment|
  step 'I append to "' + repo_name + '/' + filename + '" with "some change"'
  step 'I run `git --git-dir ' + repo_name + '/.git add ' + repo_name + '/' + filename + '`'
  step 'I run `git --git-dir ' + repo_name + '/.git commit -m"' + comment + '"`'
end

Given(/^I commit all changes to "([^"]*)" with comment "([^"]*)"$/) do |repo_name, comment|
  step 'I run `git --git-dir ' + repo_name + '/.git add ' + repo_name + '/.`'
  step 'I run `git --git-dir ' + repo_name + '/.git commit -m"' + comment + '"`'
end

When(/^I run bad_touch on "([^"]*)"$/) do |repo_name|
  step 'I run `python ' + Dir.getwd + '/src/bad_touch.py ' + repo_name + '`'
end

Then(/^the output for "([^"]*)" should be "([^"]*)"$/) do |repo_name, output|
  step 'the stdout from "python ' + Dir.getwd + '/src/bad_touch.py ' + repo_name + '" should contain exactly "' + output + '"'
end
