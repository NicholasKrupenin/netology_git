### <span style="color:yellow">Задание 1.</span>

```sql
SELECT CONCAT(s2.first_name, ' ',s2.last_name) Staff, (SELECT g.city FROM city g WHERE g.city_id  = a.city_id)  City, COUNT(c.store_id) Customer 
FROM store s 
JOIN staff s2 ON s2.staff_id  = s.manager_staff_id 
JOIN customer c ON s.store_id  = c.store_id 
JOIN address a  ON s.address_id = a.address_id        
GROUP BY c.store_id
ORDER BY COUNT(c.store_id) DESC
LIMIT 1;
```

---
### <span style="color:yellow">Задание 2.</span>

```sql
SELECT COUNT(f.film_id)
FROM film f 
WHERE f.`length`> (SELECT AVG(f.`length`) FROM film f);
```

---
### <span style="color:yellow">Задание 3.</span>

```sql
SELECT COUNT(DATE_FORMAT(r.rental_date  , '%M – %Y')) `Rental`, SUM(p.amount) Amount, DATE_FORMAT(p.payment_date , '%M – %Y') `Date`
FROM payment p 
JOIN rental r ON r.rental_id = p.rental_id 
GROUP BY DATE_FORMAT(p.payment_date , '%M – %Y')
ORDER BY SUM(p.amount) DESC, COUNT(DATE_FORMAT(r.rental_date  , '%M – %Y')) DESC 
LIMIT 1;
```

---
### <span style="color:yellow">Задание 4.</span> :suspect:

```sql
SELECT CONCAT(s.first_name, ' ',s.last_name) Staf, COUNT(r.rental_id) Rent,
CASE 
	WHEN COUNT(r.rental_id) > 8000 THEN 'Award'  
	ELSE 'Nope'
END 'Award'
FROM staff s 
JOIN rental r ON r.staff_id  = s.staff_id 
GROUP BY CONCAT(s.first_name, ' ',s.last_name);
```
---
### <span style="color:yellow">Задание 5.</span> :shipit:

```sql
SELECT f.title  
FROM film f  
LEFT JOIN inventory i ON i.film_id = f.film_id  
LEFT JOIN rental r ON r.inventory_id = i.inventory_id  
WHERE r.rental_id IS NULL;
```


