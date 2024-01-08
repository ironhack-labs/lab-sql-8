-- Rank films by length (filter out the rows with nulls or zeros in length column). 
     -- Select only columns title, length and rank in your output.
-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
     -- In your output, only select the columns title, length, rating and rank.
-- How many films are there for each of the categories in the category table? 
     -- Hint: Use appropriate join between the tables "category" and "film_category".
-- Which actor has appeared in the most films? 
     -- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
-- Which is the most active customer (the customer that has rented the most number of films)? 
     -- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

use sakila;

-- 1 and 2:
SELECT title, length, RANK() OVER (ORDER BY length) AS ranking FROM film WHERE length IS NOT NULL AND length != 0 ORDER BY length;

SELECT c.category_id, c.name AS category_name, COUNT(fc.film_id) OVER (PARTITION BY c.category_id) AS film_count FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
ORDER BY category_name;

SELECT a.actor_id, a.first_name, a.last_name AS most_appeared_actor, COUNT(fa.actor_id) AS film_count
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1;

SELECT c.customer_id, c.first_name, c.last_name AS best_customer, COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC
LIMIT 1;

