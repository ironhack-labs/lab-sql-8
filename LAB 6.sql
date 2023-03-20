-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT
	sum(ISNULL(length))
FROM sakila.film;




SELECT
	title,
	length,
    rank() over (order by length  desc) as rnk
FROM sakila.film;



-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT
	title,
	length,
    rating,
    rank() over (order by length desc) as rnk
FROM sakila.film
ORDER BY rating;

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT
	name,
    count(*) as film_categories	
FROM sakila.category c
JOIN sakila.film_category f ON f.category_id = c.category_id
group by name
;

-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT
	a.first_name,
    a.last_name,
    count(*) as actor_appeared	
FROM sakila.actor a
JOIN sakila.film_actor f ON f.actor_id = a.actor_id
group by a.actor_id
order by actor_appeared desc;




-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT
	c.first_name,
    c.last_name,
    count(rental_id) as best_customer	
FROM sakila.customer c
JOIN sakila.rental r ON r.customer_id = c.customer_id
group by first_name,last_name
order by best_customer desc;


-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
SELECT
	f.title,
    count(r.rental_id) as most_rented	
FROM sakila.film f
JOIN sakila.inventory i ON i.film_id = f.film_id
JOIN sakila.rental r ON r.inventory_id = i.inventory_id
group by f.title
order by most_rented desc LIMIT 1
;





