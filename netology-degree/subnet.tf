data "yandex_vpc_network" "net" {
  name = "degree-cloud"               #Созданная сеть
}

resource "yandex_vpc_security_group" "bastion" {
  name        = "bastion"
  network_id  = data.yandex_vpc_network.net.id

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH connections to the Bastion instance"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Allow any outgoing traffic to the Internet"
    protocol       = "ANY"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "grafana" {
  name        = "grafana"
  network_id  = data.yandex_vpc_network.net.id

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH connections to the Bastion instance"
    port           = 3000
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH connections to the Bastion instance"
    port           = 22
    v4_cidr_blocks = ["192.168.0.32/28"]
  }

  egress {
    description    = "Allow any outgoing traffic to the Internet"
    protocol       = "ANY"
    port           = -1
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "kibana" {
  name        = "kibana"
  network_id  = data.yandex_vpc_network.net.id

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH connections to the Bastion instance"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH connections to the Bastion instance"
    port           = 22
    v4_cidr_blocks = ["192.168.0.32/28"]
  }

  egress {
    description    = "Allow any outgoing traffic to the Internet"
    protocol       = "ANY"
    port           = -1
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
resource "yandex_vpc_route_table" "hop" {
  name       = "hop"
  network_id = data.yandex_vpc_network.net.id
  static_route {
    destination_prefix = "192.168.0.0/28"
    next_hop_address   = yandex_compute_instance.bastion.network_interface[0].ip_address
  }
}


resource "yandex_vpc_security_group" "secure" {
  name        = "secure group"
  network_id  = data.yandex_vpc_network.net.id
}

resource "yandex_vpc_security_group_rule" "bastion" {
  security_group_binding = "${yandex_vpc_security_group.secure.id}"
  direction              = "ingress"
  v4_cidr_blocks         = ["0.0.0.0/24"]
  port                   = 22
  protocol               = "ANY"
}

resource "yandex_vpc_security_group_rule" "grafana" {
  security_group_binding = "${yandex_vpc_security_group.secure.id}"
  direction              = "ingress"
  v4_cidr_blocks         = ["0.0.0.0/24"]
  port                   = 3000
  protocol               = "ANY"
}

resource "yandex_vpc_security_group_rule" "kibana" {
  security_group_binding = "${yandex_vpc_security_group.secure.id}"
  direction              = "ingress"
  v4_cidr_blocks         = ["0.0.0.0/24"]
  port                   = 5601
  protocol               = "ANY"
}


resource "yandex_vpc_security_group_rule" "out" {
  security_group_binding = "${yandex_vpc_security_group.secure.id}"
  direction              = "egress"
  v4_cidr_blocks         = ["0.0.0.0/24"]
  port                   = -1
  protocol               = "ANY"
}
*/




resource "yandex_vpc_gateway" "egress-gateway" {
  name = "egress-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "gate" {
  network_id = data.yandex_vpc_network.net.id#"${yandex_vpc_network.lab-net.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.egress-gateway.id#"${yandex_vpc_gateway.egress-gateway.id}"
  }
}

resource "yandex_vpc_subnet" "sub-1" {
  name = "sub-1"
  v4_cidr_blocks = ["192.168.0.0/28"]
  zone           = "ru-central1-a"
  network_id     = data.yandex_vpc_network.net.id
  route_table_id = yandex_vpc_route_table.gate.id
}

resource "yandex_vpc_subnet" "sub-2" {
  name = "sub-2"
  v4_cidr_blocks = ["192.168.0.16/28"]
  zone           = "ru-central1-b"
  network_id     = data.yandex_vpc_network.net.id
  route_table_id = yandex_vpc_route_table.gate.id
}

resource "yandex_vpc_subnet" "pub" {
  name = "pub"
  v4_cidr_blocks = ["192.168.0.32/28"]
  zone           = "ru-central1-b"
  network_id     = data.yandex_vpc_network.net.id
}
