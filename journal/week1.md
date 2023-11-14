# Week 1


[Standard Module Structure](https://developer.hashicorp.com/terraform/language/providers)


The root module structure is as follows:
```
PROJECT ROOT
│
├── variables.tf           # Variable declarations for Terraform
├── main.tf                # Main Terraform configuration file
├── providers.tf           # Defines required providers and their configuration
├── outputs.tf             # Stores outputs from Terraform resources
├── terraform.tfvars       # Variables to be loaded into the Terraform project
└── README.md              # Documentation for the root modules
```


## Loading Terraform Variables

can use `-var` flag to input or overide a variable in tfvars file.
eg `terraform plan -var="instance_type=t2.large"`


### var-file flag
can supply a file:
`terraform plan -var-file=”prod.tfvars”`
[link](https://spacelift.io/blog/terraform-tfvars)

### terraform.tfvars
default file tlo load in tf variables in bulk

### auto.tfvars
Name any file with an extension `.auto.tfvars` and it will be loaded as a variable sfile.

### Tf vars precedence:
[Link](https://spacelift.io/blog/terraform-tfvars)



### Loading Terraform input variables:
[Terraofrm inout variables](https://developer.hashicorp.com/terraform/language/values/variables)

examples:
```hcl
variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}

```




## Terraform Import:
[TF import](https://developer.hashicorp.com/terraform/cli/import/usage)
Importing resources that are not in the state file.
For dealing with configuration Drift

```bash
terraform import aws_s3_bucket.exam
ple haydn-31s850ggs4hym76c
aws_s3_bucket.example: Importing from ID "haydn-31s850ggs4hym76c"...
aws_s3_bucket.example: Import prepared!
  Prepared aws_s3_bucket for import
aws_s3_bucket.example: Refreshing state... [id=haydn-31s850ggs4hym76c]
```

Removed the random module because despite importing the s3 bucket and the random stirng, it still wants to delete the s3 bucket

### Fix using Terraform Refresh
[link](https://developer.hashicorp.com/terraform/cli/commands/refresh)
```sh
terraform apply -refresh-only -auto-approve
```
### Terraform Modules
#### Terraform Module structure
- it is recommeneded to palce modules in a `modules` folder when locally developing the,
- must be in a child folder, or a url etc, but needs tf files that the root module will reference.
  - using the source

Reference a module like so:

```terraform
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  # user_uuid   = "c96b5d6c-e138-4a75-8f2d-70c4da5786d3"
  # bucket_name = "haydn-31s850ggs4hym76c"
  user_uuid   = var.user_uuid
  bucket_name = var.bucket_name

}
```



#### Passing input variables:
Remember that the module needs to declare the variables it ints own variables.tf

```
  user_uuid   = var.user_uuid
  bucket_name = var.bucket_name
```
