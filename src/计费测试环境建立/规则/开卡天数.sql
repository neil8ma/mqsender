-- 运算符，1 ==，2 <>，3 >，4 <，5 >=，6 <=，7 in，8 between，9 like，10 not in，11 not between，12 not like

-- 开卡天数
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "开卡天数大于";
SET @oper_code = 3;
SET @result = '365';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETOPENDAYS', '', @oper_code, @result , concat(@note,@result));
END//
DELIMITER ;
CALL jietifeilv();

DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "开卡天数大于等于";
SET @oper_code = 5;
SET @result = '365';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETOPENDAYS', '', @oper_code, @result , concat(@note,@result));
END//
DELIMITER ;
CALL jietifeilv();

DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "开卡天数小于";
SET @oper_code = 4;
SET @result = '365';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETOPENDAYS', '', @oper_code, @result , concat(@note,@result));
END//
DELIMITER ;
CALL jietifeilv();

DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "开卡天数小于等于";
SET @oper_code = 6;
SET @result = '365';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETOPENDAYS', '', @oper_code, @result , concat(@note,@result));
END//
DELIMITER ;
CALL jietifeilv();