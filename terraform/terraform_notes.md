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
      - [Declaring variables at apply](#declaring-variables-at-apply)
    - [Using outputs of resources](#using-outputs-of-resources)
    - [Resource dependencies](#resource-dependencies)
    - [Output blocks](#output-blocks)
  - [Terraform providers](#terraform-providers)
  - [Terraform provisioners](#terraform-provisioners)
  - [Terraform state](#terraform-state)
    - [Remote backends](#remote-backends)
    - [State show command](#state-show-command)
    - [Resource taint](#resource-taint)
  - [Immutability of terraform](#immutability-of-terraform)
  - [Lifecycle rules](#lifecycle-rules)
  - [Datasouces](#datasouces)
  - [Meta arguments](#meta-arguments)
    - [Count](#count)
    - [For each](#for-each)
  - [Version control](#version-control)
  - [Terraform with AWS](#terraform-with-aws)
    - [Authentiation](#authentiation)
    - [Iam](#iam)
    - [S3](#s3)
  - [Debugging](#debugging)
  - [Importing](#importing)
  - [Functions](#functions)
    - [Numeric functions](#numeric-functions)
      - [Max and min](#max-and-min)
      - [Ceil and floor](#ceil-and-floor)
    - [String functions](#string-functions)
      - [Split and join](#split-and-join)
      - [Upper, lower and Title](#upper-lower-and-title)
      - [Substr](#substr)
    - [Collection functions](#collection-functions)
      - [Length](#length)
      - [Index and element](#index-and-element)
      - [Contains](#contains)
      - [Key and value](#key-and-value)
      - [Lookup](#lookup)
    - [Terraform conditional operators](#terraform-conditional-operators)
      - [Logical operators](#logical-operators)
      - [Conditional statements](#conditional-statements)
  - [Modules](#modules)
    - [Local modules](#local-modules)
    - [Using modules from the terraform registry](#using-modules-from-the-terraform-registry)
  - [Workspaces](#workspaces)
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
### Give pre-confirmation when deploying or destroying resources
Append the following to the end of your command:
```sh
--auto-approve
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

#### Declaring variables at apply

```sh
terraform apply var=key=value
```

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

The order that resources are written in the Terraform file do not reflect the order of creation during deployment, therefore it is important to identify dependencies and account for them.
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

## Terraform provisioners

A `provisioner` is a task that will be run upon resource creation - or locally on a machine. These blocks go within the resource blocks.

```tf
resource "aws_instance" "terraform-instance" {
  ami           = "ami-0055e70f580e9ae80"
  instance_type = "t2.micro"

  user_data = file("path to shell script")

  provisioner "local-exec" {
    on_failiure = continue
    command = "echo ${aws_instance.terraform-instance.public_ip} > ./ip.txt"
  }
}
```

This code will save the ip address of the commissioned `ec2` instance to a text file in the parent directory called `ip.txt`.

It is important to note that:

- The plan will not show outputs of terraform provisionals
- Some provisionals will require a network connection to the resource to work

It is recommended that provisionals are used as a last resort as they can make life unecessarily difficult at times.

## Terraform state

The `state` file is created by running `terraform apply` and houses the information about the resources to be provisioned. This allows terraform to map from code to provisioning resources.

The `tf` state is saved in a file called `terraform.tfstate`, collaberation is made possible by saving a `tfstate` file in a remote webstore such as `AWS S3` and then running the apply in a directory with the correct state in.

It is wise to store states in version controlled software.

It is a `JSON` structure that contains config data.

### Remote backends

The idea of a `remote backend` is to have a `single source of truth` for a `terraform state` file, we can do this as follows:

```tf
terraform {
  backend "s3" {
    bucket = "state-bucket"
    key = "terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "state-locking"
  }
}
```

This will save and load the state file from s3 whenever apply is run.

### State show command

One can run the `terraform state show <resource>` command to view all the terraform state information that terraform is holding in the `terraform.tfstate` file about that resource.

### Resource taint

A resource can be implicitly tainted by causing a run to fail, this means that on the next apply it will be rebuilt. 

We can explicitly taint a resource by using the `terraform taint <resource>` to ensure that the resource is rebuilt on the next apply. This can be usefeul if we dont want to completely destroy a deployment.

We can untaint a resource using `terraform untiant <resource>`

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

We need to use `sets` or `maps` for this command.

## Version control

We can control the version of a provider by using the `terraform` block:

```tf
terraform{
  required_providers {
    local = {
      source = hashicorp/local"
      version = "1.4.0" | "!=2.0.0" <- Not 2.0.0 
    }
  }
}
resource "local_file" "pet" {
  filename = "file"
  content = "file content"
}
```

## Terraform with AWS

### Authentiation

Before using `AWS` with terraform we need to authenticate our credentials to gain access to the cloud.

```tf
provider "aws" {
  region = "region"
  access_key = ""
  secret_key = ""
}
```

### Iam

We can create a user like this:

```tf
resource "aws_iam_user" "admin-user" {
    name = "ben"
    tags = {
        Description = "Legend"
    } 
}
```

Then we can create a policy using a `data` block

```tf
data "aws_iam_policy_document" "test_policy" {
  statement {
    actions = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "terraform_test_user_policy" {
  name = "terraform_test_user_policy"
  policy = "${data.aws_iam_policy_document.test_policy.json}"
}
```

Finally we can apply these:

```tf
resource "aws_iam_policy_attachment" "terraform_test_user_policy_attatchment" {
  name = "test-attatchment"

  users = [aws_iam_user.terraform_test_user.name]

  policy_arn = aws_iam_policy.terraform_test_user_policy.arn

}
```

### S3

Similarly to `IAM` we can use `resources` to provision s3 buckets

```tf
resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "terraform-test-bucket-bpw"
  tags = {
    Description = "Bucket created by terraform"
  }
}
```

We can also add objects to these buckets:

```tf
resource "aws_s3_bucket_object" "add_object" {
  content = "./main.tf"
  key = "main.tf"
  bucket = aws_s3_bucket.terraform_bucket.id
}
```

## Debugging

We can use environment variables to enable logging for terraform.

The tf logger has 5 levels, written in order of increasing granularity:

1. `Error`
2. `Warning`
3. `Debug`
4. `Info`
5. `Trace`

```sh
export TF_LOG = <log level>
```

We can also save logs to a path

```sh
export TF_LOG_PATH = ./terraform.log
```

To disable logigng unset the env variables using `unset`.

## Importing

We can import resources created externally by writing:

```sh
terraform import <resource type>.<resource name> <identifying attribute>
```

We would do this to bring the resource under `terraform` management.

Import only updates the `state file` and not the `config file`, unfortunately.

Before running import we create an empty resource that will house the imported resource, we can then complete the resource block using the `state file`.

## Functions

We can use the `terraform console` command to enter the terraform console to experiment with functions and interpoolations - basically a repr for terraform.

### Numeric functions

#### Max and min

```tf
variable "set" {
  type = set(number)
  default = [1,2,3,4,5]
}

max(var.list...) -> 5
min(var.list...) -> 1
# ... is the `expansion symbol` to expand a list into args, like * for python
```

#### Ceil and floor

This function will round its input up to the nearest integer.

```tf
ceil(10.1) -> 11
floor(10) -> 10
```

### String functions

#### Split and join

The split function allows us to separate a string into a list depending on some separator, join will join a list separated by some separator.

```tf
variable "string" {
  type = string
  default = "this-is-my-string"
}
variable "separator" {
  type = string
  default = "-"
}

split(var.separator,var.string) -> ["this","is","my","string"]
join(var.separator,["this","is","my","string"]) -> "this-is-my-string"
```

#### Upper, lower and Title

```tf
variable "string" {
  type = string
  default = "this-is-my-string"
}

upper(var.string) -> THIS-IS-MY-STRING
lower(var.string) -> this-is-my-string
title(var.string) -> This-Is-My-String
```

#### Substr

Allows us to find a substring from within a string, using an `offset` and a `length`

```tf
variable "string" {
  type = string
  default = "this-is-my-string"
}
variable "offset" {
  type = number
  default = 5
  description = "Index of character with which the substring begins"
}
variable "length" {
  type = number
  default = 2
  description = "desired length of the substring"
}

substr(var.string,var.offset,var.length) -> "is"
```

### Collection functions

#### Length

Finds the number of elements in a `collection`

```tf
variable "collection_list" {
  type = list(number)
  default = [1,2,3]
}

length(var.collection_list) -> 3
```

#### Index and element

Returns the element of the specified `collection` at index `i`, element does the opposite.

```tf
variable "collection_list" {
  type = list(number)
  default = [1,2,3]
}

index(var.collection_list,1) -> 0
element(var.collection_list,0) -> 1
```

#### Contains

Returns boolean to see if a `collection` contains an element.

```tf
variable "collection_list" {
  type = list(number)
  default = [1,2,3]
}

contains(var.collection_list,1) -> true
contains(var.collection_list,123) -> false
```

#### Key and value

For maps we can return a set of keys and values by passing the map as the argument to either of these functions.

#### Lookup

Lookup finds an element of a map based on the key `lookup(map,key,default_value)`

### Terraform conditional operators

Terraform supports the same conditional operators as python.

#### Logical operators

- `and` - `&&`
- `or` - `||`
- `not` - `!`
  
#### Conditional statements

Conditional statements are simply ternary.

```tf
condition ? true_value : false_value
```

## Modules

Modules are simply organised directories of terraform code.

### Local modules

Suppose that we have the following file structure of directories:

```sh
- root/
- modules/
  |
   -- module_1/
  | 
   -- module_2/
```

Then we can reference module 1 and 2 by writing the following in `root`

```tf
module "mod_1" {
  source = "../modules/module_1"
  var = value # We can change the values of the paramaters in the files.
}
module "mod_2" {
  source = "../modules/module_2"
  var = value # We can change the values of the paramaters in the files.
}
```

This will run the contents of module 1 and module 2.

### Using modules from the terraform registry

`Terraform resgistry` houses modules that can be imported. We can get these from the website. (reflected in the `source` argument)

## Workspaces

Terraform workspaces are a way to partition and modularise code to encourage reusability. Consider the problem of provisioning instances to London and America, we can solve this problem without rewriting code and instead using workspaces.

We can create a workspace with the

```sh
terraform workspace new <workspace name>
terraform workspace list <- Shows the workspaces currently made
```

Once a workspace has been created, it can be referenced in the config filles with `terraform.workspace`.

```tf
# variables.tf

variable "regions"{
  type = map(string)
  default = {
    "workspace_a" = "us-east-1"
    "workspace_b" = "eu-west-2"
  }
}
```

```tf
# main.tf
resource "aws_instance" "regional_instances" {
  region = lookup(var.regions,terraform.workspace)
}
```

We can view the workspace hierarchy as follows:

```sh
tree terraform.tfstate.d/
```

## Best practices

- Have one singular configuration `.tf` file per directory, we can supplement this main file with a few other files:
  - `main.tf` - main file containing resrouce definitions
  - `variables.tf` - contains variable declarations
  - `outputs.tf` - contains outputs from resources
  - `provider.tf` - conrains provider definition
