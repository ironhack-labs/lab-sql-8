-- Rank films by length (filter out the rows with nulls or zeros in length column).
--  Select only columns title, length and rank in your output.

select title, length, rank () over (order by length desc) as 'Rank'
from sakila.film
where length is not null and length > 0;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.

select title, rating, length, rank () over (partition by rating order by length desc) as 'Rank'
from sakila.film
where length is not null and length > 0;

-- Which actor has appeared in the most films? 
select actor.actor_id, actor.first_name, actor.last_name, count(film_actor.film_id) as num_films
from sakila.actor
inner join sakila.film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id, actor.first_name, actor.last_name
order by count(film_actor.film_id) desc
limit 1;

-- Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select customer.customer_id, customer.first_name, customer.last_name, count(rental.rental_id) as num_rentals
from sakila.customer
inner join sakila.rental on rental.customer_id = customer.customer_id
group by customer.customer_id,customer.first_name, customer.last_name
order by count(rental.rental_id) desc
limit 1;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood)
SELECT count(rental.inventory_id) as times_rented, film.title
FROM sakila.rental
JOIN sakila.inventory ON inventory.inventory_id = rental.inventory_id
JOIN sakila.film ON film.film_id = inventory.film_id
group by  film.title
order by count(rental.inventory_id) desc
limit 1; 
