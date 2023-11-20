select * from sakila.film;

select title length,
rank() over (order by length) as 'Rank'
from sakila.film
where length is not null and length > 0
order by length;

select 	title, length, rating, 
rank() over(partition by rating order by length ASC) as 'Rank' -- The PARTITION BY clause divides the data into partitions -- based on the rating column
from sakila.film
where length > 0 and length is not null;

Select	category.name, 	count(film_category.film_id) as 'Num_films'
from sakila.category
join sakila.film_category on category.category_id = film_category.category_id
group by category.name;

select actor.first_name, actor.last_name, count(film_actor.actor_id) as 'Num_films'
from sakila.actor
join sakila.film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
order by num_films desc
limit 1;

select first_name, last_name, count(rental_id) as num_rentals
from sakila.customer
join sakila.rental on customer.customer_id = rental.customer_id
group by customer.customer_id
order by num_rentals desc
limit 1;

select f.title as most_rented_film, count(*) as total_rentals
from sakila.film f
join sakila.inventory i on f.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
group by f.title
order by total_rentals desc
limit 1;
