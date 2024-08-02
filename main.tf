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
}

# Output values
output "instance_id" {
  value = aws_instance.example_instance.id
}