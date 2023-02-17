resource "yandex_alb_backend_group" "ws-backend-group" {
  name = "ws-backend-group"

  http_backend {
    name             = "ws-http-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_compute_instance_group.nginx.application_load_balancer.0.target_group_id]
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "1s"
      interval = "1s"
      healthcheck_port = 80
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "http-router" {
  name   = "http-router"
}

resource "yandex_alb_virtual_host" "http-host" {
  name           = "http-host"
  http_router_id = yandex_alb_http_router.http-router.id
  route {
    name = "http-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.ws-backend-group.id
        timeout          = "3s"
      }
    }
  }
}

  resource "yandex_alb_load_balancer" "balancer" {
  name        = "degree-balancer"
  network_id  = data.yandex_vpc_network.net.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.sub-1.id
    }

    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.sub-2.id
    }
  }

  listener {
    name = "worker"
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.http-router.id
      }
    }
  }
}

