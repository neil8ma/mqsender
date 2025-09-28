-- 将深圳所有乘用车场站分成三种表 深圳所有乘用车站、深圳乘用车快充站、深圳乘用车慢充站
-- 深圳所有乘用车站
DROP TABLE if EXISTS 深圳所有乘用车站;
create table 深圳所有乘用车站
select b.station_name as 名称, b.station_code as 场站编号, a.battery_code as 设备编号, a.battery_name as 设备名称, ''  as 备注
from br_batterycharge a
         LEFT JOIN
     br_station_detail b
     ON
             a.station_id = b.station_id
where a.city_code = '100309';

-- 深圳乘用车快充站
DROP TABLE if EXISTS 深圳乘用车快充站;
create table 深圳乘用车快充站
SELECT b.station_name as 名称, b.station_code as 场站编号, a.battery_code as 设备编号, a.battery_name as 设备名称, ''  as 备注
from br_station_detail b
         LEFT JOIN
     br_batterycharge a
     ON
             b.station_id = a.station_id
where b.station_id in (
    select f.station_id from
        (SELECT station_id ,count(*) charge_sum ,sum(quick_slow) flag from br_batterycharge  where city_code = '100309' GROUP BY station_id) f
    where f.flag = f.charge_sum
);

-- 深圳乘用车慢充站
DROP TABLE if EXISTS 深圳乘用车慢充站;
create table 深圳乘用车慢充站
SELECT b.station_name as 名称, b.station_code as 场站编号, a.battery_code as 设备编号, a.battery_name as 设备名称, ''  as 备注
from br_station_detail b
         LEFT JOIN
     br_batterycharge a
     ON
             b.station_id = a.station_id
where b.station_id in (
    select f.station_id from
        (SELECT station_id ,count(*) charge_sum ,sum(quick_slow) flag from br_batterycharge  where city_code = '100309' GROUP BY station_id) f
    where f.flag = 0
);
-- 将深圳所有乘用车场站分成三种表 所有场站快慢站表 end

-- 已有表结构有变化，先执行数据库补丁脚本
-- 城市默认套餐
INSERT INTO `bf_favour_public_info_t` (`city_code`, `server_fee`) VALUES ('100309', '0.80');

-- 基础电价

-- 插入深圳基础电价峰平谷费用场景，南山公司费用场景
SET GLOBAL group_concat_max_len=1024000;
SET SESSION group_concat_max_len=1024000;

set @rate_scene_id = (SELECT MAX(rate_scene_id)+1 from bf_rate_scene_config_t );

INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '1', '1.0388', '深圳峰平谷12');
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '2', '0.6863', '深圳峰平谷12');
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '3', '0.2423', '深圳峰平谷12');

set @rate_scene_id = @rate_scene_id +1;

INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '1', '1.0638', '深圳峰平谷13');
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '2', '0.7113', '深圳峰平谷13');
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '3', '0.2673', '深圳峰平谷13');

set @rate_scene_id = @rate_scene_id +1;

INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '1', '0.9411', '深圳峰平谷14');
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '2', '0.6363', '深圳峰平谷14');
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '3', '0.2523', '深圳峰平谷14');

set @rate_scene_id = @rate_scene_id +1;

INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '1', '1.0328', '深圳峰平谷15');
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '2', '0.6803', '深圳峰平谷15');
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '1', @rate_scene_id, '3', '0.2363', '深圳峰平谷15');

set @rate_scene_id = @rate_scene_id +1;

INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES ('100309', '0', @rate_scene_id, '0', '0.989', '深圳南山公司无分时');

-- 插入深圳基础电价峰平谷分时场景，南山公司费用场景 11:30－14:00、16:30－19:00、21:00－23:00（共9小时）
set @scene_id = (SELECT MAX(scene_id)+1 from bf_time_scene_config_t );

INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '1', '09:00:00', '11:30:00');
INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '1', '14:00:00', '16:30:00');
INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '1', '19:00:00', '21:00:00');
INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '2', '07:00:00', '09:00:00');
INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '2', '11:30:00', '14:00:00');
INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '2', '16:30:00', '19:00:00');
INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '2', '21:00:00', '23:00:00');
INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '3', '23:00:00', '00:00:00');
INSERT INTO `bf_time_scene_config_t` (`city_code`, `scene_type_id`, `scene_id`, `scene_name`, `scene_time_id`, `start_date`, `end_date`)
VALUES ('100309', '1', @scene_id, '深圳峰平谷', '3', '00:00:00', '07:00:00');

-- 插入深圳无分时费用场景表
set @sz_rate_scene_id = (SELECT MAX(ddd.rate_scene_id) from bf_rate_scene_config_t ddd);
insert INTO bf_rate_scene_config_t(city_code , rate_scene_type_id , rate_scene_id , scene_time_id , rate_value , rate_scene_desc)
SELECT '100309' as city_code , '0' as rate_scene_type_id  ,  @sz_rate_scene_id := @sz_rate_scene_id +1 as rate_scene_id ,'0' as scene_time_id ,
ok.rate_value as rate_value ,ok.rate_scene_desc as rate_scene_desc
from
    (SELECT DISTINCT
    convert(excel.TotalModeFloat / 100 , DECIMAL(15, 4)) as rate_value , CONCAT(excel.CityCode,excel.TotalModeFloat) as rate_scene_desc
    from station_price_excel excel
    where excel.TotalModeFloat != '未配置' AND excel.TotalModeFloat not LIKE '%峰平谷%' and excel.Memo != 'no'
    ) ok ;

-- SELECT * from bf_rate_scene_config_t t where t.city_code = '100309' ORDER BY t.rate_scene_desc
-- 插入深圳基础电价表

-- 检查资源表匹配性
--  SELECT * from station_price_excel WHERE StationNo  not in (SELECT b.station_code from br_station_detail b );
--  SELECT station_name , station_code from br_station_detail
-- WHERE city_code = '100309' and station_code  not in (SELECT StationNo from station_price_excel );

-- 联合查询插入价格是峰平谷的场站
-- INSERT INTO `bf_indb_base_config_t` (`city_code`, `battery_code`, `battery_id`, `station_id`, `rate_scene_id`,
-- `tariff_unit_id`, `calc_method_id`, `change_date`, `if_valid`, `time_scene_id`,
-- `special_time_scene_id`, `rule_id`,
--  `power_percent`, `configure_type`, `state`, `fail`)
set @time_scene_id := (SELECT t.scene_id from bf_time_scene_config_t t where t.scene_name = '深圳峰平谷' LIMIT 1);
insert INTO `bf_indb_base_config_t` (`city_code`, `battery_code`, `battery_id`, `station_id`, `rate_scene_id`,
                                     `tariff_unit_id`, `calc_method_id`, `change_date`, `if_valid`, `time_scene_id`, `special_time_scene_id`, `rule_id`,
                                     `power_percent`, `configure_type`, `state`, `fail`)
SELECT charge.city_code ,charge.battery_code ,charge.battery_id , charge.station_id ,rate_scene.rate_scene_id ,
       '1' as tariff_unit_id , '3' as calc_method_id , NOW() as change_date , '1' as if_valid ,
       CASE
           WHEN excel.TotalModeFloat LIKE '%峰平谷%' THEN @time_scene_id
           ELSE '0'
           END
           as time_scene_id,
       '0' as special_time_scene_id , '0' as rule_id , '1' as power_percent , '1' as configure_type , '1' as state , '' as fail
from station_price_excel excel
         LEFT JOIN
     br_station_detail station
     ON
             excel.StationName = station.station_name
         LEFT JOIN
     br_batterycharge charge
     ON
             charge.station_id = station.station_id
         LEFT JOIN
     (SELECT DISTINCT t.rate_scene_id ,t.rate_scene_desc from bf_rate_scene_config_t t where t.city_code = '100309')
         rate_scene
     ON
             rate_scene.rate_scene_desc = CONCAT(excel.CityCode , excel.TotalModeFloat)
where charge.city_code = '100309' AND excel.TotalModeFloat != '未配置'  AND excel.Memo != 'no' ;

-- 珠海桩费用
SET @zh_city_code = '100309';
set @zh_rate_scene_id = (SELECT MAX(ddd.rate_scene_id) from bf_rate_scene_config_t ddd);
INSERT INTO `bf_rate_scene_config_t` (`city_code`, `rate_scene_type_id`, `rate_scene_id`, `scene_time_id`, `rate_value`, `rate_scene_desc`)
VALUES (@zh_city_code, '0', @zh_rate_scene_id := @zh_rate_scene_id + 1, '0', '0.7', '珠海电费');

INSERT INTO `bf_indb_base_config_t` (`city_code`, `battery_code`, `battery_id`, `station_id`, `rate_scene_id`, `tariff_unit_id`,
                                     `calc_method_id`, `change_date`, `if_valid`, `time_scene_id`, `special_time_scene_id`, `rule_id`, `power_percent`, `configure_type`,
                                     `state`, `fail`)
SELECT @zh_city_code , battery_code , battery_id , station_id , @zh_rate_scene_id , '1' as tariff_unit_id,
       '3' as calc_method_id, '2020-02-29 19:07:54' as change_date, '1' as if_valid, '0' as time_scene_id , '0' as special_time_scene_id, '0' as rule_id,
       '1.00' as power_percent, '1' as configure_type, '1' as state, '' as fail
from br_batterycharge where station_id = (SELECT station_id from br_station_detail where station_name = 'V12文化创意产业园');

-- 折扣方案


SET @@autocommit=0;
START TRANSACTION;

-- 1 大鹏新区管委会	交流	服务费0.36元/度+电费（代收代付）	配置服务费折扣方案，0.36元，设备限定为大鹏新区管委会的交流慢充桩桩编码	在该站点刷卡、app、微信小程序充电，场站扣费优先于套餐		自有公网慢充
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '大鹏新区管委会');


INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.3600', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '大鹏新区管委会', '1', '0', '大鹏新区管委会', '0', NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 2	龙华新区管委会大楼停车场	交流	服务费0.36元/度+电费（代收代付）

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '龙华新区管委会大楼停车场');


INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.3600', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '龙华新区管委会大楼停车场', '1', '0', '龙华新区管委会大楼停车场', '0', NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 3 龙华党校	交流	服务费0.36元/度+电费（代收代付）	配置服务费折扣方案，0.36元，设备限定为龙华党校的交流慢充桩桩编码	在该站点刷卡、app、微信小程序充电，场站扣费优先于套餐		自有公网慢充
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '龙华党校');


INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.3600', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '龙华党校', '1', '0', '龙华党校', '0', NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 4	福永街道办大院	交流	服务费0.55元/度+电费（代收代付）
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '福永街道办大院');


INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.5500', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '福永街道办大院', '1', '0', '福永街道办大院', '0', NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 5	观澜办事处	交流	服务费0.55元/度+电费（代收代付）

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '观澜办事处');


INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.5500', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '观澜办事处', '1', '0', '观澜办事处', '0', NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 6 深圳信息职业技术学院	交流	服务费0.8元/度+电费（代收代付）	配置服务费折扣方案，0.8元，设备限定为深圳信息职业技术学院的交流慢充桩桩编码
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '深圳信息职业技术学院');


INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.8000', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '深圳信息职业技术学院', '1', '0', '深圳信息职业技术学院', '0', NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 7 联合广场	交流	峰期、平期1.15元/度、谷期0.9元/度	配置服务费折扣方案，峰期、平期1.15-基础电价、谷期0.9元-基础电价，设备限定为联合广场的交流快充桩桩编码	刷卡、app、微信小程序、互联互通客户小桔充电
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '联合广场');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                        AS `rate_value` ,
                                          '联合广场折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '联合广场', '1', '0', '联合广场', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 8	新安公园西站	直流	峰期、平期1.25元/度、谷期0.9元/度

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '新安公园西站');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                          AS `rate_value` ,
                                          '新安公园西站折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '新安公园西站', '1', '0', '新安公园西站', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 9	洪浪公园站	直流	峰期、平期1.25元/度、谷期0.9元/度

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '洪浪公园站');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                         AS `rate_value` ,
                                          '洪浪公园站折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '洪浪公园站', '1', '0', '洪浪公园站', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');


-- 10	前海企业公馆	直流	峰期、平期1.25元/度、谷期0.9元/度	配置服务费折扣方案，峰期、平期1.25-基础电价、谷期0.9元-基础电价，设备限定为前海企业公馆的直流快充桩桩编码	刷卡、app、微信小程序、互联互通客户小桔充电

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '前海企业公馆');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                          AS `rate_value` ,
                                          '前海企业公馆折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '前海企业公馆', '1', '0', '前海企业公馆', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 11	绿创万众茶城	直流	峰期、平期1.25元/度、谷期0.9元/度	"配置服务费折扣方案，峰期、平期1.25-基础电价、谷期0.9元-基础电价，设备限定为绿创万众茶城的直流快充桩桩编码
-- "	在该站点刷卡、app、微信小程序、场站扣费优先于套餐

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创万众茶城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                               AS `rate_value` ,
                                          '绿创万众茶城直流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '绿创万众茶城直流快充桩', '1', '0', '绿创万众茶城直流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no  FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 2;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 12	绿创万众茶城	交流	峰期1.15元/度，平期0.9元/度，谷期0.78元/度	配置服务费折扣方案，峰期、平期1.15-基础电价、平期0.9元-基础电价、谷期0.78元-基础电价，设备限定为绿创万众茶城的交流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创万众茶城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.78 -rate_value
                                              END
                                                               AS `rate_value` ,
                                          '绿创万众茶城交流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '绿创万众茶城交流快充桩', '1', '0', '绿创万众茶城交流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 1;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 13	清湖园	直流	峰期1.18元/度，平谷期0.9元/度	配置服务费折扣方案，峰期1.18-基础电价、平谷期0.9元-基础电价，设备限定为清湖园的直流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '清湖园');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.18 - rate_value
                                              WHEN scene_time_id IN ('2','3') THEN 0.9 - rate_value
                                              END
                                                            AS `rate_value` ,
                                          '清湖园直流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '清湖园直流快充桩', '1', '0', '清湖园直流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no  FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 2;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 14	绿创华南城	直流	峰期、平期1.25元/度、谷期0.9元/度	配置服务费折扣方案，峰期、平期1.25-基础电价、谷期0.9元-基础电价，设备限定为绿创华南城的直流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创华南城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 - rate_value
                                              END
                                                              AS `rate_value` ,
                                          '绿创华南城直流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '绿创华南城直流快充桩', '1', '0', '绿创华南城直流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 2;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 15	绿创华南城	交流	峰期1.09元/度，平期0.89元/度，谷期0.69元/度	配置服务费折扣方案，峰期1.09-基础电价、平期0.89-基础电价、谷期0.69元-基础电价，设备限定为绿创华南城交流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创华南城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.09 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.89 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.69 - rate_value
                                              END
                                                              AS `rate_value` ,
                                          '绿创华南城交流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '绿创华南城交流快充桩', '1', '0', '绿创华南城交流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 1;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 16	龙鸿源五金电商中心	直流	峰期、平期1.25元/度、谷期0.9元/度	配置服务费折扣方案，峰平期1.25-基础电价、谷期0.9元-基础电价，设备限定为龙鸿源五金电商中心的直流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '龙鸿源五金电商中心');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 - rate_value
                                              END
                                                                  AS `rate_value` ,
                                          '龙鸿源五金电商中心直流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '龙鸿源五金电商中心直流快充桩', '1', '0', '龙鸿源五金电商中心直流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 2;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 17	龙鸿源五金电商中心	交流	峰期1.15元/度，平期0.89元/度，谷期0.75元/度	配置服务费折扣方案，峰期1.15-基础电价、平期0.89-基础电价、谷期0.75元-基础电价，设备限定为龙鸿源五金电商中心的交流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '龙鸿源五金电商中心');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.89 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.75 - rate_value
                                              END
                                                                  AS `rate_value` ,
                                          '龙鸿源五金电商中心交流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '龙鸿源五金电商中心交流快充桩', '1', '0', '龙鸿源五金电商中心交流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 1;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 18	八约一街	不区分	峰平期1.15元/度，谷期0.9元/度	配置服务费折扣方案，峰平期1.15-基础电价、谷期0.9元-基础电价，设备限定为八约一街场站编码 不对
-- 八约一街	不区分	峰期1.14元/度，平期0.9元/度 ， 谷期0.56元/度	配置服务费折扣方案，峰平期1.15-基础电价、谷期0.9元-基础电价，设备限定为八约一街场站编码 新调整
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '八约一街');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.14 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.56 -rate_value
                                              END
                                                        AS `rate_value` ,
                                          '八约一街折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '八约一街', '1', '0', '八约一街', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 19  海关大厦充电场站	不区分	峰平期1.25元/度，谷期0.9元/度	配置服务费折扣方案，峰平期1.15-基础电价、谷期0.9元-基础电价，设备限定为场站编码海关大厦充电场站、时间限定为2020年2月15日9:00以后

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '海关大厦充电场站');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                            AS `rate_value` ,
                                          '海关大厦充电场站折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '海关大厦', '1', '0', '海关大厦', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 20 甲岸智能立体车库	不区分	峰平期1.25元/度，谷期0.9元/度	"配置服务费折扣方案，峰平期1.15-基础电价、谷期0.9元-基础电价，设备限定为甲岸智能立体车库、启创国际汽配城公网充电站、安托山站（委托运营）场站编码

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '甲岸智能立体车库');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                            AS `rate_value` ,
                                          '甲岸智能立体车库折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '甲岸智能立体车库', '1', '0', '甲岸智能立体车库', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 21 启创国际汽配城公网充电站	 不区分	峰平期1.25元/度，谷期0.9元/度	"配置服务费折扣方案，峰平期1.15-基础电价、谷期0.9元-基础电价，设备限定为甲岸智能立体车库、启创国际汽配城公网充电站、安托山站（委托运营）场站编码

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '启创国际汽配城公网充电站');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                                AS `rate_value` ,
                                          '启创国际汽配城公网充电站折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '启创国际汽配城公网充电站', '1', '0', '启创国际汽配城公网充电站', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 22  安托山站（委托运营）	不区分	峰平期1.25元/度，谷期0.9元/度	"配置服务费折扣方案，峰平期1.15-基础电价、谷期0.9元-基础电价，设备限定为甲岸智能立体车库、启创国际汽配城公网充电站、安托山站（委托运营）场站编码

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '安托山站（委托运营）');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 -rate_value
                                              END
                                                              AS `rate_value` ,
                                          '安托山站（委托运营）折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '安托山站（委托运营）', '1', '0', '安托山站（委托运营）', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');


-- 23 升阳升西丽站	不区分	峰平谷期电费/度+服务费0.75元/度+电费代收代付	配置服务费折扣方案，0.75元/度，设备限定为升阳升西丽站场站编码
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '升阳升西丽站');


INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.7500', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '升阳升西丽站', '1', '0', '升阳升西丽站', '0', NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 24	前海西部物流园	不区分	服务费0.45元/度+电费1.55元/度	"配置服务费折扣方案，0.45元/度，设备限定为前海西部物流园场站编码
-- 配置电费折扣方案，1.55元/度，设备限定为前海西部物流园场站编码"	在该站点刷卡、场站扣费优先于套餐

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '前海西部物流园');

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '1', '3', '1.55', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '前海西部物流园电费', '1', '0', '前海西部物流园电费', '0', NULL, '0', NULL, NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.45', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '前海西部物流园服务费', '1', '0', '前海西部物流园服务费', '0', NULL, '0', NULL, NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 25 25	港中大深圳校区	不区分	服务费0.396元/度+电费0元	"配置服务费折扣方案，0.396元/度，设备限定为港中大深圳校区场站编码
-- 配置电费折扣方案，0元/度，设备限定为港中大深圳校区场站编码"

-- 未割接此场站无需配置

-- 26	赤湾站	不区分	服务费0.55元/度+电费（代收代付）	配置服务费折扣方案，0.55元，设备限定为赤湾站场站编码
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '赤湾站');


INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.5500', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '赤湾站', '1', '0', '赤湾站', '0', NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 27	V12文化创意产业园	不区分	电费0.7，服务费0.8	"配置服务费折扣方案，0.8元，设备限定V12文化创意产业园站 配置电费折扣方案，0.7元，设备限定V12文化创意产业园站"
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = 'V12文化创意产业园');

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '1', '3', '0.7', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, 'V12文化创意产业园电费', '1', '0', 'V12文化创意产业园电费', '0', NULL, '0', NULL, NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', '0.8', NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, 'V12文化创意产业园服务费', '1', '0', 'V12文化创意产业园服务费', '0', NULL, '0', NULL, NULL);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');


-- 深圳场站优先无需比较套餐
UPDATE bf_rebate_plan_t set  if_compare = 0 where city_code = '100309';

COMMIT;
SET @@autocommit=1;


-- 资费


SET @@autocommit=0;
START TRANSACTION;
-- 1
-- 深圳个人0元测试套餐	深圳柜面	89	个人	服务费0元/度+电费（0元）	直接配置无分时固定电费服务费套餐	所有场站
-- 深圳0元套餐（集团A）	深圳柜面	6	集团A	服务费0元/度+电费（0元）	直接配置无分时固定电费服务费套餐	所有场站
-- set @city_code = '100309';
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳个人0元测试套餐', '深圳个人0元测试套餐', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1, '1', NULL, '深圳个人0元测试套餐电费', '深圳个人0元测试套餐电费', NULL);
set @ref_event_pricing_strategy_id_ele := @event_pricing_strategy_id;

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳个人0元测试套餐服务费', '深圳个人0元测试套餐服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_ele, NULL, '5', '1');
INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_ele, '5', NULL);
set @pricing_section_id_ele := @pricing_section_id;
INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_ele, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');
INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');

-- -------------------
-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳0元套餐（集团）', '深圳0元套餐（集团）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1, '1', NULL, '深圳0元套餐（集团）电费', '深圳0元套餐（集团）电费', NULL);
set @ref_event_pricing_strategy_id_ele := @event_pricing_strategy_id;

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳0元套餐（集团）服务费', '深圳0元套餐（集团）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_ele, NULL, '5', '1');
INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_ele, '5', NULL);
set @pricing_section_id_ele := @pricing_section_id;
INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_ele, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');
INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');

-- 2
-- 2.1 深圳市测试按照充电度数收取服务费用（个人）	深圳柜面	9	个人	服务费0.55元/度+电费（代收代付）	"直接配置服务费套餐，电费不用配
-- 套餐配置规则：包含所有乘用车站"


-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end
set @allCYC = (SELECT GROUP_CONCAT(DISTINCT CONCAT("'",`场站编号`,"'") SEPARATOR ',') from `深圳所有乘用车站` WHERE `备注` =  '');

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳市测试按照充电度数收取服务费用（个人）', '深圳市测试按照充电度数收取服务费用（个人）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳市测试按照充电度数收取服务费用（个人）服务费', '深圳市测试按照充电度数收取服务费用（个人）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @allCYC, '包含所有乘用车站');
set @allCYC_rule_id := @rule_id;

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @allCYC_rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.5500', '0', '0', '1.00');




-- 2.2 深圳市测试按照充电度数收取服务费用（集团A）	深圳柜面	10	集团A	服务费0.55元/度+电费（代收代付）	"直接配置服务费套餐，电费不用配
-- 套餐配置规则：包含所有乘用车站"


-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @allCYC_rule_id := (SELECT rule_id from bf_rule_config_t WHERE note = '包含所有乘用车站');
-- 整体运行下面注释end
set @allCYC = (SELECT GROUP_CONCAT(DISTINCT CONCAT("'",`场站编号`,"'") SEPARATOR ',') from `深圳所有乘用车站` WHERE `备注` =  '');

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳市测试按照充电度数收取服务费用（集团A）', '深圳市测试按照充电度数收取服务费用（集团A）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳市测试按照充电度数收取服务费用（集团A）服务费', '深圳市测试按照充电度数收取服务费用（集团A）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @allCYC_rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.5500', '0', '0', '1.00');




-- 2.3 深圳市测试按照充电度数收取服务费用（集团B）	深圳柜面	112	集团B	服务费0.55元/度+电费（代收代付）	"直接配置服务费套餐，电费不用配
-- 套餐配置规则：包含乘用车站"



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @allCYC_rule_id := (SELECT rule_id from bf_rule_config_t WHERE note = '包含所有乘用车站');
-- 整体运行下面注释end
set @allCYC = (SELECT GROUP_CONCAT(DISTINCT CONCAT("'",`场站编号`,"'") SEPARATOR ',') from `深圳所有乘用车站` WHERE `备注` =  '');

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳市测试按照充电度数收取服务费用（集团B）', '深圳市测试按照充电度数收取服务费用（集团B）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳市测试按照充电度数收取服务费用（集团B）服务费', '深圳市测试按照充电度数收取服务费用（集团B）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @allCYC_rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.5500', '0', '0', '1.00');




-- 3
-- 3.1深圳巴士个体套餐1（个人）	深圳柜面	104	个人	服务费0.8元/度+电费（代收代付）	直接配置服务费套餐，电费不用配


-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳巴士个体套餐1（个人）', '深圳巴士个体套餐1（个人）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳巴士个体套餐1（个人）服务费', '深圳巴士个体套餐1（个人）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.8000', '0', '0', '1.00');




-- 3.2 深圳巴士集团套餐1（集团A）	深圳柜面	105	集团A	服务费0.8元/度+电费（代收代付）	直接配置服务费套餐，电费不用配


-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳巴士集团套餐1（集团A）', '深圳巴士集团套餐1（集团A）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳巴士集团套餐1（集团A）服务费', '深圳巴士集团套餐1（集团A）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.8000', '0', '0', '1.00');




-- 3.3  深圳巴士集团套餐1（集团B）	深圳柜面	106	集团B	服务费0.8元/度+电费（代收代付）	直接配置服务费套餐，电费不用配


-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳巴士集团套餐1（集团B）', '深圳巴士集团套餐1（集团B）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳巴士集团套餐1（集团B）服务费', '深圳巴士集团套餐1（集团B）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.8000', '0', '0', '1.00');




-- 4
-- 4.1 通勤车套餐个人01	深圳柜面	148	个人	服务费0.75元/度+电费（代收代付）	直接配置服务费套餐，电费不用配



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '通勤车套餐个人01', '通勤车套餐个人01', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '通勤车套餐个人01服务费', '通勤车套餐个人01服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.7500', '0', '0', '1.00');




-- 4.2 通勤车套餐集团A01	深圳柜面	149	集团A	服务费0.75元/度+电费（代收代付）	直接配置服务费套餐，电费不用配



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '通勤车套餐集团A01', '通勤车套餐集团A01', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '通勤车套餐集团A01服务费', '通勤车套餐集团A01服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.7500', '0', '0', '1.00');




-- 4.3 通勤车套餐集团B01	深圳柜面	150	集团B	服务费0.75元/度+电费（代收代付）	直接配置服务费套餐，电费不用配



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '通勤车套餐集团B01', '通勤车套餐集团B01', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '通勤车套餐集团B01服务费', '通勤车套餐集团B01服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.7500', '0', '0', '1.00');




-- 5
-- 5.1出租车客户打包价套餐（个人）	深圳柜面	179	个人	民乐p+r站：峰期1.15元/度（含电费）、平谷期0.9元/度（含电费）；其他乘用车快充站峰平期服务费0.55元/度+电费代收代付、谷期0.9元/度（含电费）；慢充站充电服务费0.55元/度+电费代收代付	"1、脚本计算民乐站峰服务费：1.15- 民乐站峰期基础电价；2、脚本计算民乐站平谷服务费：0.9- 民乐站平期基础电价；3、配置民乐服务费规则项：场站为民乐p+r站，服务费为上述计算值；4、配置其他若干快充站服务费规则项：相同基础电价的站点配置成一条规则项，谷期为0.9-基础电价，封平期为0.55，规则为包含这些站点编码；5、配置慢充服务费规则项：0.55，规则为包含这些慢充站点编码 目前无慢充桩乘用车场站"



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '出租车客户打包价套餐（个人）', '出租车客户打包价套餐（个人）', '1', '1', NULL);

-- 民乐场站费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = (SELECT station_id from br_station_detail where station_name = '民乐P+R停车场') limit 1 ;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '1' THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('2','3') THEN 0.9 -rate_value
                                              END
                                                                      AS `rate_value` ,
                                          '出租车客户打包价套餐（个人）民乐P+R停车场峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 民乐场站费用场景end

-- 包含民乐场站规则
SELECT  CONCAT("'",`station_code`,"'") into @minleCodeStr from br_station_detail where station_name = '民乐P+R停车场' ;
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @minleCodeStr, '包含民乐场站');
-- 包含民乐场站规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '出租车客户打包价套餐（个人）民乐p+r站服务费', '出租车客户打包价套餐（个人）民乐p+r站服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');

