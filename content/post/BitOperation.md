---
title:       "Bit Operation Problem Series"
subtitle:    ""
description: "Collection of Bit Operation Problems"
date:        2019-06-05
author:      Yubai Tao
image:       "img/bit.png"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
## Bit Operation Problem Series

* LC 89 *Gray Code*
<br>: Gray code is a binary numeral system where
two successive values differ in only one bit.
<br>: Example 00 - 0, 01 - 1, 11 - 3, 10 - 2.
<br>: input(2), output([0, 1, 3, 2])
<br> Use the patter that the digits except M.S.B. mirror with 
previous outputs.
<br> Notice that the first 4 gray code is symmetric with
last 4 gray code in the table.

    | Original | Gray Code |
    | -------- | --------- |
    | 000 | 0 00 |
    | 001 | 0 01 |
    | 010 | 0 11 |
    | 011 | 0 10 |
    | 100 | 1 10 |
    | 101 | 1 11 |
    | 110 | 1 01 |
    | 111 | 1 00 |
    
    ```java
    class Demo {
        private List<Integer> grayCode(int n) {
            List<Integer> list = new LinkedList<>();
            list.add(0);
            for (int i = 0; i < n; i++) {
                int size = list.size();
                for (int j = size - 1; j >= 0; j--) {
                    list.add(list.get(j) | 1 << i);
                }
            }
            return list;
        }
    }
    ```
    
    
    
