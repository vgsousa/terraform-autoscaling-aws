locals {
  common_tags = {
    owner      = "vgsousa"
    managed-by = "terraform"
    service    = "Auto Scaling App"
  }

  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }
}