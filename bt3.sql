-- Sử dụng database world
USE world;

-- Tạo Stored Procedure truy vấn danh sách quốc gia sử dụng một ngôn ngữ với tỷ lệ > 50%
DELIMITER //

CREATE PROCEDURE GetCountriesByLanguage(
    IN p_language VARCHAR(50)
)
BEGIN
    SELECT CountryCode, Language, Percentage
    FROM countrylanguage
    WHERE Language = p_language AND Percentage > 50;
END //

DELIMITER ;

-- Gọi Stored Procedure với một ngôn ngữ cụ thể (ví dụ: 'English')
CALL GetCountriesByLanguage('English');

-- Xóa Stored Procedure sau khi kiểm tra
DROP PROCEDURE IF EXISTS GetCountriesByLanguage;
