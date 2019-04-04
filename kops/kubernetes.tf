locals = {
  cluster_name                 = "kubernetes.aws.empoweredtechnology.net"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-us-east-1a-masters-kubernetes-aws-empoweredtechnology-net.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"]
  masters_role_arn             = "${aws_iam_role.masters-kubernetes-aws-empoweredtechnology-net.arn}"
  masters_role_name            = "${aws_iam_role.masters-kubernetes-aws-empoweredtechnology-net.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"]
  node_subnet_ids              = ["${aws_subnet.us-east-1a-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1b-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1c-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1d-kubernetes-aws-empoweredtechnology-net.id}"]
  nodes_role_arn               = "${aws_iam_role.nodes-kubernetes-aws-empoweredtechnology-net.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-kubernetes-aws-empoweredtechnology-net.name}"
  region                       = "us-east-1"
  route_table_public_id        = "${aws_route_table.kubernetes-aws-empoweredtechnology-net.id}"
  subnet_us-east-1a_id         = "${aws_subnet.us-east-1a-kubernetes-aws-empoweredtechnology-net.id}"
  subnet_us-east-1b_id         = "${aws_subnet.us-east-1b-kubernetes-aws-empoweredtechnology-net.id}"
  subnet_us-east-1c_id         = "${aws_subnet.us-east-1c-kubernetes-aws-empoweredtechnology-net.id}"
  subnet_us-east-1d_id         = "${aws_subnet.us-east-1d-kubernetes-aws-empoweredtechnology-net.id}"
  vpc_cidr_block               = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.cidr_block}"
  vpc_id                       = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
}

output "cluster_name" {
  value = "kubernetes.aws.empoweredtechnology.net"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-1a-masters-kubernetes-aws-empoweredtechnology-net.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-kubernetes-aws-empoweredtechnology-net.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-kubernetes-aws-empoweredtechnology-net.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-1a-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1b-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1c-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1d-kubernetes-aws-empoweredtechnology-net.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-kubernetes-aws-empoweredtechnology-net.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-kubernetes-aws-empoweredtechnology-net.name}"
}

output "region" {
  value = "us-east-1"
}

output "route_table_public_id" {
  value = "${aws_route_table.kubernetes-aws-empoweredtechnology-net.id}"
}

output "subnet_us-east-1a_id" {
  value = "${aws_subnet.us-east-1a-kubernetes-aws-empoweredtechnology-net.id}"
}

output "subnet_us-east-1b_id" {
  value = "${aws_subnet.us-east-1b-kubernetes-aws-empoweredtechnology-net.id}"
}

output "subnet_us-east-1c_id" {
  value = "${aws_subnet.us-east-1c-kubernetes-aws-empoweredtechnology-net.id}"
}

output "subnet_us-east-1d_id" {
  value = "${aws_subnet.us-east-1d-kubernetes-aws-empoweredtechnology-net.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-kubernetes-aws-empoweredtechnology-net" {
  name                 = "master-us-east-1a.masters.kubernetes.aws.empoweredtechnology.net"
  launch_configuration = "${aws_launch_configuration.master-us-east-1a-masters-kubernetes-aws-empoweredtechnology-net.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1a-kubernetes-aws-empoweredtechnology-net.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubernetes.aws.empoweredtechnology.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1a.masters.kubernetes.aws.empoweredtechnology.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-kubernetes-aws-empoweredtechnology-net" {
  name                 = "nodes.kubernetes.aws.empoweredtechnology.net"
  launch_configuration = "${aws_launch_configuration.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-east-1a-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1b-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1c-kubernetes-aws-empoweredtechnology-net.id}", "${aws_subnet.us-east-1d-kubernetes-aws-empoweredtechnology-net.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubernetes.aws.empoweredtechnology.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.kubernetes.aws.empoweredtechnology.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-kubernetes-aws-empoweredtechnology-net" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "a.etcd-events.kubernetes.aws.empoweredtechnology.net"
    "k8s.io/etcd/events"                                           = "a/a"
    "k8s.io/role/master"                                           = "1"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-kubernetes-aws-empoweredtechnology-net" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "a.etcd-main.kubernetes.aws.empoweredtechnology.net"
    "k8s.io/etcd/main"                                             = "a/a"
    "k8s.io/role/master"                                           = "1"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-kubernetes-aws-empoweredtechnology-net" {
  name = "masters.kubernetes.aws.empoweredtechnology.net"
  role = "${aws_iam_role.masters-kubernetes-aws-empoweredtechnology-net.name}"
}

resource "aws_iam_instance_profile" "nodes-kubernetes-aws-empoweredtechnology-net" {
  name = "nodes.kubernetes.aws.empoweredtechnology.net"
  role = "${aws_iam_role.nodes-kubernetes-aws-empoweredtechnology-net.name}"
}

resource "aws_iam_role" "masters-kubernetes-aws-empoweredtechnology-net" {
  name               = "masters.kubernetes.aws.empoweredtechnology.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.kubernetes.aws.empoweredtechnology.net_policy")}"
}

