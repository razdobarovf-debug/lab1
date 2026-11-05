-- Лабораторная работа №1. Вариант 31.

-- Удаление старых таблиц (если были)
DROP TABLE IF EXISTS Paths_Previous_Day;
DROP TABLE IF EXISTS Path_Occupancy;
DROP TABLE IF EXISTS Trams;

-- 1. Создание главной таблицы Трамваи
CREATE TABLE Trams (
    tram_id INT PRIMARY KEY,
    depot_number INT NOT NULL,
    model VARCHAR(50) NOT NULL,
    year_built INT NOT NULL,
    last_overhaul_date DATE,
    total_seats INT NOT NULL,
    seating_capacity INT NOT NULL,
    length_meters NUMERIC(5, 2) NOT NULL,
    bogies INT NOT NULL,
    sections INT NOT NULL
);

-- 2. Создание дочерней таблицы Занятость путей (с ключом на депо)
CREATE TABLE Path_Occupancy (
    depot_number INT PRIMARY KEY,
    path_number INT NOT NULL,
    entry_datetime TIMESTAMP NOT NULL,
    tram_id INT NOT NULL,
    exit_datetime TIMESTAMP,
    additional_info TEXT,
    FOREIGN KEY (tram_id) REFERENCES Trams (tram_id) ON DELETE CASCADE
);

-- 3. Заполнение Трамваев
INSERT INTO Trams (tram_id, depot_number, model, year_built, last_overhaul_date, total_seats, seating_capacity, length_meters, bogies, sections) VALUES
(1001, 1, '71-605', 2010, '2020-05-15', 150, 40, 15.50, 2, 1),
(1002, 1, '71-619', 2015, NULL, 200, 50, 27.50, 4, 2),
(1003, 2, 'T3', 2005, '2018-10-20', 120, 30, 14.00, 2, 1),
(1004, 2, 'T3-T3', 2008, '2022-03-10', 240, 60, 28.00, 4, 2),
(1005, 3, '71-608', 2012, NULL, 160, 45, 15.20, 2, 1),
(1006, 3, 'LVS-2005', 2018, NULL, 300, 80, 35.00, 6, 3),
(1007, 1, '71-619', 2019, NULL, 200, 50, 27.50, 4, 2),
(1008, 2, '71-605', 1998, '2015-04-12', 150, 40, 15.50, 2, 1),
(1009, 3, 'T3-T3', 2011, '2021-09-01', 240, 60, 28.00, 4, 2),
(1010, 1, 'LVS-2005', 2020, NULL, 300, 80, 35.00, 6, 3);

-- 4. Заполнение Занятости путей
INSERT INTO Path_Occupancy (depot_number, path_number, entry_datetime, exit_datetime, tram_id, additional_info) VALUES
(1, 101, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE, 1002, 'Утренний выезд'),
(2, 201, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE, 1004, 'Выезд по маршруту'),
(3, 301, CURRENT_DATE - INTERVAL '3 days', CURRENT_DATE - INTERVAL '2 days', 1006, 'Экскурсия'); 
