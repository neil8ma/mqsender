package com.cpit.mqsender;

import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.TimeInterval;
import cn.hutool.core.util.RandomUtil;
import com.alibaba.fastjson.JSON;
import com.cpit.icp.dto.billing.baseconfig.BfAcctBalanceT;
import com.cpit.icp.dto.collect.MonRechargeRecordDto;
import com.cpit.icp.dto.collect.MonRechargeRecordProcessDto;
import com.cpit.icp.dto.collect.third.YLMonProcessRecord;
import com.cpit.icp.dto.collect.third.YLMonRechargeRecord;
import com.cpit.icp.dto.crm.GroupCust;
import com.cpit.icp.dto.crm.User;
import com.cpit.icp.dto.third.infypower.collect.msg.up.bill.ChargingProcess;
import com.cpit.icp.dto.third.infypower.collect.msg.up.bill.ChargingSettlement;
import com.cpit.mqsender.dao.BfAcctBalanceTMapper;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class Sender {
    private final AmqpTemplate amqpTemplate;
    @Autowired
    BfAcctBalanceTMapper bfAcctBalanceTMapper;
    @Autowired
    RedisTemplate redisTemplate;
    @Autowired
    public Sender(AmqpTemplate amqpTemplate){
        this.amqpTemplate = amqpTemplate;
    }
    
    public void zk(int rebateId){
        HashMap map = new HashMap();
        ArrayList<String> o = new ArrayList<>();
        int j = 1;
        while(j < 2){
            //构造空异常
//            o.add("101794");
//            o.add("101755");
            o.add(String.valueOf(rebateId));
            map.put("dis",o);
            amqpTemplate.convertAndSend("electricityUpd", map);
            j++;
        }
    }
    public void rp() {
            MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
            monRechargeRecord.setDeviceNo("0107010606022317");
            monRechargeRecord.setChargerCode("0107010606022317");
            monRechargeRecord.setCardId("6803131000000542");
            // 设置结束时间为当前时刻
            monRechargeRecord.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            // 根据chargeTime（14400秒）计算开始时间：结束时间减去秒数
            String chargeTimeStr = "14400"; // 假设这是你的充电时间字符串
            long seconds = Long.parseLong(chargeTimeStr);
            LocalDateTime endTime = LocalDateTime.now();
            LocalDateTime startTime = endTime.minusSeconds(seconds); // 核心操作：减去秒数[4,7](@ref)
            // 设置开始时间
            monRechargeRecord.setStartTime(startTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            // 设置充电时间
            monRechargeRecord.setChargeTime(chargeTimeStr);
            monRechargeRecord.setKwh("570.31");
            monRechargeRecord.setMsgCode("0x79");
            monRechargeRecord.setPlatTransFlowNum("mm7840614400195");
            monRechargeRecord.setOperatorId("0200");
            monRechargeRecord.setRechargeType("2");
            monRechargeRecord.setVin("0");
            monRechargeRecord.setPlateNumber("0      ");
            monRechargeRecord.setStartSoc("35");
            monRechargeRecord.setEndSoc("74");
            monRechargeRecord.setAh("5273");
            monRechargeRecord.setStrategy(null);
            monRechargeRecord.setStrategyParam(null);
            monRechargeRecord.setNormalEnd(null);
            monRechargeRecord.setTraceTime("2024-10-17 17:48:47");
            monRechargeRecord.setStartKwh("0");
            monRechargeRecord.setEndKwh("27.92");
            monRechargeRecord.setChargeBookNo(null);
            monRechargeRecord.setSerialNo("0");
            monRechargeRecord.setChargeSource(null);
            monRechargeRecord.setGunNum("01");
            monRechargeRecord.setIsComplementaryBuckle("0");
            amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
    }

    public void sendpp(){
        MonRechargeRecordProcessDto monRechargeRecord = new MonRechargeRecordProcessDto();

        monRechargeRecord.setCardId("7810117821307651");
        monRechargeRecord.setDeviceNo("0107131006101436");
        monRechargeRecord.setGunNum("02");
        monRechargeRecord.setAccumulatedKwh("569");
        monRechargeRecord.setAccumulatedAh("3072");
        monRechargeRecord.setStartSOC("22");
        monRechargeRecord.setCurrentSOC("28");
        monRechargeRecord.setAccumulatedMinutes("60");
        monRechargeRecord.setStartTime("2025-10-25 15:51:00");
        monRechargeRecord.setCurrentTime("2025-10-25 16:51:00");
        monRechargeRecord.setFlowNumber("mm7240614400195");
        amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
    }

    public void sendnotifyRule(){
        Map<String, Object> rabitMap = new HashMap<>();
//        rabitMap.put("rule",4129);
        //构造空异常
        rabitMap.put("rule","abc");
        amqpTemplate.convertAndSend("electricityUpd", rabitMap);
    }


    public void payFirstfx() {
        String flum = getPayFirstOrderNo();
    }

    public void payFirst() {
    }

    private String getPayFirstOrderNo() {
        StringBuffer orderNo = new StringBuffer(RandomUtil.randomString(15));
        orderNo = orderNo.replace(3,4,"8");
        String key = "PAY_FIRST:" + orderNo;
        redisTemplate.opsForValue().set(key,new BigDecimal("1000.00"));
        System.out.println(key);
        return orderNo.toString();
    }

    public void sendOfferMsg() {
        List<Integer> userIds = new ArrayList<>();
        //构造空异常
        userIds.add(100142943);
        userIds.add(100145434);
        userIds.add(100145570);
        amqpTemplate.convertAndSend("user_prod_offer_charge", userIds);
//        amqpTemplate.convertAndSend("user_prod_offer_charge", "1");
    }

    public void b6() {
        MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
        monRechargeRecord.setCardId("6809131900001780");
        monRechargeRecord.setDeviceNo("0107140810042102");
        monRechargeRecord.setChargerCode("0107140810042102");
        monRechargeRecord.setOperatorId("0200");
        monRechargeRecord.setRechargeType("1");
        monRechargeRecord.setVin("LZYTBTBW6H1059669");
        monRechargeRecord.setPlateNumber("0      ");
        monRechargeRecord.setStartSoc("47");
        monRechargeRecord.setEndSoc("49");
        monRechargeRecord.setAh("5273");
        monRechargeRecord.setChargeTime("5");
        monRechargeRecord.setStrategy("4");
        monRechargeRecord.setStrategyParam("0");
        monRechargeRecord.setNormalEnd("81");
        monRechargeRecord.setStartTime("2025-11-06 14:05:02");
        monRechargeRecord.setTraceTime("2025-09-3 15:33:00");
        monRechargeRecord.setEndTime( "2025-11-06 14:10:02");
        monRechargeRecord.setStartKwh("97694.18");
        monRechargeRecord.setEndKwh("97785.33");
        monRechargeRecord.setGunNum("02");
        monRechargeRecord.setPlatTransFlowNum("maming982342287");
        monRechargeRecord.setChargeBookNo("0");
        monRechargeRecord.setSerialNo("0000");
        monRechargeRecord.setChargeSource("5273");
//        monRechargeRecord.setIsComplementaryBuckle("1");
        String[] slotPower = new String[]{
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000",
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000",
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","15.000","0.000","0.000",
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000",
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000"
        };
        monRechargeRecord.setSlotPower(slotPower);
        monRechargeRecord.setMsgCode("0xB6");
        amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
    }

    public void sendjichudianjia(String batteryId) {
        Map<String, Object> rabitMap = new HashMap<>();
        ArrayList<String> ids = new ArrayList<String>();
        //构造空异常
        ids.add(batteryId);
//        ids.add("20001340");
//        ids.add("20001345");
        rabitMap.put("ele", ids);
        amqpTemplate.convertAndSend("electricityUpd", rabitMap);
    }

    public void notifyUser(){
        //构造空异常
        User user = new User();
//        user.setCardId("6803131000000542");
        amqpTemplate.convertAndSend("dealMsg", user);
    }

    public void notifyGroupCust(){
        GroupCust cust = new GroupCust();
        //构造空异常
//        cust.setGroupId("100308202011230098");
        amqpTemplate.convertAndSend("dealMsg", cust);
    }
}
