-- Таблица с типами "species_type"
-- Таблица с видами "species"
-- Таблица с местами  "places"
-- Таблица с распределением видов по местам "species_in_places"

-- Final HW

-- Задание 1

-- Составьте запрос, который выведет имя вида с наименьшим id. Результат будет соответствовать букве «М». Done

SELECT species_name
FROM species
ORDER BY species_id ASC
LIMIT 1;

/*
SELECT species_name
FROM species
WHERE species_id = (SELECT MIN(species_id) FROM species);
*/

/*Составьте запрос, который выведет имя вида с количеством представителей более 1800.
Результат будет соответствовать букве «Б». DONE */ 

SELECT species_name
FROM species
WHERE species_amount > 1800

/*Составьте запрос, который выведет имя вида, начинающегося на «п» и относящегося к типу с type_id = 5.
Результат будет соответствовать букве «О». DONE*/

SELECT species_name
FROM species
WHERE species_name LIKE 'п%' AND type_id = 5;

/*Составьте запрос, который выведет имя вида, заканчивающегося на «са» или количество представителей которого равно 5.
Результат будет соответствовать букве В. DONE*/

SELECT species_name
FROM species
WHERE species_name LIKE '%са' OR species_amount = 5;

-- Задание 2

/* Составьте запрос, который выведет имя вида, появившегося на учете в 2023 году.
Результат будет соответствовать букве «Ы». DONE*/

SELECT species_name
FROM species
WHERE EXTRACT(YEAR FROM date_start) = 2023;

/*Составьте запрос, который выведет названия отсутствующего (status = absent) вида, расположенного вместе с place_id = 3.
Результат будет соответствовать букве «С». DONE*/

SELECT species.species_name
FROM species
INNER JOIN species_in_places 
ON species.species_id = species_in_places.species_id
WHERE species.species_status = 'absent' AND species_in_places.place_id = 3;

/*Составьте запрос, который выведет название вида, расположенного в доме и появившегося в мае, 
а также и количество представителей вида. Название вида будет соответствовать букве «П».DONE*/

SELECT species.species_name, species.species_amount
FROM species
JOIN species_in_places ON species.species_id = species_in_places.species_id
JOIN places ON species_in_places.place_id = places.place_id
WHERE places.place_name = 'дом' AND EXTRACT(MONTH FROM species.date_start) = 5;

/*Составьте запрос, который выведет название вида, состоящего из двух слов (содержит пробел).
Результат будет соответствовать знаку !. DONE*/

SELECT species_name
FROM species
WHERE species_name LIKE '% %'


-- Задание 3

/*Составьте запрос, который выведет имя вида, появившегося с малышом в один день. 
Результат будет соответствовать букве «Ч».*/
SELECT s.species_name
FROM species AS s 
JOIN (SELECT date_start
FROM species 
WHERE species_name = 'малыш') AS mal
ON s.date_start = mal.date_start 
WHERE s.species_name <> 'малыш';

/*Составьте запрос, который выведет название вида, расположенного в здании с наибольшей площадью. 
Результат будет соответствовать букве «Ж». DONE*/
SELECT species_name, place_size
FROM (SELECT species_name, place_size
FROM species 
INNER JOIN species_in_places
ON species.species_id=species_in_places.species_id

INNER JOIN places
ON species_in_places.place_id=places.place_id
WHERE place_name IN ('дом','сарай')) AS t
ORDER BY place_size DESC
LIMIT 1;

/*Составьте запрос/запросы, которые найдут название вида, относящегося к 5-й по численности группе проживающей дома.
Результат будет соответствовать букве «Ш». DONE*/

SELECT species_name
FROM species 
INNER JOIN species_in_places
ON species.species_id=species_in_places.species_id

INNER JOIN places
ON species_in_places. place_id=places.place_id
WHERE place_name='дом'
ORDER BY species_amount DESC
OFFSET 4 LIMIT 1;

/*Составьте запрос, который выведет сказочный вид (статус fairy), не расположенный ни в одном месте.
Результат будет соответствовать букве «Т».*/

SELECT species.species_name
FROM species 
FULL JOIN species_in_places
ON species.species_id = species_in_places.species_id
FULL JOIN places
ON species_in_places.place_id = places.place_id
WHERE species.species_status = 'fairy' AND place_name IS null; 

