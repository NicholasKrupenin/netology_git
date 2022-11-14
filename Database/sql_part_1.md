### Задание 1.

<!-- ![](/Database/img/sql_1jpg.png) -->

```sql
SELECT DISTINCT a.district
FROM address a 
WHERE LEFT (a.district, 1) = "K" AND RIGHT (a.district, 1) = "a" AND NOT INSTR(a.district, ' ');
``` 
---
### Задание 2.

```sql
SELECT p.amount, p.payment_date 
FROM payment p 
WHERE p.amount > 10 AND  p.payment_date BETWEEN '2005-05-15 00:00:00' AND '2005-06-19 00:00:00';
```

---
### Задание 3.

```sql
SELECT r.* 
FROM rental r
ORDER BY r.rental_date DESC  
LIMIT 5;
```

---
### Задание 4.

```sql
SELECT LOWER(REPLACE(c.first_name, 'LL', 'PP')) name 
FROM customer c 
WHERE c.first_name = 'KELLY' OR c.first_name = 'WILLIE';
```


