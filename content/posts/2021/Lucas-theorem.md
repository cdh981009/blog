---
title: "뤼카의 정리(Lucas' theorem)"
date: 2021-02-11T22:36:43+09:00
description: "뤼카의 정리(Lucas' theorem)에 대한 설명과 증명"
categories:
    - Algorithm
tags:
    - 정수론
    - Problem solving
titlemath: "$$\\binom m n \\equiv \\prod_{i=0}^k \\binom {m_i} {n_i} \\pmod p $$"
---

뤼카의 정리는 음이 아닌 정수 `$m, n$` 소수 `$p$`에 대해 `$\binom m n \bmod p$`를 쉽게 구할 수 있게 해주는 정리다.

<!--more-->

## 공식

음이 아닌 정수 `$m, n$` 소수 `$p$`에 대해 뤼카의 정리는 다음과 같다.

`$$\binom m n \equiv \prod_{i=0}^k \binom {m_i} {n_i} \pmod p $$`

이때 `$m$`과 `$n$`은 각각 다음과 같다.

`$$m = m_k p^k + m_{k-1}p^{k-1} + \cdots + m_1 p + m_0$$`

`$$n = n_k p^k + n_{k-1}p^{k-1} + \cdots + n_1 p + n_0$$`

## 사용

아주 큰 숫자 `$m, n$`에 대해 이항 계수 `$\binom m n$`을 구해야 하나 정확한 값을 알 필요는 없고 적당히 작은 소수 `$p$`로 나눈 나머지만 알면 될 때 사용할 수 있다.

## 증명

#### step 1.

`$p$`가 소수이고 `$n$`이 `$1 \le n \le p - 1$`인 정수일 때, 이항 계수 `$\binom p n$`은 다음과 같다.

`$$\binom p n = {{p \cdot (p - 1) \cdots (p - n - 1)} \over {n \cdot (n - 1) \cdots 1}} $$`

이 식의 분모는 `$p$`로 나누어 떨어지지 않고(`$\because n \le p - 1$`, `$p$`는 소수) 분자는 `$p$`로 나누어 떨어진다. 따라서 `$p \mid \binom p n$`이고 이를 통해 다음 식을 얻을 수 있다.

`$$(1 + X)^p \equiv 1 + X^p \pmod p$$`

위 식의 양 변에 `$p$`제곱을 하는 귀납법을 통해 모든 음수가 아닌 `$i$`에 대해 다음이 성립한다.

`$$(1 + X)^{p^i} \equiv 1 + X^{p^i} \pmod p$$`

#### step 2.

결론부터 말하자면 다음을 보일 것이다.

`$$
\sum_{n=0}^m {\binom m n}X^n \equiv \sum_{n=0}^m \left(\prod_{i=0}^k \binom {m_i} {n_i}\right) X^n \pmod p
$$`

음수가 아닌 정수 `$m$`과 소수 `$p$`가 있다고 하자. 이때 `$m$`을 다음과 같이 표현할 수 있다.

`$$m = \sum_{i=0}^k m_i p^i \hspace2ex {(0 \le m_i \le p-1)}$$`

step 1의 결과를 이용하면

`$$
\eqalign {
\sum_{n=0}^m {\binom m n}X^n &= (1 + X)^m \\
    &= \prod_{i=0}^k\left((1 + X)^{p^i}\right)^{m_i} \\
    &\equiv \prod_{i=0}^k(1 + X^{p^i})^{m_i} \\
    &= (1+X^{p^0})^{m_0} (1+X^{p^1})^{m_1} \cdots (1+X^{p^k})^{m_k}
}
$$`

위 식에서 어떤 `$n$`에 대해 `$X^n$`의 계수를 구하고 싶다. 이때 `$n$`역시 다음과 같이 표현할 수 있다.

`$$n = \sum_{i=0}^k n_i p^i \hspace2ex {(0 \le n_i \le p-1)}$$`

따라서 `$X^n$`를 만들기 위해선 각 `$X^{p^i}$`가 `$n_i$`번 곱해진 후 전체가 모두 곱해져야 한다.

`$(1 + X^{p^i})^{m_i}$`에서 `$X^{p^i n_i}$`의 계수는 `$\binom {m_i} {n_i}$`이므로 `$X^n$`의 계수는 `$\prod_{i=0}^k \binom {m_i} {n_i}$`이다.

그러므로

`$$
\eqalign {
\prod_{i=0}^k(1 + X^{p^i})^{m_i}
    &= (1+X^{p^0})^{m_0} (1+X^{p^1})^{m_1} \cdots (1+X^{p^k})^{m_k} \\
    &= \sum_{n=0}^m \left(\prod_{i=0}^k \binom {m_i} {n_i}\right) X^n
}
$$`

정리하면 다음 식을 얻는다.

`$$
\sum_{n=0}^m {\binom m n}X^n \equiv \sum_{n=0}^m \left(\prod_{i=0}^k \binom {m_i} {n_i}\right) X^n \pmod p
$$`

임의의 `$n \space (1 \le n \le m)$`에 대해 양 변의 `$X^n$`의 계수가 합동이므로 결론적으로 우리가 원하는 합동식을 얻을 수 있다.

`$$ \therefore \binom m n \equiv \prod_{i=0}^k \binom {m_i} {n_i} \pmod p $$`

**출처**: [위키백과](https://en.wikipedia.org/wiki/Lucas%27s_theorem)