-- 除了民乐场站外费用场景
DROP PROCEDURE if EXISTS deal_no_minle ;
CREATE PROCEDURE deal_no_minle()
BEGIN
DROP TABLE  if EXISTS 5_temp;

CREATE TEMPORARY TABLE `5_temp`
SELECT base.time_scene_id, base.rate_scene_id, GROUP_CONCAT(DISTINCT concat("'", all_cyc.`场站编号`,"'")) station_code_list from `深圳乘用车快充站` all_cyc
                                                                                                                                 LEFT JOIN
                                                                                                                             br_station_detail station
                                                                                                                             ON
                                                                                                                                     all_cyc.`场站编号` = station.station_code
                                                                                                                                 LEFT JOIN bf_indb_base_config_t base
                                                                                                                                           ON
                                                                                                                                                   base.station_id = station.station_id
WHERE all_cyc.`备注` =  ''
  AND
        all_cyc.`名称` NOT LIKE '%民乐%'
GROUP BY base.rate_scene_id ;
alter table 5_temp add column id int(10) not null auto_increment primary key;
SET @i = 1;
set @n = (select max(id) from 5_temp);
WHILE @i <= @n DO
SELECT rate_scene_id ,time_scene_id ,  station_code_list INTO @base_rate_scene_id , @base_time_scene_id , @station_code_list from 5_temp WHERE id = @i;
-- *********************
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '3' THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('1','2') THEN 0.55
                                              END
                                                          AS `rate_value` ,
                                          '出租车客户打包价套餐峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 场站费用场景end

-- 场站规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @station_code_list, concat('出租车客户打包价包含场站_',@i));
-- 包含规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, concat('出租车客户打包价套餐（个人）场站服务费',@i), concat('出租车客户打包价套餐（个人）场站服务费',@i), NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');
-- *********************
SET @i := @i + 1;
END WHILE;
END;
CALL deal_no_minle();



-- 5.2 出租车客户打包价套餐（集团A）	深圳柜面	180	集团A	民乐p+r站：峰期1.15元/度（含电费）、平谷期0.9元/度（含电费）；其他乘用车快充站峰平期服务费0.55元/度+电费代收代付、谷期0.9元/度（含电费）；慢充站充电服务费0.55元/度+电费代收代付	"1、脚本计算民乐站峰服务费：1.15- 民乐站峰期基础电价；2、脚本计算民乐站平谷服务费：0.9- 民乐站平期基础电价；3、配置民乐服务费规则项：场站为民乐p+r站，服务费为上述计算值；4、配置其他若干快充站服务费规则项：相同基础电价的站点配置成一条规则项，谷期为0.9-基础电价，封平期为0.55，规则为包含这些站点编码；5、配置慢充服务费规则项：0.55，规则为包含这些慢充站点编码"



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '出租车客户打包价套餐（集团A）', '出租车客户打包价套餐（集团A）', '1', '1', NULL);

-- 民乐场站费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = (SELECT station_id from br_station_detail where station_name = '民乐P+R停车场') limit 1 ;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '1' THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('2','3') THEN 0.9 -rate_value
                                              END
                                                                       AS `rate_value` ,
                                          '出租车客户打包价套餐（集团A）民乐P+R停车场峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 民乐场站费用场景end

-- 包含民乐场站规则
SELECT  CONCAT("'",`station_code`,"'") into @minleCodeStr from br_station_detail where station_name = '民乐P+R停车场' ;
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @minleCodeStr, '出租车客户打包价套餐（集团A）包含民乐场站');
-- 包含民乐场站规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '出租车客户打包价套餐（集团A）民乐p+r站服务费', '出租车客户打包价套餐（集团A）民乐p+r站服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');

-- 除了民乐场站外费用场景
DROP PROCEDURE if EXISTS deal_no_minle ;
CREATE PROCEDURE deal_no_minle()
BEGIN
DROP TABLE  if EXISTS 5_temp;

CREATE TEMPORARY TABLE `5_temp`
SELECT base.time_scene_id, base.rate_scene_id, GROUP_CONCAT(DISTINCT concat("'", all_cyc.`场站编号`,"'")) station_code_list from `深圳乘用车快充站` all_cyc
                                                                                                                                 LEFT JOIN
                                                                                                                             br_station_detail station
                                                                                                                             ON
                                                                                                                                     all_cyc.`场站编号` = station.station_code
                                                                                                                                 LEFT JOIN bf_indb_base_config_t base
                                                                                                                                           ON
                                                                                                                                                   base.station_id = station.station_id
WHERE all_cyc.`备注` =  ''
  AND
        all_cyc.`名称` NOT LIKE '%民乐%'
GROUP BY base.rate_scene_id ;
alter table 5_temp add column id int(10) not null auto_increment primary key;
SET @i = 1;
set @n = (select max(id) from 5_temp);
WHILE @i <= @n DO
SELECT rate_scene_id ,time_scene_id ,  station_code_list INTO @base_rate_scene_id , @base_time_scene_id , @station_code_list from 5_temp WHERE id = @i;
-- *********************
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '3' THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('1','2') THEN 0.55
                                              END
                                                                 AS `rate_value` ,
                                          '出租车客户打包价套餐（集团A）套餐峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 场站费用场景end

-- 场站规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @station_code_list, concat('出租车客户打包价套餐（集团A）包含场站_',@i));
-- 包含规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, concat('出租车客户打包价套餐（集团A）场站服务费',@i), concat('出租车客户打包价套餐（集团A）场站服务费',@i), NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');
-- *********************
SET @i := @i + 1;
END WHILE;
END;
CALL deal_no_minle();



-- 5.3出租车客户打包价套餐（集团B）	深圳柜面	181	集团B	民乐p+r站：峰期1.15元/度（含电费）、平谷期0.9元/度（含电费）；其他乘用车快充站峰平期服务费0.55元/度+电费代收代付、谷期0.9元/度（含电费）；慢充站充电服务费0.55元/度+电费代收代付	"1、脚本计算民乐站峰服务费：1.15- 民乐站峰期基础电价；2、脚本计算民乐站平谷服务费：0.9- 民乐站平期基础电价；3、配置民乐服务费规则项：场站为民乐p+r站，服务费为上述计算值；4、配置其他若干快充站服务费规则项：相同基础电价的站点配置成一条规则项，谷期为0.9-基础电价，封平期为0.55，规则为包含这些站点编码；5、配置慢充服务费规则项：0.55，规则为包含这些慢充站点编码"



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '出租车客户打包价套餐（集团B）', '出租车客户打包价套餐（集团B）', '1', '1', NULL);

-- 民乐场站费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = (SELECT station_id from br_station_detail where station_name = '民乐P+R停车场') limit 1 ;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '1' THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('2','3') THEN 0.9 -rate_value
                                              END
                                                                       AS `rate_value` ,
                                          '出租车客户打包价套餐（集团B）民乐P+R停车场峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 民乐场站费用场景end

-- 包含民乐场站规则
SELECT  CONCAT("'",`station_code`,"'") into @minleCodeStr from br_station_detail where station_name = '民乐P+R停车场' ;
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @minleCodeStr, '出租车客户打包价套餐（集团B）包含民乐场站');
-- 包含民乐场站规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '出租车客户打包价套餐（集团B）民乐p+r站服务费', '出租车客户打包价套餐（集团B）民乐p+r站服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');

-- 除了民乐场站外费用场景
DROP PROCEDURE if EXISTS deal_no_minle ;
CREATE PROCEDURE deal_no_minle()
BEGIN
DROP TABLE  if EXISTS 5_temp;

CREATE TEMPORARY TABLE `5_temp`
SELECT base.time_scene_id, base.rate_scene_id, GROUP_CONCAT(DISTINCT concat("'", all_cyc.`场站编号`,"'")) station_code_list from `深圳乘用车快充站` all_cyc
                                                                                                                                 LEFT JOIN
                                                                                                                             br_station_detail station
                                                                                                                             ON
                                                                                                                                     all_cyc.`场站编号` = station.station_code
                                                                                                                                 LEFT JOIN bf_indb_base_config_t base
                                                                                                                                           ON
                                                                                                                                                   base.station_id = station.station_id
WHERE all_cyc.`备注` =  ''
  AND
        all_cyc.`名称` NOT LIKE '%民乐%'
GROUP BY base.rate_scene_id ;
alter table 5_temp add column id int(10) not null auto_increment primary key;
SET @i = 1;
set @n = (select max(id) from 5_temp);
WHILE @i <= @n DO
SELECT rate_scene_id ,time_scene_id ,  station_code_list INTO @base_rate_scene_id , @base_time_scene_id , @station_code_list from 5_temp WHERE id = @i;
-- *********************
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '3' THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('1','2') THEN 0.55
                                              END
                                                                 AS `rate_value` ,
                                          '出租车客户打包价套餐（集团B）套餐峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 场站费用场景end

-- 场站规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @station_code_list, concat('出租车客户打包价套餐（集团B）包含场站_',@i));
-- 包含规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, concat('出租车客户打包价套餐（集团B）场站服务费',@i), concat('出租车客户打包价套餐（集团B）场站服务费',@i), NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');
-- *********************
SET @i := @i + 1;
END WHILE;
END;
CALL deal_no_minle();



-- 6 小桔充电计费套餐（集团B）	深圳柜面	183	集团B	峰平期服务费0.55元/度+电费（代收代付）、谷期打包价0.9元/度（含电费）；	配置服务费规则项：峰平期0.55，谷期为0.9-基础电价，规则为场站编码包含滴滴第一批场站列表	2019.12.30日起小桔客户在联合广场、新安公园西、洪浪公园、前海企业公馆充电按场站资费优先收费



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '小桔充电计费套餐（集团B）', '小桔充电计费套餐（集团B）', '1', '1', NULL);

