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
    private RedisTemplate redisTemplate;

    @Autowired
    private AmqpTemplate amqpTemplate;

    @ShellMethod("普天桩发消息")
    public void p() {
        sender.sendp();
    }

    @ShellMethod("普天桩发消息")
    public void jiujiu() {
        for(int i = 0 ;i<80;i++){
            for(int j = 0 ;j<10;j++){
                int a = RandomUtil.randomInt(2,11);
                int b = RandomUtil.randomInt(2,11);
                System.out.print(a*b);
                System.out.print("      ");
            }
            System.out.println("");
        }
    }

    @ShellMethod("测试redis")
    public void redis() {
        redisTemplate.opsForZSet().add("myzset", "member1", 0.5);
        redisTemplate.opsForZSet().add("myzset", "member2", 0.1);
        redisTemplate.opsForZSet().add("myzset", "member3", 0.8);
        redisTemplate.opsForZSet().add("myzset", "member4", 0.2);
        redisTemplate.opsForZSet().add("myzset", "member5", 0.6);
        redisTemplate.opsForZSet().add("myzset", "member6", 0.9);
        Set oks = redisTemplate.opsForZSet().reverseRangeByScore("myzset",0.0,0.56);
        TimeInterval timer = DateUtil.timer();
        Set ok = redisTemplate.opsForZSet().reverseRangeByScore("myzset",0.0,0.56,0,1);
        System.out.println(timer.interval()+"毫秒");
        System.out.println(new ArrayList<>(ok).get(0));
    }

    @ShellMethod("发先付后退过程消息依恋")
    public void payfirst_p_yl(){
        sender.payfirst_p_yl();
    }

    @ShellMethod("普天桩发消息")
    public void error(String _batteryCode,String _cardNo) {
        batteryCode = _batteryCode;
        cardId = _cardNo;
        sender.error(batteryCode,cardId);
    }

    @ShellMethod("普天桩发消息")
    public void reerror() {
        sender.error(batteryCode,cardId);
    }

    @ShellMethod("普天桩发消息")
    public void rp() {
        sender.rp();
    }

    @ShellMethod("测试发消息性能")
    public void cheshixingneng() {
        sender.rp();
    }

    @ShellMethod("折扣")
    public void zk(int rebateId) {
        sender.zk(rebateId);
    }

    @ShellMethod("普天桩发消息")
    public void ps() {
        sender.sendps();
    }
    @ShellMethod("普天桩35度")
    public void du() {
        sender.sendnotifyRule();
    }
    @ShellMethod("英飞源桩发消息")
    public void y() {
        sender.sendYFY();
    }

    @ShellMethod("英飞源桩发消息")
    public void yp(){
        sender.sendYFYP();
    }
    @ShellMethod("亿联桩发消息")
    public String l() {
        String maming = "maming is ok";
        return DateUtil.date().toString();
//        return maming.substring(0,2);
    }

    @ShellMethod("性能测试发消息")
    public void xn(int i) {
        sender.xn(i);
    }
    @ShellMethod("亿联桩发消息")
    public void init() {
        sender.init();
    }

    @ShellMethod("亿联桩发消息")
    public void sz() {
        sender.sz();
    }

    @ShellMethod("单卡多发消息")
    public void dk() {
        sender.dk();
    }

    @ShellMethod("先付后用单卡多发消息")
    public void payfirst() {
        sender.payFirst();
    }

    @ShellMethod("驿联结算消息")
    public void yl(){
        sender.sendYL();
    }

    @ShellMethod("过程消息")
    public void pp() {
        sender.sendpp();
    }

    @ShellMethod("我都开始")
    public void test() {
        DateTime begin = DateUtil.parse("2023-2-15 19:05:50");
        DateTime end = DateUtil.parse("2023-2-15 10:05:50");
        DateTime b = DateUtil.parse("2023-2-15 11:05:50");
        boolean isFind = DateUtil.isIn(b,begin,end);
        System.out.println(isFind);
    }


    @ShellMethod("亿联桩发消息")
    public void ji(int i) {
        sender.setji(i);
    }

    @ShellMethod("余额变动发消息")
    public void yuer(int i) {
//        sender.balanceUpdate(i);
        for (int j = 0; j < 100000; j++) {
            BalanceChangeMsg balanceChangeMsg =
                    BalanceChangeMsg.builder().userId(10758).userType(1).groupBID(null).build();
            amqpTemplate.convertAndSend("icp-balance-change-queue", balanceChangeMsg);
        }

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

    @ShellMethod("调用计费策略")
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

    @ShellMethod("xxx")
    public void youlishu() {
        for(int i = 0;i<10; i++){
            for(int j = 0;j<3;j++){
                int a = RandomUtil.randomInt(-20,20);
                int b = RandomUtil.randomInt(-20,20);
                if(b>=0)
                    System.out.printf("%20s",a + " - "+b +" =    ");
                else
                    System.out.printf("%20s",a + " - ("+b +") =    ");
            }
            System.out.println("");
        }
    }

    @ShellMethod("ooo")
    public void ooo() {
        System.out.println(SecureUtil.md5("`6nT(6+^_Gs4rtY#1!@"));
    }

    @ShellMethod("xxx")
    public void youlishujian() {
        System.out.printf("%20s\n","---------------有理数减法-----------------");
        //有理数减法，全负数
        for(int i = 0;i<10; i++){
            for(int j = 0;j<4;j++){
                int a = RandomUtil.randomInt(-20,0);
                int b = RandomUtil.randomInt(-20,0);
                if(b>=0)
                    System.out.printf("%20s",a + " - "+b +" =    ");
                else
                    System.out.printf("%20s",a + " - ("+b +") =    ");
            }
            System.out.println("");
        }
        System.out.printf("%20s\n","--------------------------------");
        //有理数减法，前负后正
        for(int i = 0;i<10; i++){
            for(int j = 0;j<4;j++){
                int a = RandomUtil.randomInt(-20,0);
                int b = RandomUtil.randomInt(0,20);
                if(b>=0)
                    System.out.printf("%20s",a + " - "+b +" =    ");
                else
                    System.out.printf("%20s",a + " - ("+b +") =    ");
            }
            System.out.println("");
        }
        System.out.printf("%20s\n","--------------------------------");
        //有理数减法，前正后负
        for(int i = 0;i<10; i++){
            for(int j = 0;j<4;j++){
                int a = RandomUtil.randomInt(0,20);
                int b = RandomUtil.randomInt(-20,0);
                if(b>=0)
                    System.out.printf("%20s",a + " - "+b +" =    ");
                else
                    System.out.printf("%20s",a + " - ("+b +") =    ");
            }
            System.out.println("");
        }
        System.out.printf("%20s\n","--------------------------------");
        //有理数减法，前正后正
        for(int i = 0;i<10; i++){
            for(int j = 0;j<4;j++){
                int a = RandomUtil.randomInt(0,20);
                int b = RandomUtil.randomInt(0,20);
                if(b>=0)
                    System.out.printf("%20s",a + " - "+b +" =    ");
                else
                    System.out.printf("%20s",a + " - ("+b +") =    ");
            }
            System.out.println("");
        }

    }

    @ShellMethod("xxx")
    public void youlishujia() {
        System.out.printf("%20s\n","---------------有理数加法-----------------");
        //有理数减法，全负数
        for(int i = 0;i<10; i++){
            for(int j = 0;j<4;j++){
                int a = RandomUtil.randomInt(-20,0);
                int b = RandomUtil.randomInt(-20,0);
                if(b>=0)
                    System.out.printf("%20s",a + " + "+b +" =    ");
                else
                    System.out.printf("%20s",a + " + ("+b +") =    ");
            }
            System.out.println("");
        }
        System.out.printf("%20s\n","--------------------------------");
        //有理数减法，前负后正
        for(int i = 0;i<10; i++){
            for(int j = 0;j<4;j++){
                int a = RandomUtil.randomInt(-20,0);
                int b = RandomUtil.randomInt(0,20);
                if(b>=0)
                    System.out.printf("%20s",a + " + "+b +" =    ");
                else
                    System.out.printf("%20s",a + " + ("+b +") =    ");
            }
            System.out.println("");
        }
        System.out.printf("%20s\n","--------------------------------");
        //有理数减法，前正后负
        for(int i = 0;i<10; i++){
            for(int j = 0;j<4;j++){
                int a = RandomUtil.randomInt(0,20);
                int b = RandomUtil.randomInt(-20,0);
                if(b>=0)
                    System.out.printf("%20s",a + " + "+b +" =    ");
                else
                    System.out.printf("%20s",a + " + ("+b +") =    ");
            }
            System.out.println("");
        }
        System.out.printf("%20s\n","--------------------------------");
        //有理数减法，前正后正
        for(int i = 0;i<10; i++){
            for(int j = 0;j<4;j++){
                int a = RandomUtil.randomInt(0,20);
                int b = RandomUtil.randomInt(0,20);
                if(b>=0)
                    System.out.printf("%20s",a + " + "+b +" =    ");
                else
                    System.out.printf("%20s",a + " + ("+b +") =    ");
            }
            System.out.println("");
        }
    }



}
