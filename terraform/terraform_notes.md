# Terraform

- [Terraform](#terraform)
  - [What is it?](#what-is-it)
  - [High level features](#high-level-features)
  - [How to install](#how-to-install)
  - [How to run](#how-to-run)
    - [How to deploy resources](#how-to-deploy-resources)
    - [How to destroy resources](#how-to-destroy-resources)
  - [Syntax](#syntax)
    - [Blocks](#blocks)
    - [Variables](#variables)
    - [Using outputs of resources](#using-outputs-of-resources)
    - [Resource dependencies](#resource-dependencies)
    - [Output blocks](#output-blocks)
  - [Terraform providers](#terraform-providers)
  - [Terraform state](#terraform-state)
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

## Best practices

- Have one singular configuration `.tf` file per directory, we can supplement this main file with a few other files:
  - `main.tf` - main file containing resrouce definitions
  - `variables.tf` - contains variable declarations
  - `outputs.tf` - contains outputs from resources
  - `provider.tf` - conrains provider definition
