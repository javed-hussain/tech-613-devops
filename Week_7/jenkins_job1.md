## Using Jenkins

# Setting Up the Jenkins CI/CD Pipeline


## 1. Create app repo 
## 2. Create the Dev Branch

## 3. Create an SSH Key for Jenkins
- On your laptop, run:
    - ssh-keygen -t ed25519 -C "jenkins-sparta-cicd"
- When asked for the file location, use a new filename inside your `.ssh` folder:
    - Example: ~/.ssh/jenkins_sparta
- Do not overwrite an existing key.
- The command creates:
    - jenkins_sparta — private key for Jenkins.
    - jenkins_sparta.pub — public key for GitHub.

## 4. Add the Public Key to GitHub
- Open the repository.
- Go to Settings → Deploy keys → Add deploy key.
- Enter the title `Jenkins CI/CD`.
- Open `jenkins_sparta.pub` in a text editor.
- Copy its contents into the Key field.
- Tick Allow write access so Jenkins can push merged changes.
- Click Add key.

## 5. Add the Private Key to Jenkins
- Open the course Jenkins URL and sign in.
- Go to Manage Jenkins → Credentials. or do this in the job screen
- Select the credential store/domain permitted by your instructor.
- Click Add Credentials.
- Select SSH Username with private key.
- Enter:
    - Username: git
    - ID: javed-github-ssh
    - Private Key: Enter directly → paste the private key.
    - Passphrase: enter it if you created one.
- Save.

> Never add private keys to GitHub, screenshots or documentation.

## 6. Create Job 1 — Build and Test
- From the Jenkins dashboard, click New Item.
- Enter `javed-app-test`.
- Select Freestyle project → OK.
- discard old builds
  - builds are records of each time a run of the pipeline occurs
  - strategy log rotations
- select github project and add github https url
- If required, tick Restrict where this project can be run.
- Under Source Code Management, select Git.
- Enter the repository URL:
    - git@github.com:YOUR_USERNAME/sparta-app-cicd.git
- Select the credential `javed-github-ssh`.
- Under Branches to build, enter:
    - */dev
- Under build environment - provide node and npm to path version 20
- Under Build Steps, select Add build step → Execute shell.
- Enter the app’s dependency-installation and test commands.
- For an npm app with a package-lock.json and test script, an example is:
```bash
set -e
cd app
npm ci
npm test
```
- Click Save → Build Now.
- Open the build number → Console Output.
- Confirm the output ends with:
    - Finished: SUCCESS

## 7. Enable the Jenkins Webhook Trigger
- Open `javed-app-test` → Configure.
- Under Build Triggers, tick:
    - GitHub hook trigger for GITScm polling
- Save.

## 8. Add the Webhook in GitHub
- Open the repository → Settings → Webhooks.
- Click Add webhook.
- Set Payload URL to the course Jenkins address followed by:
    - /github-webhook/
- Example:
    - https://YOUR_JENKINS_ADDRESS/github-webhook/
- Set Content type to application/json.
- Select Just the push event.
- Use the matching course webhook secret if one is configured.
- Click Add webhook.

## 9. Test the Webhook


## 10. Next — Merge and Deployment Jobs
- Job 2 must merge the revision that passed Job 1.
- Job 3 must deploy that run’s tested files to the app EC2 instance.
- Only trigger each job when the previous job succeeds.
- Do not independently clone the latest branch during deployment.



---

[← Week 7 contents](./README.md) · [Next: Job 2 — CI merge →](./jenkins_job2.md)
