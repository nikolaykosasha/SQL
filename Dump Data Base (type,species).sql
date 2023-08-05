-- Создаем таблицу с типами
CREATE TABLE species_type ( 
    type_id       INTEGER PRIMARY KEY,
    type_name     VARCHAR NOT NULL
);

-- Создаем таблицу с видами
CREATE TABLE species( 
    species_id       INTEGER PRIMARY KEY,
    type_id          INTEGER,
    species_name     VARCHAR NOT NULL,
    species_amount   INTEGER,
    date_start       DATE,
	  species_status varchar(100) NOT NULL DEFAULT 'active'::character varying,
    CONSTRAINT species_status_check CHECK (((species_status)::text = ANY (ARRAY[('active'::character varying)::text, ('absent'::character varying)::text, ('fairy'::character varying)::text])))
);

-- Создаем табицу с местами 
CREATE TABLE places ( 
    place_id       INTEGER PRIMARY KEY,
    place_name     VARCHAR NOT NULL,
    place_size     NUMERIC(10,2),
    place_date_start  TIMESTAMP NOT NULL DEFAULT CURRENT_DATE
);

-- Создаем таблицу с распределеним видов по местам
CREATE TABLE species_in_places ( 
    place_id      INTEGER,
    species_id     INTEGER,
    PRIMARY KEY (place_id, species_id)
);

commit;

-- Создаем связи между таблицами

ALTER TABLE species ADD CONSTRAINT type_id_fkey FOREIGN KEY (type_id) REFERENCES species_type(type_id);
ALTER TABLE species_in_places ADD CONSTRAINT place_id_fkey FOREIGN KEY (place_id) REFERENCES places(place_id);
ALTER TABLE species_in_places ADD CONSTRAINT species_id_fkey FOREIGN KEY (species_id) REFERENCES species(species_id);

-- Добавление типов 

INSERT INTO species_type (type_id, type_name)
VALUES
(1, 'человек'),
(2, 'животные'),
(3, 'птицы'),
(4, 'рыбы'),
(5, 'цветы'),
(6, 'фрукты'),
(7, 'ягоды');

-- Добавление мест

INSERT INTO places (place_id, place_name, place_size, place_date_start)
VALUES
(1, 'дом', 120.00, '2010-04-12 10:00:00.000'),
(2, 'сарай', 200.00, '2011-05-30 15:30:00.000'),
(3, 'сад', 350.00, '2010-04-12 12:35:15.000'),
(4, 'лес', 0.00, '1900-01-01 00:00:00.000'),
(5, 'река', 0.00, '1900-01-01 00:00:01.000');

-- Добавление видов

INSERT INTO species (species_id, type_id, species_name, species_amount, date_start, species_status)
VALUES
(1, 1, 'малыш', 20, '2022-10-04', 'active'),
(2, 1, 'мужчина', 40, '2010-04-12', 'active'),
(3, 1, 'женщина', 42, '2010-04-12', 'active'),
(4, 2, 'собака', 30, '2010-05-30', 'active'),
(5, 2, 'кошка', 10, '2022-10-04', 'active'),
(6, 2, 'лошадь', 50, '2010-04-12', 'active'),
(7, 2, 'единорог', 1, '2010-04-12', 'fairy'),
(8, 2, 'лиса', 5, '2010-04-12', 'active'),
(9, 2, 'волк', 0, '2010-04-12', 'absent'),
(10, 2, 'скунс', 2, '2010-04-12', 'active'),
(11, 2, 'обезьяна', 6, '2023-04-10', 'active'),
(12, 3, 'попугай', 15, '2020-01-01', 'active'),
(13, 3, 'соловей', 7, '2010-04-12', 'active'),
(14, 3, 'дятел', 4, '2010-04-12', 'active'),
(15, 3, 'сова', 10, '2010-04-12', 'active'),
(16, 4, 'голубая рыба', 2, '2010-04-12', 'active'),
(17, 5, 'подсолнух', 1000, '2010-04-12', 'active'),
(18, 5, 'роза', 2000, '2010-04-12', 'active'),
(19, 5, 'тюльпан', 1500, '2010-04-12', 'active'),
(20, 6, 'яблоко', 0, '2010-04-12', 'absent'),
(21, 6, 'груша', 13, '2010-04-12', 'active'),
(22, 6, 'слива', 11, '2010-04-12', 'active'),
(23, 7, 'клубника', 30, '2010-04-12', 'active'),
(24, 7, 'вишня', 7, '2010-04-12', 'active');

-- Добавление расположения видов по местам

INSERT INTO species_in_places (place_id, species_id)
VALUES(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 6),
(4, 8),
(4, 9),
(4, 10),
(1, 11),
(1, 12),
(4, 13),
(4, 14),
(4, 15),
(5, 16),
(3, 17),
(3, 18),
(3, 19),
(3, 20),
(4, 20),
(3, 21),
(3, 22),
(3, 23),
(3, 24);

