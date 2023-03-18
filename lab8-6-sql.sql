-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT
	title, length,
    rank() over (order by length desc) as rnk
FROM sakila.film
WHERE length > 0
ORDER BY length desc;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

SELECT
	title, length,rating,
    rank() over (partition by rating order by length desc) as rnk
FROM sakila.film
WHERE length > 0
ORDER BY rating desc;


-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

SELECT category_id, count(title)
FROM sakila.film_category c
JOIN sakila.film f ON c.film_id = f.film_id
GROUP BY category_id;

-- Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT 
	first_name, last_name, count(film_id) as num_of_films
FROM sakila.actor a
JOIN sakila.film_actor f ON a.actor_id = f.actor_id
GROUP BY a.actor_id
ORDER BY num_of_films desc;

-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT 
	first_name, last_name , count(rental_id) as num_of_rentals
FROM sakila.rental r
LEFT JOIN sakila.customer c ON r.customer_id = c.customer_id
GROUP BY r.customer_id
ORDER BY num_of_rentals desc;


-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

SELECT 
	title, COUNT(rental_id) as countfilm
FROM sakila.inventory i
JOIN  sakila.film f ON i.film_id = f.film_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY countfilm desc
LIMIT 1;



