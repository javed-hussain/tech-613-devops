# Job 3 — CD Deploy Using Rsync

## Purpose
- Job 3 deploys the app from Jenkins to the app EC2 instance.
- It is triggered automatically after Job 2 succeeds.
- It copies the app files to EC2 and restarts the PM2 application.

## Create the Job
- Jenkins dashboard → New Item.
- Name and Select Freestyle project → OK.

## Check Out the Repository
- Same as prev job except branch set to main now
    - */main
- Jenkins checks out the latest main branch into Job 3’s workspace.

## Add the EC2 SSH Credential
- Jenkins → Manage Jenkins → Credentials.
- Select SSH Username with private key.
- Enter:
    - Username: ubuntu
    - ID: javed-ec2-ssh
- Private Key → Enter directly.
- Paste the full contents of the app EC2 pem file.

## Enable SSH Agent
- Job 3 → Configure → Build Environment → SSH Agent.
- Select:
    - javed-ec2-ssh
- This supplies the EC2 private key to rsync and ssh.

## Add the Deployment Script
- Build Steps → Add build step → Execute shell.
- Enter:
    - set -e
    - rsync -rlvz --exclude node_modules --exclude .git -e "ssh -o StrictHostKeyChecking=accept-new" ./app/ ubuntu@54.220.242.42:/home/ubuntu/tech613-tictactoe-node-app/app/
    - ssh -o StrictHostKeyChecking=accept-new ubuntu@54.220.242.42 'cd /home/ubuntu/tech613-tictactoe-node-app/app && npm ci && pm2 restart YOUR_APP_NAME'


## What Each Command Does
- set -e:
    - Stops the build if any command fails.
- rsync:
    - Copies the contents of ./app/ to the EC2 app folder.
    - Excludes node_modules and .git.
    - Does not delete destination files missing from the source.
- ssh:
    - Connects to the app EC2 instance.
    - Installs dependencies with npm ci.
    - Restarts the existing PM2 application.
- StrictHostKeyChecking=accept-new:
    - Accepts a previously unknown EC2 host key.
    - Rejects a changed host key.

## Trigger Job 3 From Job 2
- Open Job 2 → Configure.
- Post-build Actions → Build other projects.
- Enter:
    - javed-job3-cd-deploy
- Select Trigger only if build is stable.
- Leave Job 3’s GitHub webhook trigger unticked.


## Pipeline
Push to dev → Test → Merge → Checkout main on Jenkins → Rsync to EC2 → Restart PM2
