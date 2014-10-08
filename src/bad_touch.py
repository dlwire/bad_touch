import os, sys, re
from git import *

def add_commit_touches(touches, commit):
  for filename in commit.stats.files.keys():
    rally_id = get_rally_id(commit)

    filetouch = touches[filename] if touches.has_key(filename) else new_filetouch()
    if rally_id is not None:
      change_type = get_change_type(rally_id)
      filetouch[change_type].add(rally_id)
    touches[filename] = filetouch
  return touches

def add_file_touches(repo):
  touches = {}
  for tree in repo.tree().trees:
    for file in tree.blobs:
      for commit in repo.iter_commits(paths=file.path):
        rally_id = get_rally_id(commit)

        filetouch = touches[file.path] if touches.has_key(file.path) else new_filetouch()
        if rally_id is not None:
          change_type = get_change_type(rally_id)
          filetouch[change_type].add(rally_id)
        touches[file.path] = filetouch
  return touches

def new_filetouch():
  filetouch = {}
  filetouch['story'] = set()
  filetouch['defect'] = set()
  return filetouch

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

def print_file_touches(file):
  print(file[0] +
    ',' + str(len(file[1]['story'])) +
    ',' + str(len(file[1]['defect']))
  )

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
      touches = reduce(add_commit_touches, repo.iter_commits(), {})
      # touches = add_file_touches(repo)
      map(print_file_touches, touches.items())

if __name__ == "__main__":
    main()
