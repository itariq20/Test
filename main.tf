# main.tf

# Define the module
module "example_module" {
  source = "./example_module"

  # Module variables
  variable_1 = "value_1"
  variable_2 = "value_2"
}

# Resource definition outside the module
resource "aws_instance" "example_instance" {
  instance_type = "t2.micro"
  ami           = "ami-0c94855ba95c71c99"
  tags = {
    git_commit           = "ff22ae5041d0f24eb1a51075f8cd326e17ff0d16"
    git_file             = "main.tf"
    git_last_modified_at = "2024-08-02 08:56:41"
    git_last_modified_by = "31933916+itariq20@users.noreply.github.com"
    git_modifiers        = "31933916+itariq20"
    git_org              = "itariq20"
    git_repo             = "Test"
    yor_name             = "example_instance"
    yor_trace            = "566b9020-c467-4a57-8cce-707eed79119d"
  }
}

# Output values
output "instance_id" {
  value = aws_instance.example_instance.id
}