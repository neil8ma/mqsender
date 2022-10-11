package com.cpit.mqsender;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.json.JSONUtil;
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
    public void error(String batteryCode,String cardNo) {
        sender.error(batteryCode,cardNo);
    }

    @ShellMethod("普天桩发消息")
    public void rp() {
        sender.rp();
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
    public String l() {
        String maming = "maming is ok";
        return maming.substring(0,2);
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

    @ShellMethod("调用计费策略")
    public void dangechelue() {
        try{
            String url = "http://localhost:26150//bil/getConnectivityBusinessStrategyInformation";
                batteryCode = "0107141106101702";
                cardId = "6803131700038297";
                BfBusinessStrategyT bfBusinessStrategyT = new BfBusinessStrategyT();
                bfBusinessStrategyT.setBatteryCode(batteryCode);
                bfBusinessStrategyT.setCardId(cardId);
                bfBusinessStrategyT.setType(1);
                bfBusinessStrategyT.setChargeStartTime(new Date());
                bfBusinessStrategyT.setChargeEndTime(new Date());
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
