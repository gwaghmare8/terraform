![AWS](https://img.shields.io/badge/AWS-Compatible-orange?logo=amazon-aws)
![Terraform](https://img.shields.io/badge/Terraform-v1.0+-623CE4?logo=terraform)
## AWS EC2 Web Instance Deployment
This Terraform project provisions a single **t3.micro** EC2 instance on AWS, configured for SSH access using a custom public key.

## Components Created
EC2 Instance (`aws_instance.web`):

* Type: `t3.micro`

* Assigned a Public IP for external access.

* Uses a dynamic name defined by the `var.instance-name` variable.

Key Pair `(aws_key_pair.key)`:

* Imports a local public key file (`./terraform-key.pub`) to AWS.

Security Group `(aws_security_group.sg)`:

* Ingress: Opens Port 22 (SSH) to the entire internet `(0.0.0.0/0)`.

* Egress: Allows all outbound traffic (`-1` protocol) to any destination.

## Setup Requirements
1. SSH Key Preparation
This script expects a public key file to exist in your project root. If you haven't created one yet, run this in your terminal:

<pre>
Bash
ssh-keygen -t rsa -b 4096 -f ./terraform-key
</pre>
This will create `terraform-key` (private) and `terraform-key.pub` (public).


2. Variables
Ensure you have a `variables.tf` file or provide the `instance-name` at runtime.

<pre>
Terraform
variable "instance-name" {
  default = "my-first-ec2"
}
  </pre>

  
## Deployment Commands

1. Initialize: Download the AWS provider.
<pre>
Bash
terraform init
</pre>

# Plan: Review the 3 resources to be created.
<pre>
Bash
terraform plan
</pre>

# Apply: Deploy to AWS.
<pre>
Bash
terraform apply
</pre>

# Cleanup: Terminate the instance
<pre>
Bash
terraform destroy
</pre>

## ⚠️ Security Warning
The current configuration allows SSH access from any IP address. To protect your instance, consider changing the `cidr_blocks` in the `ingress` rule to your specific IP: `cidr_blocks = ["your.ip.address/32"]`
