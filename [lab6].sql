-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.
select title, length, rank() over(order by length desc) as rank_lenght from sakila.film
where length is not null;

-- 2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
select title, rating, rank() over(order by length) as rank_lenght from sakila.film
where length is not null
order by 3 asc;

-- 3. How many films are there for each of the categories in the category table? **Hint**: 
-- Use appropriate join between the tables "category" and "film_category".
select cat.name, film_cat.category_id, count(film_cat.film_id) as count_film_cat
from sakila.film_category film_cat
left join sakila.category cat
on film_cat.category_id = cat.category_id
group by 1,2
order by 3 desc;

-- 4. Which actor has appeared in the most films? **Hint**: You can create a join between the tables "actor" and "film actor" 
-- and count the number of times an actor appears. GINA DEGENERES 42
select act.first_name, act.last_name, count(film_act.actor_id) as count_film_act
from sakila.film_actor film_act
left join sakila.actor act 
on film_act.actor_id = act.actor_id
group by film_act.actor_id
order by 3 desc
limit 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? **Hint**: 
-- Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer. ELEANOR HUNT 46
select cus.first_name, cus.last_name, count(rent.customer_id) as count_film_rent
from sakila.rental rent
left join sakila.customer cus 
on rent.customer_id = cus.customer_id
group by rent.customer_id
order by 3 desc
limit 1;

-- Which is the most rented film? (The answer is Bucket Brotherhood). CORRECT
select film.title, count(rental_id) as count_best
from sakila.rental rent
left join sakila.inventory inv 
on rent.inventory_id = inv.inventory_id
left join sakila.film film
on inv.film_id = film.film_id
group by film.film_id
order by 2 desc
limit 1;