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

### Pre-requisites

- Valid credential for any AWS account (not AWS academy account)
You can use the command below to allow terraform access to Amazon APIs
If you use any AWS credentials profile name apart from "skillsont" configured in the provider.tf,
make sure to update the [provider.tf](https://github.com/cxzczxzc/cloud-competition-repo/blob/bfbed815a10d035c23563d6b1a74fdc430c1576f/Terraform/ForJudges/provider.tf#L12) accordingly. There is no need to specify profile in provider.tf if you are using the default profile.

### Prerequisites

## AWS Credentials configuration

```
aws configure
```

- Terraform version 0.14.x
- Network connectivity

### Deployment of  2-Tiered web application with Terraform

Run the commands below to complete full deployment of the hosting solution and the application.
The resultsing URL of ALB should be serving out test application.

```
terraform init
terraform plan
terraform apply 
```

Please not that the deployment might take up to 15 minutes, be patient.
