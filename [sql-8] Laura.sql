-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your 
-- output.
select title, length, dense_rank () over (order by length desc) as 'Rank'
from sakila.film
where isnull(length) = False
;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only 
-- select the columns title, length, rating and rank.
select title, rating, length,  
dense_rank () over (partition by rating order by length desc) as 'Rank'
from sakila.film
where isnull(length) = False
;

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" 
-- and "film_category".
select cat.category_id, cat.name as category, count(movie.film_id) as film_count
from sakila.category as cat
left join sakila.film_category as movie 
on cat.category_id = movie.category_id
group by cat.category_id
;

-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the 
-- number of times an actor appears.
select actor.actor_id, actor.first_name, actor.last_name, count(film.film_id) as film_count
from sakila.actor as actor
left join sakila.film_actor as film 
on actor.actor_id = film.actor_id
group by actor.actor_id
;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables 
-- "customer" and "rental" and count the rental_id for each customer.
select cust.customer_id, cust.first_name, cust.last_name, count(rent.rental_id) as rental_count
from sakila.customer as cust
left join sakila.rental as rent
on rent.customer_id = cust.customer_id
group by cust.customer_id
order by rental_count desc
limit 1
;

-- BONUS: Which is the most rented film? (The answer is Bucket Brotherhood).
-- (This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements 
-- later in the lessons.)
-- (Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.)


select film.film_id, film.title, count(rental.rental_id) as rental_count
from sakila.inventory as inventory
join sakila.film as film
on inventory.film_id = film.film_id
join sakila.rental as rental
on inventory.inventory_id = rental.inventory_id
group by film.film_id
order by rental_count desc
limit 1
;