-- Sử dụng database world
USE world;

-- Tạo Stored Procedure GetCountriesWithLargeCities
DELIMITER //

CREATE PROCEDURE GetCountriesWithLargeCities()
BEGIN
    -- Truy vấn danh sách các quốc gia có tổng dân số thành phố > 10 triệu và thuộc lục địa 'Asia'
    SELECT 
        country.Name AS CountryName,
        SUM(city.Population) AS TotalPopulation
    FROM country
    JOIN city ON country.Code = city.CountryCode
    WHERE country.Continent = 'Asia'
    GROUP BY country.Name
    HAVING TotalPopulation > 10000000
    ORDER BY TotalPopulation DESC;
END //

DELIMITER ;

-- Gọi Stored Procedure
CALL GetCountriesWithLargeCities();

-- Xóa Stored Procedure
DROP PROCEDURE IF EXISTS GetCountriesWithLargeCities;
