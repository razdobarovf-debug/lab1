-- ЛАБОРАТОРНАЯ №1 (Создание таблиц и данных)

-- 1. Удаляем старые таблицы (чтобы начать с чистого листа)
DROP TABLE IF EXISTS Paths_Previous_Day;
DROP TABLE IF EXISTS Path_Occupancy;
DROP TABLE IF EXISTS Trams;

-- 2. Создаем главную таблицу Трамваи (Первичный ключ: tram_id)
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

-- 3. Создаем дочернюю таблицу Занятость путей
-- СОСТАВНОЙ ПЕРВИЧНЫЙ КЛЮЧ: Депо + Номер пути + Время заезда
CREATE TABLE Path_Occupancy (
    depot_number INT NOT NULL,
    path_number INT NOT NULL,
    entry_datetime TIMESTAMP NOT NULL,
    tram_id INT NOT NULL,
    exit_datetime TIMESTAMP,
    additional_info TEXT,
    PRIMARY KEY (depot_number, path_number, entry_datetime),
    FOREIGN KEY (tram_id) REFERENCES Trams (tram_id) ON DELETE CASCADE
);

-- 4. Заполняем Трамваи (10 штук)
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

-- 5. Заполняем Занятость путей (10 штук)
INSERT INTO Path_Occupancy (depot_number, path_number, entry_datetime, exit_datetime, tram_id, additional_info) VALUES
(1, 101, CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE - INTERVAL '1 day', 1001, 'Плановый выезд'),
(1, 102, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE, 1002, 'Утренний выезд'),
(2, 201, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE, 1004, 'Выезд по маршруту'),
(2, 202, CURRENT_DATE, NULL, 1003, 'На ремонте'),
(3, 301, CURRENT_DATE - INTERVAL '3 days', CURRENT_DATE - INTERVAL '2 days', 1006, 'Экскурсия'),
(1, 103, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE, 1007, 'Замена вагона'),
(2, 203, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE, 1009, 'Ночной выезд'),
(3, 302, CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE - INTERVAL '4 days', 1005, 'Техосмотр'),
(1, 104, CURRENT_DATE, NULL, 1010, 'Сломался пантограф'),
(2, 204, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE, 1008, 'Обычный выезд');


