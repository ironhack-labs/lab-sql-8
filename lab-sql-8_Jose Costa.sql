#1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title, length, dense_rank() over (order by length desc) as rnk from sakila.film where (length is not null) or (length!=0);

#2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
# In your output, only select the columns title, length, rating and rank.

select title, length, rating, dense_rank() over (partition by rating order by length desc) as rnk from sakila.film where (length is not null) or (length!=0);

#3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

select count(c.category_id) as films_count,name from sakila.category c
    left join sakila.film_category f on c.category_id=f.category_id group by name order by name;
    
#4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select count(c.actor_id) as films_count,c.last_name,c.first_name from sakila.actor c
    left join sakila.film_actor f on c.actor_id=f.actor_id group by last_name order by films_count desc limit 1;
    
# 5. Which is the most active customer (the customer that has rented the most number of films)? 
# Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select count(c.customer_id) as rentals_count,f.last_name,f.first_name from sakila.rental c
    left join sakila.customer f on c.customer_id=f.customer_id group by last_name order by rentals_count desc limit 1;
    
# Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
# This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
# Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

select f.title, count(*) as rental_count from sakila.film f
    join sakila.inventory i on f.film_id=i.film_id
    join sakila.rental r on i.inventory_id=r.inventory_id
    group by f.film_id order by rental_count desc limit 1;



