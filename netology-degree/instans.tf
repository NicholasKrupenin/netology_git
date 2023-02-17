resource "yandex_compute_instance" "bastion" {
  name = "bastion"
  zone = "ru-central1-b"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.pub.id 
    nat = true 

    security_group_ids = [yandex_vpc_security_group.bastion.id]
  }

  provisioner "remote-exec" {
    inline = ["echo Server its up!"]
  
    connection {
      type = "ssh"
      user = var.user
      private_key = file(var.ssh_key_private)
      host = self.network_interface[0].nat_ip_address
    }
  }
 
 metadata = {
    user-data = data.template_file.cloud_init.rendered
  }
}

resource "yandex_compute_instance" "kibana" {
  name = "kibana"
  zone = "ru-central1-b"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.pub.id
    nat = true
    security_group_ids = [yandex_vpc_security_group.kibana.id]
  }

 metadata = {
    user-data = data.template_file.cloud_init.rendered
  }

}

resource "yandex_compute_instance" "grafana" {
  name = "grafana"
  zone = "ru-central1-b"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
    }
  }

 network_interface {
    subnet_id = yandex_vpc_subnet.pub.id 
    nat = true 
    security_group_ids = [yandex_vpc_security_group.grafana.id]
  }

 metadata = {
    user-data = data.template_file.cloud_init.rendered
  }

}

resource "yandex_compute_instance" "elasticsearch" {
  name = "elasticsearch"
  zone = "ru-central1-a"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sub-1.id
  }

 metadata = {
    user-data = data.template_file.cloud_init.rendered
  }

}

resource "yandex_compute_instance" "prometheus" {
  name = "prometheus"
  zone = "ru-central1-b"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sub-2.id
  }

 metadata = {
    user-data = data.template_file.cloud_init.rendered
  }

}
