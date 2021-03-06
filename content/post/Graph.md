---
title:       "Graph Problem Series"
subtitle:    ""
description: "Collection of Graph Problems"
date:        2019-06-19
author:      Yubai Tao
image:       "img/graph.jpg"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
# Graph Problem Series

## Table of Contents <a name="toc"></a>
* [Topological Sort](#TopologicalSort)
  * [LC207 Course Schedule](#207)
  * [LC210 Course Schedule II](#210)
  * [LC269 Alien Dictionary](#269)

---
##### Topological Sort[^1] <a name="TopologicalSort"></a>
* BFS approach (Kahn's Algorithm)
  ```
  L: Empty list that will contain the sorted element
  S: Set of all nodes with no incoming edge
  while S is non-empty do
      remove a node n from S
      add n to tail of L
      for each node m with an edge e from n to m do
          remove edge e from the graph
          if m has no other incoming edges then
              insert m into S
  if graph has edges then
      return error (graph has at least one cycle)
  else
      return L (a topologically sorted order)
  ```
  The more straight-forward explanation is that: 
  First find all nodes that in-degree is zero.
  Remove these nodes and update the in-degree of rest nodes.
  Then do this to the new nodes that have zero in-degree.
  Use a list structure to hold the 0-indegree nodes, 
  prefer a `Queue`.
  <br> After the whole process, 
  if there are still nodes with in-degree. 
  Then cycle presents.
  <br> If not, the removed nodes formed the topological sort result.
  This result is not unique. 
  
* DFS approach
  ```
  L: Empty list that will contain the sorted node
  while exists nodes without a permanent mark do
      select an unmarked node n
      visit(n)
  function visit(node n)
      if n has a permanent mark then return
      if n has a temporary mark then stop (not a DAG/acyclic)
      for each node m with an edge from n to m do
          visit(m)
      remove temporary mark from n
      mark n with a permanent mark
      add n to head of L
  ```
  This approach use the idea that the topological sequence 
  is the reverse order result of finishing time running DFS.
  So we may use a stack to save the nodes that we are 
  'finished', or 'done visiting'. 

---

* LC269H *Alien Dictionary* <a name="269"></a>
<br> :: There is a new alien language 
which uses the latin alphabet. However, 
the order among letters are unknown to you. 
You receive a list of non-empty words from the dictionary, 
where words are sorted lexicographically 
by the rules of this new language. 
Derive the order of letters in this language.
<br> Example input:
<br> &nbsp;&nbsp;&nbsp;&nbsp; "wrt",
<br> &nbsp;&nbsp;&nbsp;&nbsp; "wrf",
<br> &nbsp;&nbsp;&nbsp;&nbsp; "er",
<br> &nbsp;&nbsp;&nbsp;&nbsp; "ett",
<br> &nbsp;&nbsp;&nbsp;&nbsp; "rftt"
<br> Output : "wertf"
<br> In the example: 
<br> &nbsp;&nbsp;&nbsp;&nbsp; "wrt" \> "wrf" -- (t -\> f), 
<br> &nbsp;&nbsp;&nbsp;&nbsp; "wrf" \> "er" -- (w -\> e) ...
<br> The pattern is that the first different character 
between two consecutive words can give us one induction rule.
Collect all these induction rules, 
then use the topological to find the order.
<br> This is pretty much like [Course Schedule II](#210),
one slight modification is that we do not have the fixed alphabet.
We have to keep a alphabet (`Set`), and after using all the induction rules,
we add the characters that appears in the alphabet but
do not participate the induction 
(solely starts in topological sort).
    ```java
    class Demo {
        // Using Kahn's algorithm
        private String alienOrder(String[] words) {
            int n = words.length;
            Map<Character, Integer> indegreeMap = new HashMap<>();
            Set<char[]> orderSet = new HashSet<>();
            Set<Character> alphabet = new HashSet<>();
            for (int i = 0; i < n - 1; i++) {
                int minLen = Math.min(words[i].length(), words[i + 1].length());
                int m = words[i].length();
                for (int j = 0; j < m; j++) {
                    alphabet.add(words[i].charAt(j));
                }
                for (int j = 0; j < minLen; j++) {
                    if (words[i].charAt(j) != words[i + 1].charAt(j)) {
                        char hi = words[i].charAt(j);
                        char lo = words[i + 1].charAt(j);
                        if (!orderSet.contains(new char[]{hi, lo})) {
                            if (!indegreeMap.containsKey(hi)) {
                                indegreeMap.put(hi, 0);
                            }
                            indegreeMap.put(lo, indegreeMap.getOrDefault(lo, 0) + 1);
                            orderSet.add(new char[]{hi, lo});
                        }
                        break;
                    }
                }
            }
            for (int j = 0; j < words[n - 1].length(); j++) {
                alphabet.add(words[n - 1].charAt(j));
            }
            Queue<Character> queue = new LinkedList<>();
            StringBuilder sb = new StringBuilder();
            Set<Character> usedSet = new HashSet<>();
            for (Map.Entry<Character, Integer> entry : indegreeMap.entrySet()) {
                if (entry.getValue() == 0) {
                    queue.offer(entry.getKey());
                }
            }
            while (!queue.isEmpty()) {
                char currChar = queue.poll();
                sb.append(currChar);
                usedSet.add(currChar);
                for (char[] pair : orderSet) {
                    if (pair[0] == currChar) {
                        indegreeMap.put(pair[1], indegreeMap.get(pair[1]) - 1);
                        if (indegreeMap.get(pair[1]) == 0) {
                            queue.offer(pair[1]);
                        }
                    }
                }
            }
            for (int i :indegreeMap.values()){
                if (i != 0) {
                    return "";
                }
            }
            for (char c : alphabet) {
                if (!usedSet.contains(c)) {
                    sb.append(c);
                }
            }
            return sb.toString();
        }
    }
    ```
[Back to TOC](#toc)    
 

  


* LC207M *Course Schedule* <a name="207"></a>
<br> :: pair(course, prereq) in prerequisites[][].
Judge if this schedule is valid.
<br> Actually, we do not need to do topological sort 
in this problem. But to find if there is a cycle, 
we need to judge whether there is any node left after removal
of all 0-indegree nodes (kahn's algorithm), 
or whether there are any nodes get visited twice before
finishing.
    ```java
    class Demo {
        // DFS approach
        private boolean canFinish_(int numCourses, int[][] prerequisites) {
            Map<Integer, List<Integer>> map = new HashMap<>();
            for (int i = 0; i < numCourses; i++) {
                map.put(i, new LinkedList<>());
            }
            int n = prerequisites.length;
            for (int i = 0; i < n; i++) {
                map.get(prerequisites[i][0]).add(prerequisites[i][1]);
            }
            int[] visited = new int[numCourses];
            boolean[] cyclic = new boolean[1];
            for (int i = 0; i < numCourses; i++) {
                if (visited[i] == 0) {
                    DFS(map, i, visited, cyclic);
                }
            }
            return !cyclic[0];
        }
    
        private void DFS(Map<Integer, List<Integer>> map, int node, int[] visited, boolean[] cyclic) {
            visited[node] = 1;
            List<Integer> neighbors = map.get(node);
            for (int nei : neighbors) {
                if (visited[nei] == 0) {
                    DFS(map, nei, visited, cyclic);
                } else if (visited[nei] == 1) {
                    cyclic[0] = true;
                }
            }
            visited[node] = 2;
        }
        
        
        // Kahn's Algorithm
        private boolean canFinish(int numCourses, int[][] prerequisites) {
            int[] indegrees = new int[numCourses];
            int n = prerequisites.length;
            for (int[] pair : prerequisites) {
                indegrees[pair[1]]++;
            }
            Queue<Integer> queue = new LinkedList<>();
            for (int i = 0; i < numCourses; i++) {
                if (indegrees[i] == 0) {
                    queue.offer(i);
                }
            }
            int currNode;
            while (!queue.isEmpty()) {
                currNode = queue.poll();
                for (int i = 0; i < n; i++) {
                    if (prerequisites[i][0] == currNode) {
                        indegrees[prerequisites[i][1]]--;
                        if (indegrees[prerequisites[i][1]] == 0) {
                            queue.offer(prerequisites[i][1]);
                        }
                    }
                }
            }
            for (int i : indegrees) {
                if (i != 0) {
                    return false;
                }
            }
            return true;
        }
    }
    ```
[Back to TOC](#toc)


* LC210M *Course Schedule II* <a name="210"></a>
<br> :: Like [Course Schedule I](#207), 
but this time we need to save the topological result.
And we need to return reverse of the topological result, because the
graph is a dependency graph, which is opposite to the sequence that
the courses should be taken.
    ```java
    class Demo {
        // DFS approach
        private int[] findOrder_(int numCourses, int[][] prerequisites) {
            int n = prerequisites.length;
            Map<Integer, List<Integer>> map = new HashMap<>();
            for (int i = 0; i < numCourses; i++) {
                map.put(i, new LinkedList<>());
            }
            for (int i = 0; i < n; i++) {
                map.get(prerequisites[i][0]).add(prerequisites[i][1]);
            }
            int[] visited = new int[numCourses];
            Deque<Integer> stack = new LinkedList<>();
            int[] ret = new int[numCourses];
            for (int i = 0; i < numCourses; i++) {
                if (visited[i] == 0) {
                    if (DFS(map, i, visited, stack)) {
                        return new int[0];
                    }
                }
            }
            for (int i = numCourses - 1; i >= 0; i--) {
                ret[i] = stack.pop();
            }
            return ret;
        }
        
        private boolean DFS(Map<Integer, List<Integer>> map, int node, int[] visited, Deque<Integer> stack) {
            visited[node] = 1;
            List<Integer> list = map.get(node);
            for (int i : list) {
                if (visited[i] == 0) {
                    if (DFS(map, i, visited, stack)) {
                        return true;
                    }
                } else if (visited[i] == 1) {
                    return true;
                }
            }
            visited[node] = 2;
            stack.push(node);
            return false;
        }
        
        // Kahn's Algorithm
        private int[] findOrder(int numCourses, int[][] prerequisites) {
            int[] indegrees = new int[numCourses];
            int[] ret = new int[numCourses];
            int n = prerequisites.length;
            List<Integer> list = new LinkedList<>();
            Queue<Integer> queue = new LinkedList<>();
            for (int[] pair : prerequisites) {
                indegrees[pair[1]]++;
            }
            for (int i = 0; i < numCourses; i++) {
                if (indegrees[i] == 0) {
                    queue.offer(i);
                }
            }
            while (!queue.isEmpty()) {
                int currNode = queue.poll();
                list.add(currNode);
                for (int i = 0; i < n; i++) {
                    if (prerequisites[i][0] == currNode) {
                        indegrees[prerequisites[i][1]]--;
                        if (indegrees[prerequisites[i][1]] == 0) {
                            queue.offer(prerequisites[i][1]);
                        }
                    }
                }
            }
            if (list.size() != numCourses) {
                return new int[0];
            }
            for (int i = 0; i < numCourses; i++) {
                ret[i] = list.get(numCourses - 1 - i);
            }
            return ret;
        }
    }
    ```
[Back to TOC](#toc)



[^1]: https://www.wikiwand.com/en/Topological_sorting