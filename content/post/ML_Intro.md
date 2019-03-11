---
title:       "Machine Learning: Intro"
subtitle:    ""
description: ""
date:        2019-03-11
author:      Yubai Tao
image:       ""
showtoc:     false
tags:        ["MachineLearning"]
categories:  ["Tech" ]
---
# Machine Learning: Intro

### Types of Learning

* Supervised Learning
  * Classification
  * Regression
* Unsupervised Learning
* Reinforcement Learning

### Supervised Learning
* Classification
  * Given examples lableled by class, learn to place new examples in correct class
* Regression
  * Given input/output pairs, where output is real-valued, learn to predict oiutput given new input

Given: Training examples of form **{x, f(x)}** for some unknown function **f**
<br>
Goal: Output hypothesis **h** that is equal to **f**, or that is a good approximation to **f**.

Or more generally, given new **x**, predict value of **f(x)**
<br>
In classification, **f(x)** is the class that **x** belongs to.
<br>
In regression, **f(x)** is the real-valued output, for input **x**.

### Unsupervised Learning
* Learning "what normally happens"
* No label/output
* Clustering: Grouping similar instances

### Reinforcement Learning
* In some applications, the output of the system is a sequence of actions.
In such a case, a single action is not important; what is important is the
policy that is the sequence of correct actions to reach the goal. There is
no such thing as the best action in any intermediate state; an action is
good if it is part of a good policy. In such a case, the machine learning
program should be able to assess the goodness of policies and learn from
past good action sequences to be able to generate a policy. Such learning
reinforcement methods are called reinforcement learning algorithms.

* Example: game playing, singe move by itself is not that important; it is the sequence of right moves that is good.


