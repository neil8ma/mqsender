DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @i = 1;
SET @rate_scene_type_id = 1; -- 峰平谷
SET @n = 3;
SET @rate_scene_id = IFNULL((SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t),1);
SET @base_value = 1.15;
SET @rate_scene_desc = concat("峰平谷--",@base_value);
WHILE @i <= @n DO
      INSERT INTO icp.bf_rate_scene_config_t
        (city_code, rate_scene_type_id, rate_scene_id, scene_time_id, rate_value, rate_scene_desc)
        VALUES(@city_code, @rate_scene_type_id, @rate_scene_id, @i, @base_value * @i , @rate_scene_desc);
      SET @i := @i + 1;
END WHILE;
END//
DELIMITER ;
CALL jietifeilv();

-- 峰平谷尖
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @i = 1;
SET @rate_scene_type_id = 2; -- 峰平谷尖
SET @n = 4;
SET @rate_scene_id = IFNULL((SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t),1);
SET @base_value = 1.27;
SET @rate_scene_desc = concat("峰平谷尖--",@base_value);
WHILE @i <= @n DO
      INSERT INTO icp.bf_rate_scene_config_t
        (city_code, rate_scene_type_id, rate_scene_id, scene_time_id, rate_value, rate_scene_desc)
        VALUES(@city_code, @rate_scene_type_id, @rate_scene_id, @i, @base_value * @i , @rate_scene_desc);
      SET @i := @i + 1;
END WHILE;
END//
DELIMITER ;
CALL jietifeilv();


-- 峰平谷尖低谷深谷
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @i = 1;
SET @rate_scene_type_id = 3; -- 峰平谷尖低谷深谷
SET @n = 6;
SET @rate_scene_id = IFNULL((SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t),1);
SET @base_value = 0.31;
SET @rate_scene_desc = concat("峰平谷尖低谷深谷--",@base_value);
WHILE @i <= @n DO
      INSERT INTO icp.bf_rate_scene_config_t
        (city_code, rate_scene_type_id, rate_scene_id, scene_time_id, rate_value, rate_scene_desc)
        VALUES(@city_code, @rate_scene_type_id, @rate_scene_id, @i, @base_value * @i , @rate_scene_desc);
      SET @i := @i + 1;
END WHILE;
END//
DELIMITER ;
CALL jietifeilv();

-- 无分时
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @i = 1;
SET @rate_scene_type_id = 0; -- 无分时
SET @n = 3;
SET @rate_scene_id = IFNULL((SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t),1);
SET @base_value = 0.27;
SET @rate_scene_desc = "无分时";
SET @scene_time_id = 0;
WHILE @i <= @n DO
      INSERT INTO icp.bf_rate_scene_config_t
        (city_code, rate_scene_type_id, rate_scene_id, scene_time_id, rate_value, rate_scene_desc)
        VALUES(@city_code, @rate_scene_type_id, @rate_scene_id, @scene_time_id, @base_value * @i , concat(@rate_scene_desc,ROUND(@base_value * @i, 2)));
      SET @i := @i + 1;
      SET @rate_scene_id := @rate_scene_id +1;
END WHILE;
END//
DELIMITER ;
CALL jietifeilv();