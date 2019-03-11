---
title:       "Machine Learning: Bayesian Decision Theory"
subtitle:    ""
description: ""
date:        2019-03-11
author:      Yubai Tao
image:       "img/bayes.jpg"
showtoc:     false
tags:        ["MachineLearning"]
categories:  ["Tech" ]
---
# Machine Learning: Bayesian Decision Theory

### Preliminary: Probability theory

* Sum rule: 
$$ p(x) = \sum\_{y}{p(x, y)} $$
* Chain rule (product rule):
$$ p(x, y) = p(y|x)p(x) $$
$$ p(x, y, z) = p(y | x,z)p(x|z)p(z) $$

* Bayes Theorem (Bayes's Rule):
$$ p(y|x) = \frac{p(x|y)p(y)}{p(x)} $$
$$ p(y|x,z) = \frac{p(x,z|y)p(y)}{p(x,z)} $$

* Using sum and product rule:
$$ p(x) = \sum\_{y}{p(x|y)p(y)} $$

* Conditionally independent: **x** and **z** are independent given **y** if:
$$ p(x|y,z) = p(x|y) $$

### Naive Bayes Classifier

##### Why "naive"?
In order to apply Bayes rule, we must assume that **Conditional independence among features** (all features are independently and idnetically distributed aka iid), which is a strong assumption.

##### Bayes's Rule
$$ p(y|x)=\frac{p(y)p(x|y)}{p(x)} $$
p(x) is independent of y.

* *p(y|x)*: posterior
* *p(y)*: prior
* *p(x|y)*: likelihood
* *p(x)*: evidence (marginal likelihood)

$$ posterior = \frac{prior \times likelihood}{evidence} $$

##### ML & MAP

* MAP (Maximum a-posterior) hypothesis is the *y* that maximizes *p(y)p(x|y)*
* ML (Maximum likelihood) hypothesis is the *y* that maximizes *p(x|y)*

MAP hypothesis is the same as the ML hypothesis if the priors are the same.

* MAP: $$ \mathop{argmax}\_{y}p(y|x)= \mathop{argmax}\_{y}p(x|y)p(y) $$
