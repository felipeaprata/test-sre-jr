# Explicação do Terraform 

## Ínicio
### No começo, colocamos o 'provider' para definir que iremos criar recursos na AWS e na região us-east-1
```bash
provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}
```
### Setamos mais algumas variaveis que iremos usar depois, como o tipo da instancia e o nome do dominio
```bash
variable "instance_type" {
  default = "t2.micro"
}

variable "domain_name" {
  default = "queroserumprinter.com"
}
```
## Criação da VPC e dos recursos de rede
### Cria uma VPC com o CIDR 10.0.0.0/16
```bash
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```
### Criação do Internet gateway vinculando a VPC
```bash
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
```
### Cria uma RT com o tráfego direcionado para o IG
```bash
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
```
### Criação de duas Subnets públicas com AZ diferentes e com ip público
```bash
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}
```
### Fazemos o vinculo da RT com as Subnets
```bash
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}
```
## Security Groups
### SG para a instancia EC2, liberando acesso Inbound para a porta 80 e vinculando a VPC criada
```bash
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group EC2"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
### SG para o Load Balancer, liberando acesso Inbound para a porta 80 e vinculando a VPC criada
```bash
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group ALB"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
## Instancia EC2
### Fazemos a busca da AMI mais recente do Amazon Linux
```bash
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```
### Configuração da EC2. Usamos a AMI encontrada anteriormente, o tipo da instancia declarado no começo, SG e Subnets criadas, e o User data que atualiza, instala o Nginx, coloca a frase "Eu quero ser um Printer" no index, inicia e habilita o nginx.
```bash
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.name]
  subnet_id     = aws_subnet.public.id
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              echo "Eu quero ser um Printer" > /usr/share/nginx/html/index.html
              systemctl start nginx
              systemctl enable nginx
              EOF
  tags = {
    Name = "web-server"
  }
}
```
## Load Balancer
### Define o target group para o tráfego HTTP 80
```bash
resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
```
### Faz a ligação entre o LB e a EC2
```bash
resource "aws_lb_target_group_attachment" "web_tg_attachment" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}
```
### Faz a criação do LB, associando duas subnets e ao SG criado
```bash
resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public2.id]
  enable_deletion_protection = false
}
```
### Configura o LB para escutar a porta 80 e encaminhar o tráfego para o grupo destino
```bash
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
```
## Route 53
### Cria uma zona no Route 53 
```bash
resource "aws_route53_zone" "main" {
  name = var.domain_name
}
```
### Faz o vinculo da zona criada para o LB utilizando o alias
```bash
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_lb.web_alb.dns_name
    zone_id                = aws_lb.web_alb.zone_id
    evaluate_target_health = true
  }
}
```
## Outputs
### Mostra o IP público do EC2, o dns do LB e o nome de registro no Route 53
```bash
output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "alb_dns_name" {
  value = aws_lb.web_alb.dns_name
}

output "route53_record" {
  value = aws_route53_record.www.name
}
```
