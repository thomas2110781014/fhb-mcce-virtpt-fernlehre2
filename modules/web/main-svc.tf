resource "aws_launch_configuration" "web" {
  image_id = data.aws_ami.amazon-2.image_id
  instance_type = "t3.micro"
  user_data = base64encode(templatefile("${path.module}/templates/init_web.tftpl", { container_image = var.container_image, container_image_version = var.container_image_version } ))
  security_groups = [aws_security_group.ingress-all-ssh.id, aws_security_group.ingress-all-http.id]
  name_prefix = "${var.web_name}-web-"

  key_name = "aws-aca"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg-web" {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  desired_capacity   = var.desired_instances
  max_size           = var.max_instances
  min_size           = var.min_instances
  name = "${var.web_name}-asg"

  launch_configuration = aws_launch_configuration.web.name

  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.main_elb.id
  ]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup = "60"
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Name"
    value               = "${var.web_name}-web"
    propagate_at_launch = true
  }

}

resource "aws_elb" "main_elb" {
  name = "${var.web_name}-elb"
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  security_groups = [
    aws_security_group.elb_http.id
  ]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}
