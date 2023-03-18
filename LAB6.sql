-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select 
	title,
    length,
    rating,
    rank() over (order by length desc) as rnk
from sakila.film
where length is not null and length > 0 
;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.

select 
	title,
    length,
    rating,
	rank() over (partition by rating order by length desc) as rnk -- gives the number o the row, doens't consider dulicates etc.
    from sakila.film
where length is not null and length > 0 
order by length desc;

-- 3. How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".

select 
	a.category_id,
	count(a.film_id) as num_film    
from sakila.film_category a 
left join sakila.category l on a.category_id = l.category_id 
group by a.category_id
;

-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select 
	a.actor_id,
    first_name, 
    last_name,
	count(a.actor_id) as frequency
from sakila.actor a 
left join sakila.film_actor l on a.actor_id = l.actor_id 
group by a.actor_id
order by frequency desc
;


-- 5. Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select 
	a.customer_id as customer_id,
    first_name,
    last_name,
	count(a.customer_id) as customer_frequency
from sakila.customer a 
left join sakila.rental l on a.customer_id = l.customer_id 
group by a.customer_id
order by customer_frequency desc
;