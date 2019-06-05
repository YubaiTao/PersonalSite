---
title:       "Dynamic Programming Problem Series"
subtitle:    ""
description: "Collection of DP Problems"
date:        2019-06-05
author:      Yubai Tao
image:       "img/dp.jpeg"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
# Dynamic Programming

#### Sell Stock Problem Series

* Best Time to Buy and Sell Stock I (LC#121, Easy)
<br>
```Java
class Solution {
    public int maxProfit(int[] prices) {
        if (prices == null || prices.length == 0) {
            return 0;
        }
        int n = prices.length;
        int buyPrice = Integer.MAX_VALUE;
        int maxProfit = 0;
        for (int i = 0; i < n; i++) {
            buyPrice = Math.min(buyPrice, prices[i]);
            maxProfit = Math.max(maxProfit, prices[i] - buyPrice);
        }
        return maxProfit;
    }
}
```

* Best Time to Buy and Sell Stock II (LC#122, Easy)
<br>
Actually an greedy approach. Just add all earning range.

* Best Time to Buy and Sell Stock III (LC#123, Hard)
<br>
```Java
class Solution {
    public int maxProfit(int[] prices) {
        int hold1 = Integer.MIN_VALUE;
        int hold2 = Integer.MIN_VALUE;
        int release1 = Integer.MIN_VALUE;
        int release2 = Integer.MIN_VALUE;
        if (prices.length == 0) {
            return 0;
        }
        for (int i : prices) {
            hold1 = Math.max(hold1, -i);
            release1 = Math.max(release1, hold1 + i);
            hold2 = Math.max(hold2, release1 - i);
            release2 = Math.max(release2, hold2 + i);
        }
        return release2;
    }
}
```

* Best Time to Buy and Sell Stock IV (LC#188, hard)
```Java
class Solution {
    /**
     * dp[i, j] represents the max profit up until prices[j] using at most i transactions. 
     * dp[i, j] = max(dp[i, j-1], prices[j] - prices[jj] + dp[i-1, jj]) { jj in range of [0, j-1] }
     *          = max(dp[i, j-1], prices[j] + max(dp[i-1, jj] - prices[jj]))
     * dp[0, j] = 0; 0 transactions makes 0 profit
     * dp[i, 0] = 0; if there is only one price data point you can't make any transaction.
     */
    public int maxProfit(int k, int[] prices) {
    	int n = prices.length;
    	if (n <= 1)
    		return 0;
    	
    	//if k >= n/2, then you can make maximum number of transactions. (for speed up)
    	if (k >=  n/2) {
    		int maxPro = 0;
    		for (int i = 1; i < n; i++) {
    			if (prices[i] > prices[i-1])
    				maxPro += prices[i] - prices[i-1];
    		}
    		return maxPro;
    	}
    	
        int[][] dp = new int[k+1][n];
        for (int i = 1; i <= k; i++) {
        	int localMax = dp[i-1][0] - prices[0];
        	for (int j = 1; j < n; j++) {
        		dp[i][j] = Math.max(dp[i][j-1],  prices[j] + localMax);
        		localMax = Math.max(localMax, dp[i-1][j] - prices[j]);
        	}
        }
        return dp[k][n-1];
    }
}
```

#### Derived Buy-Sell-Stock-Like Problems

* Best Time to Buy and Sell Stock with Cooldown (LC#309, medium)
<br>
```Java
class solution {
    private int maxProfit(int[] prices) {
        if (prices == null || prices.length <= 1) {
            return 0;
        }
        int n = prices.length;
        int[] buy = new int[n];
        int[] sell = new int[n];
        buy[0] = -prices[0];
        buy[1] = Math.max(-prices[0], -prices[1]);
        sell[0] = 0;
        sell[1] = Math.max(sell[0], prices[1] + buy[0]);
        for (int i = 2; i < n; i++) {
            buy[i] = Math.max(buy[i - 1], sell[i - 2] - prices[i]);
            sell[i] = Math.max(sell[i - 1], buy[i - 1] + prices[i]);
        }

        return sell[n - 1];
    }
}
```

* Best Time to Buy and Sell Stock with Transaction Fee (LC#714, medium)
```Java
class solution {
    private int maxProfit(int[] prices, int fee) {
        if (prices == null || prices.length <= 1) {
            return 0;
        }
        int n = prices.length;
        int[] buy = new int[n];
        int[] sell = new int[n];
        buy[0] = -prices[0];
        sell[0] = 0;
        for (int i = 1; i < n; i++) {
            buy[i] = Math.max(buy[i - 1], sell[i - 1] - prices[i]);
            sell[i] = Math.max(sell[i - 1], buy[i - 1] + prices[i] - fee);
        }
        return sell[n - 1];
    }
}
```


