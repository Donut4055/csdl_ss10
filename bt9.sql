-- Sử dụng database world
USE world;

-- 2) Tạo VIEW CountryLanguageView
CREATE OR REPLACE VIEW CountryLanguageView AS
SELECT 
    c.Code AS CountryCode,
    c.Name AS CountryName,
    cl.Language,
    cl.IsOfficial
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T';

-- 3) Hiển thị lại VIEW CountryLanguageView
SELECT * FROM CountryLanguageView;

-- 4) Tạo Stored Procedure GetLargeCitiesWithEnglish
DELIMITER //

CREATE PROCEDURE GetLargeCitiesWithEnglish()
BEGIN
    SELECT 
        ci.Name AS CityName,
        c.Name AS CountryName,
        ci.Population
    FROM city ci
    JOIN country c ON ci.CountryCode = c.Code
    JOIN CountryLanguageView clv ON c.Code = clv.CountryCode
    WHERE clv.Language = 'English' AND ci.Population > 1000000
    ORDER BY ci.Population DESC
    LIMIT 20;
END //

DELIMITER ;

-- 5) Gọi Stored Procedure để kiểm tra
CALL GetLargeCitiesWithEnglish();

-- 6) Xóa Stored Procedure
DROP PROCEDURE IF EXISTS GetLargeCitiesWithEnglish;
