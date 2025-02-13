-- Sử dụng database world
USE world;

-- 2) Tạo VIEW OfficialLanguageView
CREATE OR REPLACE VIEW OfficialLanguageView AS
SELECT 
    c.Code AS CountryCode,
    c.Name AS CountryName,
    cl.Language
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T';

-- 3) Hiển thị VIEW OfficialLanguageView
SELECT * FROM OfficialLanguageView;

-- 4) Tạo chỉ mục (INDEX) trên cột Name của bảng city
CREATE INDEX idx_city_name ON city(Name);

-- 5) Tạo Stored Procedure GetSpecialCountriesAndCities
DELIMITER //

CREATE PROCEDURE GetSpecialCountriesAndCities(IN language_name VARCHAR(50))
BEGIN
    SELECT 
        c.Name AS CountryName,
        ci.Name AS CityName,
        ci.Population AS CityPopulation,
        (SELECT SUM(c2.Population) FROM city c2 WHERE c2.CountryCode = c.Code) AS TotalPopulation
    FROM city ci
    JOIN country c ON ci.CountryCode = c.Code
    JOIN OfficialLanguageView olv ON c.Code = olv.CountryCode
    WHERE olv.Language = language_name 
      AND ci.Name LIKE 'New%'
    GROUP BY c.Code, ci.Name, ci.Population
    HAVING TotalPopulation > 5000000
    ORDER BY TotalPopulation DESC
    LIMIT 10;
END //

DELIMITER ;

-- 6) Gọi Stored Procedure với ngôn ngữ 'English'
CALL GetSpecialCountriesAndCities('English');
