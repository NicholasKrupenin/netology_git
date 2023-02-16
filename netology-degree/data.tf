data "template_file" "cloud_init" {
  template = file("user.yml")
  vars = {
    user = var.user
    ssh_key = file(var.ssh_key)
  }
}

data "yandex_compute_image" "image" {
  family = "centos-7"
}