resource "aws_subnet" "this" {
  for_each = {
    "public_a" : ["192.168.1.0/24", "${var.aws_region}a", "Public A"]
    "public_b" : ["192.168.2.0/24", "${var.aws_region}b", "Public B"]
    "private_a" : ["192.168.3.0/24", "${var.aws_region}a", "Private A"]
    "private_b" : ["192.168.4.0/24", "${var.aws_region}b", "Private B"]
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]

  tags = merge(local.common_tags, { Name = each.value[2] })
}