resource "aws_iam_role" "nodes-kubernetes-aws-empoweredtechnology-net" {
  name               = "nodes.kubernetes.aws.empoweredtechnology.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.kubernetes.aws.empoweredtechnology.net_policy")}"
}

resource "aws_iam_role_policy" "masters-kubernetes-aws-empoweredtechnology-net" {
  name   = "masters.kubernetes.aws.empoweredtechnology.net"
  role   = "${aws_iam_role.masters-kubernetes-aws-empoweredtechnology-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.kubernetes.aws.empoweredtechnology.net_policy")}"
}

resource "aws_iam_role_policy" "nodes-kubernetes-aws-empoweredtechnology-net" {
  name   = "nodes.kubernetes.aws.empoweredtechnology.net"
  role   = "${aws_iam_role.nodes-kubernetes-aws-empoweredtechnology-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.kubernetes.aws.empoweredtechnology.net_policy")}"
}

resource "aws_internet_gateway" "kubernetes-aws-empoweredtechnology-net" {
  vpc_id = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "kubernetes.aws.empoweredtechnology.net"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-kubernetes-aws-empoweredtechnology-net-443f8ca30eee60f8160d10ac9e63f14b" {
  key_name   = "kubernetes.kubernetes.aws.empoweredtechnology.net-44:3f:8c:a3:0e:ee:60:f8:16:0d:10:ac:9e:63:f1:4b"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.kubernetes.aws.empoweredtechnology.net-443f8ca30eee60f8160d10ac9e63f14b_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-1a-masters-kubernetes-aws-empoweredtechnology-net" {
  name_prefix                 = "master-us-east-1a.masters.kubernetes.aws.empoweredtechnology.net-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kubernetes-aws-empoweredtechnology-net-443f8ca30eee60f8160d10ac9e63f14b.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-kubernetes-aws-empoweredtechnology-net.id}"
  security_groups             = ["${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.kubernetes.aws.empoweredtechnology.net_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-kubernetes-aws-empoweredtechnology-net" {
  name_prefix                 = "nodes.kubernetes.aws.empoweredtechnology.net-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kubernetes-aws-empoweredtechnology-net-443f8ca30eee60f8160d10ac9e63f14b.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  security_groups             = ["${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.kubernetes.aws.empoweredtechnology.net_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.kubernetes-aws-empoweredtechnology-net.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kubernetes-aws-empoweredtechnology-net.id}"
}

resource "aws_route_table" "kubernetes-aws-empoweredtechnology-net" {
  vpc_id = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "kubernetes.aws.empoweredtechnology.net"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
    "kubernetes.io/kops/role"                                      = "public"
  }
}

resource "aws_route_table_association" "us-east-1a-kubernetes-aws-empoweredtechnology-net" {
  subnet_id      = "${aws_subnet.us-east-1a-kubernetes-aws-empoweredtechnology-net.id}"
  route_table_id = "${aws_route_table.kubernetes-aws-empoweredtechnology-net.id}"
}

resource "aws_route_table_association" "us-east-1b-kubernetes-aws-empoweredtechnology-net" {
  subnet_id      = "${aws_subnet.us-east-1b-kubernetes-aws-empoweredtechnology-net.id}"
  route_table_id = "${aws_route_table.kubernetes-aws-empoweredtechnology-net.id}"
}

resource "aws_route_table_association" "us-east-1c-kubernetes-aws-empoweredtechnology-net" {
  subnet_id      = "${aws_subnet.us-east-1c-kubernetes-aws-empoweredtechnology-net.id}"
  route_table_id = "${aws_route_table.kubernetes-aws-empoweredtechnology-net.id}"
}

resource "aws_route_table_association" "us-east-1d-kubernetes-aws-empoweredtechnology-net" {
  subnet_id      = "${aws_subnet.us-east-1d-kubernetes-aws-empoweredtechnology-net.id}"
  route_table_id = "${aws_route_table.kubernetes-aws-empoweredtechnology-net.id}"
}

resource "aws_security_group" "masters-kubernetes-aws-empoweredtechnology-net" {
  name        = "masters.kubernetes.aws.empoweredtechnology.net"
  vpc_id      = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "masters.kubernetes.aws.empoweredtechnology.net"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
  }
}

