## Intro to Terraform

### What is Terraform? What is it used for?
- terraform is an infrastructure orchestration tool
- allows us to manage and provision cloud resources
- different to configuration management tools like Ansible which deploy software onto existing servers
- sees infrastructure as immutable (disposable)
- uses code written in HCL (Hashicorp Configuration Language) - aims to be a good balance between human and machine readable
  * HCL can be converted 1:1 to JSON and vice versa

### Why use Terraform? The benefits?
* **declarative** - say what you want, not how to do it
* easy to use
* cloud agnostic - deploy to any cloud provider
* sort of open-source (Uses a business source license BSL cant use terraform to create competing commercial products)
  * some organisations use OpenTofu - meant to be a drop in replacement
* Expressive and extendable: HCL language has loops variables termplate files etc, providers and plug ins can extend what it manages (diff cloud vendors)

##### Provider vs cloud provider:
- Cloud provider is the platform (AWS Azure), 
- Terraform provider is the plugin or API that lets terraform talk to that provider
- terraform providers are downloaded locally
- Cloud Vendors maintain its own provider and update them
- Multi cloud is supported - use both providers together

##### Alternatives to Terraform

* Pulumi (not declarative but similat)
* AWS CloudFormation, Azure ARM/Bicep templates, GCP Deployment Manager


### Orchestration?
- Orchestrartion is the process of automating and managing the entire lifecycle of infrastructure resources (create, maintain and destory)
- Terraform acts like a conductor of an orchestra: it coordinates the pieces of instructure to work together
  - Creates things in the right order
  - Destroys things in the right order
  - connects resources together

### How does Terraform act as "orchestrator"?
 
* Co-ordinating the piece of instructure to work together
* Includes
  * setting things up/destroying in the right order
  * makes sure things are connected together properly
* To do this, it relies on understanding the dependencies between resources
  * Implicit: Terraform works them out itself

### How Terraform finds AWS credentials (order)
1. Environment variables (highest priority). The names must match exactly. (mediocre unless using key vault etc )
2. Terraform variables, for example credentials hard-coded in the provider block. This is the worst option NEVER DO.
3. The shared credentials file created by `aws configure`. (mediocre security)
4. EC2 instance metadata (IAM role). Use this when Terraform runs on an EC2 instance. (Best for security)

#### Give Terraform access to Azure and GCP
AZURE:
1. Install Azure CLI and login to Azure using command `az login`
GCP:
1. Install Google Cloud (gcloud) CLI and login to gcloud using command `gcloud init`
2. Create Application Default Credentials (ADC): `gcloud auth application-default login`
* There is no need to specify any credentials file when using ADC - Terraform will automatically pickup the credentials

### Why use Terraform for different environments (e.g. production, testing, etc)

* Production
  * Easily create a larger-scale or more scalable version of infrastructure

* Dev and Testing environments
  * Easily spin up infrastructure for testing/dev that mirrors production
  * Easily tear it down when not needed

## How Terraform Works

### 1. Configuration Files
- Write `.tf` files, such as `main.tf`, to describe the infrastructure you want.
- Specify the provider, region and resources.
- Run Terraform commands from the folder containing these files.

### 2. Terraform CLI
- Terraform runs on your local laptop or PC.
- The CLI reads your configuration files and coordinates the required provider plugins.
- On macOS, run it using the `terraform` command.

### 3. Providers and APIs
- Providers are plugins that allow Terraform to communicate with external services.
- Each cloud platform has its own provider:
  - AWS provider → AWS API → AWS resources.
  - Azure provider → Azure API → Azure resources.
  - Google Cloud provider → Google Cloud API → Google Cloud resources.
- Providers use your configured credentials to access and manage resources.

### 4. Main Commands
ND = non destructive - no potential to modify (destory add change) state
- `terraform init`(ND)
  - Initialises the working directory.
  - Checks for a .tf file and checks the providers
  - Downloads required providers and modules.
  - Sets up the backend used to store state.

