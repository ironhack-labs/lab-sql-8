use sakila;

SELECT title, length, RANK() OVER (ORDER BY length) AS

SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length) AS rank
FROM film_view
ORDER BY rating, rank;

select a.name as category, count(*) as 'Film_count'
from category a
join film_category fc on a.category_id = fc.category_id
group by c.name;
​
select a.actor_id, a.first_name, a.last_name, count(*) as film_count
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id
order by film_count desc limit 1;
​

select c.customer_id, c.first_name, c.last_name, count(*) as rental_count
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by rental_count desc limit 1;











