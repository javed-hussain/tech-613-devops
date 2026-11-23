# Week 6 cheatsheet: Infrastructure as Code

- **IaC:** describe infrastructure in version-controlled files so environments can be reviewed, repeated, and changed consistently.
- **Terraform is declarative:** write the desired state; Terraform compares it with state and real infrastructure, then proposes changes.
- **Core workflow:** `terraform init` → `terraform fmt` / `validate` → `terraform plan` → review → `terraform apply`. Use `terraform destroy` only when you intend to remove managed resources.
- **State:** maps configuration to real resources. Protect it as sensitive data, avoid concurrent writes, and use a remote backend with locking for team workflows.
- **Providers and resources:** providers connect Terraform to APIs; resources describe objects to create/manage. Keep credentials outside source code.
- **Ansible:** configures machines using tasks, inventories, and playbooks; prefer idempotent tasks that can safely be run again. Terraform provisions resources; Ansible commonly configures them.

See [IaC notes](../Week_6/Notes/IaaC_Notes.md), [Terraform](../Week_6/Notes/terraform_intro.md), and [Ansible](../Week_6/Notes/Intro_to_ansible.md).
