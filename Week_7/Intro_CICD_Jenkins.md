# Introduction to CI/CD and Jenkins

- [Introduction to CI/CD and Jenkins](#introduction-to-cicd-and-jenkins)
  - [1. What is CI?](#1-what-is-ci)
    - [Benefits](#benefits)
  - [2. What is CD?](#2-what-is-cd)
    - [Benefits](#benefits-1)
  - [3. What is Jenkins?](#3-what-is-jenkins)
  - [4. Why Use Jenkins?](#4-why-use-jenkins)
    - [Benefits](#benefits-2)
    - [Disadvantages](#disadvantages)
  - [5. Stages of a Jenkins Pipeline](#5-stages-of-a-jenkins-pipeline)
  - [7. Why Build a Pipeline? — Business Value](#7-why-build-a-pipeline--business-value)
  - [8. Our Jenkins Pipeline](#8-our-jenkins-pipeline)
    - [Pipeline Flow](#pipeline-flow)
  - [9. What is a Webhook?](#9-what-is-a-webhook)
  - [Additional Architecture Details](#additional-architecture-details)
    - [Jenkins Nodes](#jenkins-nodes)
    - [What the Three Jobs Do](#what-the-three-jobs-do)
    - [Important Deployment Point](#important-deployment-point)
    - [Security Connections](#security-connections)

## 1. What is CI?
- Continuous Integration means frequently integrating (merging) code changes into a shared codebase, supported by automated tests.
- Developers trigger a CI pipleine by pushing code to a repo
- When the pipeline is triggered certain tests are run automatically before it is integrated into the main code

### Benefits
- Detects bugs early - reduces costs.
- Gives developers faster feedback.
- Makes code integration easier.
- Helps maintain a stable and functional codebase.

## 2. What is CD?
CD can mean:
- Continuous Delivery: 
  - keeps tested software ready to deploy, with a manual release decision.
  - Typically involved producing a deployable artifact that requires manual approval
- Continuous Deployment: 
  - automatically deploys changes that pass the checks to production. (no need for manual approval)
  - faster but relies entirely on automated processes

### Benefits
- Speeds up software releases.
- Gets features and fixes to users sooner.
- Keeps software ready for deployment.
- Supports faster feedback and improvement.

## 3. What is Jenkins?
- Jenkins is an open-source automation server used to build, test, package and deploy applications.
- Primary use is CICD but can automate much more


## 4. Why Use Jenkins?

### Benefits
- Automates repetitive tasks and reduces manual errors.
- Plugins support different tools and workflows.
- Agents distribute jobs across multiple machines.
- Customisable and cross-platform.
- Has community support.

### Disadvantages
- Can be complex to configure.
- Jenkins and plugins require maintenance.
- Running multiple jobs can be resource-intensive.
- Interface can feel dated or cluttered.

## 5. Stages of a Jenkins Pipeline
1. SCM: retrieve code from version control.
2. Build: prepare or compile the application.
3. Test: run automated checks.
4. Package: create a deployable artifact.
5. Deploy: release into the target environment.
6. Monitor: observe performance and log issues.

Repository --> Build --> Test --> Package --> Deploy --> Monitor

- Alternatives to Jenkins: GitHub Actions, GitLab CI, CircleCI, Travis CI, Bamboo, TeamCity, GoCD, Azure Pipelines.

## 7. Why Build a Pipeline? — Business Value
- Faster delivery: release features and fixes sooner.
- Lower costs: reduce repetitive work and rework.
- Better quality: detect problems before release.
- Easier collaboration: integrate changes frequently.
- Faster improvement: shorten the feedback cycle.
- Additional Business Value:
  - Higher productivity: developers spend less time deploying and more time developing and testing.
  - Reduced risk: automation reduces manual errors and can catch problems before deployment.
  - Consistent quality: changes must pass a standard set of tests.

## 8. Our Jenkins Pipeline

The pipeline uses three jobs:

1. Build and test: retrieve the latest code and run unit tests.
2. Merge: merge passing code into the main branch.
3. Deploy: automatically deploy the updated app to AWS.

- CI = build/test and merge.
- CD = automatic deployment to AWS.

### Pipeline Flow

Push to dev branch
        |
        v
GitHub sends webhook
        |
        v
Jenkins receives notification
        |
        v
Build and test --> Merge to main --> Deploy to AWS

![cicd pipeline](/tech-613-devops/Images/cicdpipeline.png)

## 9. What is a Webhook?

A webhook is a notification sent from one service to another when an event happens.

In our pipeline:
- A developer pushes code to the dev branch.
- GitHub notifies Jenkins through a webhook.
- Jenkins must be configured to receive the notification and trigger the pipeline.
Webhook vs Polling:
- Polling: Jenkins repeatedly asks GitHub whether anything changed.
- Webhook: GitHub tells Jenkins when a change happens.
Why Use Pipeline?
- Starts the pipeline automatically after a push.
- Avoids repeatedly checking GitHub for changes.

## Additional Architecture Details

### Jenkins Nodes
- The master/built-in node manages Jenkins and assigns jobs.
- Agent/worker nodes run the jobs.
- Agents can be added to handle more workload.
- Running jobs on the built-in node is simpler, but a failed or resource-heavy job could affect Jenkins itself. Separate agents also isolate job execution.

### What the Three Jobs Do
1. Job 1 — Test: gets the code from the dev branch, builds it and runs unit tests.
2. Job 2 — Merge: if Job 1 succeeds, merges dev into main.
3. Job 3 — Deploy: if Job 2 succeeds, copies the tested code to the EC2 instance and runs the app.

If a job fails, later jobs do not run. The team is notified, fixes the issue and reruns the pipeline.

### Important Deployment Point
Deploy the same code that was tested by Jenkins. Don’t clone the repository again during deployment: a newer push could mean a different version gets deployed.

### Security Connections
- Jenkins needs an SSH private key to write the merge back to GitHub; the matching public key is added to the repository.
- Jenkins needs an SSH private key to connect to the EC2 instance and copy the updated code.
- The video mentions `scp` or `rsync` over SSH for copying files.