-- 费用场景
DROP PROCEDURE if EXISTS deal_no_minle ;
CREATE PROCEDURE deal_no_minle()
BEGIN
DROP TABLE  if EXISTS 6_temp;

CREATE TEMPORARY TABLE `6_temp`
SELECT base.time_scene_id, base.rate_scene_id, GROUP_CONCAT(DISTINCT concat("'", cz.`场站编号`,"'")) station_code_list from `滴滴场站汇总` cz
                                                                                                                            LEFT JOIN
                                                                                                                        br_station_detail station
                                                                                                                        ON
                                                                                                                                cz.`场站编号` = station.station_code
                                                                                                                            LEFT JOIN bf_indb_base_config_t base
                                                                                                                                      ON
                                                                                                                                              base.station_id = station.station_id
WHERE cz.`备注` =  '' or  cz.`备注` IS NULL
GROUP BY base.rate_scene_id ;
alter table 6_temp add column id int(10) not null auto_increment primary key;
SET @i = 1;
set @n = (select max(id) from 6_temp);
WHILE @i <= @n DO
SELECT rate_scene_id ,time_scene_id ,  station_code_list INTO @base_rate_scene_id , @base_time_scene_id , @station_code_list from 6_temp WHERE id = @i;
-- *********************
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '3' THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('1','2') THEN 0.55
                                              END
                                                                         AS `rate_value` ,
                                          concat('小桔充电计费套餐（集团B）峰平谷_',@i) AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 场站费用场景end

-- 场站规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @station_code_list, concat('小桔充电计费套餐（集团B）包含场站_',@i));
-- 包含规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, concat('小桔充电计费套餐（集团B）场站服务费_',@i), concat('小桔充电计费套餐（集团B）场站服务费_',@i), NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');
-- *********************
SET @i := @i + 1;
END WHILE;
END;
CALL deal_no_minle();



-- 7
-- 7.1 深圳乘用车套餐（1）(个人)	深圳柜面	188	个人	峰平期服务费0.55元/度+电费（代收代付）、谷期打包价0.9元/度（含电费）；	配置服务费规则项：峰平期0.55，谷期为0.9-基础电价，规则为场站编码包含除公交场站外所有乘用车站列表	除公交场站外所有乘用车站



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳乘用车套餐（1）（个人）', '深圳乘用车套餐（1）（个人）', '1', '1', NULL);

-- 费用场景
DROP PROCEDURE if EXISTS deal_no_minle ;
CREATE PROCEDURE deal_no_minle()
BEGIN
DROP TABLE  if EXISTS 7_temp;

CREATE TEMPORARY TABLE `7_temp`
SELECT base.time_scene_id, base.rate_scene_id, GROUP_CONCAT(DISTINCT concat("'", cz.`场站编号`,"'")) station_code_list from `深圳乘用车快充站` cz
                                                                                                                            LEFT JOIN
                                                                                                                        br_station_detail station
                                                                                                                        ON
                                                                                                                                cz.`场站编号` = station.station_code
                                                                                                                            LEFT JOIN bf_indb_base_config_t base
                                                                                                                                      ON
                                                                                                                                              base.station_id = station.station_id
WHERE cz.`备注` =  '' or  cz.`备注` IS NULL
GROUP BY base.rate_scene_id ;
alter table 7_temp add column id int(10) not null auto_increment primary key;
SET @i = 1;
set @n = (select max(id) from 7_temp);
WHILE @i <= @n DO
SELECT rate_scene_id ,time_scene_id ,  station_code_list INTO @base_rate_scene_id , @base_time_scene_id , @station_code_list from 7_temp WHERE id = @i;
-- *********************
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '3' THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('1','2') THEN 0.55
                                              END
                                                                       AS `rate_value` ,
                                          concat('深圳乘用车套餐（1）（个人）_',@i) AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 场站费用场景end

-- 场站规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @station_code_list, concat('深圳乘用车套餐（1）（个人）包含场站_',@i));
-- 包含规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, concat('深圳乘用车套餐（1）（个人）场站服务费_',@i), concat('深圳乘用车套餐（1）（个人）场站服务费_',@i), NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');
-- *********************
SET @i := @i + 1;
END WHILE;
END;
CALL deal_no_minle();



-- 7.2 深圳乘用车套餐（1）（集团A）	深圳柜面	189	集团A	峰平期服务费0.55元/度+电费（代收代付）、谷期打包价0.9元/度（含电费）；	配置服务费规则项：峰平期0.55，谷期为0.9-基础电价，规则为场站编码包含除公交场站外所有乘用车站列表	除公交场站外所有乘用车站



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳乘用车套餐（1）（集团A）', '深圳乘用车套餐（1）（集团A）', '1', '1', NULL);

-- 费用场景
DROP PROCEDURE if EXISTS deal_no_minle ;
CREATE PROCEDURE deal_no_minle()
BEGIN
DROP TABLE  if EXISTS 7_temp;

CREATE TEMPORARY TABLE `7_temp`
SELECT base.time_scene_id, base.rate_scene_id, GROUP_CONCAT(DISTINCT concat("'", cz.`场站编号`,"'")) station_code_list from `深圳乘用车快充站` cz
                                                                                                                            LEFT JOIN
                                                                                                                        br_station_detail station
                                                                                                                        ON
                                                                                                                                cz.`场站编号` = station.station_code
                                                                                                                            LEFT JOIN bf_indb_base_config_t base
                                                                                                                                      ON
                                                                                                                                              base.station_id = station.station_id
WHERE cz.`备注` =  '' or  cz.`备注` IS NULL
GROUP BY base.rate_scene_id ;
alter table 7_temp add column id int(10) not null auto_increment primary key;
SET @i = 1;
set @n = (select max(id) from 7_temp);
WHILE @i <= @n DO
SELECT rate_scene_id ,time_scene_id ,  station_code_list INTO @base_rate_scene_id , @base_time_scene_id , @station_code_list from 7_temp WHERE id = @i;
-- *********************
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '3' THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('1','2') THEN 0.55
                                              END
                                                                        AS `rate_value` ,
                                          concat('深圳乘用车套餐（1）(集团A)_',@i) AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 场站费用场景end

-- 场站规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @station_code_list, concat('深圳乘用车套餐（1）（集团A）包含场站_',@i));
-- 包含规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, concat('深圳乘用车套餐（1）（集团A）场站服务费_',@i), concat('深圳乘用车套餐（1）（集团A）场站服务费_',@i), NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');
-- *********************
SET @i := @i + 1;
END WHILE;
END;
CALL deal_no_minle();



-- 7.3 深圳乘用车套餐（1）（集团B）	深圳柜面	189	集团A	峰平期服务费0.55元/度+电费（代收代付）、谷期打包价0.9元/度（含电费）；	配置服务费规则项：峰平期0.55，谷期为0.9-基础电价，规则为场站编码包含除公交场站外所有乘用车站列表	除公交场站外所有乘用车站



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳乘用车套餐（1）（集团B）', '深圳乘用车套餐（1）（集团B）', '1', '1', NULL);

-- 费用场景
DROP PROCEDURE if EXISTS deal_no_minle ;
CREATE PROCEDURE deal_no_minle()
BEGIN
DROP TABLE  if EXISTS 7_temp;

CREATE TEMPORARY TABLE `7_temp`
SELECT base.time_scene_id, base.rate_scene_id, GROUP_CONCAT(DISTINCT concat("'", cz.`场站编号`,"'")) station_code_list from `深圳乘用车快充站` cz
                                                                                                                            LEFT JOIN
                                                                                                                        br_station_detail station
                                                                                                                        ON
                                                                                                                                cz.`场站编号` = station.station_code
                                                                                                                            LEFT JOIN bf_indb_base_config_t base
                                                                                                                                      ON
                                                                                                                                              base.station_id = station.station_id
WHERE cz.`备注` =  '' or  cz.`备注` IS NULL
GROUP BY base.rate_scene_id ;
alter table 7_temp add column id int(10) not null auto_increment primary key;
SET @i = 1;
set @n = (select max(id) from 7_temp);
WHILE @i <= @n DO
SELECT rate_scene_id ,time_scene_id ,  station_code_list INTO @base_rate_scene_id , @base_time_scene_id , @station_code_list from 7_temp WHERE id = @i;
-- *********************
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '3' THEN 0.9 - rate_value
                                              WHEN scene_time_id IN ('1','2') THEN 0.55
                                              END
                                                                        AS `rate_value` ,
                                          concat('深圳乘用车套餐（1）（集团B）_',@i) AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 场站费用场景end

-- 场站规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @station_code_list, concat('深圳乘用车套餐（1）（集团B）包含场站_',@i));
-- 包含规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, concat('深圳乘用车套餐（1）（集团B）场站服务费_',@i), concat('深圳乘用车套餐（1）（集团B）_',@i), NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');
-- *********************
SET @i := @i + 1;
END WHILE;
END;
CALL deal_no_minle();



-- 8 互联互通套餐01	深圳柜面	191	集团B	服务费0.7元/度+电费（代收代付）	配置服务费规则项：服务费0.7，规则为场站编码包含所有乘用车场站	所有乘用车场站



-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end
set @allCYC = (SELECT GROUP_CONCAT(DISTINCT CONCAT("'",`场站编号`,"'") SEPARATOR ',') from `深圳所有乘用车站` WHERE `备注` =  '');

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '互联互通套餐01', '互联互通套餐01', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '互联互通套餐01服务费', '互联互通套餐01服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @allCYC, '互联互通套餐01包含所有乘用车站');
set @allCYC_rule_id := @rule_id;

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @allCYC_rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.7000', '0', '0', '1.00');




-- 9 巴士集团、东部公交计费套餐	深圳柜面	182	集团B	服务费0元/度+电费0元/度	"配置服务费规则项：服务费0；
-- 配置电费规则项：电费0；"



