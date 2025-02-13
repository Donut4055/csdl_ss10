-- Sử dụng database world
USE world;

-- Tạo Stored Procedure tính tổng dân số của một quốc gia
DELIMITER //

CREATE PROCEDURE CalculatePopulation(
    IN p_countryCode CHAR(3), 
    OUT total_population BIGINT
)
BEGIN
    SELECT SUM(Population) INTO total_population
    FROM city 
    WHERE CountryCode = p_countryCode;
END //

DELIMITER ;

-- Khai báo biến để lưu kết quả
SET @total_population = 0;

-- Gọi Stored Procedure với một quốc gia cụ thể (ví dụ: USA - Hoa Kỳ)
CALL CalculatePopulation('USA', @total_population);

-- Hiển thị kết quả
SELECT @total_population AS Total_Population;

-- Xóa Stored Procedure sau khi kiểm tra
DROP PROCEDURE IF EXISTS CalculatePopulation;
