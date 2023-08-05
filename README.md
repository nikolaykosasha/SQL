# SQL

В этом хранилище расположены тестовые артефакты

// Header

Этот репозиторий содержит созданные мной SQL запросы

Владею базовыми навыками SQL и понимаю основные конструкции этого языка для работы с данными в базе данных. Я овладел запросами которые покрывают разные аспекты работы с данными: от выборки по условиям и сортировки до использования функций агрегации и объединения таблиц. Также  мне удалось применить вложенные подзапросы, функции для работы с датами и текстовыми данными.

В рамках изучения SQL я выполнил следующие задания:

Скачать dump баз данных ":Животные и Места" отсюда (ссылка).



**Задание 1:**

1. Составьте запрос, который выведет имя вида с наименьшим id.
```sql
SELECT species_name
FROM species
ORDER BY species_id ASC
LIMIT 1;

```
2. Составьте запрос, который выведет имя вида с количеством представителей более 1800.
```sql
SELECT species_name
FROM species
WHERE species_amount > 1800

```
3. Составьте запрос, который выведет имя вида, начинающегося на «п» и относящегося к типу с type_id = 5
```sql
SELECT species_name
FROM species
WHERE species_name LIKE 'п%' AND type_id = 5;

```
4. Составьте запрос, который выведет имя вида, заканчивающегося на «са» или количество представителей которого равно 5
```sql
SELECT species_name
FROM species
WHERE species_name LIKE '%са' OR species_amount = 5;

```

**Задание 2:**

1. Составьте запрос, который выведет имя вида, появившегося на учете в 2023 году.
```sql
SELECT species_name
FROM species
WHERE EXTRACT(YEAR FROM date_start) = 2023;

```
2. Составьте запрос, который выведет названия отсутствующего (status = absent) вида, расположенного вместе с place_id = 3
```sql
SELECT species.species_name
FROM species
INNER JOIN species_in_places 
ON species.species_id = species_in_places.species_id
WHERE species.species_status = 'absent' AND species_in_places.place_id = 3;

```
3. Составьте запрос, который выведет название вида, расположенного в доме и появившегося в мае, а также и количество представителей вида.
```sql
SELECT species.species_name, species.species_amount
FROM species
JOIN species_in_places ON species.species_id = species_in_places.species_id
JOIN places ON species_in_places.place_id = places.place_id
WHERE places.place_name = 'дом' AND EXTRACT(MONTH FROM species.date_start) = 5;

```
4. Составьте запрос, который выведет название вида, состоящего из двух слов (содержит пробел).
```sql
SELECT species_name
FROM species
WHERE species_name LIKE '% %'

```

**Задание 3:**

1. Составьте запрос, который выведет имя вида, появившегося с малышом в один день.
```sql
SELECT s.species_name
FROM species AS s 
JOIN (SELECT date_start
FROM species 
WHERE species_name = 'малыш') AS mal
ON s.date_start = mal.date_start 
WHERE s.species_name <> 'малыш';

```
2. Составьте запрос, который выведет название вида, расположенного в здании с наибольшей площадью.
```sql
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

```
3. Составьте запрос/запросы, которые найдут название вида, относящегося к 5-й по численности группе проживающей дома.
```sql
SELECT species_name
FROM species 
INNER JOIN species_in_places
ON species.species_id=species_in_places.species_id

INNER JOIN places
ON species_in_places. place_id=places.place_id
WHERE place_name='дом'
ORDER BY species_amount DESC
OFFSET 4 LIMIT 1;

```
4. Составьте запрос, который выведет сказочный вид (статус fairy), не расположенный ни в одном месте.
```sql
SELECT species.species_name
FROM species 
FULL JOIN species_in_places
ON species.species_id = species_in_places.species_id
FULL JOIN places
ON species_in_places.place_id = places.place_id
WHERE species.species_status = 'fairy' AND place_name IS null; 

```