resource "aws_security_group" "studentApp_sg" {
  name        = "studentApp_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
 

  tags = {
    Name = "studentApp_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "studentApp_sg1_ipv4" {
  security_group_id = aws_security_group.studentApp_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "studentApp_sg2_ipv4" {
  security_group_id = aws_security_group.studentApp_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
output "name" {
  value = aws_security_group.studentApp_sg.name
  
}