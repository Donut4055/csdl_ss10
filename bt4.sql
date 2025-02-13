-- Sử dụng database world
USE world;

-- Tạo Stored Procedure UpdateCityPopulation
DELIMITER //

CREATE PROCEDURE UpdateCityPopulation(
    INOUT p_city_id INT,
    IN p_new_population INT
)
BEGIN
    -- Cập nhật dân số mới cho thành phố có city_id
    UPDATE city
    SET Population = p_new_population
    WHERE ID = p_city_id;

    -- Truy vấn thông tin thành phố sau khi cập nhật
    SELECT ID AS CityID, Name, Population
    FROM city
    WHERE ID = p_city_id;
END //

DELIMITER ;

-- Gọi Stored Procedure với ID thành phố và dân số mới (ví dụ: ID = 1, dân số mới = 900000)
CALL UpdateCityPopulation(1, 900000);

-- Xóa Stored Procedure sau khi kiểm tra
DROP PROCEDURE IF EXISTS UpdateCityPopulation;
