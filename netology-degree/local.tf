resource "local_file" "ansible_host" {
  content = <<-DOC
    [app_servers]   
    nginx1 ansible_host=${yandex_compute_instance_group.nginx.instances[0].network_interface[0].ip_address}
    nginx2 ansible_host=${yandex_compute_instance_group.nginx.instances[1].network_interface[0].ip_address}
    prometheus ansible_host=${yandex_compute_instance.prometheus.network_interface[0].ip_address}
    kibana ansible_host=${yandex_compute_instance.kibana.network_interface[0].ip_address}
    elasticsearch ansible_host=${yandex_compute_instance.elasticsearch.network_interface[0].ip_address}
    grafana ansible_host=${yandex_compute_instance.grafana.network_interface[0].ip_address}
  
    [app_servers:vars]
    raw=${path.cwd}
    ansible_user=${var.user}
    ansible_ssh_private_key_file=${var.ssh_key_private}
    ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ${var.user}@${yandex_compute_instance.bastion.network_interface[0].nat_ip_address}"' 
    DOC
  filename = "./inventory.ini"
}

resource "local_file" "var" {
  content = <<-DOC
    nginx1: ${yandex_compute_instance_group.nginx.instances[0].network_interface[0].ip_address} 
    nginx2: ${yandex_compute_instance_group.nginx.instances[1].network_interface[0].ip_address}
    prometheus: ${yandex_compute_instance.prometheus.network_interface[0].ip_address} 
    kibana: ${yandex_compute_instance.kibana.network_interface[0].ip_address}
    elasticsearch: ${yandex_compute_instance.elasticsearch.network_interface[0].ip_address} 
    grafana: ${yandex_compute_instance.grafana.network_interface[0].ip_address}
    DOC
  filename = "./raw_docker/var.yml"
}

