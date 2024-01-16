use sakila;

-- Task 1
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM actor;

-- Task 2
-- i
SELECT first_name, COUNT(*) AS name_count FROM actor
GROUP BY first_name ORDER BY name_count DESC;
 
-- ii
SELECT first_name, COUNT(*) AS name_count FROM actor
GROUP BY first_name HAVING COUNT(*) = 1;

-- Task 3
-- i
SELECT last_name, COUNT(*) AS name_count FROM actor
GROUP BY last_name ORDER BY name_count DESC;

-- ii
SELECT DISTINCT last_name FROM actor;

-- Task 4
-- i
SELECT * FROM film WHERE rating = 'R';

-- ii
SELECT * FROM film WHERE rating <> 'R';

-- iii
SELECT * FROM film WHERE rating IN ('G', 'PG');

-- Task 5
-- i
SELECT * FROM film WHERE replacement_cost <= 11;

-- ii
SELECT * FROM film WHERE replacement_cost BETWEEN 11 AND 20;

-- iii
SELECT * FROM film ORDER BY replacement_cost DESC;

-- Task 6
SELECT f.title AS movie_title, COUNT(fa.actor_id) AS actor_count FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id GROUP BY f.title
ORDER BY actor_count DESC LIMIT 3;

-- Task 7
SELECT title FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%';

-- Task 8
SELECT a.first_name, a.last_name FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Agent Truman';

-- Task 9
SELECT f.title AS film_title FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- Task 10
-- i
SELECT
    rating,
    MAX(rental_rate) AS max_rental_rate,
    MIN(rental_rate) AS min_rental_rate,
    AVG(rental_rate) AS avg_rental_rate
FROM film GROUP BY rating
ORDER BY avg_rental_rate DESC;

-- ii
SELECT f.title AS movie_title, COUNT(r.rental_id) AS rental_frequency FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title ORDER BY rental_frequency DESC;

-- Task 11
SELECT c.name AS category_name, AVG(f.replacement_cost) AS avg_replacement_cost, AVG(f.rental_rate) AS avg_rental_rate
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name HAVING (AVG(f.replacement_cost) - AVG(f.rental_rate)) > 15
ORDER BY category_name;

-- Task 12
SELECT c.name AS category_name, COUNT(fc.film_id) AS film_count FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name HAVING film_count > 70 ORDER BY film_count DESC;
