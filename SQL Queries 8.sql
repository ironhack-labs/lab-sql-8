USE sakila;

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT
	title,
    length,
    rank() over (order by length) as rnk
FROM film
WHERE length > 0 and length is not null
ORDER BY length;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
-- In your output, only select the columns title, length, rating and rank.
SELECT
	title,
    length,
    rating,
    rank() over (partition by rating order by length) as rnk
FROM film
WHERE length > 0 and length is not null
ORDER BY rating,length;

-- 3. How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".
SELECT
	c.category_id,
    c.name,
    count(fc.category_id) as num_films
FROM category c
LEFT JOIN film_category fc ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY c.category_id
;

-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT
	a.actor_id,
    a.first_name,
    a.last_name,
    count(fa.actor_id) as film_count
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY 4 DESC
LIMIT 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT
	c.customer_id,
    c.first_name,
    c.last_name,
    count(r.customer_id) as rental_num
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY 4 DESC
LIMIT 1;

-- Bonus. Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. 
-- We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
SELECT
	f.film_id,
    f.title,
    count(r.rental_id) as rental_num
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_num DESC
LIMIT 1;
