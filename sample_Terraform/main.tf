provider "aws" {
  region  = "us-east-1"
  access_key = "AKIA4MTWNCOCQJH5GSDR"
  secret_key = "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"
}
/////Deploying EC2 instance in AWS///////////

# resource "<provider>_<resource_type>" "name" {
#     config options----
#     key1="value"
#     key2="value2"
  
# }
resource "aws_instance" "my_first_server" {
    ami           = "ami-04b70fa74e45c3917"
    instance_type = "t2.nano"

    tags = {
    Name = "Ec2" //modifining instaces
  }
}

