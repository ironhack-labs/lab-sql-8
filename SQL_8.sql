
-- 1. Rank films by length (filter out the rows with nulls or zeros in length column)
select title, length, rank() over (partition by length order by length desc) as "Ranks_duration"
from sakila.film
where (length <> " ") and (length <> 0);

-- 2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column).

select title, length, rating, rank() over (partition by rating order by length desc) as "Rating_length"
from sakila.film
where (length <> " ") and (length <> 0);


-- 3. How many films are there for each of the categories in the category table? 
-- **Hint**: Use appropriate join between the tables "category" and "film_category".
select cat.name, count(film_id) as number_of_films_per_category
from sakila.category cat
left join sakila.film_category fcat
on cat.category_id=fcat.category_id
group by cat.name;


-- 4. Which actor has appeared in the most films?
-- **Hint**: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select * from sakila.actor;
select * from sakila.film_actor;
select * from sakila.film;

select act.actor_id, concat(first_name, " ", last_name) as actor_full_name, count(*) as actor_film_count
from sakila.actor as act
left join sakila.film_actor f_act
on act.actor_id = f_act.actor_id
group by actor_id
order by count(*) desc
limit 1;


-- 5. Which is the most active customer (the customer that has rented the most number of films)? 

select c.customer_id, concat(first_name, " ", last_name) as customer_full_name, count(*) as best_customer
from sakila.customer as c
left join sakila.rental ren
on c.customer_id = ren.customer_id
group by customer_id
order by count(*) desc
limit 1;

-- **Bonus**: Which is the most rented film? (The answer is Bucket Brotherhood).
select f.film_id, f.title, count(rental_id) as most_rented_film
from sakila.film f 
left join sakila.inventory i
on f.film_id = i.film_id
left join sakila.rental ren
on i.inventory_id = ren.inventory_id
group by film_id
order by count(rental_id) desc
limit 1;
