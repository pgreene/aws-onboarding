## Purpose

AWS account onboarding process 

## Instructions

* Ensure you have the **latest version** of terraform installed. Use [tfenv](https://github.com/tfutils/tfenv) to manage multiple versions.
* Log into the AWS Console: https://pgreene.signin.aws.amazon.com/console
* Retrieve AWS CLI Credentials from [SSM Parameter Store.](https://us-east-1.console.aws.amazon.com/systems-manager/parameters/?region=us-east-1&tab=Table)
* Configure your [new AWS CLI Profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) locally with retrieved credentials and verify it exists: `aws configure list-profiles`
* Clone this repo: `git clone git@github.com:pgreene/aws-onboarding.git`
* In **locals.tf** on *line 5*, enter your email address.
* Navigate to this directory in your terminal: `cd ./aws-onboarding`
* From this directory in your terminal run:

```
terraform init
terraform providers lock
terraform plan
terraform apply
```