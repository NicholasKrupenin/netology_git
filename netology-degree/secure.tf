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
    description    = "Allow 3000 port"
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
    description    = "Allow 5601 port"
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
