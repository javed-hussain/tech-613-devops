# Git Notes:

- [Git Notes:](#git-notes)
    - [What is Version Control:](#what-is-version-control)
    - [What is Git:](#what-is-git)
      - [Centralises vs Distrbuted VCS](#centralises-vs-distrbuted-vcs)
    - [Creating a git repo:](#creating-a-git-repo)
    - [Comitting to your local git repo:](#comitting-to-your-local-git-repo)
    - [Copying repo to remote:](#copying-repo-to-remote)
      - [Syncing remote and local:](#syncing-remote-and-local)
  - [Collabertive Git](#collabertive-git)
    - [Branches](#branches)

### What is Version Control:
* For anyone who creates content
* Remembers each version update and history of changes (can revert to prev states)
* Provides off site copy of data
* Supports collaboration: simultaneous updates - overlapping changes - merging and dealing with conflicts

### What is Git:
A version control system, records all changes in a file - open source and free - has a local copy and remote copy
Command line interface is Git Bash
Directories/folders are called repositories

#### Centralises vs Distrbuted VCS
* Centralized (CVCS): Uses a single central server to store all code and history. Developers must connect to this server to commit changes, get updates, or branch. Examples include SVN and CVS.
* Distributed (DVCS): Gives every user a complete local clone of the entire repository, including its full history. Developers can work offline, commit locally, and push or pull changes when connected. Examples include Git and Mercurial.

### Creating a git repo:
* `git init` command to initialise git
* Touch to create a new file eg touch `.gitignore` (`mv` old new to rename) and (`rm` name to delete)
* `.gitignore` file contains everything we do not want to add eg. *.ignore means any file that ends with .ignore will not be added

### Comitting to your local git repo:
* Working directory: storage containing project files currently being worked on
* Staging area: choose what files from working directory to add to repo - Uses command `git add (--all)` (git is an opt in system must specify what files are being added)
* local repo: actual repository use command `git commit -m “”` (use `-a` to commit everything and skip add)
* `git status`: shows status of the repo
* `git diff` : shows the difference between working and latest commit
* `Git log` : log of all things that have happened

### Copying repo to remote:
* `Git remote add origin url` to establish connection
* `Git push -u origin branch` to push to the remote and then `git push`
* `Git remove remote origin` (deletes the remote link)
* To copy from remote use `git clone url`

#### Syncing remote and local:  
* `Git pull` - pulls the files from the remote and syncs it to the local

## Collabertive Git

### Branches
* allow multiple people to work simultaneously without having to work serially - the different branches work in parrarell
* Can create a branch through github settings
* git checkout -b branch name to create and move to said branch