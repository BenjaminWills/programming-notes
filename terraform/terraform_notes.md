# Terraform

- [Terraform](#terraform)
  - [What is it?](#what-is-it)
  - [High level features](#high-level-features)
  - [How to install](#how-to-install)
  - [How to run](#how-to-run)
    - [How to deploy resources](#how-to-deploy-resources)
    - [How to destroy resources](#how-to-destroy-resources)
  - [Syntax](#syntax)
    - [blocks](#blocks)
  - [Terraform providers](#terraform-providers)
  - [Best practices](#best-practices)

## What is it?

`Terraform` is an `IAC` (infrastructure as code) tool that allows us to provision cloud resources using code. More specifically `terraform` is a `provisioning tool`, that can provision for **all** major cloud providers as well as hundreds of `SaaS` and `Iaas` providers.

## High level features

It uses the `HashiCorp configuration language` that looks like:

```java
resource "aws_instance" "webserver" {
  ami = "ami"
  instance_type = "t2.micro"
}
```

`Terraform` has three stages that it goes through before running a file:

1. Initialisation - discovering the services required
2. Planning - the order of deployment
3. Application - apply the resources

## How to install

```sh
brew install terraform

terraform version
```

## How to run

### How to deploy resources

```sh
terraform init
terraform plan
terraform apply
```

### How to destroy resources

```sh
terraform destroy
```

## Syntax

Each `terraform` statement takes the following form:

```java
<block> <parameters> {
  key1 = value1
  key2 = value2
}
```

### blocks

A block in `terraform` specifies the infrastructure and the provider required.

## Terraform providers

When we run `terraform init`, `terraform` downloads necessary plugins for the specified providers and saves them in the root directory. There are 3 tiers of providers:

1. Official - `AWS`,`GCP` etc. These are made by HashiCorp
2. Partner - A 3rd party software that has partnered by HashiCorp
3. Community - Open source plugins

when running `terraform init` you will notice that it specifies a few things:

```sh
* [hostname] org_namespace/resource_type version
```

## Best practices

- Have one singular configuration `.tf` file per directory, we can supplement this main file with a few other files:
  - `main.tf` - main file containing resrouce definitions
  - `variables.tf` - contains variable declarations
  - `outputs.tf` - contains outputs from resources
  - `provider.tf` - conrains provider definition

