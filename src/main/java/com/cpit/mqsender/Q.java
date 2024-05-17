package com.cpit.mqsender;

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
            int[] coins = {1, 5, 10, 20, 50};
            int amount = 100;
            int ways = countChange(amount, coins);
            System.out.println(ways);
        }
}
