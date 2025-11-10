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
    private final static Logger logger = LoggerFactory.getLogger(Sender.class);
    private final AmqpTemplate amqpTemplate;
    int step = 100;
    int ji = -1;
    int startPos = step*ji;
    int endPos = startPos+step;
    @Autowired
    BfAcctBalanceTMapper bfAcctBalanceTMapper;

    @Autowired
    RedisTemplate redisTemplate;

    @Autowired
    public Sender(AmqpTemplate amqpTemplate){
        this.amqpTemplate = amqpTemplate;
    }
    
    public void payfirst_p_yl(){
        //直接停机
        /**
         * [YLMonProcessRecord [deviceNo=0505331613120609, gunNum=02, cardNo=7810113869937909,
         * startChargingTime=2024-09-29 13:53:07.000, ammulateChargingTime=2, ammulatekwh=1.14,
         * currSoc=42, currAmmeter=33245.0, ammulateFee=0.24, ammuServiceFee=0.29, ammuTotalAmount=0.53]]
         */
        DateUtil.now();
        String endTime = DateUtil.now();
        String beginTime = DateUtil.offsetSecond(DateUtil.parse(endTime),5).toString();
        int cardIndex = Data.allCard.size();
        int batteryIndex = Data.allBatteryCharge.size();
        for (int cardI = 0; cardI < cardIndex; cardI++) {
            for (int batterJ = 0; batterJ < batteryIndex && batterJ < 1; batterJ++) {
                bfAcctBalanceTMapper.insertCenterTransNo(getPayFirstOrderNo(),Data.allBatteryCharge.get(batterJ),
                Data.allCard.get(cardIndex),"01");
                YLMonProcessRecord ok = new YLMonProcessRecord();
                ok.setDeviceNo(Data.allBatteryCharge.get(batterJ));
                ok.setGunNum("02");
                ok.setCardNo(Data.allCard.get(cardIndex));
                ok.setStartChargingTime("2024-09-29 13:53:07");
                ok.setAmmulateChargingTime("2");
                ok.setAmmulatekwh("1.14");
                ok.setCurrSoc("42");
                ok.setCurrAmmeter("33245");
                ok.setAmmulateFee("0.24");
                ok.setAmmuServiceFee("0.29");
                ok.setAmmuTotalAmount("0.53");
                amqpTemplate.convertAndSend("dealMsg", ok);
            }
        }
    }

    public void dk() {
        DateUtil.now();
        String endTime = DateUtil.now();
        String beginTime = DateUtil.offsetMinute(DateUtil.parse(endTime),-156).toString();
        int cardIndex = Data.allCard.size();
        int batteryIndex = Data.allBatteryCharge.size();
        for (int cardI = 0; cardI < cardIndex; cardI++) {
            for (int batterJ = 0; batterJ < batteryIndex && batterJ < 20; batterJ++) {
                MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
                monRechargeRecord.setCardId(Data.allCard.get(cardI));
                monRechargeRecord.setDeviceNo(Data.allBatteryCharge.get(batterJ));
                monRechargeRecord.setChargerCode(Data.allBatteryCharge.get(batterJ));
                monRechargeRecord.setOperatorId("0200");
                monRechargeRecord.setRechargeType("1");
                monRechargeRecord.setChargerCode(monRechargeRecord.getDeviceNo());
                monRechargeRecord.setVin("LZYTBTBW6H1059669");
                monRechargeRecord.setPlateNumber("0      ");
                monRechargeRecord.setStartSoc("47");
                monRechargeRecord.setEndSoc("99");
                monRechargeRecord.setAh("5273");
                monRechargeRecord.setKwh("91.15");
                monRechargeRecord.setChargeTime("9360");
                monRechargeRecord.setStrategy("4");
                monRechargeRecord.setStrategyParam("0");
                monRechargeRecord.setNormalEnd("81");
                monRechargeRecord.setStartTime(beginTime);
                monRechargeRecord.setTraceTime(endTime);
                monRechargeRecord.setEndTime(endTime);
                monRechargeRecord.setStartKwh("97694.18");
                monRechargeRecord.setEndKwh("97785.33");
                monRechargeRecord.setPlatTransFlowNum(RandomUtil.randomString(15));
                monRechargeRecord.setChargeBookNo("0");
                monRechargeRecord.setSerialNo("0000");
                monRechargeRecord.setChargeSource("5273");
                monRechargeRecord.setGunNum("02");
                monRechargeRecord.setIsComplementaryBuckle("1");
                monRechargeRecord.setMsgCode("0x79");
                amqpTemplate.convertAndSend("rechargeRecordMsg", monRechargeRecord);
            }
        }
    }


    public void sz() {
        DateUtil.now();
        String endTime = DateUtil.now();
        String beginTime = DateUtil.offsetMinute(DateUtil.parse(endTime),-156).toString();
        int cardIndex = Data.allCard.size();
        int batteryIndex = Data.allBatteryCharge.size();
        for (int cardI = 0; cardI < cardIndex; cardI++) {
            for (int batterJ = 0; batterJ < batteryIndex; batterJ++) {
                MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
                monRechargeRecord.setCardId(Data.allCard.get(cardI));
                monRechargeRecord.setDeviceNo(Data.allBatteryCharge.get(batterJ));
                monRechargeRecord.setChargerCode(Data.allBatteryCharge.get(batterJ));
                monRechargeRecord.setOperatorId("0200");
                monRechargeRecord.setRechargeType("1");
                monRechargeRecord.setChargerCode(monRechargeRecord.getDeviceNo());
                monRechargeRecord.setVin("LZYTBTBW6H1059669");
                monRechargeRecord.setPlateNumber("0      ");
                monRechargeRecord.setStartSoc("47");
                monRechargeRecord.setEndSoc("99");
                monRechargeRecord.setAh("5273");
                monRechargeRecord.setKwh("91.15");
                monRechargeRecord.setChargeTime("9360");
                monRechargeRecord.setStrategy("4");
                monRechargeRecord.setStrategyParam("0");
                monRechargeRecord.setNormalEnd("81");
                monRechargeRecord.setStartTime(beginTime);
                monRechargeRecord.setTraceTime(endTime);
                monRechargeRecord.setEndTime(endTime);
                monRechargeRecord.setStartKwh("97694.18");
                monRechargeRecord.setEndKwh("97785.33");
                monRechargeRecord.setPlatTransFlowNum(RandomUtil.randomString(15));
                monRechargeRecord.setChargeBookNo("0");
                monRechargeRecord.setSerialNo("0000");
                monRechargeRecord.setChargeSource("5273");
                monRechargeRecord.setGunNum("02");
                monRechargeRecord.setIsComplementaryBuckle("1");
                monRechargeRecord.setMsgCode("0x79");
                amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
            }
        }
    }

    /**
     * 2022-08-12 17:08:36,064 INFO [SimpleAsyncTaskExecutor-1] c.c.icp.billing.main.BillMsgReceiver [BillMsgReceiver.java : 110]
     * 结算消息接入:[MonRechargeRecordDto [deviceNo=0107141609070310, ver=null, operatorId=0200, rechargeType=1,
     * rechargeType34a=null, cardId=6801131300008547, chargerCode=0107141609070310, vin=LZYTBTBW6H1059669, plateNumber=0       ,
     * startSoc=47, endSoc=99, ah=0, kwh=91.15, chargeTime=4311, strategy=4, strategyParam=0,
     * normalEnd=81, startTime=2022-07-21 08:23:08, traceTime=2022-08-12 17:06:27,
     * endTime=2022-07-21 09:34:59, startKwh=97694.18, endKwh=97785.33,
     * platTransFlowNum=200210823069788, chargeBookNo=0                   ,
     * serialNo=0000, chargeSource=null, gunNum=02, msgCode=0x79, inDate=null, accumulatedKwh=null,
     * inQuTime=2022-08-12 17:08:33, subStationId=30000443,
     * preIp=10.21.2.110, prePort=59810, getInQuTime()=2022-08-12 17:08:33,
     *  ]]
     */
    public void sendp() {
            for(int i = 0;i< 73795;i++){
                MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
                monRechargeRecord.setCardId(Data.allCard.get(RandomUtil.randomInt(0,30677)));
                monRechargeRecord.setDeviceNo(Data.allBatteryCharge.get(RandomUtil.randomInt(0,6207)));
                monRechargeRecord.setOperatorId("0200");
                monRechargeRecord.setRechargeType("1");
                monRechargeRecord.setChargerCode(monRechargeRecord.getDeviceNo());
                monRechargeRecord.setVin("LZYTBTBW6H1059669");
                monRechargeRecord.setPlateNumber("0      ");
                monRechargeRecord.setStartSoc("47");
                monRechargeRecord.setEndSoc("99");
                monRechargeRecord.setAh("5273");
                monRechargeRecord.setKwh("91.15");
                monRechargeRecord.setChargeTime("67");
                monRechargeRecord.setStrategy("4");
                monRechargeRecord.setStrategyParam("0");
                monRechargeRecord.setNormalEnd("81");
                monRechargeRecord.setStartTime("2022-12-2 11:09:33");
                monRechargeRecord.setTraceTime("2022-12-2 11:10:40");
                monRechargeRecord.setEndTime("2022-12-2 11:10:40");
                monRechargeRecord.setStartKwh("97694.18");
                monRechargeRecord.setEndKwh("97785.33");
                monRechargeRecord.setPlatTransFlowNum(RandomUtil.randomString(15));
                monRechargeRecord.setChargeBookNo("0");
                monRechargeRecord.setSerialNo("0000");
                monRechargeRecord.setChargeSource("5273");
                monRechargeRecord.setGunNum("02");
                monRechargeRecord.setIsComplementaryBuckle("1");
                monRechargeRecord.setMsgCode("0x79");
                amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
            }
    }





    /**
     * MonRechargeRecordDto [deviceNo=01030A0006030807, ver=null, operatorId=null,
     * rechargeType=1, rechargeType34a=null, cardId=6806131300048843, chargerCode=01030A0006030807,
     * startSoc=65, endSoc=99, ah=0, kwh=30.00, chargeTime=10800, strategy=null,
     * strategyParam=null, normalEnd=null, startTime=2022-10-09 06:00:17, traceTime=null, endTime=2022-10-09 09:00:17,
     * startKwh=100.00, endKwh=130.00, platTransFlowNum=715101200083501, chargeBookNo=null, serialNo=0, chargeSource=6,gunNum=02, msgCode=0x79,isComplementaryBuckle=1,
     * isProcessMsg=false
     * @param batteryCode
     * @param cardNo
     */
    public void error(String batteryCode,String cardNo){
        Integer a = 1;
        Integer b = 1;
        if(a == b){
            System.out.println("a == b : " );
        }else{
            System.out.println("a != b : " );
        }

        MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
        monRechargeRecord.setDeviceNo("0303250010120828");
        monRechargeRecord.setCardId("7810113820122369");
        monRechargeRecord.setOperatorId("0000");
        monRechargeRecord.setRechargeType("1");
        monRechargeRecord.setChargerCode("0303250010120828");
        monRechargeRecord.setStartSoc("22");
        monRechargeRecord.setEndSoc("100");
        monRechargeRecord.setAh("0");
        monRechargeRecord.setKwh("18.21");
        String beginTime = DateUtil.now();
        monRechargeRecord.setStartTime("2022-10-13 21:12:01");
        DateTime endTime = DateUtil.offsetHour(DateUtil.parse(beginTime),5);
        monRechargeRecord.setEndTime("2022-10-13 21:18:50");
        monRechargeRecord.setChargeTime("409");
        monRechargeRecord.setStartKwh("24.0");
        monRechargeRecord.setEndKwh("42.21");
        monRechargeRecord.setPlatTransFlowNum("101132109296348");
        monRechargeRecord.setChargeBookNo(null);
        monRechargeRecord.setSerialNo("0");
        monRechargeRecord.setChargeSource("6");
        monRechargeRecord.setGunNum("02");
//        monRechargeRecord.setIsComplementaryBuckle("0");
        monRechargeRecord.setMsgCode("0x79");
        monRechargeRecord.setProcessMsg(false);
        amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
    }


    /**
     *
     * @param rebateId 102076 折扣价与原价相等
     * 102124验证配置桩折扣是否更新站展示表
     */
    public void zk(int rebateId){
        HashMap map = new HashMap();
        ArrayList<String> o = new ArrayList<>();
//        o.add("102123");
//        map.put("dis",o);
//        amqpTemplate.convertAndSend("electricityUpd", map);
//        int i = 1;
//        while(i < 10000){
//            o.add("40202102");
//            o.add("40205686");
//            o.add("40204663");
//            map.put("ele",o);
//            rp();
//            amqpTemplate.convertAndSend("electricityUpd", map);
//            i++;
//        }

        int j = 1;
        while(j < 2){
            o.add("101794");
            o.add("101755");
            o.add("101747");
            map.put("dis",o);
            rp();
            amqpTemplate.convertAndSend("electricityUpd", map);
            j++;
        }


        //验证配置桩折扣是否更新站展示表
//        HashMap map = new HashMap();
//        map.put("rebatePlanId",102124);
//        amqpTemplate.convertAndSend("displayPriceMsg", map);
        //验证折扣价与基础点击相等情况
//        HashMap mapx = new HashMap();
//        mapx.put("rebatePlanId",rebateId);
//        amqpTemplate.convertAndSend("displayPriceMsg", mapx);
//        try {
//            Thread.sleep(2000);
//        } catch (InterruptedException e) {
//            throw new RuntimeException(e);
//        }
//        HashMap mapxx = new HashMap();
//        mapxx.put("stationId",10022916);
//        mapxx.put("cityCode","100331");
//        mapx.put("stationIds",mapxx);
//        amqpTemplate.convertAndSend("displayPriceMsg", mapx);
    }

    /**
     * MonRechargeRecordDto [deviceNo=01030A0006030807, ver=3.4, operatorId=0000, rechargeType=1, rechargeType34a=null, cardId=6806131500048696, chargerCode=01030A0006030807, vin=0                , plateNumber=0       , startSoc=22, endSoc=100, ah=88, kwh=89.62, chargeTime=222, strategy=4, strategyParam=4, normalEnd=1, startTime=2023-07-01 21:50:08, traceTime=2023-07-01 21:50:31, endTime=2023-07-01 21:50:31, startKwh=31.0, endKwh=120.62, platTransFlowNum=200012150042808, chargeBookNo=0
     *
     *
     * 结算消息接入:[MonRechargeRecordDto [deviceNo=0107140606033126, ver=3.4, operatorId=0000, rechargeType=1, rechargeType34a=null, cardId=6811131900002235, chargerCode=0107140606033126, vin=                 , plateNumber=        , startSoc=14, endSoc=18, ah=0, kwh=2.69, chargeTime=611, strategy=4, strategyParam=0, normalEnd=81, startTime=2023-07-14 06:05:10, traceTime=2023-07-14 06:15:24, endTime=2023-07-14 06:15:21, startKwh=169331.83, endKwh=169334.52, platTransFlowNum=101140453552713, chargeBookNo=                    , serialNo=0000, chargeSource=null, gunNum=01, msgCode=0x79, inDate=null, accumulatedKwh=null, electricityPricingPlanId=null, servicePricingPlanId=null, electricityRebatePlanId=null
     */
    public void rp() {
        /**
         * todo 定位测试分时加字段需求
         * 过程消息接入: [
         * MonRechargeRecordProcessDto [deviceNo=0307311513103014, rechargeType=null,
         * gunNum=02, cardId=7810115800246065, accumulatedKwh=30.4406, accumulatedAh=1370,
         * startSOC=null, currentSOC=81, ammeterKwh=null, accumulatedMinutes=26,
         * startTime=2024-05-06 17:48:47, currentTime=2024-05-06 18:14:47, flowNumber=707240506239647]]
         */
        String x79 = "MonRechargeRecordDto [deviceNo=0107140810042112, ver=3.4, rechargeType=5, rechargeType34a=null, cardId=6806131300048824, chargerCode=0107141608121906, vin=LSKG57C12KA111394, plateNumber=0       , startSoc=16, endSoc=153, ah=200, kwh=25.81, chargeTime=600, normalEnd=1, startTime=2025-09-08 08:55:01, traceTime=2025-09-08 08:55:01, endTime=2025-09-08 09:05:01, startKwh=1131.6, endKwh=1152.91, platTransFlowNum=207750908948230, chargeSource=null, gunNum=01, msgCode=0x79, isLateDeductionFee=null, isComplementaryBuckle=null, groupUser=null, isRebill=false, inQuTime=], slotPower=[null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]]]";
            MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
            monRechargeRecord.setDeviceNo("0107141514033108");
            monRechargeRecord.setChargerCode("0107141514033108");
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
            monRechargeRecord.setIsComplementaryBuckle("1");
            TimeInterval timer = DateUtil.timer();
//            for(int i = 0;i< 10000;i++){
                amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
//            }
//            logger.info("【耗时计算】发消息耗时{}毫秒",timer.interval());
//            timer = DateUtil.timer();
//            for(int i = 0;i< 10000;i++){
//               logger.info("日志计算{}", monRechargeRecord);
//            }
//            logger.info("日志耗时{}毫秒",timer.interval());
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
        rabitMap.put("rule",4129);
//        rabitMap.put("rule",4105);
//        rabitMap.put("rule",4106);
//        rabitMap.put("rule",4107);
        amqpTemplate.convertAndSend("electricityUpd", rabitMap);
    }

    public void sendps() {
        for (int i = startPos;i<endPos&&i<Data.allCard.size();i++){
            for (int j = startPos;j<endPos&&j<Data.allBatteryCharge.size();j++){
                MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
                monRechargeRecord.setDeviceNo(Data.allBatteryCharge.get(j));
                monRechargeRecord.setOperatorId("0200");
                monRechargeRecord.setRechargeType("1");
                monRechargeRecord.setCardId(Data.allCard.get(i));
                monRechargeRecord.setChargerCode(Data.allBatteryCharge.get(j));
                monRechargeRecord.setVin("LZYTBTBW6H1059669");
                monRechargeRecord.setPlateNumber("0      ");
                monRechargeRecord.setStartSoc("47");
                monRechargeRecord.setEndSoc("99");
                monRechargeRecord.setAh("5273");
                monRechargeRecord.setKwh("91.15");
                monRechargeRecord.setChargeTime("4311");
                monRechargeRecord.setStrategy("4");
                monRechargeRecord.setStrategyParam("0");
                monRechargeRecord.setNormalEnd("81");
                monRechargeRecord.setStartTime("2022-07-21 08:23:08");
                monRechargeRecord.setTraceTime("2022-08-12 17:06:27");
                monRechargeRecord.setEndTime("2022-07-21 09:34:59");
                monRechargeRecord.setStartKwh("97694.18");
                monRechargeRecord.setEndKwh("97785.33");
                monRechargeRecord.setPlatTransFlowNum("200210823069788");
                monRechargeRecord.setChargeBookNo("0");
                monRechargeRecord.setSerialNo("0000");
                monRechargeRecord.setChargeSource("5273");
                monRechargeRecord.setGunNum("02");
                monRechargeRecord.setMsgCode("0x79");
                amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
            }
        }
    }

    public void init(){
        try {
            testReadFile("cardid.txt",Data.allCard);
            testReadFile("batterycharge.txt",Data.allBatteryCharge);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    public void testReadFile(String url , List<String> list) throws IOException {

        Resource resource = new ClassPathResource(url);
        InputStream is = resource.getInputStream();
        InputStreamReader isr = new InputStreamReader(is);
        BufferedReader br = new BufferedReader(isr);
        String data = null;
        while((data = br.readLine()) != null) {
            list.add(data);
        }
        br.close();
        isr.close();
        is.close();
        System.out.println(list.size());
    }

    public void setji(int i) {
        this.ji = i;
        this.startPos = step*ji;
        this.endPos = startPos+step;
    }

    /**
     * 英飞源消息发送
     ChargingSettlement(chargeCode=0107311511031006, chargeType=1, gunNum=02, cardNo=7810119902905250,
     charge_start_date=2022-11-07 17:46:59, charge_end_date=2022-11-07 17:49:02, duration=123, start_soc=28,
     end_soc=30, finishReason=80, power=0.921, start_power=168351.968, end_power=168352.896, fee=1.24,
     ifFinishNoSwipeCard=1, cardRemPreCharge=0, cardRemAftCharge=0, serviceFee=0.23,
     ifOfflinePayment=00, strategy=0, strategyParam=0, vin=FFFFFFFFFFFFFFFFF,
     plate_no=0, startType=1, centerTransNo=715071747005180,
     slotPower=[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.921, 0.0, 0.0, 0.0, 0.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
     ], chargeSource=1, msgCode=202, errorMsg=null, groupUser=null, isRebill=false,
     ifSuccess=false, isProcessMsg=false, billingMode=null, isLateDeductionFee=null,
     isComplementaryBuckle=null, normalEnd=null, inDate=null, ifDurationError=0,
     poleCityCode=null, ah=0, accumulatedKwh=null, ver=3.4a, thirdFlag=0)

     英飞源结算消息接入:ChargingSettlement(chargeCode=0107311511031002, chargeType=1,
     gunNum=02, cardNo=7810113715192204, charge_start_date=2022-11-14 23:55:15,
     charge_end_date=2022-11-15 00:14:20, duration=1144,
     start_soc=57, end_soc=91, finishReason=2, power=17.328,
     start_power=175908.688, end_power=175926.016, fee=13.07,
     ifFinishNoSwipeCard=1, cardRemPreCharge=0, cardRemAftCharge=0,
     serviceFee=6.88, ifOfflinePayment=00, strategy=0, strategyParam=0,
     vin=, plate_no=0, startType=1, centerTransNo=703142355159873,
     slotPower=[13.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
     0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
     0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
     0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.078]
     */
    public void sendYFY() {
//        for(int i = 0;i<10;i++){
            ChargingSettlement cs = new ChargingSettlement();
//            String batteryCode = Data.allBatteryCharge.get(RandomUtil.randomInt(1, 19479));
//            String cardId = Data.allCard.get(RandomUtil.randomInt(1, 492507));
            String batteryCode = "0107311511031002";
            String cardId = "7810113715192204";
            cs.setChargeCode(batteryCode);
            cs.setChargeType("1");
            cs.setGunNum("02");
            cs.setCardNo(cardId);
            cs.setCharge_start_date("2022-11-14 23:55:15");
            cs.setCharge_end_date("2022-11-15 00:14:20");
            cs.setDuration("1144");
            cs.setStart_soc("28");
            cs.setEnd_soc("30");
            cs.setFinishReason("80");
            cs.setPower("17.328");
            cs.setStart_power("175908.688");
            cs.setEnd_power("175926.016");
            cs.setFee("13.07");
            cs.setIfFinishNoSwipeCard("1");
            cs.setCardRemAftCharge("0");
            cs.setCardRemPreCharge("0");
            cs.setServiceFee("0.23");
            cs.setIfOfflinePayment("0");
            cs.setStrategy("0");
            cs.setStrategyParam("0");
            cs.setVin("0");
            cs.setPlate_no("0");
            cs.setStartType("1");
            cs.setCenterTransNo("703142355159873");
            String[] slotPower = new String[48];
            for (int j = 0; j < 48;j++){
                slotPower[j] = "0.0";
            }
            slotPower[0] = "13.25";
            slotPower[47] = "4.078";
            cs.setSlotPower(slotPower);
            cs.setChargeSource("1");
            amqpTemplate.convertAndSend("dealMsg", cs);
//        }

    }

    /**
     * ChargingProcess(chargeCode=0307311512012120, gunSum=2, gunNum=01, rechargeType=1,
     * workStatus=02, currentSOC=88, fee=49.66, remainChargeTime=10, duration=2219,
     * power=36.789, startPower=57625.872, currentPower=57662.66, startType=1, strategy=0,
     * strategyParam=0, bookingId=0, cardNo=7810115989166209, bookingTimeout=0,
     * startTime=2022-11-02 17:38:26, cardRemPreCharge=65.07)
     *
     * ChargingProcess(chargeCode=0107311511031011, gunSum=2, gunNum=02,
     * rechargeType=1, workStatus=02,
     * currentSOC=89, fee=0, remainChargeTime=600, duration=34,
     * power=0.0, startPower=162538.192, currentPower=162538.192,
     * startType=1, strategy=0, strategyParam=0, bookingId=0,
     * cardNo=7810113530922762, bookingTimeout=0,
     * startTime=2022-11-14 18:20:58, cardRemPreCharge=10.1)
     */
    public void sendYFYP() {
        ChargingProcess cps = new ChargingProcess();
        cps.setCardNo("7810113530922762");
        cps.setChargeCode("0107311511031011");
        cps.setGunNum("02");
        cps.setGunSum("2");
        cps.setRechargeType("1");
        cps.setCurrentSOC("88");
        cps.setCurrentPower("162538.192");
        cps.setStartPower("162538.192");
        cps.setStartTime("2022-11-14 18:20:58");
        cps.setDuration("34");
        cps.setPower("0.0");
        cps.setFee("0");
        amqpTemplate.convertAndSend("third_procMsg_up", cps);
    }

    public void sendYL(){
            YLMonRechargeRecord cs = new YLMonRechargeRecord();
            String batteryCode = "0307331212040101";
            cs.setDeviceNo(batteryCode);
            cs.setGunNum("02");
            cs.setArrivalTime("2022-11-07 23:01:01");
            cs.setStartTime("2022-11-07 23:01:01");
            cs.setChargeTime("300");
            String[] slotPower = new String[48];
            for (int j = 0; j < 48;j++){
                slotPower[j] = "0.0";
            }
            slotPower[46] = "3.16";
            cs.setTimePeriodKwh(slotPower);
            cs.setStartSoc("42");
            cs.setEndSoc("49");
            cs.setChargeAmount("2.28");
            cs.setServiceAmount("2.28");
            cs.setAccumulateKwh("3.16");
            cs.setTransFlowNum("101072300273407");
            cs.setChargeEndTime("2022-11-07 23:06:01");
            amqpTemplate.convertAndSend("rechargeRecordMsg", cs);
    }


    public void xn(int m) {
        int i = 0;
        while (i < m){
//        while (i < 1){
            MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
            monRechargeRecord.setDeviceNo("0507311513102521");
            monRechargeRecord.setOperatorId("0200");
            monRechargeRecord.setRechargeType("1");
            monRechargeRecord.setCardId("7810113632838629");
            monRechargeRecord.setChargerCode("0507311513102521");
            monRechargeRecord.setVin("LZYTBTBW6H1059669");
            monRechargeRecord.setPlateNumber("0      ");
            monRechargeRecord.setStartSoc("47");
            monRechargeRecord.setEndSoc("99");
            monRechargeRecord.setAh("5273");
            monRechargeRecord.setKwh("91.15");
            int beginT = RandomUtil.randomInt(1,24*60*60*2);
            int duration = RandomUtil.randomInt(30*60,4*60*60);
            int endT = beginT + duration;
            Date startTime = DateUtil.offset(DateUtil.beginOfDay(DateUtil.yesterday()), DateField.SECOND,beginT);
            Date endTime = DateUtil.offset(DateUtil.beginOfDay(DateUtil.yesterday()), DateField.SECOND,endT);
            monRechargeRecord.setStartTime(DateUtil.formatDateTime(startTime));
            monRechargeRecord.setEndTime(DateUtil.formatDateTime(endTime));
            monRechargeRecord.setChargeTime(String.valueOf(duration));
            monRechargeRecord.setStrategy("4");
            monRechargeRecord.setStrategyParam("0");
            monRechargeRecord.setNormalEnd("81");
            monRechargeRecord.setTraceTime("2022-08-12 17:06:27");
            monRechargeRecord.setStartKwh("97694.18");
            monRechargeRecord.setEndKwh("97785.33");
            monRechargeRecord.setPlatTransFlowNum(RandomUtil.randomString(15));
            monRechargeRecord.setChargeBookNo("0");
            monRechargeRecord.setSerialNo("0000");
            monRechargeRecord.setChargeSource("5273");
            monRechargeRecord.setGunNum("02");
            monRechargeRecord.setMsgCode("0x79");
            amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
            i++;
        }
        //deviceNo=0507311513102521, rechargeType=null, gunNum=02, cardId=7810113632838629

    }

    public static void main(String[] args) {
//        Set a = new HashSet();
//        Random random = new Random();
//        for (int i = 0; i < 10000; i++) {
//            a.add(random.nextInt(1000000));
//        }
//        System.out.println(a.size());

        StringBuffer orderNo = new StringBuffer(RandomUtil.randomString(15));
        orderNo.replace(3,4,"8");
        System.out.println(orderNo);
    }

    @Transactional
    public void balanceUpdate(int i) {
        BfAcctBalanceT ok  = new BfAcctBalanceT();
        ok.setAmount(new BigDecimal(i));
        ok.setAcctId(10758);
        ok.setServId(10758);
        ok.setBalanceTypeId(1);
        bfAcctBalanceTMapper.updateAcctBalance(ok);

    }

    public void payFirstfx() {
        String flum = getPayFirstOrderNo();
        /**
         * 接收到互联互通充电结算信息,中心流水号:【108840925197854】对象【OrderHlht [StartChargeSeq=108840925197854, ConnectorID=0755PTS033059,
         * EquipId=0755PTS033059, OpreatorId=359950395, AccountNo=7810116788123352,
         * AccountType=0, StartTime=2024-09-25 16:06:53, EndTime=2024-09-25 16:07:30,
         * TotalPower=1.2, TotalElecMoney=1.02, TotalSeviceMoney=1.01, TotalMoney=1.03,
         * StopReason=0, SumPeriod=1,
         * ChargeDetails=[ChargingPriceSlotDetails{centerTransNo='108840925197854',
         * detailStartTime=Wed Sep 25 16:06:53 CST 2024, detailEndTime=Wed Sep 25 16:07:30 CST 2024,
         * elecPrice=1.0, sevicePrice=1.0, detailPower=1.2, detailElecMoney=1.02, detailSeviceMoney=1.01, sceneTimeId=1}]]】
         */
    }

    public void payFirst() {
        DateUtil.now();
        String endTime = DateUtil.now();
        String beginTime = DateUtil.offsetSecond(DateUtil.parse(endTime),5).toString();
        int cardIndex = Data.allCard.size();
        int batteryIndex = Data.allBatteryCharge.size();
        for (int cardI = 0; cardI < cardIndex; cardI++) {
            for (int batterJ = 0; batterJ < batteryIndex && batterJ < 1; batterJ++) {
                MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
                monRechargeRecord.setCardId(Data.allCard.get(cardI));
                monRechargeRecord.setDeviceNo(Data.allBatteryCharge.get(batterJ));
                monRechargeRecord.setChargerCode(Data.allBatteryCharge.get(batterJ));
                monRechargeRecord.setOperatorId("0200");
                monRechargeRecord.setRechargeType("1");
                monRechargeRecord.setChargerCode(monRechargeRecord.getDeviceNo());
                monRechargeRecord.setVin("LZYTBTBW6H1059669");
                monRechargeRecord.setPlateNumber("0      ");
                monRechargeRecord.setStartSoc("47");
                monRechargeRecord.setEndSoc("99");
                monRechargeRecord.setAh("5273");
                monRechargeRecord.setKwh("91.15");
                monRechargeRecord.setChargeTime("5");
                monRechargeRecord.setStrategy("4");
                monRechargeRecord.setStrategyParam("0");
                monRechargeRecord.setNormalEnd("81");
                monRechargeRecord.setStartTime(beginTime);
                monRechargeRecord.setTraceTime(endTime);
                monRechargeRecord.setEndTime( endTime);
                monRechargeRecord.setStartKwh("97694.18");
                monRechargeRecord.setEndKwh("97785.33");
                monRechargeRecord.setGunNum("02");
                monRechargeRecord.setPlatTransFlowNum(getPayFirstOrderNo());
//                monRechargeRecord.setPlatTransFlowNum(RandomUtil.randomString(15));
                monRechargeRecord.setChargeBookNo("0");
                monRechargeRecord.setSerialNo("0000");
                monRechargeRecord.setChargeSource("5273");
                monRechargeRecord.setIsComplementaryBuckle("1");
                monRechargeRecord.setMsgCode("0x79");
                amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
            }
        }
    }

    private String getPayFirstOrderNo() {
        StringBuffer orderNo = new StringBuffer(RandomUtil.randomString(15));
        orderNo = orderNo.replace(3,4,"8");
        String key = "PAY_FIRST:" + orderNo;
        redisTemplate.opsForValue().set(key,new BigDecimal("1000.00"));
        System.out.println(key);
        return orderNo.toString();
    }

    public void sendprocess(MonRechargeRecordProcessDto monRechargeRecordProcessDtos) {
            amqpTemplate.convertAndSend("dealMsg", monRechargeRecordProcessDtos);
    }
    public void send79process(List<MonRechargeRecordDto> monRechargeRecordProcessDtos) {
            amqpTemplate.convertAndSend("dealMsg", monRechargeRecordProcessDtos.get(0));
    }

    public void sendOfferMsg() {
        List<Integer> userIds = new ArrayList<>();
        userIds.add(100142943);
        userIds.add(100145434);
        userIds.add(100145570);
        amqpTemplate.convertAndSend("user_prod_offer_charge", userIds);
    }

//    public void kafkaSend() {
//        kafkaTemplate.send("my-topic", 0);
//    }
//
//    public void sendprocesskafka(MonRechargeRecordProcessDto monRechargeRecordProcessDto) {
//        kafkaTemplate.send("dealProcessMsg", monRechargeRecordProcessDto);
//    }

//    public void send79kafka(List<MonRechargeRecordDto> monRechargeRecordProcessDtos) {
//        MonRechargeRecordDto msg = monRechargeRecordProcessDtos.get(0);
//        // 构建带Header的消息
//        String jsonstring = JSON.toJSONString(msg);
//        // 添加自定义Header
//        kafkaTemplate.send("DEAL_MSG", msg.getPlatTransFlowNum(), jsonstring);
//    }

//    public void sendProcesskafka(List<MonRechargeRecordProcessDto> settleDtos) {
//        for(int i = 0;i<settleDtos.size();i++){
//            MonRechargeRecordProcessDto msg = settleDtos.get(i);
//            String jsonstring = JSON.toJSONString(msg);
//            // 构建带Header的消息
//            kafkaTemplate.send("DEAL_PROCESS_MSG", msg.getFlowNumber(), jsonstring);
//        }
//    }

    public void b6() {
        /**
         * 结算消息接入:[MonRechargeRecordDto [deviceNo=0107140810042102, ver=3.4a, rechargeType=1, rechargeType34a=05, cardId=6809131900001780, chargerCode=0107140810042102, vin=LSKG57C12KA111394, plateNumber=0       , startSoc=22, endSoc=80, ah=0, kwh=15.000, chargeTime=300, normalEnd=1, startTime=2025-11-06 14:05:01, traceTime=2025-11-06 14:05:01, endTime=2025-11-06 14:10:01, startKwh=1131.6090, endKwh=1152.9190, platTransFlowNum=207751106530918, chargeSource=null, gunNum=01, msgCode=0xB6, isLateDeductionFee=null, isComplementaryBuckle=null, groupUser=null, isRebill=false, inQuTime=], slotPower=[0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 15.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000]]
         */
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
        //                monRechargeRecord.setPlatTransFlowNum(RandomUtil.randomString(15));
        monRechargeRecord.setChargeBookNo("0");
        monRechargeRecord.setSerialNo("0000");
        monRechargeRecord.setChargeSource("5273");
//        monRechargeRecord.setIsComplementaryBuckle("1");
        String[] slotPower = new String[]{
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000",
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000",
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","15.000","0.000",
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000",
            "0.000","0.000","0.000","0.000","0.000","0.000","0.000","0.000"
        };
//        [1.000, 2.000, 0.100, 0.020, 0.003, 0.000, 0.000, 0.000, 0.000, 0.000,
//            0.000, 0.000, 1.000, 2.220, 3.500, 0.000, 0.112, 10.113, 6.000, 5.005,
//            10.999, 1.100, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000,
//            0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000,
//            0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 12.123]
        monRechargeRecord.setSlotPower(slotPower);
        monRechargeRecord.setMsgCode("0xB6");
        amqpTemplate.convertAndSend("dealMsg", monRechargeRecord);
    }

    public void sendjichudianjia() {
        Map<String, Object> rabitMap = new HashMap<>();
        ArrayList<String> ids = new ArrayList<String>();
        ids.add("20001332");
        ids.add("20001340");
        ids.add("20001345");
        rabitMap.put("ele", ids);
        amqpTemplate.convertAndSend("electricityUpd", rabitMap);
    }

    public void notifyUser(){
        User user = new User();
        user.setCardId("6803131000000542");
        amqpTemplate.convertAndSend("dealMsg", user);
    }

    public void notifyGroupCust(){
        GroupCust cust = new GroupCust();
        cust.setGroupId("100308202011230098");
        amqpTemplate.convertAndSend("dealMsg", cust);
    }
}
