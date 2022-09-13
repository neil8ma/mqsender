package com.cpit.mqsender;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.log.Log;
import cn.hutool.log.LogFactory;
import com.cpit.common.Dispatcher;
import com.cpit.common.JsonUtil;
import com.cpit.icp.dto.billing.connectivity.BfBusinessStrategyT;
import com.cpit.icp.dto.common.ResultInfo;
import com.cpit.icp.dto.resource.BrBatterycharge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Date;

@ShellComponent
public class BaseCommands {

    private static final Log logger = LogFactory.get();

    String cardId;

    String batteryCode;
    @Autowired
    Sender sender;

    @Autowired
    private RestTemplate restTemplate;

    @ShellMethod("普天桩发消息")
    public void p() {
        sender.sendp();
    }
    @ShellMethod("普天桩发消息")
    public void ps() {
        sender.sendps();
    }
    @ShellMethod("英飞源桩发消息")
    public void y() {
        sender.sendYFY();
    }
    @ShellMethod("亿联桩发消息")
    public void l() {

    }
    @ShellMethod("亿联桩发消息")
    public void init() {
        sender.init();
    }

    @ShellMethod("亿联桩发消息")
    public void ji(int i) {
        sender.setji(i);
    }

    @ShellMethod("调用计费策略")
    public void redo() {
        try{
            String url = "http://localhost:26150//bil/batchGetConnectivityBusinessStrategyInformation";
            BfBusinessStrategyT bfBusinessStrategyT = new BfBusinessStrategyT();
            bfBusinessStrategyT.setBatteryCode(batteryCode);
            bfBusinessStrategyT.setCardId(cardId);
            bfBusinessStrategyT.setType(1);
            bfBusinessStrategyT.setChargeStartTime(new Date());
            bfBusinessStrategyT.setChargeEndTime(new Date());
            ArrayList<BfBusinessStrategyT> bfBusinessStrategyTS = new ArrayList<BfBusinessStrategyT>();
            bfBusinessStrategyTS.add(bfBusinessStrategyT);
            String param = JsonUtil.beanToJson(bfBusinessStrategyTS);
            ResultInfo result = (ResultInfo) new Dispatcher(restTemplate).doPost(url, ResultInfo.class, param);
            logger.info("查询结果："+result);
        }catch(Exception ex){
            logger.error("error in queryChargingInfo",ex);
        }
    }

    @ShellMethod("调用计费策略")
    public void chelue() {
        try{
            String url = "http://localhost:26150//bil/batchGetConnectivityBusinessStrategyInformation";
            ArrayList<BfBusinessStrategyT> bfBusinessStrategyTS = new ArrayList<BfBusinessStrategyT>();

            for(int i = 0;i<10;i++){
                batteryCode = Data.allBatteryCharge.get(RandomUtil.randomInt(1, 19479));
                cardId = Data.allCard.get(RandomUtil.randomInt(1, 492507));
                BfBusinessStrategyT bfBusinessStrategyT = new BfBusinessStrategyT();
                bfBusinessStrategyT.setBatteryCode(batteryCode);
                bfBusinessStrategyT.setCardId(cardId);
                bfBusinessStrategyT.setType(1);
                bfBusinessStrategyT.setChargeStartTime(new Date());
                bfBusinessStrategyT.setChargeEndTime(new Date());
                bfBusinessStrategyTS.add(bfBusinessStrategyT);
            }
            String param = JsonUtil.beanToJson(bfBusinessStrategyTS);
            ResultInfo result = (ResultInfo) new Dispatcher(restTemplate).doPost(url, ResultInfo.class, param);
            logger.info("查询结果："+result);
        }catch(Exception ex){
            logger.error("error in queryChargingInfo",ex);
        }
    }

}
