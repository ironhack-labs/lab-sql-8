use sakila;

#1 Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select
	TITLE, LENGTH,
    rank() over (order by LENGTH) as rnk 
from FILM
where length > 0 AND length is not null
order by LENGTH;

# 2 Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
#In your output, only select the columns title, length, rating and rank.

select
	TITLE, LENGTH, RATING,
    rank() over(partition by RATING order by LENGTH desc) as rnk 
from FILM
where length > 0 AND length is not null;

#3 How many films are there for each of the categories in the category table? 
#Hint: Use appropriate join between the tables "category" and "film_category".

select
c.name, COUNT(*) as film_count
from CATEGORY c
join FILM_CATEGORY f on (c.category_id = f.category_id)
group by c.name
order by film_count desc
;

# 4 Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and 
#count the number of times an actor appears.

select
a.actor_id,a.first_name, a.last_name, COUNT(f.film_id) as actor_count
from actor a
join film_actor f on (a.actor_id = f.actor_id)
group by a.actor_id
order by actor_count desc
limit 1;


#5 - Which is the most active customer (the customer that has rented the most number of films)? 
#Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select
c.customer_id, c.first_name, c.last_name, count(*) as active_customer
from customer c
join rental r on (c.customer_id = r.customer_id)
group by c.customer_id
order by active_customer desc limit 1;


#Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).


select i.film_id, f.title,count(*) as most_rented_film
from inventory i
join film f on (i.film_id = f.film_id)
join rental r on (i.inventory_id = r.inventory_id)
group by i.film_id
order by most_rented_film desc limit 1
;

