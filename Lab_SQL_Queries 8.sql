-- Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.
-- 

select length, title, rank() over(order by length desc) as 'Rank'
from sakila.film 
WHERE
    length IS NOT NULL
    AND length > 0;

-- Rank films by length within the rating category
-- (filter out the rows with nulls or zeros in length column).
-- In your output, only select the columns title, length, rating and rank.

select length, title, rating, rank() over(partition by rating order by length desc ) as 'Rank_len'
from sakila.film 
WHERE
    length IS NOT NULL
    AND length > 0;
    
-- How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".    
-- checking table first and joining parameter category Id
select *
from sakila.category;

select *
from sakila.film_category;

-- joining table  and couting movies by categorie
SELECT c.name , count(f.film_id)
FROM sakila.category c
LEFT JOIN sakila.film_category f ON c.category_id = f.category_id
GROUP BY c.name;

-- result 
-- 'Action', '64'
-- 'Animation', '66'
-- 'Children', '60'
-- 'Classics', '57'
-- 'Comedy', '58'

-- Which actor has appeared in the most films?
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select *
from sakila.actor;

select *
from sakila.film_actor;

-- creating a join table between actor and film id , and use of count to get numbers of actor

SELECT a.actor_id , count(f.film_id) as film_count
FROM sakila.actor a
LEFT JOIN sakila.film_actor f ON f.actor_id = a.actor_id
GROUP BY a.actor_id;

-- Which is the most active customer (the customer that has rented the most number of films)?
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select *
from sakila.customer;

select *
from sakila.rental;

-- using count and join to get the list of rental count by customer 
-- after order by desc to get the customer ID with the most rental

-- customer Id, 148 with most rent 
SELECT r.customer_id , count(r.rental_id) as rent_count
FROM sakila.rental r
LEFT JOIN sakila.customer c ON r.customer_id = c.customer_id
GROUP BY r.customer_id
order by count(r.rental_id) desc;

-- Bonus question 

SELECT
    f.title AS most_rented_film,
    COUNT(r.rental_id) AS rental_count
FROM
    sakila.film f
JOIN
    sakila.inventory i ON f.film_id = i.film_id
JOIN
    sakila.rental r ON i.inventory_id = r.inventory_id
GROUP BY
    f.title
ORDER BY
    rental_count DESC
LIMIT 1;