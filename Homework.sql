--#1 List all customers who live in Texas (join)
SELECT first_name, last_name, district
FROM address --TABLE A
INNER JOIN customer--TABLE B
ON address.address_id = customer.address_id
WHERE district = 'Texas';


--#2 Get all payments above $6.99 with the customer's full name
SELECT first_name,last_name,amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;



--#3 Show all customers' names who have made payments over $175(subqueries)
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY payment.customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);



--#4 List all customers that live in Nepal using the city table (join)
SELECT first_name,last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';



--#5 Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(payment_id) DESC;

-- #6 What film had the most actors in it?
SELECT film.film_id, title, COUNT(*)
FROM film_actor
JOIN film
ON film_actor.film_id = film.film_id
GROUP BY film.film_id, title
ORDER BY  COUNT Desc
Limit 1;


--# 7 Which actor has been in the least movies?
SELECT actor.actor_id, first_name, last_name, COUNT(*)
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id
GROUP BY actor.actor_id, first_name, last_name
ORDER BY COUNT(*)
limit 1;

-- # 8 How many districts have more than 5 customers in it?
SELECT district, COUNT(*)
FROM address
GROUP BY district
Having COUNT(*) > 5