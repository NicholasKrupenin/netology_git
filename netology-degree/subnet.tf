data "yandex_vpc_network" "net" {
  name = "nw"               #Созданная сеть
}

resource "yandex_vpc_gateway" "egress-gateway" {
  name = "egress-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "gate" {
  network_id = data.yandex_vpc_network.net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.egress-gateway.id
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
