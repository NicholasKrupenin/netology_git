
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

![](/Databases_and_their_types/img/nginx_2.jpg)

## Задание 4. Filebeat.
Установить и запустить Filebeat. Переключить поставку логов Nginx с Logstash на Filebeat.

> Так же как и в предыдущем.

---

```yml
version: '3.7'

services:
  elasticsearch:
    image: elasticsearch:7.16.1
    volumes:
      - ./configs/elasticsearch/config.yml:/usr/share/elasticsearch/config/elasticsearch.yml:ro
    environment:
      ES_JAVA_OPTS: "-Xmx512m -Xms512m"
      ELASTIC_USERNAME: "elastic"
      ELASTIC_PASSWORD: "Awesome123"
      discovery.type: single-node
    networks:
      - elk
    ports:
      - "9200:9200"
      - "9300:9300"

  logstash:
    image: logstash:7.16.2
    volumes:
      - ./configs/logstash/config.yml:/usr/share/logstash/config/logstash.yml:ro
      - ./configs/log/nginx:/var/log/nginx
      - ./configs/pipe/pipelines.yml:/usr/share/logstash/config/pipelines.yml:ro
      - ./configs/pipe/pipelines:/usr/share/logstash/config/pipelines:ro
    environment:
      LS_JAVA_OPTS: "-Xmx512m -Xms512m"
    ports:
      - "5044:5044"
      - "5000:5000"
      - "9600:9600"
    networks:
      - elk
    depends_on:
      - elasticsearch

  kibana:
    image: kibana:7.16.1
    depends_on:
      - elasticsearch
    volumes:
      - ./configs/kibana/config.yml:/usr/share/kibana/config/kibana.yml:ro
    networks:
      - elk
    ports:
      - "5601:5601"

  nginx:
    image: nginx:latest
    depends_on:
      - elasticsearch
    volumes:
      - ./configs/log/nginx:/var/log/nginx 
    networks:
      - elk
    ports:
      - "8080:80"

  beats:
    image: elastic/filebeat:7.16.2
    volumes:
      - ./configs/filebeat/config.yml:/usr/share/filebeat/filebeat.yml:ro
      - ./configs/log/nginx:/var/log/nginx
    networks:
      - elk
    ports:
      - "5044:5044"
    depends_on:
    - elasticsearch

networks:
  elk:
    driver: bridge
```
