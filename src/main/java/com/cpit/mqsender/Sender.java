package com.cpit.mqsender;

import com.cpit.dao.BillCacheMapper;
import com.cpit.icp.dto.collect.MonRechargeRecordDto;
import com.cpit.icp.dto.crm.GroupUser;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Sender {
    private final AmqpTemplate amqpTemplate;

    private final BillCacheMapper billCacheMapper;

//    List<String> allCard = null;

    @Autowired
    public Sender(AmqpTemplate amqpTemplate, BillCacheMapper billCacheMapper){
        this.amqpTemplate = amqpTemplate;
        this.billCacheMapper = billCacheMapper;
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
        List<GroupUser> allCardList = billCacheMapper.getAllGroupUser();
        MonRechargeRecordDto monRechargeRecord = new MonRechargeRecordDto();
        monRechargeRecord.setDeviceNo("0107141609070310");
        monRechargeRecord.setOperatorId("0200");
        monRechargeRecord.setRechargeType("1");
        monRechargeRecord.setCardId("6801131300008547");
        monRechargeRecord.setChargerCode("5273");
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