set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '巴士集团、东部公交计费套餐', '巴士集团、东部公交计费套餐', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1, '1', NULL, '巴士集团、东部公交计费套餐电费', '巴士集团、东部公交计费套餐电费', NULL);
set @ref_event_pricing_strategy_id_ele := @event_pricing_strategy_id;

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '巴士集团、东部公交计费套餐服务费', '巴士集团、东部公交计费套餐服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_ele, NULL, '5', '1');
INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_ele, '5', NULL);
set @pricing_section_id_ele := @pricing_section_id;
INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_ele, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');
INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');




-- 扫码套餐


-- 整体运行下面注释
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);
-- 整体运行下面注释end

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '扫码套餐', '扫码套餐', '1', '1', NULL);

-- 民乐场站费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = (SELECT station_id from br_station_detail where station_name = '民乐P+R停车场') limit 1 ;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id = '1' THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('2','3') THEN 0.9 -rate_value
                                              END
                                                            AS `rate_value` ,
                                          '扫码套餐民乐P+R停车场峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 民乐场站费用场景end

-- 包含民乐场站规则
SELECT  CONCAT("'",`station_code`,"'") into @minleCodeStr from br_station_detail where station_name = '民乐P+R停车场' ;
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @minleCodeStr, '扫码套餐包含民乐场站');
-- 包含民乐场站规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '扫码套餐民乐p+r站服务费', '扫码套餐民乐p+r站服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');

-- 赤湾站服务费无分时0.55，电费代收代付
-- 包含赤湾场站规则
SELECT  CONCAT("'",`station_code`,"'") into @minleCodeStr from br_station_detail where station_name = '赤湾站' ;
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @minleCodeStr, '扫码套餐包含赤湾站');
-- 包含赤湾站规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '扫码套餐赤湾站服务费', '扫码套餐赤湾站服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.5500', '0', '0', '1.00');

-- 慢充站点-------------------------
DROP PROCEDURE if EXISTS deal_no_minle_m ;
CREATE PROCEDURE deal_no_minle_m()
BEGIN

set @manlist = (SELECT GROUP_CONCAT(concat("'", station.station_code,"'"))  from
(
select a.* from
(SELECT station_id ,count(*) charge_sum ,sum(quick_slow) flag from br_batterycharge  where city_code = '100309' GROUP BY station_id) a
where a.flag = 0
)
 all_cyc
LEFT JOIN
br_station_detail station
ON
all_cyc.station_id = station.station_id
WHERE
station.station_name NOT LIKE '%民乐%');

-- 场站慢充规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @manlist, '扫码套餐慢充包含场站');
-- 包含慢充规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '扫码套餐慢充服务费', '扫码套餐慢充服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1','0', '1', '0' , '0.8000', '0', '0', '1.00');

-- *********************
END;
CALL deal_no_minle_m();

-- 快充站点-------------------------
DROP PROCEDURE if EXISTS deal_no_minle_k ;
CREATE PROCEDURE deal_no_minle_k()
BEGIN

DROP TABLE  if EXISTS smk_temp;

CREATE TEMPORARY TABLE `smk_temp`
SELECT base.time_scene_id, base.rate_scene_id, rate.rate_scene_type_id , GROUP_CONCAT(DISTINCT concat("'", station.station_code,"'")) station_code_list from
    (
        select a.* from
            (SELECT station_id ,count(*) charge_sum ,sum(quick_slow) flag from br_batterycharge  where city_code = '100309' GROUP BY station_id) a
        where a.flag = a.charge_sum
    )
        all_cyc
        LEFT JOIN
    br_station_detail station
    ON
            all_cyc.station_id = station.station_id
        LEFT JOIN bf_indb_base_config_t base
                  ON
                          base.station_id = station.station_id
        LEFT JOIN (SELECT DISTINCT rate_scene_type_id , rate_scene_id from bf_rate_scene_config_t ) rate
                  ON
                          base.rate_scene_id = rate.rate_scene_id
where base.time_scene_id is not NULL
  AND
        station.station_name NOT LIKE '%民乐%'
  and
        station.station_name NOT LIKE '%赤湾%'
GROUP BY base.rate_scene_id ORDER BY base.time_scene_id DESC;

alter table smk_temp add column id int(10) not null auto_increment primary key;
SET @i = 1;
set @n = (select max(id) from smk_temp);
WHILE @i <= @n DO
SELECT rate_scene_id ,time_scene_id ,  station_code_list INTO @base_rate_scene_id , @base_time_scene_id , @station_code_list from smk_temp WHERE id = @i;
-- *********************
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

IF (@base_time_scene_id != 0) THEN
	INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                              CASE
                                                  WHEN scene_time_id = '3' THEN 0.9 - rate_value
                                                  WHEN scene_time_id IN ('1','2') THEN 0.55
                                                  END
                                                                     AS `rate_value` ,
                                              concat('扫码套餐快充站点_',@i) AS `rate_scene_desc`
                                       from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;

ELSE
	SET @base_time_scene_id = (SELECT DISTINCT scene_id from bf_time_scene_config_t where scene_name = '深圳峰平谷');
	-- 基础电价无分时，这边是峰平谷
INSERT INTO bf_rate_scene_config_t
SELECT `city_code`, 1 AS `rate_scene_type_id`, @rate_scene_id, '1' AS `scene_time_id`,
       '0.55' as `rate_value` ,
       concat('扫码套餐快充站点_',@i) AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id
UNION
SELECT `city_code`, 1 AS `rate_scene_type_id`, @rate_scene_id, '2' AS `scene_time_id`,
       '0.55' as `rate_value` ,
       concat('扫码套餐快充站点_',@i) AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id
UNION
SELECT `city_code`, 1 AS `rate_scene_type_id`, @rate_scene_id, '3' AS `scene_time_id`,
       0.9 - rate_value as rate_value,
       concat('扫码套餐快充站点_',@i) AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id;


END IF;
	-- 场站费用场景end
	-- 场站规则
INSERT INTO `bf_rule_config_t` (`city_code`, `rule_id`, `sys_id`, `group_id`, `cond_id`, `cond_type`, `obj_code`, `params`, `oper_code`, `result`, `note`)
VALUES (@city_code, @rule_id := @rule_id + 1, NULL, '1', '1', NULL, 'GETSTATIONID', NULL, '7', @station_code_list, concat('扫码套餐快充包含场站_',@i));
-- 包含规则end

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, concat('扫码套餐快充服务费',@i), concat('扫码套餐快充服务费',@i), NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');


INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', @rule_id);
set @pricing_section_id_fee := @pricing_section_id;


INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', @rate_scene_id, '0', @base_time_scene_id, '0', '1.00');
-- *********************
SET @i := @i + 1;
END WHILE;
END;
CALL deal_no_minle_k();

-- 深圳市宝马用户套餐	深圳市宝马用户套餐	深圳柜面	59	个人	深圳宝马卡服务费1*90%=0.9元/kwh+电费（代收代付）
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '深圳市宝马用户套餐', '深圳市宝马用户套餐', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '深圳市宝马用户套餐服务费', '深圳市宝马用户套餐服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;


INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.9000', '0', '0', '1.00');

-- 宝马电子卡专属集团（深圳）	宝马电子卡专属集团（深圳）	深圳柜面	211	集团B	服务费0元/度+电费0元/度
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '宝马电子卡专属集团（深圳）', '宝马电子卡专属集团（深圳）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1, '1', NULL, '宝马电子卡专属集团（深圳）电费', '宝马电子卡专属集团（深圳）电费', NULL);
set @ref_event_pricing_strategy_id_ele := @event_pricing_strategy_id;

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '宝马电子卡专属集团（深圳）服务费', '宝马电子卡专属集团（深圳）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_ele, NULL, '5', '1');
INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_ele, '5', NULL);
set @pricing_section_id_ele := @pricing_section_id;
INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_ele, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');
INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');

-- 宝马云端互联专属集团（深圳）	宝马云端互联专属集团（深圳）	深圳柜面	212	集团B	服务费0.55元/度+电费（代收代付）
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '宝马云端互联专属集团（深圳）', '宝马云端互联专属集团（深圳）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '宝马云端互联专属集团（深圳）服务费', '宝马云端互联专属集团（深圳）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;


INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '0.5500', '0', '0', '1.00');

-- 珠海资费（个人）	珠海资费（个人）	深圳柜面	171	个人	1.5元/度（含电费+服务费）
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '珠海资费（个人）', '珠海资费（个人）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1, '1', NULL, '珠海资费（个人）电费', '珠海资费（个人）电费', NULL);
set @ref_event_pricing_strategy_id_ele := @event_pricing_strategy_id;

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '珠海资费（个人）服务费', '珠海资费（个人）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_ele, NULL, '5', '1');
INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_ele, '5', NULL);
set @pricing_section_id_ele := @pricing_section_id;
INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_ele, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');
INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '1.5000', '0', '0', '1.00');

-- 珠海资费（集团A）	珠海资费（集团A）	深圳柜面	172	集团A	1.5元/度（含电费+服务费）
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '珠海资费（集团A）', '珠海资费（集团A）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1, '1', NULL, '珠海资费（集团A）电费', '珠海资费（集团A）电费', NULL);
set @ref_event_pricing_strategy_id_ele := @event_pricing_strategy_id;

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '珠海资费（集团A）服务费', '珠海资费（集团A）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_ele, NULL, '5', '1');
INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_ele, '5', NULL);
set @pricing_section_id_ele := @pricing_section_id;
INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_ele, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');
INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '1.5000', '0', '0', '1.00');

