-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.

select title, length,
rank() over (order by length asc) as 'rank'
from sakila.film
where length is not null
;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.

select title, length, rating,
rank() over (partition by rating order by length asc) as 'rank'
from sakila.film
where length is not null 
;

-- 3. How many films are there for each of the categories in the category table?
--  Hint: Use appropriate join between the tables "category" and "film_category".

select cat.name as category, count(film.film_id) as films
from sakila.category cat
inner join sakila.film_category film
on cat.category_id = film.category_id
group by cat.category_id, cat.name
order by films desc
;

-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select  f_actor.actor_id, actor.first_name, actor.last_name, count(f_actor.film_id) as count 
from sakila.actor actor
inner join sakila.film_actor f_actor
on actor.actor_id = f_actor.actor_id
group by f_actor.actor_id
order by count desc
Limit 1
;

-- The actor that appeared in the most films was Gina Degeneres with a total of 42.

-- 5. Which is the most active customer (the customer that has rented the most number of films)?
--  Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select cust.customer_id, cust.first_name, cust.last_name, count(rent.rental_id) as count
from sakila.customer cust
inner join sakila.rental rent
on cust.customer_id = rent.customer_id
group by rent.customer_id
order by count desc
;

-- The customer that rented the most films was Eleanor Hunt with 46 films.

