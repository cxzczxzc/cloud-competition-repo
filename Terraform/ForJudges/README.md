###

# Description

Infrastructure as code solution using Terraform for 2-Tiered web application.
The deployment uses public AMI with the application code and dependencies already available.
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

- Valid credential for AWS account (not AWS academy account)
You can use the command below to allow terraform access to Amazon APIs  

```
aws configure
```

- Terraform version 0.14.x
- Network connectivity

### Deployment of  2-Tiered web application with Terraform

```
cd Terraform
terraform init
terraform plan
terraform apply 
```
