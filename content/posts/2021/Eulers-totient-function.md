---
title: "오일러 피 함수(Euler's phi (totient) function)"
date: 2021-02-17T18:58:43+09:00
description: "오일러 피 함수(Euler's phi (totient) function)에 대한 설명과 증명"
categories:
    - Algorithm
tags:
    - 정수론
    - Problem solving
titlemath: "$$\\phi(n) = \\sum p_i^{a_i - 1} (p_i - 1)$$"
draft: true
---

오일러 피(파이) 함수 `$\phi(n)$`는 1부터 `$n$`까지 정수 중 `$n$`과 서로소인 수의 갯수를 세는 함수이다.

<!--more-->

## 공식

양의 정수 `$n$`에 대해 오일러 피 함수는 다음과 같이 정의된다.

`$$\phi(n) = \sum p_i^{a_i - 1} (p_i - 1)$$`

이때 각 `$p_i$`는 `$n$`의 소인수이고 `$a_i$`는 `$p_i$`의 차수이다. 즉 `$n$`을 소인수분해 하면 `$\prod p_i^{a_i}$`이다.

## 증명

#### step 1

`$n$`이 소수 `$p$`에 대해 `$n = p^k$`인 경우(소수의 `$k$`제곱수인 경우) `$\phi(n) = p^{k - 1} (p - 1)$`임을 증명한다.

1 이상 `$p^k$` 이하 정수이면서 `$p^k$`와 서로소가 **아니려면** 소인수로 `$p$`를 가지면 된다. 

따라서 `$p$`의 배수이면 되므로 이런 수는 `$p, 2p, 3p \space \cdots \space p^{k-1}p$`, 총 `$p^{k-1}$`개 이다.

`$$\therefore \phi(n) = p^k - p^{k - 1} = p^{k-1} (p - 1)$$`

#### step 2

오일러 피 함수가 곱셈적 함수(multiplicative function)임을 증명한다. 즉 `$m$`과 `$n$`이 서로소일 경우, `$\phi(mn) = \phi(m) \phi(n)$`임을 보인다.

먼저 1부터 `$mn$`까지 숫자를 나열하는 `$m * n$` 테이블을 그리고 여기서 `$mn$`과 서로소인 숫자가 몇 개인지 세어보자.

`$$
\begin{matrix}
1 & m + 1 & 2m + 1 & \cdots & (n-1)m + 1 \cr
2 & m + 2 & 2m + 2 & \cdots & (n-1)m + 2 \cr
3 & m + 3 & 2m + 3 & \cdots & (n-1)m + 3 \cr
\vdots & \vdots & \vdots & & \vdots \cr
m & 2m & 3m & \cdots & nm
\end{matrix}
$$`

이 테이블에서 `$r \text {-th row}$`의 값들은 `$km + r$`의 꼴이다. (`$0 \le k \le n - 1$`)

`$d = gcd(m, r)$`이라고 할 때 `$d \gt 1$`이면(`$m$`과 `$r$`이 서로소가 아니면) `$d \mid m$`이고 `$d \mid r$`이므로 `$d \mid km + r$`이고 `$d \mid mn$`이다. 즉 `$km + r$`과 `$mn$`은 공약수 `$d$`를 가진다.

따라서 `$m$`과 서로소가 **아닌** `$r$`에 대해 `$r \text {-th row}$`의 `$n$`개 값들은 **모두** `$mn$`과 서로소가 아니다. 

그러므로 `$mn$`과 서로소일 수도 있는 값들은 `$m$`과 서로소인 `$r$`에 대해 `$r \text {-th row}$`에 있다. 그리고 그런 `$\text{row}$`는 `$\phi(m)$`개 있음을 알고있다.

이제 그런 `$\text{row}$`마다 `$mn$`과 서로소인 값은 정확히 `$\phi(n)$`개 있음을 보이면 된다.

n개 값들 중 서로소인 `$r$`은  `$\phi(m)$`개 있다.


#### step 3

1보다 큰 양의 정수 n은 소수의 k제곱수들의 곱이므로 step 1, step 2의 결과에 의해 오일러 피 함수의 정당성을 증명하였다.

**출처**: [Loyola University Chicago 수업자료](http://gauss.math.luc.edu/greicius/Math201/Fall2012/Lectures/euler-phi.article.pdf)