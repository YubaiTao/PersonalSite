---
title:       "Depth-First Problem Series"
subtitle:    ""
description: "Collection of DFS Problems"
date:        2019-06-05
author:      Yubai Tao
image:       "img/dfs.jpg"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
# DFS

#### Island Problem Series

* LC 200 *Number of Islands*
<br> Multiple solutions:
  - DFS and mark visited island to '0'
  - BFS and do the same
  - UnionFind all the '1's and return the number of connected
  components
  
* LC 305 *Number of Islands II*
<br> Add `island` to the empty grid, and
save islands number after each addition.
<br> DFS would TLE, use union-find.

* LC 694 *Number of Distinct Islands*
<br> Same as original number of islands,
but use DFS direction path as islands identifier 
to deduplicate.

* LC 711 *Number of Distinct Islands II*
<br> Now transformation include rotation/reflection.
<br> Use conflict identifier for islands
distinction.

* LC 1020 *Number of Enclaves* 
<br> DFS at the boundary lands.

#### Naive DFS

* LC 17 *Letter Combinations of a Phone Number*
<br> First construct the possible set for each number.
<br> Then do DFS for the input the get all the combinations.

