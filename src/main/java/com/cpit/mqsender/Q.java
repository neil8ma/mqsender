package com.cpit.mqsender;

import cn.hutool.core.date.DateUtil;
import cn.hutool.log.Log;
import cn.hutool.log.LogFactory;
import com.cpit.icp.dto.billing.cardroll.BfCardroll;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Q {
        public static int countChange(int n, int[] coins) {
            int[] dp = new int[n + 1];
            dp[0] = 1;

            for (int coin : coins) {
                for (int i = coin; i <= n; i++) {
                    dp[i] += dp[i - coin];
                }
            }

            return dp[n];
        }

        public static void main(String[] args) {
                System.out.println(DateUtil.currentSeconds()/60/5);
            Log logger = LogFactory.get();
//            int[] coins = {1, 5, 10, 20, 50};
//            int amount = 100;
//            int ways = countChange(amount, coins);
//            System.out.println(ways);
//            System.out.println(DateUtil.format(new Date(),
//                    "HH:mm"));
            LocalTime time = LocalTime.parse("10:03");
            System.out.println(time);

            Date ok = DateUtil.parse(time.toString());
            System.out.println(ok);
            SimpleDateFormat simpleFormat = new SimpleDateFormat("yMMdd");
            System.out.println(simpleFormat.format(new Date()));

            String nyr = DateUtil.format(new Date(), "yyMMdd");
            nyr = "8"+nyr.substring(1,nyr.length());
            System.out.println(nyr);
            BfCardroll a = new BfCardroll();
            a.setCardrollId(54854);
            a.setCardrollName("sdfsdfsdfsdfsdfsdf");
            logger.info("卡券使用,优惠券:{}",a.getCardrollName());
            BigDecimal sss = new BigDecimal("12.322");
            sss.toString();
            logger.info("ik,{}",sss);

            List<Integer> os = new ArrayList<>();
            for (Integer o: os) {
                logger.info("dkskd,{}",o);
            }

            BigDecimal one = null;
            BigDecimal two = new BigDecimal("1.2");
            int result = two.compareTo(one);
            logger.info("jiba --- > {}",result);
        }

}
