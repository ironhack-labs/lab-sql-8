-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select film.title, film.length, rank() over (order by film.length desc) as 'rank'
from sakila.film
where length is not null
;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select film.rating,  film.title, film.length, rank() over (order by film.length desc) as 'rank'
from sakila.film
where length is not null
order by film.rating
;

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select c.name, count(f.film_id) as Qty
from sakila.film_category as f
left join sakila.category as c 
on  c.category_id = f.category_id
group by c.name
order by 2 desc
;


-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select a.first_name, a.last_name,count(a.actor_id) as Qty
from sakila.actor as a
left join sakila.film_actor as fa 
on  a.actor_id = fa.actor_id
group by a.actor_id
order by 3 desc
limit 1
;


-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select c.first_name, c.last_name, count(r.rental_id) as Qty
from sakila.rental as r
left join sakila.customer as c
on  c.customer_id = r.customer_id
group by r.customer_id
order by 3 desc
limit 1
;




-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).

select f.title, count(r.rental_id) as Qty
from sakila.rental as r
left join sakila.inventory as i
on  i.inventory_id = r.inventory_id
left join sakila.film as f
on i.film_id = f.film_id
group by  f.film_id
order by 2 desc
limit 1

-- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.

-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.