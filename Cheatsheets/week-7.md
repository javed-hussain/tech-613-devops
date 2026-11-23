# Week 7 cheatsheet: Jenkins and CI/CD

- **Continuous Integration:** merge changes frequently and automatically build/test them. **Continuous Delivery** keeps changes releasable; **Continuous Deployment** releases successful changes automatically.
- **Pipeline shape:** checkout → build → test → package → deploy. Fail fast and make each stage's result visible.
- **Jenkins:** a controller schedules work on agents/nodes. Jobs or pipelines run the steps; webhooks can trigger builds when a repository changes.
- **Credentials:** use Jenkins credential storage for private keys/tokens. Give keys the minimum required access; never place secrets in a job script or repository.
- **Git flow:** build/test a development branch, merge only after checks pass, then deploy the intended revision. Verify the deployed app and retain a rollback path.
- **Troubleshooting:** inspect the console log, confirm agent tools and permissions, check repository credentials/webhook delivery, and identify the first failing stage.

See the [Jenkins introduction](../Week_7/Intro_CICD_Jenkins.md) and [pipeline job notes](../Week_7/jenkins_job1.md).
