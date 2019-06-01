---
title:       "LinkedList Problem Series"
subtitle:    ""
description: "Collection of LinkedList Problems"
date:        2019-06-01
author:      Yubai Tao
image:       "img/linkedlist.png"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
# LinkedList Problem Series
---
## Table of Contents

#### Reverse Problems
* [LC206 Reverse Linked List](#ReverseLinkedList)
* [LC92 Reverse Linked List II](#ReverseLinkedListII)

#### Copy Problems
* Test


--- 

* LC 92 *Reverse Linked List II* <a name="ReverseLinkedListII"></a>

* LC 138 *Copy List with Random Pointer*
  * O(N) Space Solution: 
  <br> Use Map<oldNode, newNode> to save the relationship
  between two lists. Two rounds, first for connect next pointers,
  second for connect random pointers.
  * O(1) Space Solution:
  <br> 
    1. Insert nodes right after the original nodes
    2. Assign random nodes to the copy nodes
    3. Extract nodes from the list to a new list
    
* LC 160 *Intersection of Two Linked Lists*
<br>: Given two head of LinkedList, and they may intercourse 
at one node, or not. If this node exists, return it.
<br> Also Map method can be used.
    ```java
    class Demo {
        /**
         * Use two pointer to solve the problem.
         *
         * Time Complexity: O(M + N)
         *
         * Trick:
         *     After one pointer reach the end,
         *     redirect it to the other linked list's head.
         *     And the when two pointer meets,
         *     the meeting point would be intersection.
         *
         * Simple proof:
         *
         *   LinkedList A
         *              (1)       (2)
         *   start  * ------ & --------- || end
         *          |        |
         *          |        |
         *          + ------ +
         *              (3)
         *   LinkedList B
         *
         *   LLA first reach the end, after went (1) + (2), then goes into (3)
         *   then LLB had finished (3) + (2), then goes into (1)
         *   They would meet right at the intersection because both of them had
         *   traveled (1) + (2) + (3)
         *
         *
         *
         * @param headA
         * @param headB
         * @return
         */
        private ListNode getIntersectNode_(ListNode headA, ListNode headB) {
            if (headA == null || headB == null) {
                return null;
            }
            ListNode pA = headA;
            ListNode pB = headB;
            while (pA != pB) {
                pA = pA == null ? headB : pA.next;
                pB = pB == null ? headA : pB.next;
            }
            return pA;
        }
    }
    ``` 
    
* LC 206 *Reverse Linked List* <a name="ReverseLinkedList"></a>
<br>: Reverse Linked List in two manners, recursively and 
iteratively.
<br> Recursive: Base case & null case; Next result of recursive
call as new previous nodes, after all calls, it would return
the new Head.
<br> Iterative: Define three pointers, prev, curr, next.
Property of these three remains during iteration.
    ```java
    class Demo {
        // Recursively
        private ListNode reverseList(ListNode head) {
            if (head == null || head.next == null) {
                return head;
            }
            ListNode prev = reverseList(head.next);
            head.next.next = head;
            head.next = null;
            return prev;
        }
    
        // Iteratively
        private ListNode reverseList_(ListNode head) {
            if (head == null) {
                return null;
            }
            ListNode prev = null;
            ListNode curr = head;
            while (curr != null) {
                ListNode next = curr.next;
                curr.next = prev;
                prev = curr;
                curr = next;
            }
            return prev;
        }
    }
    ```
