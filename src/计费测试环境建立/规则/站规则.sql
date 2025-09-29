-- 运算符，1 ==，2 <>，3 >，4 <，5 >=，6 <=，7 in，8 between，9 like，10 not in，11 not between，12 not like
set @allCYC = (SELECT GROUP_CONCAT(DISTINCT CONCAT("'",`场站编号`,"'") SEPARATOR ',') from `深圳所有乘用车站` WHERE `备注` =  '');
-- 站
-- 站等于
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "等于";
SET @oper_code = 1;
SET @result = '''CABJ0C001406''';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETSTATIONID', '', @oper_code, @result , @note+@result);
END//
DELIMITER ;
CALL jietifeilv();
-- 站不等于
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "站不等于";
SET @oper_code = 2;
SET @result = '''CABJ0C001406''';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETSTATIONID', '', @oper_code, @result , @note+@result);
END//
DELIMITER ;
CALL jietifeilv();
-- 站包含
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "桩包含";
SET @oper_code = 7;
SET @result = '''CAAHAE001306'',''CAAHAF001806'',''CAAHAE001706'',''CAAHAD001606'',''CAAHAH001506'',''CAAHAF001106'',''CAAHAF001206'',''CAAHAA000806'',''CAAHAH002006'',''CAAHAE002306'',''CAAHAL002406'',''CAAHAA002506''';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETCHARGERNO', '', @oper_code, @result , @note+@result);
END//
DELIMITER ;
CALL jietifeilv();
-- 站不包含
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "桩不包含";
SET @oper_code = 7;
SET @result = ''0107030103112201','0107030103112205'';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETCHARGERNO', '', @oper_code, @result , @note+@result);
END//
DELIMITER ;
CALL jietifeilv();

-- 站不包含
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "桩不包含";
SET @oper_code = 7;
SET @result = '''CAAHAE001306'',''CAAHAF001806'',''CAAHAE001706'',''CAAHAD001606'',''CAAHAH001506'',''CAAHAF001106'',''CAAHAF001206'',''CAAHAA000806'',''CAAHAH002006'',''CAAHAE002306'',''CAAHAL002406'',''CAAHAA002506''';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'GETCHARGERNO', '', @oper_code, @result , @note+@result);
END//
DELIMITER ;
CALL jietifeilv();
