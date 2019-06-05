---
title:       "Breadth-First Search Problem Series"
subtitle:    ""
description: "Collection of BFS Problems"
date:        2019-06-05
author:      Yubai Tao
image:       "img/bfs.jpg"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
# BFS Problem Series

* LC 909 *Snakes and Ladders*
<br>: can jump 6 steps or use ladder/snake
<br>BFS for 6 steps, when encounter a ladder/snake,
add the updated value.
<br>Use `Set` to save the visited positions.


* LC 675 *Cut Off Trees for Golf Event*
<br>: Grid with obstacles('0'), land('1'), trees('height, >1').
<br>: Cut off trees from small height to larger height.
<br>: Return the path length of movement, start from (0, 0).
<br> Sort the tree position by height, then 
the problem turns to an all-source-shortest-path problem.
<br> Solve it using BFS, when encounter an unreachable tree,
return -1.

* LC 297 *Serialize and Deserialize Binary Tree*
<br> Use BFS to Serialize, save the null values.
<br> During the Deserialization, 
create a queue, offer the first value form the split array.
Loop all the values in the split array.
<br> When polling out an value for the queue, consider it as the
parent of the next two elements in the loop. <br>
Push back these two nodes to the queue, they would be used as parent 
of other nodes.
<br> It's like a reverse thought of BFS with queue.
    ```Java
    class Demo {
        public TreeNode deserialize(String data) {
            if (data.equals("")) {
                return null;
            }
            String[] nodeVals = data.split(",");
            int n = nodeVals.length;
            Queue<TreeNode> queue = new LinkedList<>();
            TreeNode root = new TreeNode(Integer.valueOf(nodeVals[0]));
            queue.add(root);
            for (int i = 1; i < n; i++) {
                TreeNode parent = queue.poll();
                if (!nodeVals[i].equals("null")) {
                    TreeNode left = new TreeNode(Integer.parseInt(nodeVals[i]));
                    parent.left = left;
                    queue.add(left);
                }
                i++;
                if (!nodeVals[i].equals("null")) {
                    TreeNode right = new TreeNode(Integer.parseInt(nodeVals[i]));
                    parent.right = right;
                    queue.add(right);
                }
            }
            return root;
        }
    }
    ```