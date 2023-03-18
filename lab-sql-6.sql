use sakila;

-- 1

select title, length, rank() over (order by length asc) as 'rank' from film
where length > 0;

-- 2

select title, length, rating, rank() over (partition by rating order by length desc) as 'rank' from film;

-- 3

select count(f.category_id) as 'movie count', name from category c 
	right join film_category f on c.category_id = f.category_id
    group by c.name;
    
-- 4

select count(f.actor_id) as 'appearence count', CONCAT(first_name, ' ', last_name) as full_name from actor a 
	right join film_actor f on a.actor_id = f.actor_id
    group by full_name;
    
-- 5

select count(r.rental_id) as 'rental count', CONCAT(first_name, ' ', last_name) as full_name from customer c 
	right join rental r on c.customer_id = r.customer_id
    group by full_name;
    
-- Bonus

with rental_counts as (
select count(r.rental_id) as rental_count, film_id from inventory i 
	right join rental r on i.inventory_id = r.inventory_id
	group by film_id
    )
select title, rental_counts.* from film
join rental_counts on film.film_id = rental_counts.film_id
order by rental_counts.rental_count desc
limit 1;