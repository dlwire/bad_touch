import os, sys, re
from git import *

def add_file_if_needed(touches, filename):
  if not touches.has_key(filename):
    touches[filename] = {}
    touches[filename]['story'] = set()
    touches[filename]['defect'] = set()

def get_touches(repo):
  touches = {}

  for commit in repo.iter_commits():
    for filename in commit.stats.files.keys():
      add_file_if_needed(touches, filename)
      rally_id = get_rally_id(commit)
      if rally_id is not None:
        change_type = get_change_type(rally_id)
        touches[filename][change_type].add(rally_id)
        
  return touches

def generate_output(touches):
  for file in touches:
    print(file +
      ',' + str(len(touches[file]['story'])) +
      ',' + str(len(touches[file]['defect'])))

def get_change_type(rally_id):
  if is_story_work(rally_id):
    return 'story'
  elif is_defect_work(rally_id):
    return 'defect'
  return None

def get_rally_id(commit):
  search = re.search(r'(?:.*)(de\d+|s\d+)(?:.*)', commit.message.lower())
  if search:
    return search.groups()[0]
  return None

def is_story_work(rally_id):
  return rally_id.lower().startswith('s')

def is_defect_work(rally_id):
  return rally_id.lower().startswith('de')

def main():
  repo_path = sys.argv[1]

  if not os.path.exists(repo_path):
    print("'" + repo_path + "' is not a directory")
    exit(1)
  else:
    try:
      repo = Repo(repo_path)
    except InvalidGitRepositoryError as e:
      print("'" + repo_path + "' is not a valid git repository")
      exit(1)
    else:
      if len(repo.refs) == 0:
        print("'" + repo_path + "' is empty")
        exit(0)
      touches = get_touches(repo)
      generate_output(touches)

if __name__ == "__main__":
    main()
