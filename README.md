# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:
Found here: https://semver.org/


Major.Minor.Patch eg `1.0.1`


## Installing Terraform
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli


## Shebang for bash scripts
https://en.wikipedia.org/wiki/Shebang_(Unix)


## Gitpod tasks
https://www.gitpod.io/docs/configure/workspaces/tasks

# testing


### Working with Env Vars

Can list out Env Vars using `env`

We can filter specific env vars using grep

### Gipot env vars
can store into gitpod using Gitpod Secrets Storage

```sh
gp PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023'

```

all future workspace will start with that env var


## AWS installation
aws is installed for this project via the bash script


dont use homebrew version.

Check if AWS credentials are working:
```sh
aws sts get-caller-identity
```
if successful youll receive a json payload with information about your userid and account

```json
{
    "UserId": "sdfsdfsd:email",
    "Account": "1234567891012",
    "Arn": "arn:aws:sts::1234567891012:assumed-role/"
}
```

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

Need to generate AWS CLI credentials to enter as variables, use AWS SSO and copy paste.

## Terraform basics

## Terraform Registry:
https://registry.terraform.io/

providers - how you directly interact with an api

module - template to provide commonly used actions - portable code


### Random provider:
https://registry.terraform.io/providers/hashicorp/random/latest


```hcl
resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}
```


### Other ways to output
```sh
terraform output
random_bucket_name = "ZhQzoI8GMpvy0cI1"

terraform output random_bucket_name
"ZhQzoI8GMpvy0cI1"
```

Terraform init plan apply!

TF state file = state of all the things, resources, bucket name  etc. - do not f*ck with

`.terraform` directory contains binaries of terraform providers


To output bucket name = .bucket:
```hcl
output "random_bucket_name" {

  value = aws_s3_bucket.example.bucket

}
```

To include random within other objects:

create the random string name with preffered values:

```hcl
resource "random_string" "bucket_name" {
  length  = 16
  lower   = true
  upper   = false
  special = false
  # override_special = ""
}```


then include that in a name or field:
```hcl
resource "aws_s3_bucket" "example" {
  bucket = "haydn-${random_string.bucket_name.result}"
}
```




# VScode cheat sheet

Multi Cursor Selection
**Using Keyboard Shortcut:**
Hold Alt (Windows/Linux) or Option (Mac) and then click at the points where you want the cursors.


**Selecting all occurrences of a word:**

Place the cursor on the word and press Ctrl + Shift + L or Cmd + Shift + L.

**To edit the end of multiple lines:**
Adding a cursor at the end/beginning of each line in a selection:

Make a selection of multiple lines, then press Shift + Alt + I.


# Git cheat sheet

commit without signing requirement:
```sh
git commit --no-gpg-sign -m "#12 add random terraform provider"
```


# Terraform cloud
https://app.terraform.io/app/terrorhaydz/workspaces

can store state here.
have some special work with gitpod and token format in gitpod.

up to 500 resources for $free!

Need to login to create a token
Documentation: terraform.io/docs/cloud


## Credentials for Terraform Cloud
- include all 3
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN


### Issues with Terarform cloud and gitpod

When attempting to run `terraform login` it will launch bash to generate a token, but doesnt work.

Manually generate a token in Terraform cloud.

Then create file manually:
```sh
touch /home/gitpod.terraform.d/credentials/tfrc.json
```

then need to provide the correct json format,

### Terraform alias
add to bash profile:
`~/.bash_profile`
`source ~/.bash_profile`

```
alias tf="terraform"
```
Use Chatgpt to create a  bash script


```bash
#!/bin/bash

# Define the alias you want to add
ALIAS_DEFINITION='alias tf="terraform"'

# Define the file you want to add it to
PROFILE_FILE="$HOME/.bash_profile"

# Check if the alias already exists in the file
if grep -q "$ALIAS_DEFINITION" "$PROFILE_FILE"; then
    echo "The alias '$ALIAS_DEFINITION' already exists in $PROFILE_FILE"
else
    # Add the alias to the end of the file
    echo "$ALIAS_DEFINITION" >> "$PROFILE_FILE"
    echo "The alias '$ALIAS_DEFINITION' has been added to $PROFILE_FILE"
fi

# Refresh the profile to make the alias available in the current session
source "$PROFILE_FILE"
```
