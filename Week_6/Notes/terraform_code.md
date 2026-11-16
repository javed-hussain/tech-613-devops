## Explaining the EC2 Terraform Code

### 1. Terraform Block

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
```

- Defines settings for Terraform itself.
- `required_providers` declares the provider plugins the configuration needs.
- `aws` is the local name used for the AWS provider.
- `source = "hashicorp/aws"` tells Terraform to use HashiCorp's AWS provider from the Terraform Registry.
- `terraform init` downloads the required provider.

### 2. Provider Block

```hcl
provider "aws" {
  region = "eu-west-1"
}
```

- Configures the AWS provider.
- `eu-west-1` is the AWS region for Ireland.
- Resources using this provider configuration are created in that region.
- Credentials are not hardcoded: the provider uses your configured AWS credentials.

### 3. Resource Block

```hcl
resource "aws_instance" "first_vm" {
  ami           = "ami-0c1c30571d2dae5c9"
  instance_type = "t3.micro"

  tags = {
    Name = "tech613-javed-tf-first-vm"
  }
}
```

- Declares an EC2 instance that Terraform should manage.
- `aws_instance` is the resource type.
- `first_vm` is Terraform's local label for this resource.
- Together, they form the resource address: `aws_instance.first_vm`.
- `first_vm` is not the instance's AWS name or its unique EC2 instance ID.
- Selects the Amazon Machine Image used to launch the instance and then the instance type. and then add a name tag - for the aws console diff to terraforms label

### Key Distinction

- `terraform` → declares Terraform requirements.
- `provider` → configures communication with AWS.
- `resource` → describes the infrastructure to manage.
- - `data` → looks up existing infrastructure or provider information.
- `variable` → defines configurable inputs (`var.name`).
- `locals` → defines reusable internal values (`local.name`).
- `output` → exposes results, such as resource IDs or public IPs.
- `module` → uses a reusable collection of Terraform configuration.
- The code declares the **desired state**; running `terraform apply` carries out the necessary changes.