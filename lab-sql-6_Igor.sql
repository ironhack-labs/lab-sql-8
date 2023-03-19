-- Lab | SQL Queries 8

-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

SELECT 
	title, 
	length, 
RANK() OVER (ORDER BY length) as rnk
FROM sakila.film
WHERE length IS NOT NULL AND length > 0
ORDER BY length;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.

SELECT 
	title, 
    length, 
    rating, 
RANK() OVER (PARTITION BY rating ORDER BY length ASC) as rnk -- The PARTITION BY clause divides the data into partitions 
																	-- based on the rating column
FROM sakila.film
WHERE length > 0 AND length IS NOT NULL;

-- How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".

SELECT 
	category.name, 
	COUNT(film_category.film_id) as num_films
FROM sakila.category
JOIN sakila.film_category ON category.category_id = film_category.category_id
GROUP BY category.name;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and 
-- "film actor" and count the number of times an actor appears.

SELECT 
	actor.first_name, 
    actor.last_name, 
COUNT(film_actor.actor_id) as num_films
FROM sakila.actor
JOIN sakila.film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY num_films DESC
LIMIT 1;

-- Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT 
	first_name, 
	last_name, 
COUNT(rental_id) as num_rentals
FROM sakila.customer
JOIN sakila.rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY num_rentals DESC
LIMIT 1;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).

-- This query might require using more than one join statement. Give it a try. 
-- We will talk about queries with multiple join statements later in the lessons.

-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

SELECT 
    f.title as most_rented_film,
    COUNT(*) as total_rentals
FROM sakila.film f
JOIN sakila.inventory i ON f.film_id = i.film_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 1;