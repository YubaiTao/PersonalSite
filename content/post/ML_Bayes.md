---
title:       "Machine Learning: Bayesian Decision Theory"
subtitle:    ""
description: "Brief introduction to Bayes Classifier"
date:        2019-03-11
author:      Yubai Tao
image:       "img/bayes.jpg"
showtoc:     true
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

#### Why "naive"?
In order to apply Bayes rule, we must assume that **Conditional independence among features**, which is a strong assumption.

#### Bayes's Rule
$$ p(y|x)=\frac{p(y)p(x|y)}{p(x)} $$
p(x) is independent of y.

* *p(y|x)*: posterior
* *p(y)*: prior
* *p(x|y)*: likelihood
* *p(x)*: evidence (marginal likelihood)

$$ posterior = \frac{prior \times likelihood}{evidence} $$

Generalized formula:
$$ p(Y = y\_k)=\frac{p(Y=y\_k)\prod\_{i}p(x\_i|Y=y\_{k})}
{\sum\_{j}p(Y=y\_j)\prod\_{i}p(x\_i|y\_j)} $$

#### ML & MAP

* MAP (Maximum a-posterior) hypothesis is the *y* that maximizes *p(y)p(x|y)*
* ML (Maximum likelihood) hypothesis is the *y* that maximizes *p(x|y)*

MAP hypothesis is the same as the ML hypothesis if the priors are the same.

* MAP: $$ \mathop{argmax}\_{y}p(y|x)= \mathop{argmax}\_{y}p(x|y)p(y) $$

#### Smoothing
* Why use it? 
  * Estimating that $p(x\_i|C)=0$ is dangerous (can lead numerator to zero)
  * Use "smoothed" estimates that are never equal to 0
* Add m smoothing
  $$ p(x\_i=v|C)=\frac{t+m}{N+ms} $$
  
where $s$ is the number of possible attributes for $x\_i$

#### Gaussian Bayes Classifier
Assume $p(x|y)$ is a Gaussian distribution:
$$ p(x|C) = \frac{1}{\sqrt{2\pi \sigma^{2}}}
exp(-\frac{{(x - \mu)}^{2}}{2\sigma^{2}}) $$
$$ \mu = \frac{1}{N}\sum\_{i=1}^{N}x^{(i)} $$
$$ \sigma\_{2} = \frac{1}{N}\sum\_{i=1}^{N}{(x^{(i)}-\mu)}^{2} $$

When using Gaussian Bayes classifier, we apply $log()$ function to the estimate function (ML/MAP) for convinence.

--- 

### An Example Problem
Suppose there are two types of screenings that are used to detect whether a person has a certain disease. Screening method 1 is a blood test which is fast and inexpensive, but not very accurate. It has a 15% false positive rate, and a 10% false negative rate. 

Screening method 2 is based on doing an MRI of the patient. It is expensive and takes more time. It has a 5% false positive rate, and a 3% false negative rate.

The "false positive rate" is the probability that the method mistakenly returns a positive result (says the person has the disease), when the person does not have the disease. The \false negative rate" is the probability that the method mistakenly returns a negative result (says the person doesn't have the disease), when the person does have the disease.

Suppose that 0.02% of the population has this disease.

1. Suppose a random person from the population is screened using Screening method 1, and it returns a positive result. Using a Bayesian approach, which is the MAP hypothesis: that the person has the disease, or that the person does not have the disease?

    $P(D)=0.0002\quad P(\bar{D})=0.998$<br>
    $P(pos\_1|\bar{D})=0.15\quad P(neg\_1|\bar{D})=0.85$ <br>
    $P(pos\_1|D)=0.9\quad P(neg\_1|D)=0.1$ <br>
    $P(pos\_2|\bar{D})=0.05\quad P(neg\_2|\bar{D})=0.95$ <br>
    $P(pos\_2|D)=0.97\quad P(neg\_2|D)=0.03$ <br>
    <br>
    $P(D|pos\_1)=P(D)P(pos\_1|D)/P(pos\_1)=0.00018/P(pos\_1)$<br>
    $P(\bar{D}|pos\_1)=P(\bar{D})P(pos\_1|\bar{D})/P(pos\_1)=0.14997/P(pos\_1)$<br>
    Since $P(\bar{D}|pos\_1)>P(D|pos1)$, so the MAP hypothesis is that the patient does not have the disease.
   
2. Repeat the previous question, but give the ML hypothesis.
   
    $P(pos\_1|D)=0.9$<br>
    $P(pos\_1|\bar{D})=0.15$<br>
    Since $P(pos\_1|D)>P(pos\_1|\bar{D})$, so the ML hypothesis is that the patient has the disease.
   
3. Now suppose that because the person had a positive result using Screening method 1, the person is then sent to be screened using Screening method 2. If the result is positive again, what is the posterior probability that the person has the disease? Assume the results of the two screening methods are independent.

     $$x=\{pos\_1, pos\_2\}$$
     $$P(x|D)P(D)=P(pos\_1|D)P(pos\_2|D)P(D)$$
     $$P(x|\bar{D})P(\bar{D})=P(pos\_1|\bar{D})P(pos\_2|\bar{D})P(\bar{D})$$
     $$P(D|x)=\frac{P(x|D)P(D)}{P(x|D)P(D)+P(x|\bar{D})P(\bar{D})}=0.0227548$$


