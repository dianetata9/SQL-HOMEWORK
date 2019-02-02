USE SAKILA;

-- 1a
select first_name,last_name from actor;

-- 1a
select concat(upper(first_name), ' ', upper(last_name)) as 'Actor Name' from actor;

-- 2a
SELECT actor_id , first_name, last_name
FROM Actor
WHERE  first_name = 'joe';

-- 2b
SELECT last_name
FROM Actor
WHERE last_name like '%GEN%';

-- 2c
SELECT last_name
FROM Actor
WHERE last_name like '%LI%'
ORDER BY last_name, first_name;

-- 2d
SELECT country_id, country
FROM country
WHERE country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
alter table actor
add column description blob

-- 3b
alter table actor
drop column description;

-- 4a
SELECT last_name, count(last_name) as "Count of Last Name"
FROM Actor
group by last_name;

-- 4b
SELECT last_name, count(last_name) as "Count of Last Name"
FROM Actor
group by last_name
having count(*) >= 2;

-- 4c
update actor
set first_name = 'Harpo'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

-- 4d
update actor set first_name = case when first_name = 'HARPO' then 'GROUCHO' else 'MUCHO GROUCHO' end where actor_id = 172;

-- 5a
show create table sakila.address;
desc  sakila.address;

-- 6a
select first_name, last_name, address
from staff s
inner join address a
on s.address_id = a.address_id;

-- 6b
select first_name, last_name, sum(amount)
from staff s
inner join payment p
on s.staff_id = p.staff_id
where month(payment_date) = 8 and year(payment_date) = 2005
group by p.staff_id;

-- 6c
select title, count(actor_id)
from film f
inner join film_actor fa
on f.film_id = fa.film_id
group by title;

-- 6d
select title, count(inventory_id)
from film f
inner join inventory i 
on f.film_id = i.film_id
where title = "Hunchback Impossible";

-- 6e
select first_name, last_name, sum(amount)
from payment p
inner join customer c
on p.customer_id = c.customer_id
group by p.customer_id
order by last_name asc;

-- 7a
select title from film
where language_id in
	(select language_id 
	from language
	where name = "English" )
and (title like "K%") or (title like "Q%");

-- 7b
select last_name, first_name from actor
where actor_id in(
	select actor_id from film_actor
	where film_id in(
    select film_id from film
		where title = "Alone Trip"
	)
);

-- 7c
select first_name, last_name, email
from customer
inner join address
using (address_id)
	inner join city
	using (city_id)
		inner join country
		using (country_id) where country.country = 'Canada';
        
-- 7d
select title, category
from film_list
where category = 'Family';

-- 7e
select title, rental_duration 
from film
order by rental_duration desc;


-- 7f
select store.store_id, sum(amount)
from store
inner join staff
on store.store_id = staff.store_id
inner join payment p 
on p.staff_id = staff.staff_id
group by store.store_id
order by sum(amount);


-- 7g
select store_id, city, country
from store
join address
on store.address_id = address.address_id
join city c
on (address.city_id = c.city_id) 
join country co
on c.country_id = co.country_id;

-- 7h
select c.name, sum(amount) as amount from category c
join film_category f on c.category_id = f.category_id
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id
group by c.name order by amount desc limit 5;

-- 8a

create view top_five_genres as 
select c.name, sum(amount) as amount from category c
join film_category f on c.category_id = f.category_id
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id
group by c.name order by amount desc limit 5;

-- 8b

select * from top_five_genres;

-- 8c

drop view top_five_genres;