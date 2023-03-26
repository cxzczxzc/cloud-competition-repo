# Description

The cloucformation template creates resources in your AWS account

## Assumptions
- You have an access to AWS account
- AWS region is us-east-1 (US East N.Virginia)
- Latest version of AWS CLI is installed on your machine (not needed if you are using AWS console)

## Usage
- From command line using AWS CLI: 
    ```
    aws cloudformation create-stack --stack-name competition-stack --template-body file:///Users/hdossani/git/aws-cf-essentials/templates/competition-stack.yml --region us-east-1
    ```
- From AWS Console: Import template from the CloudFormation service page to create the new stack. You only need to provide stack name, all other values are default values.

## Resources
### Network Resources
- VPC :     
    - cidr range : 10.100.0.0/16
    - name: (stack-name)-VPC
- Internet Gateway :  
    - name: (stack-name)-IG
- Public Subnet A :  
    - cidr range : 10.100.1.0/24
    - name :  (stack-name)-PublicSubnet-A
- Public Subnet B :   
    - cidr range : 10.100.2.0/24
    - name :  (stack-name)-PublicSubnet-b
- Private Subnet A :  
    - cidr range : 10.100.3.0/24
    - name :  (stack-name)-PrivateSubnet-A
- Private Subnet B :   
    - cidr range : 10.100.4.0/24
    - name :  (stack-name)-PrivateSubnet-b
- Public Route Table
    - name : (stack-name)-PublicRouteTable
    - route to : Internet Gateway
- Private Route Table
    - name : (stack-name)--PrivateRouteTable
    - route to : NAT Gateway
- NAT Gateway
    - name : (stack-name)-NAT
### RDS  
- name : (stack-name)-RDS
- type : MYSQL
- UserName : dbuser
- Password : nopassword
### Ec2 Instance
- name :  (stack-name)-ec2
- type : Amazon Liunx 2


