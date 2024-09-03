package com.cpit.mqsender;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.log.Log;
import cn.hutool.log.LogFactory;
import com.cpit.icp.dto.billing.hlht.ChargingPriceSlotDetails;
import com.cpit.icp.dto.billing.hlht.OrderHlht;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;
import org.springframework.web.client.RestTemplate;

import java.math.BigDecimal;
import java.util.ArrayList;

@ShellComponent
public class hlhtMsgSender {
    private static final Log logger = LogFactory.get();

    String cardId = "6806131300048918";

    String batteryCode = "0107131007010315";
    @Autowired
    Sender sender;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private AmqpTemplate amqpTemplate;

    /**
     * 中心流水号:【708240716332023】对象【OrderHlht [StartChargeSeq=708240716332023, ConnectorID=565002014110P5F0000101, EquipId=565002014110P5F00001, OpreatorId=MA00305A7, AccountNo=7810118612767523, AccountType=0, StartTime=2024-07-16 07:06:57, EndTime=2024-07-16 07:08:33, TotalPower=0.0, TotalElecMoney=0.0, TotalSeviceMoney=0.0, TotalMoney=0.0, StopReason=1, SumPeriod=1, ChargeDetails=[ChargingPriceSlotDetails{centerTransNo='708240716332023', detailStartTime=Tue Jul 16 07:06:57 CST 2024, detailEndTime=Tue Jul 16 07:08:33 CST 2024, elecPrice=0.66, sevicePrice=0.36, detailPower=0.0, detailElecMoney=0.02, detailSeviceMoney=0.01, sceneTimeId=1}]]】
     */
    @ShellMethod("hlht发消息")
    public void hlht() {
        OrderHlht hlht = new OrderHlht();
        hlht.setStartChargeSeq("708240716332023");
        hlht.setConnectorID("565002014110P5F0000101");
        hlht.setEquipId("565002014110P5F00001");
        hlht.setOpreatorId("MA00305A7");
        hlht.setAccountNo("7810113273935252");
        hlht.setAccountType(0);
        hlht.setStartTime("2024-07-16 07:06:57");
        hlht.setEndTime("2024-07-16 07:08:33");
        hlht.setTotalPower(new BigDecimal("0.0"));
        hlht.setTotalElecMoney(new BigDecimal("0.0"));
        hlht.setTotalSeviceMoney(new BigDecimal("0.0"));
        hlht.setTotalMoney(new BigDecimal("0.0"));
        hlht.setStopReason(1);
        hlht.setSumPeriod(1);
        ChargingPriceSlotDetails cs = new ChargingPriceSlotDetails();
        cs.setCenterTransNo("708240716332023");
        cs.setDetailStartTime(DateUtil.parseDate("2024-07-16 07:06:57"));
        cs.setDetailEndTime(DateUtil.parseDate("2024-07-16 07:08:33"));
        cs.setElecPrice(new BigDecimal("0.66"));
        cs.setSevicePrice(new BigDecimal("0.36"));
        cs.setDetailPower(new BigDecimal("0.0"));
        cs.setDetailElecMoney(new BigDecimal("0.02"));
        cs.setDetailSeviceMoney(new BigDecimal("0.01"));
        cs.setSceneTimeId(1);
        ArrayList<ChargingPriceSlotDetails> li = new ArrayList<>();
        li.add(cs);
        hlht.setChargeDetails(li);
        amqpTemplate.convertAndSend("icp-bill-hlhtcharge", hlht);
    }
}
