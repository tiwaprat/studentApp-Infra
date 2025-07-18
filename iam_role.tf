resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}

# Attach AmazonS3FullAccess
resource "aws_iam_role_policy_attachment" "s3_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.ec2_role.name
}

# Attach AmazonSSMManagedInstanceCore
resource "aws_iam_role_policy_attachment" "ssm_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2_role.name
}


# For access on secretemanager custom policy


resource "aws_iam_policy" "secretsm_acess_policy" {
  name        = "secretsm-access-policy"
  description = "To fetch db cred from ssm"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      "Resource": "arn:aws:secretsmanager:us-east-1:058264408180:secret:/studentApp/db-secret*"
    }
  ]
}
EOT
}

# Attach secretManager policy to role 
resource "aws_iam_role_policy_attachment" "secretesmanager" {
  policy_arn = aws_iam_policy.secretsm_acess_policy.arn
  role       = aws_iam_role.ec2_role.name
}