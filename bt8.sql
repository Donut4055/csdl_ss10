-- Sử dụng database world
USE world;

-- Tạo Stored Procedure GetCountriesByCityNames
DELIMITER //

CREATE PROCEDURE GetCountriesByCityNames()
BEGIN
    -- Truy vấn danh sách các quốc gia có thành phố bắt đầu bằng "A", có ngôn ngữ chính thức,
    -- tổng dân số thành phố > 2 triệu, sắp xếp theo tên quốc gia tăng dần
    SELECT 
        c.Name AS CountryName,
        cl.Language AS OfficialLanguage,
        SUM(ci.Population) AS TotalPopulation
    FROM country c
    JOIN city ci ON c.Code = ci.CountryCode
    JOIN countrylanguage cl ON c.Code = cl.CountryCode
    WHERE ci.Name LIKE 'A%' 
        AND cl.IsOfficial = 'T'
    GROUP BY c.Name, cl.Language
    HAVING TotalPopulation > 2000000
    ORDER BY CountryName ASC;
END //

DELIMITER ;

-- Gọi Stored Procedure để kiểm tra
CALL GetCountriesByCityNames();

-- Xóa Stored Procedure
DROP PROCEDURE IF EXISTS GetCountriesByCityNames;
