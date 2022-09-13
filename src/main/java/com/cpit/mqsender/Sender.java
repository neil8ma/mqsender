package com.cpit.mqsender;

import cn.hutool.core.util.RandomUtil;
import com.cpit.icp.dto.collect.MonRechargeRecordDto;
import com.cpit.icp.dto.crm.GroupUser;
import com.cpit.icp.dto.third.infypower.collect.msg.up.bill.ChargingSettlement;
import lombok.var;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

@Service
public class Sender {
    private final AmqpTemplate amqpTemplate;
    int step = 100;
    int ji = -1;
    int startPos = step*ji;
    int endPos = startPos+step;

    @Autowired
    public Sender(AmqpTemplate amqpTemplate){
        this.amqpTemplate = amqpTemplate;
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
     *  英飞源结算消息接入:[ChargingSettlement(chargeCode=0107311511031010, chargeType=1, gunNum=02, cardNo=6803131300027583,
     *  charge_start_date=2022-09-09 09:04:14, charge_end_date=2022-09-09 09:19:34, duration=920, start_soc=23, end_soc=55,
     *  finishReason=80, power=11.718, start_power=163946.592, end_power=163958.32, fee=12.05, ifFinishNoSwipeCard=1,
     *  cardRemPreCharge=0, cardRemAftCharge=0, serviceFee=3.31, ifOfflinePayment=0, strategy=0, strategyParam=0, vin=0,
     *  plate_no=0, startType=1, centerTransNo=604090904157326,
     *  slotPower=[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 11.718,
     *             0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
     *             0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
     *  chargeSource=1, msgCode=402, errorMsg=null, groupUser=null, isRebill=false, ifSuccess=false, isProcessMsg=false,
     *  billingMode=null, isLateDeductionFee=null, isComplementaryBuckle=null, normalEnd=null, inDate=null, ifDurationError=0,
     *  poleCityCode=null, ah=0, accumulatedKwh=null, ver=3.4a, thirdFlag=0)]
     */
    public void sendYFY() {
        for(int i = 0;i<10;i++){
            ChargingSettlement cs = new ChargingSettlement();
            String batteryCode = Data.allBatteryCharge.get(RandomUtil.randomInt(1, 19479));
            String cardId = Data.allCard.get(RandomUtil.randomInt(1, 492507));
            cs.setChargeCode(batteryCode);
            cs.setChargeType("1");
            cs.setGunNum("02");
            cs.setCardNo(cardId);
            cs.setCharge_start_date("2022-09-09 09:04:14");
            cs.setCharge_end_date("2022-09-09 09:19:34");
            cs.setDuration("920");
            cs.setStart_soc("23");
            cs.setEnd_soc("55");
            cs.setFinishReason("80");
            cs.setPower("11.718");
            cs.setStart_power("163946.592");
            cs.setEnd_power("163958.32");
            cs.setFee("12.05");
            cs.setIfFinishNoSwipeCard("1");
            cs.setCardRemAftCharge("0");
            cs.setCardRemPreCharge("0");
            cs.setServiceFee("3.31");
            cs.setIfOfflinePayment("0");
            cs.setStrategy("0");
            cs.setStrategyParam("0");
            cs.setVin("0");
            cs.setPlate_no("0");
            cs.setStartType("1");
            cs.setCenterTransNo("604090904157326");
            String[] slotPower = new String[48];
            for (int j = 0; j < 48;j++){
                slotPower[j] = "0.0";
            }
            slotPower[18] = "11.718";
            cs.setSlotPower(slotPower);
            cs.setChargeSource("1");
            amqpTemplate.convertAndSend("third_dealMsg", cs);
        }

    }
}
