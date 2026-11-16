# Infrastructure as Code (IaC)

## What is IaC?

- **IaC** = managing and provisioning infrastructure using code rather than manually through a console.
- Uses machine-readable definitions → code that a tool can read and apply.
- Makes infrastructure setup automated and repeatable.
Infrastructure code → IaC tool → Resources created/configured

## What Problem Does It Solve?
- 'provisioning' servers (settting up and configuring them) manually takes time and can lead to mistakes.
- Repeating the same setup means selecting the same settings again.
- IaC allows us to reuse code instead of repeating manual steps.
- Currently we have automated software installation and config but we havent automated infra construction

- Iac allows can do all the provisiing of infrastrructure and config of the servers in an automated and repeatable manner

## Imperative vs Declarative

**Imperative = How**
- Specify the individual steps and their order. Example: Bash script, python, typsecript, java etc.
- HOW are we doing something

**Declarative = What**
- Specify the desired end state. The tool works out the actions required
- Examples: SQL, Prolog, Haskel, Terraform. 
- Define desired infrastructure in terraform → Terraform determines actions → Apply changes

> Imperative = how to get there. Declarative = what the result should be.


## Typical Setup Process

1. Create the infrastructure and server instances.
2. Configure the operating system and software.
3. Deploy the application and its dependencies.
4. Configure monitoring and logging.

Create → Configure → Deploy → Monitor

## Benefits of IaC

- Consistency and Accuracy
  - Reuse the same infrastructure definitions which reduce mistakes caused by manual setup.
  - Creates environments more consistently.
- Speed and Simplicity
  - Automate repetitive tasks which avoids clicking through the console every time.
  - Tools report completed actions and errors.
  - Testing and checking are still required.
- Version Control
    - Store infrastructure code in Git which comes with all the benefiets of git
- Reusability and Scalability
  - Reuse existing code easily and adapt definitions for different environments.
  - easily scale or duplicate infrastrcuture
  - Terraform can create multiple instances without copying every resource block.

## When to Use IaC
- When the same setup needs to be repeated.
- When multiple environments need consistent infrastructure.
- When manual setup involves many repetitive steps.
- When the time saved makes the initial coding effort worthwhile.
> Ask: Is this worth automating, and will I need to do it again?

## IaC in CI/CD
- IaC tools can run as part of a CI/CD pipeline.
- A pipeline can:
  1. Create infrastructure.
  2. Configure software and dependencies.
  3. Deploy updated application code.
- Some stages may require human approval before continuing.
Automated stages → Review/approval → Continue deployment

## IaC Tools

1. Infrastructure Orchestration Tools
    Create and organise infrastructure resources.
    Examples: Terraform, AWS CloudFormation → AWS, ARM/Bicep → Azure.
2. Configuration managment tools:
   - Configuring software:
   - Examples: chef, puppet, ansible

### Terraform vs Ansible

- Terraform → infrastructure provisioning.
- Ansible → software configuration management.
- Ansible can also provision infrastructure but mostly used for software config
Terraform → Create infrastructure
Ansible → Configure software
Application → Run on the configured infrastructure