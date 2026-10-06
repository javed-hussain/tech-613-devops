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
    - [Merging Branches](#merging-branches)
      - [Merge Conflicts](#merge-conflicts)
    - [Git reccomended Worflow](#git-reccomended-worflow)

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
* `git init` command to initialise git in a directory
* Touch to create a new file eg touch `.gitignore` (`mv` old new to rename) and (`rm` name to delete)
* `.gitignore` file contains everything we do not want to add eg. *.ignore means any file that ends with .ignore will not be added

### Comitting to your local git repo:
* Working directory: storage containing project files currently being worked on
* Staging area: choose what files from working directory to add to repo - Uses command `git add (--all)` (git is an opt in system must specify what files are being added)
* local repo: actual repository use command `git commit -m “”` (use `-a` to commit everything and skip add)
* `git status`: shows status of the repo
* `git diff` : shows the difference between working and latest commit
* `Git log` : log of all things that have happened (`--oneline, --graph, --all`)
* `git reset`
* `git show`: show detail of last commit or specify a commit

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
  * **Main branch**: it is good practice to configure rules to the main branch such us require pull before merge, require approval before merges, require multiple approvals before merge 
* Can create a branch manually through github **or**
* `git branch branch name` to create a new branch (`-D` to delete branch) 
* Then `git checkout branch name`  to move to said branch or (`git switch` ) (add `-b` before branch name to create a new branch and skip using git branch)
* just `git branch` to check what branch you are on 
* Can also use checkout to go back to previous commits (use log to find commit name)


### Merging Branches
* Pull requests are used when you are ready to merge a branch into another, these can be reviewed and approved and then finally merged.
* Can also use the `git merge` command for local merges
* Before merging a branch into main it is good practice to first merge the main branch into the feature branch and resolve any merge conflicts and then open a pull request

#### Merge Conflicts
- When there is conflicting changes to the same file so an automatic merge is not possible
- When merge conflicts occur we must open the files with the conflict and edit the file so that there is no longer a conflict and then push those changes
- In a merge conflict `Head` is the changes from current branch and the rest is from the other branch
- merge conflicts are easiest to solve locally
- How to reduce merge conflicts:
  - Good communication, have a standard process in the team, let your team know what files you are working on

### Git reccomended Worflow
[Git Collab Recommended Workflow (PDF)](Git%20Collab%20Recommended%20Workflow.pdf)