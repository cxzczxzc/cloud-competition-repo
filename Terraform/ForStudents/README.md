###

# Description

Infrastructure as code solution using Terraform for 2-Tiered web application.
The deployment uses public AMI with the application code and dependencies already available.
Database scheme of MySQL database is inhereted from the public snapshot of the DB.
Application is connecting to the DB hosted on Amazon RDS by using parameters retrieved from the Amazon Parameter Store.

### Pre-requisites

- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- A valid [AWS Access Key](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey)


You can use the command below to allow terraform access to Amazon APIs  

```
aws configure --profile skillsont

AWS Access Key ID [None]: ********************
AWS Secret Access Key [None]: ********************
Default region name []: 
Default output format [None]: 

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
