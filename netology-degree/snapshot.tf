resource "yandex_compute_snapshot_schedule" "cron" {
  name           = "cron"

  schedule_policy {
    expression = "0 5 * * *"
  }

  retention_period = "168h"

  disk_ids = ["${yandex_compute_instance.bastion.boot_disk[0].disk_id}",
              "${yandex_compute_instance.kibana.boot_disk[0].disk_id}",
              "${yandex_compute_instance.grafana.boot_disk[0].disk_id}",
              "${yandex_compute_instance.elasticsearch.boot_disk[0].disk_id}",
              "${yandex_compute_instance.prometheus.boot_disk[0].disk_id}"
]
}
