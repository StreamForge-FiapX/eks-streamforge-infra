resource "aws_default_vpc" "vpcstreamforge" {
  tags = {
    Name = "Default VPC to Tech Challenge"
  }
}

resource "aws_default_subnet" "subnetstreamforge" {
  availability_zone = "sa-east-1a"

  tags = {
    Name = "Default subnet for sa-east-1a to Tech Challenge",
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_default_subnet" "subnetstreamforge2" {
  availability_zone = "sa-east-1b"

  tags = {
    Name = "Default subnet for sa-east-1b to Tech Challenge",
    "kubernetes.io/role/elb" = "1"
  }
}