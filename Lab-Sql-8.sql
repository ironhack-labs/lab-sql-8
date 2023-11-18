-- 1) Ranking films by length. Selecting only columns title, length and rank in the output.
select title, length, rank() over (order by length desc) as "rank"
from sakila.film
where (length is not null) and (length > 0);

-- 2) Ranking films by length within the rating category. Selecting only the columns title, length, rating and rank.
select title, length, rating, rank() over (partition by rating order by length desc) as "rank"
from sakila.film
where (length is not null) and (length > 0);

-- 3) How many films are there for each of the categories in the category table?
select categ.name, count(*) as number_of_films
from sakila.category categ
left join sakila.film_category film_categ
on categ.category_id = film_categ.category_id
group by name;

-- 4) Which actor has appeared in the most films?
select act.actor_id, min(first_name) as first_name, min(last_name) as last_name, count(*) as number_of_films
from sakila.actor act
left join sakila.film_actor film_act
on act.actor_id = film_act.actor_id
group by act.actor_id
order by count(*) desc
limit 1;

-- 5) Which is the most active customer?
select _customer_.customer_id, min(first_name) as first_name, min(last_name) as last_name, count(*) as number_of_rented_films
from sakila.customer _customer_
left join sakila.rental _rental_
on _customer_.customer_id = _rental_.customer_id
group by _customer_.customer_id
order by count(*) desc
limit 1;

-- Bonus) Which is the most rented film?
select _film_.film_id, title, count(*) as number_of_rentals
from sakila.film _film_
left join sakila.inventory _inventory_ on _film_.film_id = _inventory_.film_id
left join sakila.rental _rental_ on _inventory_.inventory_id = _rental_.inventory_id
group by _film_.film_id
order by count(*) desc
limit 1;