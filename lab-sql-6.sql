-- Instructions

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

Select
	title,
    length,
    rank() over (order by length desc) as rnk
From sakila.film;

-- 2. Rank films by length within the rating category 
-- (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

Select
	title,
    length,
    rating,
    rank() over (order by length desc) as rnk
From sakila.film
order By rating desc;

-- 3. How many films are there for each of the categories in the category table? Hint: 
-- Use appropriate join between the tables "category" and "film_category".


Select
name,
count(*) as film_categories
from sakila.category c
join sakila.film_category f
on c.category_id = f.category_id
group by name;


-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

Select
first_name,
last_name,
count(*) as actor_appearences
from sakila.actor a
join sakila.film_actor f
on a.actor_id = f.actor_id
group by a.actor_id
order by actor_appearences desc;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

Select
first_name,
last_name,
count(rental_id) as most_active_custumers
from sakila.customer c
join sakila.rental r
on c.customer_id = r.customer_id
group by c.customer_id
order by most_active_custumers desc;


-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

Select
title,
count() as most_rental_movies
from sakila.film f
join sakila.inventory i 
on f.film_id = i.film_id
group by f.film_id
order by most_rental_movies desc


