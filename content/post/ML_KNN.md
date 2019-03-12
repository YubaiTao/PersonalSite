---
title:       "Machine Learning: K-Nearest-Neighbors"
subtitle:    ""
description: "Brief introduction to KNN"
date:        2019-03-12
author:      Yubai Tao
image:       "/img/voronoi.png"
showtoc:     false
tags:        ["MachineLearning"]
categories:  ["Tech" ]
---
# Machine Learning: K-Nearest-Neighbors

### Prediction algorithm
Given N examples $\\{x\_{(t)}, r\_{(t)}\\}^{N}\_{t=1}$ as $training\\_examples$. 

1. Given a instance $x\_{q}$ to be learned
2. Let $x^{*} \in training\\_example$ be closest $x\_{q}$ (k=1)
3. Return $r^{*}$

### Define distance between examples
Use an distance function, for instance

* For real-valued attributes, can use Euclidean distance
* For string-like attributes, can use Jaccard distance...

![caption](/img/knn.png)

### Noise & KNN
1-NN suffers from mis-labeled date, we need to smooth the output. <br>
Given N examples $\\{x\_{(t)}, r\_{(t)}\\}^{N}\_{t=1}$ as $training\\_examples$. 

1. Given a instance $x\_{q}$ to be learned
2. Find k closest training examples (relabel)
3. "*interpolate*" from those to produce the output

Some choice of interpolation:
* Majority vote (classification)
* Average (regression)
* Average weight inverse distance (regression)

Standard nearest neighbor sensitive to outliers, noise

* "Higher variance" for small k: intuitively, classifier can vary a lot depending on which examples happen to be in training set
* "Higher bias" for larger k

Issues:

* Features might have different ranges -- features with larger ranges will have more of an impact
  * Normalize to [0, 1]
  * Linearly scale to have 0 mean and variance 1
* Expensive to compute and store
* High dimension data noisy features can dominate

Advantages:

* No estimating parameters
* One hyperparameters to tune (k)
* Lazy -- no training involved
* New training examples easily added

