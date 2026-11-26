# Job 2 — CI Merge

## Before Starting
- Job 1 must successfully build and test the `dev` branch.
- The repository must have `dev` and `main` branches.
- Jenkins must have a working GitHub SSH credential with write access.
- Use the course-provided agent label.
- Required plugins/options:
    - Git plugin, which provides Git Publisher.
    - SSH Agent plugin for the alternative shell method.

## 1. Create Job 2
- Jenkins dashboard → New Item.
- Enter the name:
    - javed-ttt-job2-ci-merge
- Select Freestyle project → OK.
- Under General, select Restrict where this project can be run.

## 2. Configure the Repository
- Under Source Code Management, select Git.
- Enter Repository URL:
- Select your working GitHub SSH credential.
- Under Branches to build, enter:
    - */dev

## 3. Configure the Merge
- In the Git section, select Additional Behaviours → Add.
- Select Merge before build.
- Enter:
    - Name of repository: origin
    - Branch to merge to: main
- This prepares a merge of the selected dev revision into main in the Jenkins workspace.

## 4. Configure Git Publisher
- Under Post-build Actions, select Add post-build action.
- Select Git Publisher.
- Tick:
    - Push Only If Build Succeeds
    - Merge Results
- Leave Force Push unticked.
- Do not add shell-based fetch, merge or push commands when using this method.
- Save.

## 5. Link Job 1 to Job 2
- Open Job 1 → Configure.
- Under Post-build Actions, select Build other projects.
- Enter:
    - javed-ttt-job2-ci-merge
- Select Trigger only if build is stable.
- Save.

## 6. Check Job 2’s Triggers
- Open Job 2 → Configure → Build Triggers.
- Leave GitHub hook trigger for GITScm polling unticked.
- Do not enable Poll SCM or a scheduled trigger.
- Job 1 should trigger Job 2—not the GitHub webhook directly.

> Job 1 is upstream of Job 2. Job 2 is downstream of Job 1.

## 7. Test the Pipeline


# Alternative Method — Shell Commands


## 1. Change the Job Configuration
- Under Source Code Management → Git:
    - Keep the same repository and GitHub credential.
    - Change Branches to build to */main.
- Remove Merge before build.
- Remove the Git Publisher post-build action.
- Keep the Job 1 → Job 2 link.

## 2. Enable SSH Credentials for the Shell
- Under Build Environment, tick SSH Agent.
- Select your GitHub SSH credential.

> Selecting an SCM credential does not automatically make it available to shell commands.

## 3. Add the Shell Commands
- Build Steps → Add build step → Execute shell.
- Enter:

```bash
set -e
git fetch origin
git switch main
git pull origin main
git merge origin/dev
git push origin main
```

### What the Commands Do
- set -e: stops the script if a command fails.
- git fetch origin: updates remote branch references.
- git switch main: switches to the local main branch.
- git pull origin main: updates main from GitHub.
- git merge origin/dev: merges dev into main.
- git push origin main: uploads the updated main branch.


## 5. If Git Requests an Identity
- Add these before the merge command:
    - git config user.name "Jenkins CI"
    - git config user.email "jenkins@example.invalid"
- These apply to the repository in the job workspace.

## 6. Optional Merge Safeguard
- To stop rather than create a merge commit when branches have diverged, replace the merge command with:
    - `git merge --ff-only origin/dev`

## Troubleshooting
- Permission denied (publickey) during shell commands:
    - Check SSH Agent is enabled with the GitHub key.
    - Check the matching public key has repository write access.
- Job 2 starts before Job 1 finishes:
    - Check Job 2 is not also triggered directly by GitHub.
    - Check which upstream build number triggered it.
- Merge conflict:
    - Resolve it locally, test the changes and push again.
    - Do not force-push to bypass the problem.

## Important Limitation
- These basic configurations can retrieve a newer dev revision if another push arrives between jobs.
- For a stronger pipeline, pass the exact tested commit from Job 1 to Job 2.
- A newly created merge result may also need testing before deployment.

---

[← Week 7 contents](./README.md) | [Next: Job 3 — CD deploy →](./jenkins_job3.md)
