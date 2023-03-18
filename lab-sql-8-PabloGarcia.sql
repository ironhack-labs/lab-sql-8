
-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.
SELECT title, length, dense_rank() over(order by length) as rnk FROM sakila.film WHERE length IS NOT NULL AND length > 0 ORDER BY rnk;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
--  In your output, only select the columns title, length, rating and rank.
SELECT title, length, rating, dense_rank() over(partition by rating order by length) as rnk from sakila.film WHERE length IS NOT NULL AND length > 0 ORDER BY rating;

-- 3. How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".
SELECT name, COUNT(*) FROM  sakila.film_category as A JOIN sakila.category as B ON A.category_id = B.category_id group by A.category_id;

-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT A.actor_id, first_name, last_name, COUNT(*) FROM sakila.actor as A JOIN sakila.film_actor as B ON A.actor_id = B.actor_id group by A.actor_id order by count(*) desc;

-- 5. Which is the most active customer (the customer that has rented the most number of films)?
--  Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT A.first_name, A.last_name, COUNT(B.rental_id) FROM sakila.customer as A JOIN sakila.rental as B ON A.customer_id = B.customer_id group by A.customer_id order by count(*) desc;

-- 6. Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
SELECT A.title, COUNT(C.rental_id) FROM sakila.film as A JOIN sakila.inventory as B ON A.film_id = B.film_id JOIN sakila.rental as C ON B.inventory_id = C.inventory_id group by A.title order by COUNT(C.rental_id) desc;

