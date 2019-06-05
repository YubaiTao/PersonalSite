---
title:       "Binary Tree Problem Series"
subtitle:    ""
description: "Collection of Tree Problems"
date:        2019-06-05
author:      Yubai Tao
image:       "img/tree.jpg"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
# Tree Problem Series


#### LCA

* LC 236 *LCA (Lowest Common Ancestor)*
<br> Two solutions
  * Recursive test!!!!
```java
class Demo {
    private TreeNode lowestCommonAncestor__(TreeNode root, TreeNode p, TreeNode q) {
        if (root == null || root == p || root == q) {
            return root;
        }
        TreeNode left = lowestCommonAncestor__(root.left, p, q);
        TreeNode right = lowestCommonAncestor__(root.right, p, q);
        if (left != null && right != null) {
            return root;
        }
        return left == null ? right : left;
    }
}
```
  * Iterative
    <br> First traverse the tree and save all 
    the node-parent relationship in a `Map<node, parent>`.
    Then save all node p and it's ancestors in an `Set`.
    Finally find q's ancestors, and if hit one node also in
    the p's AncestorSet, then we find the LCA of p and q.
```java
class Demo {
    private TreeNode lowestCommonAncestorIter(TreeNode root, TreeNode p, TreeNode q) {
        if (root == null) {
            return null;
        }
        Map<TreeNode, TreeNode> parentMap = new HashMap<>();
        Queue<TreeNode> queue = new LinkedList<>();
        parentMap.put(root, null);
        queue.offer(root);
        while (!(parentMap.containsKey(p) && parentMap.containsKey(q))) {
            TreeNode currNode = queue.poll();
            if (currNode.left != null) {
                parentMap.put(currNode.left, currNode);
                queue.offer(currNode.left);
            }
            if (currNode.right != null) {
                parentMap.put(currNode.right, currNode);
                queue.offer(currNode.right);
            }
        }
        Set<TreeNode> pAncestors = new HashSet<>();
        while (p != null) {
            pAncestors.add(p);
            p = parentMap.get(p);
        }
        while (!pAncestors.contains(q)) {
            q = parentMap.get(q);
        }
        return q;
    }
}
```
    
* LC 235 *LCA of BST*
<br> Much easier, use the property of BST to judge p, q
, root \'s relative location.
  - Recursive
```java
class Demo {
    private TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        int pVal = p.val;
        int qVal = q.val;
        if (root.val > Math.max(pVal, qVal)) {
            return lowestCommonAncestor(root.left, p, q);
        }
        if (root.val < Math.min(pVal, qVal)) {
            return lowestCommonAncestor(root.rigth, p, q);
        }
        return root;
    }
}
```
  - Iterative
```java
class Demo {
    private TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        while (true) {
            if (root.val > Math.max(p.val, q.val)) {
                root = root.left;
            } else if (root.val < Math.min(p.val, q.val)) {
                root = root.right;
            } else {
                return root;
            }
        }
    }
}
```