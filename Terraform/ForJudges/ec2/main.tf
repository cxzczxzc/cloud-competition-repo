data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
}

# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Create the Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = "ontario-key-pair"
  public_key = tls_private_key.key_pair.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.key_pair.key_name}.pem"
  content  = tls_private_key.key_pair.private_key_pem
}
resource "aws_launch_template" "this_lt" {
  name_prefix            = "this-lt-"
  image_id               = var.app_ami_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = filebase64("./ec2/user_data.sh")
  iam_instance_profile {
    arn = aws_iam_instance_profile.this.arn
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "skillsontario"
  }
}

# Define IAM policy document
data "aws_iam_policy_document" "this_policy_document" {
  statement {
    sid    = "SSMParameterReadWriteAccess"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "ssm:PutParameter",
    ]
    resources = ["arn:aws:ssm:${data.aws_region.current.name}:${local.account_id}:parameter/*"]
  }
}

# Create IAM policy
resource "aws_iam_policy" "this_policy" {
  name   = "ssm-parameter-policy"
  policy = data.aws_iam_policy_document.this_policy_document.json
}

# Create IAM role
resource "aws_iam_role" "this_role" {
  name = "ec2-ssm-parameter-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "this_policy_attachment" {
  policy_arn = aws_iam_policy.this_policy.arn
  role       = aws_iam_role.this_role.name
}


# Define the IAM instance profile
resource "aws_iam_instance_profile" "this" {
  name = "this-instance-profile"

  # Associate the IAM role with the instance profile
  role = aws_iam_role.this_role.name
}
