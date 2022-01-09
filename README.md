# VIRT-PT Fernlehre 2 // Auto Scaling Groups & Terraform Modules / AWS

Deploy a simple static website with nginx docker containers
on AWS EC2 instances via Terraform modules and AWS Auto-Scaling Groups and Elastic Load Balancer.

The AWS Auto-Scaling Group keeps an eye on the load and will provision
new instances or remove instances from the pool. The content is served
via an Elastic Load Balancer which sits in front of the EC2 instances.

## Requirements

- Install [Terraform](https://www.terraform.io/downloads)
- Supply your AWS credentials (e.g. in the file `~/.aws/credentials`)

## Usage

First, initialize terraform:

    terraform init

Plan the configuration (check):

    terraform plan

And apply:

    terraform apply

When Terraform is done applying, you'll see the URLs of your deployments.
Wait for it to finish installing and then visit the page.
