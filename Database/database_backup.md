### <span style="color:yellow">Задание 1.</span>

```
1.1 differential backup
1.2 Incremental backup
1.3 Да, когда БД M-M (мастер-мастер)
```

### <span style="color:yellow">Задание 2.</span>

```sql
pg_dump <параметры> <имя базы> > <файл для сохранения копии> 
pg_dump  <параметры> <имя базы> > <файл для сохранения копии> | gzip > <путь сохранения сжатого дампа>.gz
pg_restore <параметры> <имя базы>  -d <имя дампа> 
```
[blog](https://selectel.ru/blog/postgresql-backup-tools/)

```
cron + bash,ruby,python and etc...
```

### <span style="color:yellow">Задание 3.</span>

```sql
Двоичное ведение журнала MySQL

log-bin="v:/dbbackup/db-bin-log"
#binlog-do-db=
#log-slow-queries=
#max_binlog_size=
#binlog-ignore-db=

mysqldump -u root -p*** --single-transaction
                    --flush-logs
                    --master-data=2
                    --delete-master-logs
                    --all-databases > v:/dbbackup/db_full_back.sql

mysqladmin -u root -p*** flush-logs

mysqlbinlog -u root -p*** v:/dbbackup/db-bin-log.000002 > v:/dbbackup/db-bin-log.000002.sql

mysql -u root -p*** < v:/dbbackup/db_full_back.sql


mysql -u root -p*** < v:/dbbackup/db-bin-log.000001.sql
mysql -u root -p*** < v:/dbbackup/db-bin-log.000002.sql
mysql -u root -p*** < v:/dbbackup/db-bin-log.000003.sql
 
... ...
```
[blog](https://russianblogs.com/article/3455374543/)
