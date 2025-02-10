module "my_security_group" {
  source              = "./terraform-security-group"
  aws_region         = "eu-east-1"
  security_group_name = "my-security-group"
  vpc_id             = "vpc-12345678"

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks  = ["192.168.1.0/24"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks  = ["0.0.0.0/0"]
    }
  ]
}
