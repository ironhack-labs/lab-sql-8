-- Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.

select title, length, rating
from sakila.film
WHERE length IS NOT NULL AND length > 0
Order by length desc;

-- Rank films by length within the rating category 
-- (filter out the rows with nulls or zeros in length column).
-- In your output, only select the columns title, length, rating and rank.

select film.rating,  film.title, film.length, rank() over (order by film.length desc) as 'rank'
from sakila.film
where length is not null
order by film.rating
;

-- How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".

select c.name, count(f.film_id) as Quantity
from sakila.film_category as f
left join sakila.category as c 
on  c.category_id = f.category_id
group by c.name
order by 2 desc

-- Which actor has appeared in the most films?
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select a.first_name, a.last_name,count(a.actor_id) as Quantity
from sakila.actor as a
left join sakila.film_actor as fa 
on  a.actor_id = fa.actor_id
group by a.actor_id
order by 3 desc
limit 1
;

-- Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select film.title, count(rental_id) as count_best
from sakila.rental rent
left join sakila.inventory inv 
on rent.inventory_id = inv.inventory_id
left join sakila.film film
on inv.film_id = film.film_id
group by film.film_id
order by 2 desc
limit 1;

