Select 
	staff.first_name AS Manager_first_name,
    staff.last_name AS Manager_last_name,
    store.store_id,
    address.address,
    address.district,
    city.city,
    country.country
From staff

JOIN store ON store.store_id = staff.store_id
JOIN address ON address.address_id = staff.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id
    