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

Importing resources that are not in the state file.


```bash
terraform import aws_s3_bucket.exam
ple haydn-31s850ggs4hym76c
aws_s3_bucket.example: Importing from ID "haydn-31s850ggs4hym76c"...
aws_s3_bucket.example: Import prepared!
  Prepared aws_s3_bucket for import
aws_s3_bucket.example: Refreshing state... [id=haydn-31s850ggs4hym76c]
```
