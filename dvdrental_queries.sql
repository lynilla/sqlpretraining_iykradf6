--A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
select count(distinct film_id) from film
where description ilike '%astronaut%'

--	I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
select count(distinct film_id) from film
where rating='R' and replacement_cost between 5 and 15

/*-	We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member 
 that handled the most payments. How many payments did each staff member handle? 
 And how much was the total amount processed by each staff member?*/
select staff_id, count(distinct payment_id) as num_payment_handled, sum(amount) as total_amount 
from payment
group by staff_id
order by sum(amount) desc

--Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
select rating, avg(replacement_cost) as average_replacement_cost from film
group by rating

/*-	We want to send coupons to the 5 customers who have spent the most amount of money. 
 Get the customer name, email and their spent amount!*/
select concat(c.first_name,' ',c.last_name) as customer_name, c.email, sum(p.amount) as spent_amount from customer c
join payment p 
on c.customer_id =p.customer_id
group by c.customer_id
order by sum(p.amount) desc
limit 5

--We want to audit our stock of films in all of our stores. How many copies of each movie in each store do we have?
select i.film_id, f.title, i.store_id, count(distinct i.inventory_id) as copies
from inventory i
join film f
on i.film_id =f.film_id 
group by i.film_id, f.title, i.store_id
order by i.store_id, i.film_id

/*-	We want to know what customers are eligible for our platinum credit card. The requirements are that the customer 
 has at least a total of 40 transaction payments. Get the customer name, email who are eligible for the credit card!*/
select concat(c.first_name,' ',c.last_name) as customer_name, c.email
from customer c 
join payment p
on c.customer_id =p.customer_id
group by c.customer_id
having count(distinct p.payment_id)>=40
order by customer_name