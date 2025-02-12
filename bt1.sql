
USE world;

-- Tạo Stored Procedure lấy danh sách thành phố theo mã quốc gia
DELIMITER //

CREATE PROCEDURE GetCitiesByCountry(IN country_code CHAR(3))
BEGIN
    SELECT ID AS CityID, Name, Population 
    FROM city 
    WHERE CountryCode = country_code;
END //

DELIMITER ;

-- Gọi Stored Procedure với một quốc gia cụ thể (ví dụ: Đức - DEU)
CALL GetCitiesByCountry('DEU');

-- Xóa Stored Procedure sau khi kiểm tra
DROP PROCEDURE IF EXISTS GetCitiesByCountry;
