---
title:       "Stack Problem Series"
subtitle:    ""
description: "Collection of Stack Problems"
date:        2019-06-05
author:      Yubai Tao
image:       "img/stack.jpg"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
# Stack Problem Series

#### Next bigger/smaller

* LC 1019 *Next Greater Node in LinkedList*
<br> For next bigger problem, maintain a monotonic decreasing 
stack. 
```java
public class demo {
    public int[] nextBigger(int[] A) {
        int n = A.length;
        int[] ret = new int[n];
        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && A[stack.peek()] < A[i]) {
                ret[stack.pop()] = A[i];
            }
            stack.push(i);
        }
        return ret;            
    }    
}
```

* LC 20 *Valid Parentheses*
<br>: `"()[]{}"`, `{[]}` valid. `"([)]"` invalid.
<br> Use stack to save them, 
when encounter a pair, get rid of them,
so in the end the stack should be empty.

