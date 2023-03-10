# Terraform

- [Terraform](#terraform)
  - [What is it?](#what-is-it)
  - [High level features](#high-level-features)
  - [How to install](#how-to-install)
  - [Commands](#commands)
    - [How to deploy resources](#how-to-deploy-resources)
    - [How to destroy resources](#how-to-destroy-resources)
    - [Validate syntax](#validate-syntax)
    - [Format configuration files](#format-configuration-files)
    - [Show all resources](#show-all-resources)
    - [List all providers](#list-all-providers)
    - [Visualise structure](#visualise-structure)
  - [Syntax](#syntax)
    - [Blocks](#blocks)
    - [Variables](#variables)
    - [Using outputs of resources](#using-outputs-of-resources)
    - [Resource dependencies](#resource-dependencies)
    - [Output blocks](#output-blocks)
  - [Terraform providers](#terraform-providers)
  - [Terraform state](#terraform-state)
  - [Immutability of terraform](#immutability-of-terraform)
  - [Lifecycle rules](#lifecycle-rules)
  - [Datasouces](#datasouces)
  - [Meta arguments](#meta-arguments)
    - [Count](#count)
    - [For each](#for-each)
  - [Best practices](#best-practices)

## What is it?

`Terraform` is an `IAC` (infrastructure as code) tool that allows us to provision cloud resources using code. More specifically `terraform` is a `provisioning tool`, that can provision for **all** major cloud providers as well as hundreds of `SaaS` and `Iaas` providers.

## High level features

It uses the `HashiCorp configuration language` that looks like:

```tf
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

## Commands

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

### Validate syntax

```sh
terraform validate
```

### Format configuration files

```sh
terraform fmt
```

### Show all resources

```sh
terraform show [-json]
```

### List all providers

```sh
terraform providers
```

### Visualise structure

```sh
terraform graph
```

This will generate a `digraph` JSON that can be inputted into graphing software to visualise the deployments and their dependencies.

## Syntax

Each `terraform` statement takes the following form:

```tf
<block> <parameters> {
  key1 = value1
  key2 = value2
}
```

### Blocks

A block in `terraform` specifies the infrastructure and the provider required.

### Variables

To create a variable we use the keyword `variable` followed by the name of the variable:

```tf
// variables.tf
variable "filename" {
  default = "path"
}
```

Then to call them in `main.tf` we write:

```tf
// main.tf
resource "local_file" "pet" {
  filename = var.filename
}
```

The `variable` `block` has 3 parameters:

1. `Default` - the default value of the variable
2. `Type` - the data type of the variable:
   1. `string` - ```"hello"```
   2. `number` - 1
   3. `boolean` - true/false
   4. `any` - no specification
   5. `list` - `[1,2,3]` can access using zero indexing, can also declare datatype of list like `list(number)`
   6. `map` - ```{key1=value1}``` can access using map[key], can also declare datatype of map like `map(number)` this only applies to the values
   7. `set` - A list with only unique values, can specify datatype like `set(number)`
   8. `object` - can combine different data types into one new datatype e.g:

      ```tf
      variable "something" {
        type = object({
          name = string
          colour = string
          age = number
          food = list(string)
          favourite = bool
      })
        default = {
          name = "ben"
          colour = "blue"
          age = 22
          food = ["beans"]
          favourite = true
        }
      }
      ```

   9. `tuple` - tuples are lists that can have multiple vairable types, we declare the data types like: `tuple([string,number,bool])`
3. `Description` - description for documentation purposes

### Using outputs of resources

In the `tf` docs there is an `attribute reference` section that details the outputs of each resource. We reference this output as follows:

```tf
resource "x" "y" {
  content = "${random_name.resource_name.id}"
}
```

Using the syntax: `${provider_resource.resource_name.attribute}` we can access outputs of other resources.

### Resource dependencies

There are 2 types of dependencies in resources:

1. `Implicit` - this occurs when we make a reference using string interpolation (`${x.y.attribute}`). So `terraform` knows which order to provision in
2. `Explicit` - we can use the `depends_on` argument to hard code dependencies which is a list of resources. This way we can create an order of creation.

### Output blocks

An `output block` can capture the output of a resource block:

```tf
output resource_name {
  value = resource.attribute
  description = ""
}
```

We can view all outputs with `terraform output` and specific ones with `terraform output <output name>`

## Terraform providers

When we run `terraform init`, `terraform` downloads necessary plugins for the specified providers and saves them in the root directory. There are 3 tiers of providers:

1. Official - `AWS`,`GCP` etc. These are made by HashiCorp
2. Partner - A 3rd party software that has partnered by HashiCorp
3. Community - Open source plugins

when running `terraform init` you will notice that it specifies a few things:

```sh
* [hostname] org_namespace/resource_type version
```

## Terraform state

The `state` file is created by running `terraform apply` and houses the information about the resources to be provisioned. This allows terraform to map from code to provisioning resources.

The `tf` state is saved in a file called `terraform.tfstate`, collaberation is made possible by saving a `tfstate` file in a remote webstore such as `AWS S3` and then running the apply in a directory with the correct state in.

It is wise to store states in version controlled software.

It is a `JSON` structure that contains config data.

## Immutability of terraform

Mutable infrastructure can be modified, immutable infrastructure cannot be modified, thus we must destroy the old infrastrucutre and create a new one with the updated attribute. This is how `terraform` works. This makes `versioning` easier as the whole stack is recreated on modification.

## Lifecycle rules

A `life cycle rule` is a way of managing how changes in configurations effect a resource, for example; in some cases we may want to create a new resource before we destroy the old one (such that there are no service outages etc), we can do this with the following:

```tf
resource "resource_type" "name" {
  arguments

  lifecycle {
    create_before_destroy = true
  }
}
```

We can also prevent destruction using lifecycle rules too using `prevent_destroy`. Finally we can use the `ignore changes` rule to prevent resources from being updated.

```tf
resource "aws_instance" "webserver" {
  ami = "ami"
  instance_type = "t2.micro"
  tags = {
    Name = "Project-Webserver"
  }
  lifecycle {
    ignore_changes = [
      tags
    ] | all
  }
}
```

Here we see that `ignore changes` will ignore changes to specific attributes of the resource.

## Datasouces

We can use datasources to access resources that are provisioned outside of its control using `data blocks`

```tf
data "resource" "name" {
  attributes
}
```

## Meta arguments

We can use meta arguments to create multiple resources in compact notation

### Count

Take some constant $c \geq 1$ then we can write

```tf
resource "resource" "name" {
  attributes
  count = c
}
```

This will create $c$ lots of this resource.

### For each

We can run for each loops within resource creation

```tf
resource "local_file" "name" {
  filename = each.value
  for_each = var.variable
}
```

We need to use `sets` for this command.

## Best practices

- Have one singular configuration `.tf` file per directory, we can supplement this main file with a few other files:
  - `main.tf` - main file containing resrouce definitions
  - `variables.tf` - contains variable declarations
  - `outputs.tf` - contains outputs from resources
  - `provider.tf` - conrains provider definition