- `terraform plan` (ND)
  - Reads the configuration and state, and checks existing infrastructure.
  - Shows which resources will be created, updated or destroyed.
  - Does not apply changes.

- `terraform apply`
  - by default creates a plan before 
  - Carries out the planned changes through provider API calls.
  - Normally asks for confirmation before making changes.
  - Updates Terraform state afterwards.

- `terraform fmt` (ND)
  - Automatically formats Terraform configuration files consistently.
  - Fixes indentation, spacing and alignment.
  - Does not change your cloud infrastructure.
  - Use `terraform fmt -recursive` to include subfolders.
  - Use `terraform fmt -check` to check formatting without changing files.

- `terraform destroy`
  - Deletes the infrastructure managed by the current Terraform workspace.
  - Shows a destruction plan and normally asks for confirmation.
  - Does not delete your `.tf` configuration files.
  - Does not delete unrelated resources in your AWS account.
  - Use `terraform plan -destroy` to preview destruction without deleting anything.
  - Warning: review the plan carefully, as deleting resources can cause data loss.

### 5. Terraform State
- State links the resources defined in your code to real infrastructure.
- By default, Terraform stores state locally in `terraform.tfstate`.
- A remote backend can store state centrally instead.
- State helps Terraform track the resources it manages.

### Overall Flow
Configuration files → Terraform CLI → Provider → Cloud API → Infrastructure

## Terraform File and Folder Structure

These files and folders are found inside your Terraform project directory.

### `.terraform/`
- Created when you run `terraform init`.
- Stores downloaded provider plugins, modules and local working data.
- Can be recreated by running `terraform init`.
- Do not include in version control; add it to `.gitignore`.

### `main.tf`
- Contains your infrastructure configuration, such as an AWS S3 bucket.
- Can also contain provider configuration.
- Include in version control.

### Other `.tf` Files
- Organise configuration into separate files, such as `variables.tf`, `outputs.tf` or `providers.tf`.
- Terraform reads all `.tf` files in the same directory as one configuration.
- File names are organisational conventions, not an execution order.
- Include in version control, but do not hardcode secrets.

### `.terraform.lock.hcl`
- Records selected provider versions and checksums.
- Helps keep provider installations consistent across machines.
- Created or updated during `terraform init`.
- Include in version control to ensure consistency.

### `terraform.tfstate`
- Stores Terraform's mapping between your configuration and real infrastructure.
- Helps Terraform track the resources it manages. Stores the unique IDs of each resource
- May contain sensitive information.
- Do not edit manually or include in version control.
- This is the default local state file; a remote backend stores state remotely instead.

### `terraform.tfstate.backup`
- Stores a backup of a previous local state snapshot.
- Can help with state recovery.
- May also contain sensitive information.
- Do not include in version control.

## What Is a Terraform Backend?

- A **backend** defines where Terraform stores its state and how it accesses that state.
- State maps resources in your configuration to real infrastructure using their unique IDs.

### Local Backend
- The default backend.
- Stores state on your computer in `terraform.tfstate`.
- Not ideal for teamwork because teammates may have different state files.

### Remote Backend
- Stores state in a shared location, such as AWS S3, Azure Blob Storage or Google Cloud Storage.
- Allows teammates to access the same state for the same infrastructure.
- Can support state locking to prevent conflicting updates; support and setup depend on the backend.

### Backend vs Provider
- Backend → controls where Terraform state is stored.
- Provider → communicates with service APIs to manage infrastructure.
- Example: use the AWS provider to create resources and an S3 backend to store their state.
## Why Use a Remote Backend?

- Cloud resources have unique IDs, which Terraform maps to your configuration in its state.
- By default, state is stored locally in `terraform.tfstate`.
- If teammates use separate state files, Terraform may not recognise existing resources and attempt to duplicate them or encounter naming conflicts.
- A remote backend stores one shared state so everyone tracks the same infrastructure.
- With **state locking** enabled, conflicting state updates are prevented.
- Share configuration through Git; store state securely in the remote backend.