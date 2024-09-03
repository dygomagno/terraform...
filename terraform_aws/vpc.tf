
//variáveis 
variable "prefix" {
  description = "A prefix used to name resources"
  type        = string
  default     = "dygo"
}

//configuração padrão para usar o VPC
resource "aws_vpc" "new_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "${var.prefix}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
  }


resource "aws_subnet" "subnet" {
  count = 2
  availability_zone = data.aws_availability_zones.available.names[count.index + 1]
  vpc_id     = aws_vpc.new_vpc.id
  cidr_block = "10.0.${count.index}.0/24"
 
  //gerar um ID público automáticamente//
   map_public_ip_on_launch = true  
  
  tags = {
    Name = "${var.prefix}-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "new_igw" {
  vpc_id = aws_vpc.new_vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "new_rt" {  # Corrigido "aws_rout_table" para "aws_route_table"
  vpc_id = aws_vpc.new_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new_igw.id  # Corrigido "new-igw" para "new_igw"
  }

  tags = {
    Name = "${var.prefix}-rt"
  }
}

resource "aws_route_table_association" "new_rtb" {  # Corrigido "ressource" para "resource" e "aws_rout_table_association" para "aws_route_table_association"
  count = 2
  subnet_id      = aws_subnet.subnet[count.index].id  # Corrigido "*.[count.index]" para "[count.index]"
  route_table_id = aws_route_table.new_rt.id  # Corrigido "aws_rout_table" para "aws_route_table"
}
