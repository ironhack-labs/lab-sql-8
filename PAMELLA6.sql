USE sakila;

-- 1.Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT title, length, RANK() OVER (ORDER BY length DESC) AS length_rank
FROM film
WHERE length IS NOT NULL AND length > 0;

-- 2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS length_rank
FROM film
WHERE length IS NOT NULL AND length > 0;

-- 3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT category.name, COUNT(*) AS film_count
FROM film_category fc
JOIN category ON fc.category_id = category.category_id
GROUP BY category.name;

-- 4.Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT actor.first_name, actor.last_name, COUNT(*) AS film_count
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY film_count DESC
LIMIT 1;

-- 5.Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT customer.first_name, customer.last_name, COUNT(*) AS rental_count
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY rental_count DESC
LIMIT 1;

-- BONUS Which is the most rented film? (The answer is Bucket Brotherhood).
SELECT film.title, COUNT(*) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY rental_count DESC
LIMIT 1;
