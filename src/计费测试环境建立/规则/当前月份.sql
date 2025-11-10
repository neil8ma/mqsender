-- 运算符，1 ==，2 <>，3 >，4 <，5 >=，6 <=，7 in，8 between，9 like，10 not in，11 not between，12 not like
-- 当前月份包含
DELIMITER //
DROP PROCEDURE if EXISTS jietifeilv //
CREATE PROCEDURE jietifeilv()
BEGIN
set @city_code = '100309';
SET @rule_id = IFNULL((SELECT max(rule_id)+1 from bf_rule_config_t),1);
SET @note = "当前月份包含";
SET @oper_code = 7;
SET @result = '6,7,8';
SET @group_id = 1;
SET @cond_id = 1;
INSERT INTO icp.bf_rule_config_t
(city_code, rule_id, sys_id, group_id, cond_id, cond_type, obj_code, params, oper_code, `result`, note)
VALUES( @city_code, @rule_id, 1, @group_id, @cond_id, 0, 'CURMONTH', '', @oper_code, @result , concat(@note,@result));
END//
DELIMITER ;
CALL jietifeilv();