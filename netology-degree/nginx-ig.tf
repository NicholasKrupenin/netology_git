resource "yandex_compute_instance_group" "nginx" {
  name = "http-server"
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
