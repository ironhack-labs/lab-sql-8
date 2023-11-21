-- 1. Rank films by length (filter out the rows with nulls or zeros in the length column). 
SELECT
    title,
    length,
    RANK() OVER (ORDER BY length DESC) AS 'Rank'
FROM 
    sakila.film
WHERE
    length IS NOT NULL;

-- 2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in the length column). 
SELECT
    title,
    length,
    rating,
    DENSE_RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS 'Rank'
FROM 
    sakila.film
WHERE
    length IS NOT NULL AND length > 0;

-- 3. How many films are there for each of the categories in the category table? 
-- **Hint**: Use appropriate join between the tables "category" and "film_category".
SELECT
    name,
    COUNT(name) AS count_category
FROM
    sakila.film_category film
LEFT JOIN
    sakila.category cat
ON
    film.category_id = cat.category_id
GROUP BY
    name;

-- 4. Which actor has appeared in the most films? 
-- **Hint**: You can create a join between the tables "actor" and "film_actor" and count the number of times an actor appears.
SELECT 
    act.actor_id,
    CONCAT(act.first_name,' ',act.last_name) AS name,
    COUNT(film.actor_id) AS n_films_appeared
FROM
    sakila.film_actor film
INNER JOIN
    sakila.actor act
ON
    film.actor_id = act.actor_id
GROUP BY     
    act.actor_id, act.first_name, act.last_name
ORDER BY
    n_films_appeared DESC;

-- 5. Which is the most active customer (the customer that has rented the most number of films)?
--  **Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer.
SELECT
    CONCAT(cust.first_name,' ',cust.last_name) AS name,
    COUNT(rent.rental_id) AS rental_count,
    RANK() OVER (ORDER BY COUNT(rent.rental_id) DESC) AS 'rank'
FROM 
    sakila.rental rent
LEFT JOIN
    sakila.customer cust
ON
    rent.customer_id = cust.customer_id
GROUP BY     
    cust.customer_id, cust.first_name, cust.last_name
ORDER BY
    rental_count DESC
LIMIT 10;
