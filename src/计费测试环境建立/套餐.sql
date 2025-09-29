-- 套餐使用的各种费率

-- 1 阶梯费率组

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