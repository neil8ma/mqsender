package com.cpit.mqsender;

import cn.hutool.core.date.DateUtil;

import java.time.LocalTime;
import java.util.Date;

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
        }
}
