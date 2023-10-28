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
    "Arn": "arn:aws:sts::1234567891012:assumed-role/
}
```

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

Need to generate AWS CLI credentials to enter as variables, use AWS SSO and copy paste.
