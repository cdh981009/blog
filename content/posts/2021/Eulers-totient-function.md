---
title: "오일러 피 함수(Euler's phi (totient) function)"
date: 2021-02-19T20:58:43+09:00
description: "오일러 피 함수(Euler's phi (totient) function)에 대한 설명과 증명"
categories:
    - Algorithm
tags:
    - 정수론
    - Problem solving
titlemath: "$$\\phi(n) = \\sum p_i^{a_i - 1} (p_i - 1)$$"
---

오일러 피(파이) 함수 `$\phi(n)$`는 `$1$`부터 `$n$`까지 정수 중 `$n$`과 서로소인 수의 개수를 세는 함수이다.

<!--more-->

## 공식

양의 정수 `$n$`에 대해 오일러 피 함수는 다음과 같이 정의된다.

`$$\phi(n) = \sum p_i^{a_i - 1} (p_i - 1)$$`

이때 각 `$p_i$`는 `$n$`의 소인수이고 `$a_i$`는 `$p_i$`의 차수이다. 즉 `$n$`을 소인수분해 하면 `$\prod p_i^{a_i}$`이다.

## 증명

#### Lemma 1. `$n$`이 소수 `$p$`에 대해 `$n = p^k$`인 경우 `$\phi(n) = p^{k - 1} (p - 1)$`이다.

`$1$` 이상 `$p^k$` 이하 정수이면서 `$p^k$`와 서로소가 **아니려면** 소인수로 `$p$`를 가지면 된다. 따라서 `$p$`의 배수이면 되므로 이런 수는 `$p, 2p, 3p \space \cdots \space p^{k-1}p$`, 총 `$p^{k-1}$`개 이다. 그러므로 `$n$`이 소수 `$p$`의 `$k$`제곱수인 경우 오일러 피 함수는 다음과 같이 정의된다.

`$$\therefore \phi(n) = p^k - p^{k - 1} = p^{k-1} (p - 1)$$`

#### Lemma 2. 오일러 피 함수는 곱셈적 함수(multiplicative function)이다.

`$m$`과 `$n$`이 서로소일 경우, `$\phi(mn) = \phi(m) \phi(n)$`임을 보일것이다.

`$m$`과 `$n$`이 서로소라고 하자. 이때 `$1$`부터 `$mn$`까지 숫자를 나열하는 `$m * n$` 테이블을 그리고, 이 테이블에서 `$mn$`과 서로소인 숫자가 몇 개인지 세면 그 값이 `$\phi(mn)$`이다.

`$$
\begin{matrix}
1 & m + 1 & 2m + 1 & \cdots & (n-1)m + 1 \cr
2 & m + 2 & 2m + 2 & \cdots & (n-1)m + 2 \cr
3 & m + 3 & 2m + 3 & \cdots & (n-1)m + 3 \cr
\vdots & \vdots & \vdots & & \vdots \cr
m & 2m & 3m & \cdots & nm
\end{matrix}
$$`

테이블에서 `$r \text {th row}$`의 값들은 `$km + r$`의 꼴이다. (`$0 \le k \le n - 1$`)

`$d = gcd(m, r) > 1$`인 경우 `$d = gcd(m, r) = gcd(m, km + r)$`이므로(`$\because$` 유클리드 호제법) `$km + r$`과 `$mn$`은 공약수 `$d$`를 가진다. 따라서 이 경우 `$r \text {-th row}$`의 수들은 **모두** `$mn$`과 서로소가 아니다.

반대로 `$d = gcd(m, r) = 1$`인 경우 `$d = gcd(m, r) = gcd(m, km + r) = 1$`이므로 `$km + r$`는 `$m$`과 서로소이다. 따라서 이런 `$\text{row}$`에서 `$n$`과도 서로소인 수는 `$mn$`과 서로소이다. 그리고 그런 `$\text{row}$`는 `$\phi(m)$`개 있음을 알고 있다. 이제 각 `$\text{row}$`마다 `$n$`과 서로소인 수는 정확히 `$\phi(n)$`개 있음을 보이면 된다.

`$r \text {th row}$`의 수들은 다음과 같은데, `$r$`에 `$m$`을 더하는 것을 `$n-1$`번 반복하는 꼴이다.

`$$r, \space m + r, \space 2m + r \space \cdots \space (n-1)m + r$$`

`$m$`과 `$n$`이 서로소이므로, 이 수들을 `$\bmod n$`하면 `$0$`부터 `$n - 1$`까지의 수가 정확히 한 번씩 나오게 된다. (이빨의 개수가 서로소인 두 개의 톱니바퀴가 맞물려 돌아가는 것을 떠올려보라.)

`$gcd(x + kn, n) = gcd(x, n)$`이므로 `$\bmod n$`한 값이 `$n$`과 서로소라면 원래 값도 `$n$`과 서로소이고, 그 이도 성립한다. `$1$`부터 `$n \space ( \equiv 0 \bmod n)$`까지 정수 중 `$n$`과 서로소인 수는 `$\phi(n)$`개 있으므로, 각 `$\text{row}$`마다 `$n$`과 서로소인 수는 정확히 `$\phi(n)$`개 있다.

결론적으로 `$1$`부터 `$mn$`까지 숫자를 나열한 `$m * n$` 테이블에서, `$mn$`과 서로소인 수가 포함된 `$\text{row}$`는 `$\phi(m)$`개이고 해당 `$\text{row}$`마다 `$mn$`과 서로소인 수는 `$\phi(n)$`개이다.

`$$ \therefore \phi(mn) = \phi(m) \phi(n)$$`

#### Theorem 1. 모든 양의 정수 `$n$`에 대해 `$\phi(n) = \sum p_i^{a_i - 1} (p_i - 1)$`이다.

`$n = 1$`인 경우는 자명하고, `$1$`보다 큰 양의 정수 `$n$`은 소수의 `$k$`제곱수들의 곱이므로, **Lemma 1, 2**의 결과에 따라 오일러 피 함수의 정당성을 증명하였다.

<br/><br/>
**출처**: [Loyola University Chicago 수업자료](http://gauss.math.luc.edu/greicius/Math201/Fall2012/Lectures/euler-phi.article.pdf)