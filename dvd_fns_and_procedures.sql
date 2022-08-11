-- Question 1:
-- Create a Stored Procedure that will insert a new film into the film table with the following arguments: title, description, release_year, language_id, rental_duration, rental_rate, length, replace_cost, rating

CREATE OR REPLACE PROCEDURE add_film(title VARCHAR, description VARCHAR, release_year INTEGER, language_id INTEGER, rental_duration INTEGER, rental_rate NUMERIC(5,2), length INTEGER, replacement_cost NUMERIC(5,2), rating MPAA_RATING)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating)
	VALUES (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating);
END;
$$;

-- for when i mess things up:
--DROP PROCEDURE add_film;

-- thank u IMDb for these descriptions
CALL add_film('Indiana Jones and the Raiders of the Lost Ark', 'Archaeology professor Indiana Jones ventures to seize a biblical artefact known as the Ark of the Covenant. While doing so, he puts up a fight against Renee and a troop of Nazis.', 1981, 1, 7, 3.99, 115, 15.99, 'PG');

CALL add_film('Indiana Jones and the Temple of Doom', 'A skirmish in Shanghai puts archaeologist Indiana Jones, his partner Short Round and singer Willie Scott crossing paths with an Indian village desperate to reclaim a rock stolen by a secret cult beneath the catacombs of an ancient palace.', 1984, 1, 7, 3.99, 118, 15.99, 'PG');

CALL add_film('Indiana Jones and the Last Crusade', 'In 1938, after his father Professor Henry Jones, Sr. goes missing while pursuing the Holy Grail, Professor Henry "Indiana" Jones, Jr. finds himself up against Adolf Hitler''s Nazis again to stop them from obtaining its powers.', 1989, 1, 7, 3.99, 127, 15.99, 'PG-13');

SELECT * FROM film WHERE title LIKE 'Indiana Jones%';
-- yeehaw



-- Question 2:
-- Create a Stored Function that will take in a category_id and return the number of films in that category
-- Strategy: (1) Find the number of films in each category by id (2) use the id to find the category name, (3) put it into a fn

CREATE OR REPLACE FUNCTION films_in_category(cat_id INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE num_films INTEGER;
BEGIN
	SELECT count(*) INTO num_films
	FROM film_category
	JOIN category
	ON film_category.category_id = category.category_id
	GROUP BY film_category.category_id
	HAVING film_category.category_id = cat_id;
	RETURN num_films;
END;
$$;

-- for redoing
--DROP FUNCTION films_in_category;

SELECT * FROM films_in_category(4);
SELECT * FROM films_in_category(1);
SELECT * FROM films_in_category(2);
SELECT * FROM films_in_category(12);
SELECT * FROM films_in_category(16);













