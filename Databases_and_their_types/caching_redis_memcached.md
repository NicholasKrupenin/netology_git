
## Задание 1. Кэширование.
Приведите примеры проблем, которые может решить кэширование.

> Основная функция кэша – ускорение процесса извлечения данных. Он избавляет от необходимости обращаться к менее скоростному базовому уровню хранения. Небольшой объем памяти кэша компенсируется высокой скоростью доступа.  
[Источник](https://aws.amazon.com/ru/caching/)
---
## Задание 2. Memcached.
Установите и запустите memcached.

```sh
➜  ~ sudo systemctl start memcached.service
➜  ~ sudo systemctl status memcached.service
● memcached.service - Memcached
   Loaded: loaded (/usr/lib/systemd/system/memcached.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2022-10-19 14:10:35 UTC; 4s ago
 Main PID: 3120 (memcached)
   CGroup: /system.slice/memcached.service
           └─3120 /usr/bin/memcached -u memcached -p 11211 -m 64 -c 1024

Oct 19 14:10:35 localhost.localdomain systemd[1]: Started Memcached.
➜  ~ w
 14:12:09 up 7 min,  1 user,  load average: 0.03, 0.05, 0.03
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
vagrant  pts/0    10.0.2.2         14:06    1.00s  0.43s  0.01s w
```
---
## Задание 3. Удаление по TTL в Memcached.
Запишите в memcached несколько ключей с любыми именами и значениями, для которых выставлен TTL 5.

```sh
➜  ~ telnet 127.0.0.1 11211
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
add lang 0 5 4
java
STORED
get lang
END
^]

telnet> 	uit
?Invalid command
telnet> quit
Connection closed.
➜  ~
```
---
## Задание 4. Запись данных в Redis.
Запишите в redis несколько ключей с любыми именами и значениями.

Через redis-cli достаньте все записанные ключи и значения из базы, приведите скриншот этой операции.

```sh
➜  ~ redis-cli
127.0.0.1:6379> SET money 10000000$
OK
127.0.0.1:6379> SET village "Phuket"
OK
127.0.0.1:6379> GET money
"10000000$"
127.0.0.1:6379> GET village
"Phuket"
127.0.0.1:6379>
```
---
## Задание 5*. Работа с числами.
Запишите в redis ключ key5 со значением типа "int" равным числу 5. Увеличьте его на 5, чтобы в итоге в значении лежало число 10.

```sh
127.0.0.1:6379> set key5 5
OK
127.0.0.1:6379> incrby key5 5
(integer) 10
127.0.0.1:6379> get key5
"10"
127.0.0.1:6379>
```