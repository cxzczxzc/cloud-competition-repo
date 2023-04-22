###

# Description

Infrastructure as code solution using Terraform for 2-Tiered web application.
The deployment uses public AMI with the application code and dependencies already installed.
Database scheme of MySQL database is inhereted from the public snapshot of the DB.
Application is connecting to the DB hosted on Amazon RDS by using parameters retrieved from the Amazon Parameter Store.
The ForStudents implementation is intentionally flawed.

In the ForJudges _reference_ implementation, the following issues have been addressed.
The ForJudges implementation should _not_ be shared with the students.

| Module         | Issue                                                      | Severity |
|----------------|------------------------------------------------------------|----------|
| VPC            | Missing route to NAT GW in private route table             | 0.5 |
| EC             | EC2 security group (SG) is too open                         | 2 |
|                | EC2 deployed in the public subnet.                         | 0.5 |
|                | IAM role assigned to EC2 instance is too open               | 2 |
| ALB            | TBD: Missing auto-scaling implementation, the capacity is static with 2 instances | 2 |
| Parameters     | Password is not encrypted                                  | 0.5 |
| DB             | DB deployed in the public subnet                            | 1 |
|                | DB security group (SG) is too open                         | 2 |
|                | DB is not encrypted                                        | 0.5 |
|                | Snapshots are disabled                                     | 2 |

# Terraform AWS Deployment for Competition

This Terraform deployment creates resources in your AWS account for the competition. The deployment is intentionally misconfigured for the competition, but it will still work and the Flask application functionality will be available upon deployment completion.

## Prerequisites

Before you get started, make sure you have:

- Installed the AWS CLI. You can install the AWS CLI by following the instructions [here](https://aws.amazon.com/cli/).
- Configured your AWS region to be `us-east-1` (US East N. Virginia).
- Installed Terraform v1.3.X or above. You can find the instructions for installing Terraform [here](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform).
- Configured your AWS credentials. The temporary credentials are provided by AWS as part of your competition-specific AWS account initialization. Follow the instructions below to export these credentials as environment variables. Alternatively, you can store the credentials in the `~/.aws/credentials` file (Mac) or `C:\Users\username\.aws\credentials` file (Windows).

### How to set environment variables

- Linux or macOS

    ```
    export AWS_ACCESS_KEY_ID=##ExampleKeyID##
    export AWS_SECRET_ACCESS_KEY=##ExampleAccessKey##
    export AWS_DEFAULT_REGION=us-east-1
    export AWS_SESSION_TOKEN=##Example_SESSION_TOKEN##
    ```

- Windows Command Prompt for user current session

    ```
    C:\> set AWS_ACCESS_KEY_ID=###ExampleKeyID###
    C:\> set AWS_SECRET_ACCESS_KEY=###ExampleAccessKey##
    C:\> set AWS_DEFAULT_REGION=us-east-1
    C:\> set AWS_SESSION_TOKEN=##Example_SESSION_TOKEN##
    ```

- Windows PowerShell

    ```
    PS C:\> $Env:AWS_ACCESS_KEY_ID="###ExampleKeyID###"
    PS C:\> $Env:AWS_SECRET_ACCESS_KEY="###ExampleAccessKey##"
    PS C:\> $Env:AWS_DEFAULT_REGION="us-east-1"
    PS C:\> $Env:AWS_SESSION_TOKEN=##Example_SESSION_TOKEN##
    ```

Note: Be sure to replace the values of **these environment variables** with your own.

## Usage

To use this deployment, follow these steps:

1. Change to the Terraform directory: `cd Terraform`.
2. Initialize the Terraform deployment: `terraform init`.
3. Validate the Terraform configuration: `terraform validate`.
4. Preview the Terraform deployment: `terraform plan`.
5. Apply the Terraform deployment: `terraform apply`.

If the `terraform apply` command was successful, you should see the ALB as the output:
Apply complete! Resources: 36 added, 0 changed, 0 destroyed.

```
Outputs:

alb_dns_name = "this-lb-########.us-east-1.elb.amazonaws.com"

```

Open your browser and navigate to your ALB URL to confirm that you can load the Flask app.

## Invoking Application

The Terraform deployment outputs the host URL of the application. Copy this URL and open it in your browser.
