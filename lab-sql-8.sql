SELECT
      title,
      length,
      RANK() OVER (PARTITION BY length ORDER BY title DESC) AS rnk
FROM sakila.film
ORDER BY length DESC;

SELECT
     title,
     length,
     rating,
     RANK() OVER (PARTITION BY length ORDER BY title DESC) AS rnk
FROM sakila.film
ORDER BY length DESC;

SELECT
	  category_id,
	  count(*)
FROM sakila.film AS f
JOIN sakila.film_category AS fc ON f.film_id = fc.film_id
GROUP BY category_id;

SELECT
	  a.actor_id,
      a.first_name,
      a.last_name,
	  count(*) as film_cnt
FROM sakila.actor AS a
JOIN sakila.film_actor AS fa ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id;

SELECT
      c.customer_id,
      c.first_name,
	  c.last_name,
      COUNT(r.rental_id) AS num_rentals
FROM sakila.rental AS r
JOIN sakila.customer AS c ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY num_rentals ASC;

SELECT
  f.title,
  COUNT(r.rental_id) AS num_rentals
FROM sakila.film AS f
JOIN sakila.inventory AS i ON f.film_id = i.film_id
JOIN sakila.rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY num_rentals DESC
LIMIT 1;

