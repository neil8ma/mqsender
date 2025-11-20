package com.cpit.mqsender;

import cn.hutool.Hutool;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.TimeInterval;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.json.JSONUtil;
import cn.hutool.log.Log;
import cn.hutool.log.LogFactory;
import com.cpit.common.Dispatcher;
import com.cpit.common.JsonUtil;
import com.cpit.icp.dto.billing.balance.BalanceChangeMsg;
import com.cpit.icp.dto.billing.connectivity.BfBusinessStrategyT;
import com.cpit.icp.dto.common.ResultInfo;
import com.cpit.icp.dto.resource.BrBatterycharge;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@ShellComponent
public class BaseCommands {

    private static final Log logger = LogFactory.get();

    String cardId = "6806131300048918";

    String batteryCode = "0107131007010315";
    @Autowired
    Sender sender;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private AmqpTemplate amqpTemplate;

    @ShellMethod("套餐变更")
    public void taochan(){
        sender.sendOfferMsg();
    }

    @ShellMethod("基础电价变更")
    public void jichudianjia(String batteryId){
        sender.sendjichudianjia(batteryId);
    }

    @ShellMethod("用户变更变更")
    public void yonghu(){
        sender.notifyUser();
    }

    @ShellMethod("客户变更")
    public void kehu(){
        sender.notifyGroupCust();
    }

    @ShellMethod("普天桩发B6消息")
    public void b6() {
        sender.b6();
    }

    @ShellMethod("折扣")
    public void zk(int rebateId) {
        sender.zk(rebateId);
    }

    @ShellMethod("普天桩35度")
    public void guizhe() {
        sender.sendnotifyRule();
    }

    @ShellMethod("余额变动发消息")
    public void yuer(int i) {
//        BalanceChangeMsg balanceChangeMsg =
//            BalanceChangeMsg.builder().userId(91000006).userType(1).groupBID(null).build();
        //构造异常
        BalanceChangeMsg balanceChangeMsg = new BalanceChangeMsg();
        amqpTemplate.convertAndSend("icp-balance-change-queue", balanceChangeMsg);

    }

    @ShellMethod("先付后用单卡多发消息")
    public void payfirst() {
        sender.payFirst();
    }

    @ShellMethod("过程消息")
    public void pp() {
        sender.sendpp();
    }

    @ShellMethod("普天桩发消息")
    public void jiesuan() {
        sender.rp();
    }

    @ShellMethod("调用计费策略")
    public void redo() {
        try{
            String url = "http://localhost:26750//bil/batchGetConnectivityBusinessStrategyInformation";
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

    @ShellMethod("调用单个计费策略")
    public void dangechelue() {
        try{
            String url = "http://localhost:26150//bil/getConnectivityBusinessStrategyInformation";
                batteryCode = "0107141309082801";
                cardId = "6803131300027583";
                BfBusinessStrategyT bfBusinessStrategyT = new BfBusinessStrategyT();
                bfBusinessStrategyT.setBatteryCode(batteryCode);
                bfBusinessStrategyT.setCardId(cardId);
                bfBusinessStrategyT.setType(1);
                bfBusinessStrategyT.setChargeStartTime(DateUtil.parse("2022-11-03 14:51:29"));
                bfBusinessStrategyT.setChargeEndTime(DateUtil.parse("2022-11-03 14:51:29"));
            String param = JSONUtil.toJsonStr(bfBusinessStrategyT);
            ResultInfo result = (ResultInfo) new Dispatcher(restTemplate).doPost(url, ResultInfo.class, param);
            logger.info("查询结果："+result);
        }catch(Exception ex){
            logger.error("error in queryChargingInfo",ex);
        }
    }
}
