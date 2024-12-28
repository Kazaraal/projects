resource "aws_iam_role" "ec2_editor" {
    name = "ec2_editor"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_editor_attachment" {
    role = aws_iam_role.ec2_editor.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_editor_profile"{
    name = "ec2_editor_profile"
    role = aws_iam_role.ec2_editor.name
}

# resource "aws_instance" "front_end" {
#     ami =
#     instance_type = "t2.micro"

#     tags = {
#         name = "front_end"
#     }  
# }