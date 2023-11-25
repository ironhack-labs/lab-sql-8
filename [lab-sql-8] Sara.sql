-- DA PT 2023 
-- Sara Ferreira da Silva

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.
select title, length, rank() over (order by length) as rnk
from sakila.film
where length > 0 and length is not null
order by length;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
select title, length, rating, rank() over (partition by rating order by length) as rnk
from sakila.film
where length > 0 and length is not null
order by rating, length;

-- 3. How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".
select c.name, count(*) as number_of_films
from sakila.category c
left join sakila.film_category fc
on c.category_id = fc.category_id
group by name;

-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor"
-- And count the number of times an actor appears.

select actor.first_name, actor.last_name, count(film_actor.film_id) as number_of_films
from sakila.actor actor
left join sakila.film_actor film_actor
on actor.actor_id = film_actor.actor_id
group by actor.actor_id
order by number_of_films desc
limit 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select * from sakila.customer;
select * from sakila.rental;
select * from sakila.film;

select c.first_name, c.last_name, count(r.rental_id) as number_of_rented_films
from sakila.customer c 
left join sakila.rental r 
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by number_of_rented_films desc
limit 1;

-- BONUS: Which is the most rented film? (The answer is Bucket Brotherhood).
select
	f.film_id,
    f.title,
    count(r.rental_id) as rental_num
from sakila.film f
join sakila.inventory i 
on f.film_id = i.film_id
left join sakila.rental r 
on i.inventory_id = r.inventory_id
group by f.film_id
order by rental_num desc
limit 1;

