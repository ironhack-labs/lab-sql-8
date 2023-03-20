-- 1

select title, length, rank() over (order by length desc) as rnk
from sakila.film
where length is not null and length > 0;

-- 2
select title, length, rank() over (order by length, rating desc) as rnk
from sakila.film
where length is not null and length > 0;

-- 3

select c.name as category_name, count(*) as film_count
from sakila.film_category fc
join sakila.category c ON fc.category_id = c.category_id
group by c.name
order by film_count desc;

-- 4

select actor_id, count(*) as film_count
from sakila.film_actor
group by actor_id
order by film_count DESC
limit 1;

select actor.actor_id, actor.first_name, actor.last_name, count(*) as film_count
from sakila.actor
join sakila.film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
order by film_count desc
limit 1;

-- 5 incomplete

select actor.actor_id, actor.first_name, actor.last_name, count(*) as film_count
from sakila.actor
join sakila.film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
order by film_count desc
limit 1;

