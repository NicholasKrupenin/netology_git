resource "yandex_compute_instance_group" "nginx" {
  name = "http"
  service_account_id = var.service_account_id
  instance_template {

    platform_id = "standard-v1"

    resources {
      core_fraction = 100
      cores  = 2
      memory = 2
  }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.image.id
      }
    }

    network_interface {
      subnet_ids = ["${yandex_vpc_subnet.sub-1.id}", "${yandex_vpc_subnet.sub-2.id}"]
    }

    metadata = {
      user-data = data.template_file.cloud_init.rendered
    }
  }


  scale_policy {
    auto_scale {
      measurement_duration = 60
      cpu_utilization_target = 100
      stabilization_duration = 300
      warmup_duration = 120
      initial_size = 2
      max_size = 3
      min_zone_size = 1
    }
  }

  allocation_policy {
    zones = ["ru-central1-a" ,"ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion = 1
    max_creating = 3
  }

  application_load_balancer {
    target_group_name = "nginx"
  }

}

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

