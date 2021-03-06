---
title:       "Trie Problem Series"
subtitle:    ""
description: "Collection of Trie Problems"
date:        2019-06-05
author:      Yubai Tao
image:       "img/trie.jpg"
showtoc:     false
tags:        ["Algorithm"]
categories:  ["Tech" ]
---
## Trie Problem Series

* LC 472 *Concatenated Words*
<br>: Given a dictionary, find all words that 
can be concatenated by other words in the dict.
<br> Use a trie structure to save all the words,
find all valid words in DFS fashion.
    ```java
    public class ConcatenatedWords_ {
        public List<String> findAllConcatenatedWordsInADict(String[] words) {
            List<String> res = new ArrayList<>();
            if (words == null || words.length == 0) {
                return res;
            }
            TrieNode root = new TrieNode();
            for (String word : words) { // construct Trie tree
                if (word.length() == 0) {
                    continue;
                }
                addWord(word, root);
            }
            for (String word : words) { // test word is a concatenated word or not
                if (word.length() == 0) {
                    continue;
                }
                if (testWord(word.toCharArray(), 0, root, 0)) {
                    res.add(word);
                }
            }
            return res;
        }
    
        private boolean testWord(char[] chars, int index, TrieNode root, int count) { // count means how many words during the search path
            TrieNode cur = root;
            int n = chars.length;
            for (int i = index; i < n; i++) {
                if (cur.sons[chars[i] - 'a'] == null) {
                    return false;
                }
                if (cur.sons[chars[i] - 'a'].isEnd) {
                    if (i == n - 1) { // no next word, so test count to get result.
                        return count >= 1;
                    }
                    if (testWord(chars, i + 1, root, count + 1)) {
                        return true;
                    }
                }
                cur = cur.sons[chars[i] - 'a'];
            }
            return false;
        }
    
        private void addWord(String str, TrieNode root) {
            char[] chars = str.toCharArray();
            TrieNode cur = root;
            for (char c : chars) {
                if (cur.sons[c - 'a'] == null) {
                    cur.sons[c - 'a'] = new TrieNode();
                }
                cur = cur.sons[c - 'a'];
            }
            cur.isEnd = true;
        }
    
        private static class TrieNode {
            TrieNode[] sons;
            boolean isEnd;
            TrieNode() {
                sons = new TrieNode[26];
            }
        }
    }
    ```