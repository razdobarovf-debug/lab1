-- Лабораторная работа №2. Вариант 31.

-- Задание 1. Выбрать номера путей, занятых в предыдущий день многосекционными трамваями.
SELECT DISTINCT path_number
FROM Path_Occupancy
WHERE entry_datetime::date = CURRENT_DATE - INTERVAL '1 day'
  AND tram_id IN (SELECT tram_id FROM Trams WHERE sections > 1);

-- Задание 2. Выбрать информацию о многосекционных трамваях, где количество тележек меньше 2 на одну секцию.
SELECT *
FROM Trams
WHERE sections > 1
  AND (bogies::numeric / sections) < 2;

-- Задание 3. Создать таблицу, содержащую данные 1 запроса.
DROP TABLE IF EXISTS Paths_Previous_Day;
CREATE TABLE Paths_Previous_Day AS
SELECT d.path_number, d.entry_datetime, d.exit_datetime
FROM Path_Occupancy d
WHERE d.entry_datetime::date = CURRENT_DATE - INTERVAL '1 day'
  AND d.tram_id IN (SELECT tram_id FROM Trams WHERE sections > 1);

-- Задание 4. Добавить в таблицу трамваи с повторяющейся моделью через «-».
INSERT INTO Paths_Previous_Day (path_number, entry_datetime, exit_datetime)
SELECT d.path_number, d.entry_datetime, d.exit_datetime
FROM Path_Occupancy d
JOIN Trams t ON d.tram_id = t.tram_id
WHERE t.model ~ '^([^-]+)-\1$';

-- Задание 5. Перенести время выезда на 2 часа.
UPDATE Paths_Previous_Day
SET exit_datetime = COALESCE(exit_datetime + INTERVAL '2 hours', CURRENT_TIMESTAMP),
    entry_datetime = COALESCE(entry_datetime, CURRENT_TIMESTAMP);

-- Задание 6. Удалить из созданной таблицы все односекционные трамваи.
DELETE FROM Paths_Previous_Day
WHERE path_number IN (
    SELECT d.path_number
    FROM Path_Occupancy d
    JOIN Trams t ON d.tram_id = t.tram_id
    WHERE t.sections = 1
);

-- Задание 7. Посчитать количество выездов из депо в месяц для каждого трамвая.
SELECT tram_id,
       DATE_TRUNC('month', entry_datetime) AS month,
       COUNT(*) AS departure_count
FROM Path_Occupancy
GROUP BY tram_id, DATE_TRUNC('month', entry_datetime)
ORDER BY tram_id, month; 

