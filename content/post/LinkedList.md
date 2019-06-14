---
title:       "LinkedList Problem Series"
subtitle:    ""
description: "Collection of LinkedList Problems"
date:        2019-06-14
author:      Yubai Tao
image:       "img/linkedlist.png"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
# LinkedList Problem Series

## Table of Contents

* Reverse Problems
  * [LC206 Reverse Linked List](#ReverseLinkedList)
  * [LC92 Reverse Linked List II](#ReverseLinkedListII)
  * [LC25 Reverse Nodes in k-Group](#ReverseNodesinkGroup)
* Copy Problems
  * [LC138 Copy List with Random Pointer](#CopyListwithRandomPointer)
* Remove/Insert/Reorder Problems
  * [LC237 Delete Node in a Linked List](#DeleteNodeinaLinkedList)
  * [LC203 Remove Linked List Elements](#RemoveLinkedListElements) 
  * [LC83 Remove Duplicates from Sorted List](#RemoveDuplicatesfromSortedList)
  * [LC82 Remove Duplicates from Sorted List II](#RemoveDuplicatesfromSortedListII)
  * [LC143 Reorder List](#ReorderList)
  * [LC328 Odd Even Linked List](#OddEvenLinkedList)
* Sorting Problems
  * [LC147 Insertion Sort List](#InsertionSortList)
  * [LC148 Sort List](#SortList)
* Miscellaneous
  * [LC369 Plus One Linked List](#369)
  
  
---

* LC 369 *Plus One Linked List* <a name="369"></a>
<br>: Given a non-negative integer represented as non-empty 
a singly linked list of digits, plus one to the integer.
The digits are stored such that the most significant digit is 
at the head of the list.
<br> We can naively use the carry bit to do this brute-force.
<br> Also can be done in two-pointer way. 
Key thought is to locate the right-most non-nine digit node.
(Which indicates the rest digits/nodes value are all 9).
    ```java
    class Demo {
        private ListNode plusOne_(ListNode head) {
            ListNode dummyHead = new ListNode(0);
            dummyHead.next = head;
            ListNode nonNineNode = dummyHead;
            ListNode pHead = head;
            while (pHead != null) {
                if (pHead.val != 9) {
                    nonNineNode = pHead;
                }
                pHead = pHead.next;
            }
            nonNineNode.val++;
            pHead = nonNineNode.next;
            while (pHead != null) {
                pHead.val = 0;
                pHead = pHead.next;
            }
            return dummyHead.val == 1 ? dummyHead : dummyHead.next;
        }
        
        private ListNode plusOne(ListNode head) {
            Deque<ListNode> stack = new LinkedList<>();
            ListNode oldHead = head;
            while (head != null) {
                stack.push(head);
                head = head.next;
            }
            int carry = 1;
            ListNode curr;
            while (!stack.isEmpty()) {
                curr = stack.poll();
                if (curr.val + carry == 10) {
                    carry = 1;
                    curr.val = 0;
                } else {
                    curr.val = curr.val + carry;
                    carry = 0;
                }
            }
            if (carry == 1) {
                ListNode newHead = new ListNode(1);
                newHead.next = oldHead;
                return newHead;
            }
            return oldHead;
        }
    }
    ``` 


* LC 328 *Odd Even Linked List* <a name="OddEvenLinkedList"></a>
<br>: Group all odd nodes together followed by the even nodes. (odd/even is for sequence, not node value).
<br> Straight-forward break the node, collect odd/event part, and connect two parts.
    ````java
    class Demo {
        private ListNode oddEvenList(ListNode head) {
            ListNode oddDummyHead = new ListNode(-1);
            ListNode evenDummyHead = new ListNode(0);
            ListNode oddHead = oddDummyHead;
            ListNode evenHead = evenDummyHead;
            boolean oddFlag = true;
            while (head != null) {
                if (oddFlag) {
                    oddHead.next = head;
                    head = head.next;
                    oddHead = oddHead.next;
                    oddHead.next = null;
                } else {
                    evenHead.next = head;
                    head = head.next;
                    evenHead = evenHead.next;
                    evenHead.next = null;
                }
                oddFlag = !oddFlag;
            }
            oddHead.next = evenDummyHead.next;
            return oddDummyHead.next;
        }
    }
    ````

* LC 206 *Delete Node in a Linked List* <a name="DeleteNodeinaLinkedList"></a>
<br>: Delete the node(except the tail) in a singly linked list, 
given only access to that node.
<br> Technically you can not delete a node without knowing the
previous node. 
In this question, we just rewrite the node value to the next node.
And delete the next node.
    ```java
    class Demo {
        private void deleteNode(ListNode node) {
            node.val = node.next.val;
            node.next = node.next.next;
        }
    }
    ```  
 
* LC 148 *Sort List* <a name="SortList"></a>
<br>: Sort the linked list in O(nlogn) time and constant space.
<br>Consider using merge sort, but not in recursion fashion. 
Because the stack frame can lead to non-constant time.
    ```java
    class Demo {
        private ListNode sortList(ListNode head) {
            ListNode dummyHead = new ListNode(0);
            dummyHead.next = head;
            int n = 0;
            while (head != null){
                head = head.next;
                n++;
            }
            for (int step = 1; step < n; step *= 2) {
                ListNode prev = dummyHead;
                ListNode curr = dummyHead.next;
                while (curr != null) {
                    ListNode left = curr;
                    ListNode right = split(left, step);
                    curr = split(right, step);
                    prev = merge(left, right, prev);
                }
            }
            return dummyHead.next;
        }
    
        private ListNode split(ListNode head, int step) {
            if (head == null) {
                return null;
            }
            for (int i = 1; head.next != null && i < step; i++) {
                head = head.next;
            }
            ListNode right = head.next;
            head.next = null;
            return right;
        }
    
        private ListNode merge(ListNode left, ListNode right, ListNode prev) {
            ListNode curr = prev;
            while (left != null && right != null) {
                if (left.val < right.val) {
                    curr.next = left;
                    left = left.next;
                } else {
                    curr.next = right;
                    right = right.next;
                }
                curr = curr.next;
            }
            if (left == null) {
                curr.next = right;
            } else {
                curr.next = left;
            }
            while (curr.next != null) {
                curr = curr.next;
            }
            return curr;
        }
    }
    ```


* LC 147 *Insertion Sort List* <a name="InsertionSortList"></a>
<br>: Sort the linked list in by insertion sort.
    ```java
    class Demo {
         private ListNode insertionSortList(ListNode head) {
             if (head == null || head.next == null) {
                 return head;
             }
             ListNode dummyHead = new ListNode(0);
             dummyHead.next = head;
             ListNode lHead = dummyHead;
             ListNode rHead = head.next;
             head.next = null; // Break here
             ListNode lCurr;
             ListNode rCurr;
             ListNode lNext;
             while (rHead != null) {
                 lCurr = lHead;
                 rCurr = rHead;
                 rHead = rHead.next;
                 while (lCurr.next != null && lCurr.next.val < rCurr.val) {
                     lCurr = lCurr.next;
                 }
                 lNext = lCurr.next;
                 lCurr.next = rCurr;
                 rCurr.next = lNext;
                 lHead = dummyHead;
             }
             return dummyHead.next;
         } 
    }
    ```

* LC 143 *Reorder List* <a name="ReorderList"></a>
<br>: 1->2->3->4 to 1->4->2->3 in place.
<br> Break it into 3 sub-problems.
<br> Need to break two parts before merge!!! Or the inner cycle can occur.
    ```java
    class Demo{
        /**
         * 1. Find middle node (slow-fast pointer)
         * 2. Reverse 2nd part of the list
         * 3. Merge the two part.
         *
         * @param head
         */
        private void reorderList(ListNode head) {
            // Find mid
            ListNode slow = head;
            ListNode fast = head;
            while (fast.next != null && fast.next.next != null) {
                slow = slow.next;
                fast = fast.next.next;
            }
            ListNode midNode = slow.next;
            // Reverse
            ListNode prev = null;
            ListNode curr = midNode;
            ListNode next;
            while (curr != null) {
                next = curr.next;
                curr.next = prev;
                prev = curr;
                curr = next;
            }
            slow.next = null; // !! Break two parts
            midNode = prev;
            // Merge
            ListNode pHead = head;
            ListNode qHead = midNode;
            ListNode pNext, qNext;
            while (qHead != null) {
                pNext = pHead.next;
                qNext = qHead.next;
                pHead.next = qHead;
                qHead.next = pNext;
                pHead = pNext;
                qHead = qNext;
            }
        }
    }
    ```

* LC 203 *Remove Linked List Elements* <a name="RemoveLinkedListElements"></a>
<br>: Remove nodes with appointed value.
    ```java
    class Demo {
        // Recursively
        private ListNode removeElements(ListNode head, int val) {
                if (head == null) return null;
                head.next = removeElements(head.next, val);
                return head.val == val ? head.next : head;
        }
    
        // Iteratively
        private ListNode removeElements_(ListNode head, int val) {
             ListNode dummyHead = new ListNode(0);
             dummyHead.next = head;
             head = dummyHead;
             while (head != null && head.next != null) {
                 if (head.next.val == val) {
                     head.next = head.next.next;
                 } else {
                     head = head.next;
                 }
             }
             return dummyHead.next;
        }
    }
    ```
    

* LC 83 *Remove Duplicates from Sorted List* <a name="RemoveDuplicatesfromSortedList"></a>
    ```java
    class Demo {
        private ListNode deleteDuplicates(ListNode head) {
             ListNode pHead = head;
             while (pHead != null && pHead.next != null) {
                 if (pHead.val == pHead.next.val) {
                     pHead.next = pHead.next.next;
                 } else {
                     pHead = pHead.next;
                 }
             }
             return head;
        }
    }
    ```

* LC 82 *Remove Duplicates from Sorted List II* <a name="RemoveDuplicatesfromSortedListII"></a>
<br>: Leave only distinct numbers (nodes). 
    ```java
    class Demo {
        private ListNode deleteDuplicates(ListNode head) {
            ListNode dummyHead = new ListNode(0);
            dummyHead.next = head;
            Integer preVal = null;
            ListNode prev = dummyHead;
            ListNode curr = head;
            while (curr != null) {
                if ((preVal == null || preVal != curr.val) &&
                        (curr.next == null || curr.val != curr.next.val)) {
                    preVal = curr.val;
                    prev = curr;
                    curr = curr.next;
                } else {
                    preVal = curr.val;
                    prev.next = curr.next;
                    curr = curr.next;
                }
            }
            return dummyHead.next;
        }
    }
    ```

* LC 25 *Reverse Nodes in k-Group* <a name="ReverseNodesinkGroup"></a>
<br> Re-initialize the variables needed after the loop.
    ```java
    class Demo {
        private ListNode reverseKGroup(ListNode head, int k) {
            ListNode pHead = head;
            int len = 0;
            while (pHead != null) {
                pHead = pHead.next;
                len++;
            }
            ListNode dummyHead = new ListNode(0);
            dummyHead.next = head;
    
            ListNode prev = null;
            ListNode curr = head;
            ListNode next = null;
            ListNode preHead = dummyHead;
            ListNode sectionEndNode;
            int l;
            while (len >= k) {
                l = k;
                sectionEndNode = curr;
                while (l > 0) {
                    next = curr.next;
                    curr.next = prev;
                    prev = curr;
                    curr = next;
                    l--;
                }
                preHead.next = prev;
                sectionEndNode.next = curr;
                // post re-initialization
                preHead = sectionEndNode; // prev of head of next section
                prev = null;
                curr = next;
                next = null;
                len -= k;
            }
            return dummyHead.next;
        }    
    }
    ```


* LC 92 *Reverse Linked List II* <a name="ReverseLinkedListII"></a>
<br>: Reverse Linkedlist in a section.
<br> Keep track of the breaking points, connect them after reversion.
    ```java
    class Demo {
        private ListNode reverseBetween(ListNode head, int m, int n) {
            if (m == n) {
                return head;
            }
            ListNode dummyHead = new ListNode(0);
            dummyHead.next = head;
            ListNode pHead = dummyHead;
            n -= m;
            while (m != 1 && pHead != null) {
                pHead = pHead.next;
                m--;
            }
            ListNode reverseEndNode = pHead.next;
            // reverseEndNode: the last node of the reversed part
            ListNode prev = null;
            ListNode curr = pHead.next;
            ListNode next;
            while (n >= 0) {
                next = curr.next;
                curr.next = prev;
                prev = curr;
                curr = next;
                n--;
            }
            // now prev is reversed new head
            // curr is the head of the third part
            pHead.next = prev;
            reverseEndNode.next = curr;
    
            return dummyHead.next;
        }
    
    }
    ```


* LC 138 *Copy List with Random Pointer* <a name="CopyListwithRandomPointer"></a>
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
