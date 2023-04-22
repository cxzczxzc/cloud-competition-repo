# Cloud9 IDE Set up Instruction

1. Go to  https://aws-fast-dev.sheridancollege.ca
2. **Sign In**
3. At the console home, search for **Cloud9**, and choose **Cloud9** 
<br/>
<p align="center"> 
<img style="float: center;" src='.\images\image5.jpg' width='600'>
</p>

4. In the next page, Click **Create environment** at the top right
<br />
<p align="center"> 
<img style="float: center;" src='.\images\image6.jpg' width='600'>
</p>

* **Note**: You must choose **us-east-1** **N.Virginia** at the top right of the Create environment page


5. Type in Name, Description, and choose Enviroment type ( Choose **New EC2 instance**)

    **Note**: You can also use Existing Compute option. We use New EC2 as an example.
<br>
<p align="center">
<img style="float: center;" src='.\images\image7.jpg' width='600'>
</p>

6. Leave everything at default values
7. Click **Create**
8. On the next page, Open **Cloud9 IDE** 
<br>
<p align="center"> 
<img style="float: center;" src='.\images\image8.jpg' width='600'>
</p>

9. On the next page, Click **File Menu** and click **Upload local Files**
10. Click **Select Folder**, Choose **ForStudents** folder at your local hard drive where you download and unzip your code from github.

    **Note**: You can also **clone git hub repo**.

11. Go to the terminal at the **bottom of the current web page** to set up the environment variables.
    ```
    $ cd ./Terraform/ForStudents
    $ export AWS_ACCESS_KEY_ID=##ExampleKeyID##
    $ export AWS_SECRET_ACCESS_KEY=##ExampleAccessKey##
    $ export AWS_DEFAULT_REGION=us-east-1
    $ export AWS_SESSION_TOKEN=##Example_SESSION_TOKEN##
13. Open **provider.tf** and set up provider to use enviroment variables
    ```
    provider "aws" {
    }
    ```
    **Note**: Remove any line of code in provider.tf curly brackets   

14. At terminal, type following commands to init, plan, and apply
    ```
    terraform init
    terraform plan
    terraform apply 
    ```
    If the 'terraform apply' was successful then you should the ALB as the output

    Apply complete! Resources: 36 added, 0 changed, 0 destroyed.
    ```
    Outputs:

    alb_dns_name = "this-lb-########.us-east-1.elb.amazonaws.com"

    ```
    Open your browser with your ALB URL and confirm you can load the flask app 
