use sakila;

#1a
select first_name, last_name
from actor;

#1b
select CONCAT(first_name, " ", last_name) as Actor
from actor;

#2a
select actor_id, first_name, last_name
from actor
where first_name = "Joe";

#2b
select * 
from actor
where last_name like "%GEN%"; 

#2c
select * 
from actor 
where last_name like "%LI%"
order by first_name, last_name;

#2d
select country_id, country
from country
where country in ("Afghanistan", "Bangladesh", "China");

#3a
alter table actor
add `description` blob;

#3b
alter table actor
drop column `description`;

#4a
select last_name, count(last_name)
from actor
group by last_name;

#4b
select last_name, count(last_name)
from actor
group by last_name having( count(last_name) >= 2);

#4c
update actor
set first_name = "HARPO"
where first_name = "GROUCHO" and last_name = "WILLIAMS";

#4d
update actor
set first_name = "GROUCHO"
where first_name = "HARPO" and last_name = "WILLIAMS";

#5a
show columns from actor;

#6a
select s.first_name, s.last_name, a.address 
from staff s
inner join address a on s.address_id = a.address_id;

#6b 
select s.first_name, s.last_name, sum(amount) 
from staff s
inner join payment p on s.staff_id = p.staff_id
group by s.last_name;

#6c
select f.title, f.film_id, count(a.film_id)
from film f
inner join film_actor a on f.film_id = a.film_id
group by a.film_id;

#6d
select f.title, count(i.film_id)
from film f
inner join inventory i on f.film_id = i.film_id
where f.title = "Hunchback Impossible"
group by i.film_id;

 #6e
 select c.first_name, c.last_name, sum(p.amount)
 from customer c
 inner join payment p on c.customer_id = p.customer_id
 group by c.customer_id
 order by c.last_name;

#7a
select title
from film
where language_id = (select language_id from language where name = "English") 
and title like "K%" or title like "Q%";

#7b
select first_name, last_name
from actor
where actor_id in (select actor_id from film_actor 
				where film_id = (select film_id from film 
								where title = "Alone Trip"));
                                
#7c
select c.first_name, c.last_name, c.email
from customer c
inner join address a on c.address_id = a.address_id
inner join city y on a.city_id = y.city_id
inner join country o on y.country_id = o.country_id
where o.country = "Canada";

#7d
select title 
from film 
where film_id in (select film_id from film_category
				where category_id = (select category_id from category
									where category.name = "Family"));

#7e 
select f.title, r.rental_id, count(r.rental_id)
from film f
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
group by r.rental_id
order by count(r.rental_id) desc;

#7f
select s.store_id, sum(p.amount)
from store s
inner join inventory i on s.store_id = i.store_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by s.store_id;

#7g
select s.store_id, c.city, o.country
from store s
inner join address a on s.address_id = a.address_id
inner join city c on a.city_id = c.city_id
inner join country o on c.country_id = o.country_id;

#7h
select c.name, sum(p.amount)
from category c
inner join film_category f on c.category_id = f.category_id
inner join inventory i on f.film_id = i.film_id 
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.name
order by sum(p.amount) desc
limit 5;

#8a
create view top_five as
select c.name, sum(p.amount)
from category c
inner join film_category f on c.category_id = f.category_id
inner join inventory i on f.film_id = i.film_id 
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.name
order by sum(p.amount) desc
limit 5;

#8b
select * from top_five;

#8c
drop view top_five;