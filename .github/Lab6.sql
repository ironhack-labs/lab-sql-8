use sakila;
select *  from sakila.customer;

-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select
    TITLE, LENGTH,
    rank() over (order by LENGTH) as rnk 
from FILM
where length > 0 AND length is not null
order by LENGTH;
	
-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the 
-- columns title, length, rating and rank.
select
    TITLE, LENGTH, RATING,
    rank() over (order by LENGTH) as rnk 
from FILM
where length > 0 AND length is not null
order by RATING;
select * from sakila.category;
-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and 
-- "film_category".
SELECT c.name AS category_name, COUNT(*) AS film_count
FROM sakila.category c
JOIN sakila.film_category fc ON fc.category_id = c.category_id
GROUP BY c.category_id;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times 
-- an actor appears.

SELECT first_name, last_name, a.actor_id, COUNT(fa.film_id) AS number_films
FROM sakila.actor a
JOIN sakila.film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY number_films DESC limit 1;

-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" 
-- and "rental" and count the rental_id for each customer.
select count(c.customer_id) as rentals_count,f.last_name,f.first_name 
from sakila.rental c
left join sakila.customer f on c.customer_id=f.customer_id 
group by last_name 
order by rentals_count desc limit 1;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
select f.title, count(*) as rental_count 
from sakila.film f
    join sakila.inventory i on f.film_id=i.film_id
    join sakila.rental r on i.inventory_id=r.inventory_id
    group by f.film_id order by rental_count desc limit 1;
