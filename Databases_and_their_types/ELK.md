
## Задание 1. Elasticsearch.

Установите и запустите elasticsearch, после чего поменяйте параметр cluster_name на случайный.

'curl -X GET 'localhost:9200/_cluster/health?pretty', сделанной на сервере с установленным elasticsearch. Где будет виден нестандартный cluster_name

```sh
➜  ~ curl -X GET 'localhost:9200/_cluster/health?pretty'
{
  "cluster_name" : "krupenin",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
➜  ~
```
---
## Задание 2. Kibana.
Установите и запустите kibana.

![](https://github.com/NicholasKrupenin/netology_git/blob/main/Databases_and_their_types/img/kibana_1.jpg)

## Задание 3. Logstash.
Установить и запустить Logstash и Nginx. С помощью Logstash отправить access-лог nginx в Elasticsearch.

![](https://github.com/NicholasKrupenin/netology_git/blob/main/Databases_and_their_types/img/nginx.jpg)

## Задание 4. Filebeat.
Установить и запустить Filebeat. Переключить поставку логов Nginx с Logstash на Filebeat.

> Так же как и в предыдущем.