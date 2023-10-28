# Networking 

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
}


resource "aws_subnet" "subnet" {
  for_each   = toset(local.all_subnets_name)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, index(local.all_subnets_name, each.key))
  /*
  Creating a subnets in each avalibility zones
  */
  availability_zone = element(data.aws_availability_zones.available.names, index(local.all_subnets_name, each.key))

  # cidr_block = cidrsubnet(var.vpc_cidr_block,4,index(local.all_subnets_name,each.key)) 
  tags = { Name = format("%s", each.key) }

}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "igw" }
}

# resource "aws_internet_gateway_attachment" "igw_asso" {
#   internet_gateway_id = aws_internet_gateway.igw.id
#   vpc_id              = aws_vpc.vpc.id
# }


/*Note: 
Creating routetable app tier
*/

resource "aws_route_table" "rt" {
  for_each = local.app_subnetname_cidr_list
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block = aws_subnet.subnet[each.key].cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
}




