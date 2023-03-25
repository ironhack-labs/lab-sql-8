-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title, length, rank() over (order by length desc) as rnk
from sakila.film
where length is not null and length > 0;

-- 2. Rank films by length within the rating category 
-- (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

select title, length, rank() over (order by length, rating desc) as rnk
from sakila.film
where length is not null and length > 0;

-- 3. How many films are there for each of the categories in the category table? Hint: 
-- Use appropriate join between the tables "category" and "film_category"

select c.name as category_name, count(*) as film_count
from sakila.film_category fc
join sakila.category c ON fc.category_id = c.category_id
group by c.name
order by film_count desc;

-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select actor_id, count(*) as film_count
from sakila.film_actor
group by actor_id
order by film_count DESC
limit 1;

select actor.actor_id, actor.first_name, actor.last_name, count(*) as film_count
from sakila.actor
join sakila.film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
order by film_count desc
limit 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

Select first_name, last_name,
count(rental_id) as most_active_custumers
from sakila.customer c
join sakila.rental r
on c.customer_id = r.customer_id
group by c.customer_id
order by most_active_custumers desc;
