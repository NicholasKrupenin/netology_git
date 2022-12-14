### Задание 1.

Что такое балансировка нагрузки и зачем она нужна?

> * сервис, который занимается распределением нагрузки между пулом приложений, которые находятся за ним, стараясь максимизировать скорость и утилизировать ресурсы приложений. Также, гарантирует, что приложения не будут перегружены. Бывают hardware и software решения
> 
> [преимущества]
>
> * сокращение времени простоя,
> * масштабируемость,
> * отказоустойчивость.

---
### Задание 2.

Чем отличаются между собой алгоритмы балансировки round robin и weighted round robin? В каких случаях каждый из них лучше применять?

> * **round robin** - Запросы распределяются по пулу сервером последовательно.
> * **weighted round robin** - Тот же **round robin**, но имеет дополнительное свойство — вес сервера. 
> 
> [применение] 
>
> * **round robin** - при пуле одинаковых по мощности и задач серверов
> * **weighted round robin** - при пуле разных по мощности и задач серверов

---
### Задание 3 & 4

![](https://github.com/NicholasKrupenin/netology_git/blob/main/Monitoring/img/haproxy_nginx.jpg)

---
### Задание 5.

Настройте nginx на виртуальной машине таким образом, чтобы при запросе:

```sh
curl http://localhost:8088/ping
```

он возвращал в ответе строчку:
"nginx is configured correctly"

![](https://github.com/NicholasKrupenin/netology_git/blob/main/Monitoring/img/nginx.jpg)
