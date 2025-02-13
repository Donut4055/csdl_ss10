-- Sử dụng database world
USE world;

-- Tạo Stored Procedure GetEnglishSpeakingCountriesWithCities
DELIMITER //

CREATE PROCEDURE GetEnglishSpeakingCountriesWithCities(IN language VARCHAR(50))
BEGIN
    -- Truy vấn danh sách 10 quốc gia sử dụng ngôn ngữ này làm ngôn ngữ chính thức 
    -- và có tổng dân số thành phố > 5 triệu
    SELECT 
        c.Name AS CountryName,
        SUM(ci.Population) AS TotalPopulation
    FROM country c
    JOIN city ci ON c.Code = ci.CountryCode
    JOIN countrylanguage cl ON c.Code = cl.CountryCode
    WHERE cl.Language = language AND cl.IsOfficial = 'T'
    GROUP BY c.Name
    HAVING TotalPopulation > 5000000
    ORDER BY TotalPopulation DESC
    LIMIT 10;
END //

DELIMITER ;

-- Gọi Stored Procedure với ngôn ngữ bất kỳ (ví dụ: 'English')
CALL GetEnglishSpeakingCountriesWithCities('English');

-- Xóa Stored Procedure
DROP PROCEDURE IF EXISTS GetEnglishSpeakingCountriesWithCities;
