select title, length, rank() over (order by length desc) as length_rank from sakila.film
where length > 0;

select title, length, rating, rank() over (partition by rating order by length desc) as length_rank 
from sakila.film where length > 0;

select name, count(film_id) as nr_films 
from sakila.category inner join sakila.film_category 
on sakila.category.category_id = sakila.film_category.category_id 
group by category.name;

select concat(first_name, " ", last_name) as actor_name, count(film_id) as nr_of_appearances 
from sakila.actor inner join sakila.film_actor on sakila.actor.actor_id = sakila.film_actor.actor_id 
group by actor.actor_id order by 2 desc limit 1;

select concat(first_name, " ", last_name) as customer_name, count(rental_id) as nr_of_rentals 
from sakila.customer inner join sakila.rental on sakila.customer.customer_id = sakila.rental.customer_id 
group by sakila.customer.customer_id order by 2 desc limit 1;

#bonus
select title, count(rental_id) as nr_of_rentals
  from sakila.film
  inner join sakila.inventory
  on sakila.film.film_id = sakila.inventory.film_id
  inner join sakila.rental
  on sakila.inventory.inventory_id = sakila.rental.inventory_id
  group by sakila.film.title
  order by 2 desc limit 1;