###

# Description

Infrastructure as code solution using Terraform for 2-Tiered web application.
The deployment uses public AMI with the application code and dependencies already available.
Database scheme of MySQL database is inhereted from the public snapshot of the DB.
Application is connecting to the DB hosted on Amazon RDS by using parameters retrieved from the Amazon Parameter Store.

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