-- 珠海资费（集团B）	珠海资费（集团B）	深圳柜面	173	集团B	服务费1.5元/kwh+电费0元/度
set @city_code = '100309';
set @pricing_plan_id = (SELECT max(pricing_plan_id) from bf_pricing_plan_t);
set @event_pricing_strategy_id = (SELECT max(event_pricing_strategy_id) from bf_event_pricing_strategy_t);
set @pricing_section_id = (SELECT max(pricing_section_id) from bf_pricing_section_t);
set @tariff_id = (SELECT max(tariff_id) from bf_tariff_t);
set @rule_id = (SELECT max(rule_id) from bf_rule_config_t);

INSERT INTO `bf_pricing_plan_t` (`city_code`, `pricing_plan_id`, `pricing_plan_name`, `pricing_desc`, `state`, `if_valid`, `fail`)
VALUES (@city_code, @pricing_plan_id := @pricing_plan_id + 1, '珠海资费（集团B）', '珠海资费（集团B）', '1', '1', NULL);

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1, '1', NULL, '珠海资费（集团B）电费', '珠海资费（集团B）电费', NULL);
set @ref_event_pricing_strategy_id_ele := @event_pricing_strategy_id;

INSERT INTO `bf_event_pricing_strategy_t` (`city_code`, `event_pricing_strategy_id`, `event_type_id`, `source_event_type`,
                                           `event_pricing_strategy_name`, `event_pricing_strategy_desc`, `charge_type`)
VALUES (@city_code, @event_pricing_strategy_id := @event_pricing_strategy_id + 1 , '2', NULL, '珠海资费（集团B）服务费', '珠海资费（集团B）服务费', NULL);
set @ref_event_pricing_strategy_id_fee := @event_pricing_strategy_id;

INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_ele, NULL, '5', '1');
INSERT INTO `bf_pricing_combine_t` (`pricing_plan_id`, `event_pricing_strategy_id`, `life_cycle_id`, `calc_priority`, `event_type_id`)
VALUES (@pricing_plan_id, @ref_event_pricing_strategy_id_fee, NULL, '5', '2');

INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_ele, '5', NULL);
set @pricing_section_id_ele := @pricing_section_id;
INSERT INTO `bf_pricing_section_t` (`pricing_section_id`, `pricing_section_name`, `pricing_calc_type`,
                                    `start_ref_value_id`, `end_ref_value_id`, `event_pricing_strategy_id`, `calc_priority`, `pricing_rule_id`)
VALUES (@pricing_section_id := @pricing_section_id + 1, NULL, '1', NULL, NULL, @ref_event_pricing_strategy_id_fee, '5', NULL);
set @pricing_section_id_fee := @pricing_section_id;

INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_ele, '0', '0', '1', '0', '1', '0', '0.0000', '0', '0', '1.00');
INSERT INTO `bf_tariff_t` (`tariff_id`, `pricing_section_id`, `if_gather`, `acct_item_type_id`, `tariff_unit_id`,
                           `calc_method_id`, `ref_value_type`, `rate_scene_id`, `rate_value`, `scene_id`, `if_discount`, `discount`)
VALUES (@tariff_id := @tariff_id +1, @pricing_section_id_fee, '0', '0', '1', '0', '1', '0', '1.5000', '0', '0', '1.00');

COMMIT;
SET @@autocommit=1;

-- 套餐.sql

set @prod_offer_id = (SELECT max(prod_offer_id) from bb_prod_offer) ;
DROP TABLE  IF EXISTS union_offer;
CREATE TEMPORARY TABLE union_offer
SELECT city_code, @prod_offer_id := @prod_offer_id + 1 as prod_offer_id , '2' as offer_type , plan.pricing_plan_name , '1' as status_cd ,
'2020-2-19 23:41:25' as status_date , '2020-2-19 23:41:25' as eff_date , '3000-12-31 00:00:00' as exp_date ,
plan.pricing_desc as prod_offer_desc , plan.pricing_plan_id as pricing_plan_id , plan.city_code as apply_source , '1' as coop_unit_id ,
NULL as car_number , NULL as apply_id , '0' as if_over ,
NULL as apply_unit , NULL as top_Power , null as peak_Power , NULL as flat_Power ,
NULL as valley_Power , NULL as top_Info , NULL as peak_Info , NULL as flat_Info ,NULL as valley_Info
FROM bf_pricing_plan_t plan WHERE city_code = '100309' ;

INSERT INTO bb_prod_offer SELECT prod_offer_id , offer_type , pricing_plan_name , status_cd ,
                                 status_date ,eff_date , exp_date ,
                                 prod_offer_desc , pricing_plan_id , apply_source , coop_unit_id ,
                                 car_number ,apply_id , if_over ,
                                 apply_unit , top_Power , peak_Power ,flat_Power ,
                                 valley_Power , top_Info , peak_Info , flat_Info ,valley_Info
FROM union_offer ;

set @offer_area_id = (SELECT max(offer_area_id) from bb_prod_offer_area) ;

INSERT INTO `bb_prod_offer_area`
SELECT @offer_area_id := @offer_area_id + 1 as offer_area_id , prod_offer_id , city_code , NULL as status_cd, NULL as eff_date, NULL as exp_date
from union_offer;

set @offer_channel_id = (SELECT max(offer_channel_id) from bb_prod_offer_channel) ;

INSERT INTO `bb_prod_offer_channel`
SELECT @offer_channel_id := @offer_channel_id + 1 as `offer_channel_id`, prod_offer_id, '1' as `channel_id` , '1' as `status_cd`, `eff_date`, `exp_date`
from union_offer;

UPDATE bb_prod_offer_channel SET channel_id = 1 where prod_offer_id in (SELECT prod_offer_id from bb_prod_offer where apply_source = '100309');

-- 增加网厅套餐 深圳巴士个体套餐1（个人） 深圳乘用车套餐（1）（个人）
set @offer_channel_id = (SELECT max(offer_channel_id) from bb_prod_offer_channel) ;

SET @hall_offer := (SELECT prod_offer_id from bb_prod_offer where prod_offer_name = '深圳巴士个体套餐1（个人）');

INSERT INTO `bb_prod_offer_channel` (`offer_channel_id`, `prod_offer_id`, `channel_id`, `status_cd`, `eff_date`, `exp_date`) VALUES (@offer_channel_id := @offer_channel_id + 1, @hall_offer, '2', '1', '2020-02-19 23:41:25', '3000-12-31 00:00:00');

SET @hall_offer := (SELECT prod_offer_id from bb_prod_offer where prod_offer_name = '深圳乘用车套餐（1）（个人）');

INSERT INTO `bb_prod_offer_channel` (`offer_channel_id`, `prod_offer_id`, `channel_id`, `status_cd`, `eff_date`, `exp_date`) VALUES (@offer_channel_id := @offer_channel_id + 1, @hall_offer, '2', '1', '2020-02-19 23:41:25', '3000-12-31 00:00:00');


UPDATE  bb_prod_offer SET offer_type = 1 where prod_offer_name in (
                                                                   '深圳个人0元测试套餐' ,
                                                                   '深圳市宝马用户套餐' ,
                                                                   '珠海资费（个人）' ,
                                                                   '深圳市测试按照充电度数收取服务费用（个人）' ,
                                                                   '深圳巴士个体套餐1（个人）' ,
                                                                   '通勤车套餐个人01' ,
                                                                   '出租车客户打包价套餐（个人）' ,
                                                                   '深圳乘用车套餐（1）（个人）'
    );

UPDATE bb_prod_offer SET coop_unit_id = '2' where prod_offer_name LIKE '%宝马%' AND apply_source = '100309';

UPDATE `bb_prod_offer` SET `top_Power`='0.00', `peak_Power`='0.00', `flat_Power`='0.00', `valley_Power`='0.00', `top_Info`='0.55', `peak_Info`='0.55', `flat_Info`='0.55', `valley_Info`='0.66'
WHERE `prod_offer_name`='小桔充电计费套餐（集团B）';

UPDATE `bb_prod_offer` SET  `top_Info`='0.55', `peak_Info`='0.55', `flat_Info`='0.55', `valley_Info`='0.66'
WHERE `prod_offer_desc`='深圳乘用车套餐（1）（集团B）';

UPDATE seq_sequence SET  current_value = (SELECT MAX(prod_offer_id) from bb_prod_offer ) where demo = '套餐id' ;
UPDATE seq_sequence SET  current_value = (SELECT MAX(offer_area_id) from bb_prod_offer_area ) where demo = '套餐适用地区id' ;
UPDATE seq_sequence SET  current_value = (SELECT MAX(offer_channel_id) from bb_prod_offer_channel ) where demo = '套餐适用渠道id' ;

-- 深圳优惠活动
-- 1、绿创万众茶城	交流桩：峰期1.15元/度、平0.87元/度、谷0.55元/度（价格含服务费、电费）	不限	活动时间截止至2020年4月1号00:00
-- 原来的设定时间点
UPDATE `bf_rebate_plan_t` SET `begin_date`='2020-04-01 00:00:00'  WHERE `rebate_plan_name`='绿创万众茶城交流快充桩';

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创万众茶城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.87 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.55 -rate_value
                                              END
                                                               AS `rate_value` ,
                                          '绿创万众茶城交流快充桩优惠活动峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, '2020-04-01 00:00:00', NULL, NULL, NULL, NULL, '绿创万众茶城交流快充桩优惠活动', '1', '0', '绿创万众茶城交流快充桩优惠活动', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 1;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 2 龙鸿源五金电商中心	直流桩：峰平1.15元/度（价格含服务费、电费）谷0.9	不限	活动时间截止至2020年4月1号00:00；
