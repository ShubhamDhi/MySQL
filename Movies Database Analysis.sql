-- Identify managers names at each store, with the full address of each property (street address, district, city, and country

SELECT 
    staff.first_name AS Manager_first_name,
    staff.last_name AS Manager_last_name,
    store.store_id,
    address.address,
    address.district,
    city.city,
    country.country
FROM
    staff
        LEFT JOIN store ON store.store_id = staff.store_id
        LEFT JOIN address ON address.address_id = staff.address_id
        LEFT JOIN city ON city.city_id = address.city_id
        LEFT JOIN country ON country.country_id = city.country_id
    
    
-- List the inventory item, including the store_id, inventory_id, film name, film's rating, rental rate, and replacement cost

SELECT 
    inventory.inventory_id,
    inventory.store_id,
    film.title,
    film.rating,
    film.rental_rate,
    Film.replacement_cost
FROM
    inventory
        LEFT JOIN film ON inventory.film_id = film.film_id
 
 
-- List the inventory items with each film rating at each store
 
SELECT 
    COUNT(inventory.inventory_id),
    inventory.store_id,
    film.rating
FROM
    inventory
        LEFT JOIN film ON inventory.film_id = film.film_id
GROUP BY inventory.store_id , film.rating

 
-- List the number of films, average replacement cost, and total replacement cost, sliced by store and film category

SELECT 
    store_id,
    category.name AS category,
    COUNT(inventory.inventory_id),
    AVG(film.replacement_cost),
    SUM(film.replacement_cost)
FROM
    inventory
        LEFT JOIN film ON inventory.film_id = film.film_id
        LEFT JOIN film_category ON film_category.film_id = film.film_id
        LEFT JOIN category ON category.category_id = film_category.category_id
GROUP BY store_id , category.name


-- List all customer names, which store they go to, their active status, and full addresses (street address, city, and country)

SELECT 
    customer.first_name,
    customer.last_name,
    customer.store_id,
    customer.active,
    customer.address_id,
    address.address,
    city.city,
    country.country
FROM
    customer
        LEFT JOIN address ON address.address_id = customer.address_id
        LEFT JOIN city ON city.city_id = address.city_id
        LEFT JOIN country ON country.country_id = city.country_id
  
  
-- Provide a list of customer names, total lifetime rentals, and sum of payments. Order by total lifetime value, with the most valuable customers at the top
     
SELECT 
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_rentals,
    SUM(payment.amount) AS total_payment_amount
FROM
    customer
        LEFT JOIN rental ON customer.customer_id = rental.customer_id
        LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.first_name , customer.last_name
ORDER BY SUM(payment.amount) DESC


-- List all advisor and investor names. For investors, include their affiliated company

SELECT 
    'investor' AS type, 
    first_name, 
    last_name, 
    company_name
FROM investor 
UNION 

SELECT 
    'advisor' AS type, 
    first_name, 
    last_name, 
    NULL
FROM advisor