resource "aws_security_group" "nodes-kubernetes-aws-empoweredtechnology-net" {
  name        = "nodes.kubernetes.aws.empoweredtechnology.net"
  vpc_id      = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "nodes.kubernetes.aws.empoweredtechnology.net"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  source_security_group_id = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  source_security_group_id = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kubernetes-aws-empoweredtechnology-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-kubernetes-aws-empoweredtechnology-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-1a-kubernetes-aws-empoweredtechnology-net" {
  vpc_id            = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-1a"

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "us-east-1a.kubernetes.aws.empoweredtechnology.net"
    SubnetType                                                     = "Public"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
    "kubernetes.io/role/elb"                                       = "1"
  }
}

resource "aws_subnet" "us-east-1b-kubernetes-aws-empoweredtechnology-net" {
  vpc_id            = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
  cidr_block        = "172.20.64.0/19"
  availability_zone = "us-east-1b"

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "us-east-1b.kubernetes.aws.empoweredtechnology.net"
    SubnetType                                                     = "Public"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
    "kubernetes.io/role/elb"                                       = "1"
  }
}

resource "aws_subnet" "us-east-1c-kubernetes-aws-empoweredtechnology-net" {
  vpc_id            = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
  cidr_block        = "172.20.96.0/19"
  availability_zone = "us-east-1c"

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "us-east-1c.kubernetes.aws.empoweredtechnology.net"
    SubnetType                                                     = "Public"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
    "kubernetes.io/role/elb"                                       = "1"
  }
}

resource "aws_subnet" "us-east-1d-kubernetes-aws-empoweredtechnology-net" {
  vpc_id            = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
  cidr_block        = "172.20.128.0/19"
  availability_zone = "us-east-1d"

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "us-east-1d.kubernetes.aws.empoweredtechnology.net"
    SubnetType                                                     = "Public"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
    "kubernetes.io/role/elb"                                       = "1"
  }
}

resource "aws_vpc" "kubernetes-aws-empoweredtechnology-net" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "kubernetes.aws.empoweredtechnology.net"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "kubernetes-aws-empoweredtechnology-net" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                                              = "kubernetes.aws.empoweredtechnology.net"
    Name                                                           = "kubernetes.aws.empoweredtechnology.net"
    "kubernetes.io/cluster/kubernetes.aws.empoweredtechnology.net" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "kubernetes-aws-empoweredtechnology-net" {
  vpc_id          = "${aws_vpc.kubernetes-aws-empoweredtechnology-net.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.kubernetes-aws-empoweredtechnology-net.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