-- 原来的设定时间点
UPDATE `bf_rebate_plan_t` SET `begin_date`='2020-04-01 00:00:00'  WHERE `rebate_plan_name`='龙鸿源五金电商中心直流快充桩';

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '龙鸿源五金电商中心');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.15 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 - rate_value
                                              END
                                                                  AS `rate_value` ,
                                          '龙鸿源五金电商中心直流快充桩优惠活动峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, '2020-04-01 00:00:00', NULL, NULL, NULL, NULL, '龙鸿源五金电商中心直流快充桩优惠活动', '1', '0', '龙鸿源五金电商中心直流快充桩优惠活动', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 2;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 3 龙鸿源五金电商中心	交流桩：峰1.14元/度，平0.89元/度，谷0.56元/度（价格含服务费、电费）	不限	活动时间截止至2020年4月1号00:00；
-- 原来的设定时间点
UPDATE `bf_rebate_plan_t` SET `begin_date`='2020-04-01 00:00:00'  WHERE `rebate_plan_name`='龙鸿源五金电商中心交流快充桩';

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '龙鸿源五金电商中心');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.14 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.89 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.56 - rate_value
                                              END
                                                                  AS `rate_value` ,
                                          '龙鸿源五金电商中心交流快充桩优惠活动峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, '2020-04-01 00:00:00', NULL, NULL, NULL, NULL, '龙鸿源五金电商中心交流快充桩优惠活动', '1', '0', '龙鸿源五金电商中心交流快充桩优惠活动', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 1;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 4 海关大厦	峰1.14元/度，平0.97元/度，谷0.57元/度（价格含服务费、电费)	不限	结束时间至疫情结束，另行通知
-- 原来的设置失效
UPDATE `bf_rebate_plan_t` SET `if_valid`='0'  WHERE `rebate_plan_name`='海关大厦';

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '海关大厦充电场站');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.14 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.97 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.57 - rate_value
                                              END
                                                            AS `rate_value` ,
                                          '海关大厦充电场站优惠方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '海关大厦优惠活动', '1', '0', '海关大厦优惠活动', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 5 甲岸智能立体车库	峰平1.25元/度，谷0.72元/度(价格含服务费、电费)	不限	结束时间至疫情结束，另行通知
-- 原来的设置失效
UPDATE `bf_rebate_plan_t` SET `if_valid`='0'  WHERE `rebate_plan_name`='甲岸智能立体车库';

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '甲岸智能立体车库');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.72 -rate_value
                                              END
                                                            AS `rate_value` ,
                                          '甲岸智能立体车库优惠活动峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, '甲岸智能立体车库优惠活动', '1', '0', '甲岸智能立体车库优惠活动', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);

INSERT INTO `bf_rebate_attr_t` (`rebate_plan_id`, `attr_id`, `attr_value`, `batch_no`) VALUES (@rebate_plan_id, '12', @station_id, '0');
INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 深圳调整优惠活动 --------------------------------------------------------------------

set @lcwz_time_line = '2020-04-15 23:59:59';
UPDATE `bf_rebate_plan_t` SET `begin_date` = @lcwz_time_line  WHERE `rebate_plan_name`='绿创万众茶城交流快充桩';
UPDATE `bf_rebate_plan_t` SET `end_date` = @lcwz_time_line  WHERE `rebate_plan_name`='绿创万众茶城交流快充桩优惠活动';

set @ly_time_line = '2020-04-30 23:59:59';

UPDATE `bf_rebate_plan_t` SET `begin_date` = @ly_time_line  WHERE `rebate_plan_name`='龙鸿源五金电商中心直流快充桩';
UPDATE `bf_rebate_plan_t` SET `begin_date` = @ly_time_line  WHERE `rebate_plan_name`='龙鸿源五金电商中心交流快充桩';

UPDATE `bf_rebate_plan_t` SET `end_date` = @time_line  WHERE `rebate_plan_name`='龙鸿源五金电商中心直流快充桩优惠活动';
UPDATE `bf_rebate_plan_t` SET `end_date` = @time_line  WHERE `rebate_plan_name`='龙鸿源五金电商中心交流快充桩优惠活动';


-- 绿创华南城	"交流桩：峰期1.09元/度、平0.85元/度、谷0.5元/度（价格含服务费、电费）
-- 直流桩：峰期1.25元/度、平期1.05元/度、谷期0.55元/度"	不限	2020年4月1日0：00-2020年4月30日23：59

set @lyhnc_time_line_one = '2020-04-01 00:00:00';
set @lyhnc_time_line_two = '2020-04-30 23:59:59';

UPDATE `bf_rebate_plan_t` SET `end_date` = @lyhnc_time_line_one , rebate_plan_name = '绿创华南城直流快充桩（3.31止）' WHERE `rebate_plan_name`='绿创华南城直流快充桩';
UPDATE `bf_rebate_plan_t` SET `end_date` = @lyhnc_time_line_one , rebate_plan_name = '绿创华南城直流快充桩（3.31止）' WHERE `rebate_plan_name`='绿创华南城交流快充桩';

-- 绿创华南城优惠活动

-- 直流桩：峰期1.25元/度、平期1.05元/度、谷期0.55元/度	配置服务费折扣方案，峰期1.25-基础电价、平期1.05 - 基础电价 、谷期0.55元-基础电价，设备限定为绿创华南城的直流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创华南城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 1.05 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.55 - rate_value
                                              END
                                                              AS `rate_value` ,
                                          '绿创华南城直流快充桩优惠活动峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', @lyhnc_time_line_one, @lyhnc_time_line_two, NULL, NULL, NULL, NULL, '绿创华南城直流快充桩优惠活动', '1', '0', '绿创华南城直流快充桩优惠活动', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 2;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 交流桩：峰期1.09元/度、平0.85元/度、谷0.5元/度（价格含服务费、电费）	配置服务费折扣方案，峰期1.09-基础电价、平期0.85-基础电价、谷期0.5元-基础电价，设备限定为绿创华南城交流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创华南城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.09 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.89 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.69 - rate_value
                                              END
                                                              AS `rate_value` ,
                                          '绿创华南城交流快充桩优惠活动峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', @lyhnc_time_line_one, @lyhnc_time_line_two, NULL, NULL, NULL, NULL, '绿创华南城交流快充桩优惠活动', '1', '0', '绿创华南城交流快充桩优惠活动', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 1;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 创建绿创华南城 优惠结束后的折扣方案
-- 14	绿创华南城	直流	峰期、平期1.25元/度、谷期0.9元/度	配置服务费折扣方案，峰期、平期1.25-基础电价、谷期0.9元-基础电价，设备限定为绿创华南城的直流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐
set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创华南城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1','2') THEN 1.25 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.9 - rate_value
                                              END
                                                              AS `rate_value` ,
                                          '绿创华南城直流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', @lyhnc_time_line_two, NULL, NULL, NULL, NULL, NULL, '绿创华南城直流快充桩', '1', '0', '绿创华南城直流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 2;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- 15	绿创华南城	交流	峰期1.09元/度，平期0.89元/度，谷期0.69元/度	配置服务费折扣方案，峰期1.09-基础电价、平期0.89-基础电价、谷期0.69元-基础电价，设备限定为绿创华南城交流快充桩桩编码	在该站点刷卡、app、微信小程序、场站扣费优先于套餐

set @city_code = '100309';
set @rebate_plan_id = (SELECT max(rebate_plan_id) from bf_rebate_plan_t);
set @station_id = (SELECT station_id from br_station_detail where station_name = '绿创华南城');

-- 费用场景
SET @rate_scene_id = (SELECT max(rate_scene_id)+1 from bf_rate_scene_config_t);

SELECT  DISTINCT rate_scene_id , time_scene_id into @base_rate_scene_id , @base_time_scene_id from bf_indb_base_config_t
where station_id = @station_id;

INSERT INTO bf_rate_scene_config_t SELECT `city_code`, `rate_scene_type_id`, @rate_scene_id, `scene_time_id`,
                                          CASE
                                              WHEN scene_time_id IN ('1') THEN 1.09 - rate_value
                                              WHEN scene_time_id IN ('2') THEN 0.89 - rate_value
                                              WHEN scene_time_id IN ('3') THEN 0.69 - rate_value
                                              END
                                                              AS `rate_value` ,
                                          '绿创华南城交流快充桩折扣方案峰平谷' AS `rate_scene_desc`
from bf_rate_scene_config_t where rate_scene_id = @base_rate_scene_id ;
-- 费用场景 end

INSERT INTO `bf_rebate_plan_t` (`rebate_plan_id`, `city_code`, `rebate_kind`, `rebate_obj`, `favour_type`, `fixed_value`, `rebate_percent`, `date_kind`, `begin_date`, `end_date`, `begin_time`, `end_time`, `eff_date`, `exp_date`, `rebate_plan_desc`, `if_valid`, `user_kind`, `rebate_plan_name`, `approval_status`, `reject_reason`, `scene_type`, `time_scene_id`, `rate_scene_id`) VALUES (@rebate_plan_id := @rebate_plan_id + 1, @city_code, '0', '2', '3', NULL, NULL, '0', @lyhnc_time_line_two, NULL, NULL, NULL, NULL, NULL, '绿创华南城交流快充桩', '1', '0', '绿创华南城交流快充桩', '0', NULL, '1', @base_time_scene_id, @rate_scene_id);


INSERT INTO `bf_rebate_attr_t` SELECT @rebate_plan_id as rebate_plan_id, '11' as attr_id , a.battery_id as attr_value , '0' as batch_no FROM br_batterycharge a where
        station_id = @station_id AND quick_slow = 1 AND batterycharge_type = 1;

INSERT INTO `bf_rebate_obj_t` (`rebate_plan_id`, `obj_type`, `obj_id`, `rebate_kind`, `batch_no`, `operator`) VALUES (@rebate_plan_id, '0', '0', '0', '0', '0');

-- ------------------------------------------------
UPDATE bf_rebate_plan_t set  if_compare = 0 where city_code = '100309';