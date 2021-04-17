---
title: "Splay Tree 2. 시간복잡도의 증명"
date: 2021-04-12T23:50:50+09:00
description: "Splay Tree의 amortized 시간복잡도의 증명"
categories:
    - Algorithm
tags:
    - Amortized analysis
    - BST
    - Data structure
    - Problem solving
draft: true
titlemath: "$$a_i = c_i + \\Phi(s_i) - \\Phi(s_{i-1})$$"
---

Splay tree는 비교적 간단한 동작 방식을 가지고 있다. 단순히 접근한 노드를 splay할 뿐인데 어떻게 각 쿼리가 (쿼리의 개수가 충분히 많을 때) `$amortized \space O(\log n)$`의 시간복잡도를 가질 수 있는 것일까?

<!--more-->

사실, splay tree는 그 단순한 구조에 비해 시간복잡도의 증명이 꽤나 어렵다. 정당성에 대한 이해 없이 자료구조를 쓰는 것이 마음이 불편해 공부하기 시작했지만, 배울 내용이 생각보다 많고 어려워 포기하고 싶었던 적도 있었다. 하지만 열심히 독학한 지식이고, 웹상에 한글로 적힌 관련 정보도 많지 않은 것 같아 글로 남긴다.

## Amortized analysis란?

Splay tree의 시간복잡도를 분석하기 위해서는 먼저 **amortized analysis**(분할상환분석)가 무엇인지에 대한 이해가 필요하다. Amortized analysis란, 일련의 연산으로 구성된 알고리즘의 시간복잡도를 분석할 때, 각 연산의 시간복잡도를 따로 구한 후 합하는 것이 아니라 일련의 연산을 **전체로 보았을 때** 시간복잡도를 구하는 것이라고 할 수 있다.

예를 들어 C++의 vector같은 자료구조에 `$n$`개의 원소를 넣는 것의 시간복잡도를 생각해보자. 대부분은 `$O(1)$`의 비용으로 삽입을 처리할 수 있지만, 할당된 공간이 꽉 차면 2배 크기의 새로운 공간으로 기존 원소들을 모두 이동해야 하므로, 삽입 한 번에 `$O(n)$`의 비용이 들 것이다. 그렇다고 해서 vector에 `$n$`개의 원소를 넣는 것의 시간복잡도를 `$O(n^2)$`라고 한다면 실제 실행시간을 반영하지 못하는 분석일 것이다. 대신 우리는 Amortized analysis를 통해 `$n$`개의 삽입 연산 **전체**의 시간복잡도는 `$O(n)$`이라는 결과를 도출해 낼 수 있다. 즉, 삽입 연산 하나는 `$amortized \space O(1)$`의 시간복잡도를 가진다는 뜻이다.

Amortized analysis에는 일반적으로 3가지의 종류, **aggregate method**, **accounting method**, **potential method**가 있다. 세 종류의 분석 모두 문제를 바라보는 시각이 다를 뿐 같은 분석 결과를 낼 수 있다. Splay tree의 연산을 Amortized analysis할 때는 potential method를 사용하지만, 깊은 이해를 위해 세가지를 모두 살펴보도록 하자.

세 종류의 분석을 좀 더 잘 이해하기 위해 binary counter 문제를 예로 들어보자. 이진수로 된 숫자를 바꿀 때 드는 cost를 값이 바뀌는 비트의 개수라고 가정하자. 이 때 1씩 더해가며 0부터 `$n$`까지의 숫자를 셀 때, 1씩 더하는 연산의 amortized cost(분할상환 비용)는 어떻게 될까?

#### 1. Aggregate method
**Aggregate method**는 모든 연산의 비용을 합한 후 연산의 갯수로 나눠 각 연산의 amortized cost를 구한다.

가장 하위 비트는 매 연산마다 값이 `$0, 1, 0, 1\dots$`로 바뀌기 때문에 모든 연산에서 총 `$n$`의 비용이 든다. 두번 째 비트는 두번의 연산마다 바뀌기 때문에 최대 `$n / 2$`의 비용이 든다. 일반화 하면 `$i$`번 째 비트는 `$2^{i-1}$`번의 연산마다 값이 바뀌므로 최대 `$n / 2^{i-1}$`의 비용이 든다. 따라서 모든 연산에서 드는 비용의 총 합은 최대

`$$ n + {n \over 2} + {n \over 4} + \cdots = 2n$$`

연산의 개수는 `$n$`개 이므로 `$2n / n = 2$`. 각 연산의 amortized cost는 `$O(1)$`임을 알 수 있다.

#### 2. Accounting method
**Accounting method**는 **통장**에 비용을 미리 넣어 놓았다가 나중에 꺼내서 쓰는 것으로 비유할 수 있다. 맨 처음에 통장에 든 돈은 0이다.

이진수에 1을 더했을 때 비트들의 값이 바뀌는 것을 관찰하면, 0개 이상의 연속된 1들이 0으로 바뀐 후 정확히 하나의 0이 1로 바뀐다는 것을 알 수 있다. 0이 1로 바뀔 때에는 1의 비용을 지불하고, 추가적으로 새로 생긴 1이 언젠가 0으로 바뀔 때를 대비해 1의 비용을 미리 통장에 넣어놓는다고 하자. 1이 0으로 바뀔 때에는 과거에 통장에 넣어놓은 비용을 꺼내서 쓴다고 하면, 한번의 연산에서 실제로 지불하는 비용은 2이다. 따라서 연산 한개의 amortized cost는 `$O(1)$`임을 알 수 있다.

#### 3. Potential method
**Potential method**는 accounting method의 "통장"을 자료구조의 상태에 따른 함수(potential function)로 나타내는 것이다. 이 때 연산 한개의 amortized cost는 real cost와 potential의 변화의 합으로 정의할 수 있다.

`$$amortized \space cost = real \space cost \space + \space \Delta potential$$`

식을 좀 더 엄밀하게 정의해보자. 알고리즘이 `$n$`개의 연산 `$\sigma_1, \sigma_2, \dots, \sigma_n$`을 어떤 자료구조에 행한다고 하자. 그러면 자료구조는 상태 `$s_0, s_1, \dots, s_n$`을 거쳐갈 것이고, 이에 따라서 potential function `$\Phi(s)$`도 `$\Phi(s_0), \Phi(s_1), \dots, \Phi(s_n)$`로 변할 것이다. `$i$`번 째 연산 `$\sigma_i$`의 real cost를 `$c_i$`, Amortized cost를 `$a_i$`라고 하면,

`$$a_i = c_i + \Phi(s_i) - \Phi(s_{i-1})$$`

이 식을 모든 연산(모든 `$i$`)에 대해 합하면 다음을 얻는다.

`$$\sum_i a_i = \sum_i (c_i + \Phi(s_i) - \Phi(s_{i-1})) =  (\sum_i c_i) + \Phi(s_n) - \Phi(s_0)$$`

즉 amortized cost의 합은 real cost의 합과 알고리즘 전체에서  potential 변화의 합이다. 식을 다음과 같이 표현할 수도 있다.

`$$\sum_i c_i = (\sum_i a_i) + \Phi(s_0) - \Phi(s_n)$$`

Amortized cost의 합과 real cost의 합은 `$\Phi(s_0) - \Phi(s_n)$`만큼의 오차가 있다. 우리가 최종적으로 얻기 원하는 것은 `$O(\sum c_i)$`이므로 이 오차를 알아야 한다. 만약 `$\Phi(s_0) - \Phi(s_n) \le 0$`이라면, 즉 알고리즘이 끝난 후 `$\Phi$`가 초기 값과 같거나 초기 값보다 증가한다면 다음이 성립한다.

`$$\sum_i c_i \le \sum_i a_i$$`

따라서 amortized cost의 합이 real cost의 합의 upper bound라고 할 수 있다. 반대로 `$\Phi(s_0) - \Phi(s_n) \gt 0$`라면 `$O(\Phi(s_0) - \Phi(s_n))$`를 구하는 작업이 필요하다. `$O(\Phi(s_0) - \Phi(s_n))$`과 `$O(\sum a_i)$`를 알면 `$O(\sum c_i)$`를 구할 수 있다.

Binary counter 예시에서 potential function을 이진수에서 값 1을 가진 비트의 개수로 하자. 0이 1로 바뀌면 potential이 1 증가하고, 반대로 1이 0으로 바뀌면 potential이 1 감소한다. Real cost는 연산에서 값이 바뀌는 비트의 실제 개수이므로, (0이 1로 바뀌는 개수) + (1이 0으로 바뀌는 개수)이다. 그런데 1이 0으로 바뀌는 개수 만큼 potential이 감소하므로 서로 숫자가 상쇄된다. 0이 1로 바뀌는 개수는 1이고 potential도 1 증가하므로, 결론적으로 amortized cost는 `$1 + 1 = 2 = O(1)$`이다. 이 때 `$\Phi(s_0) \le \Phi(s_n)$`이므로, `$\sum c_i \le \sum a_i$`가 성립하고, 따라서 `$\sum c_i = O(n)$`임을 알 수 있다.

##### Potential function은 어떤 기준으로 정하나?

여기서 potential function을 어떻게 정의해야 하냐는 의문점이 들 수 있다. 놀라운 점은 potential function은 실제로 존재하는 값이 아니라 분석을 위해 임의로 만든 개념이기 때문에, 분할상환분석을 하는 사람이 **임의로 정할 수 있다**는 것이다. 다만 너무 작은 함수를 택하면 식에서 의미 있는 정보를 도출할 수 없을 것이고, 너무 큰 함수를 택하면 분석한 시간복잡도가 tight 하지 않게 될 것이다. 따라서 적절한 potential function은 자료 구조의 상태를 잘 나타내는 값이 되어야 한다.

적절하지 못한 potential function을 binary counter를 분석하는 데 사용해보자. Potential을 항상 0으로 두면 어떻게 될까? 즉, `$\Phi = 0$`이라고 하자. 이제 위에서 했던 것 처럼 1이 0으로 바뀌는 개수를 potential의 감소값으로 상쇄할 수 없다. 식이 단순히 `$a_i = c_i$`가 되어버리므로 아무 유용한 정보도 얻을 수 없게 된다. (물론 우리는 aggregate method를 통해 `$\sum c_i$`를 이미 알고 있지만, potential method를 사용하는 동안은 모른다고 하자.)

이번엔 potential function을 현재 이진수 숫자의 제곱으로 정의해보자. 즉, `$\Phi(s_i) = i^2$`이다. Potential이 증가하기만 하므로 역시 상쇄되는 항이 없다. 다음 식을 유도할 수는 있지만 tight하지 않은 시간복잡도를 얻는다.

`$$
\eqalign {
\sum_i a_i &= (\sum_i c_i) + \Phi(s_n) - \Phi(s_0) \\
    &= (\sum_i c_i) + n^2 \\
    &= O(n \log n) + O(n^2) = O(n^2)
}
$$`

두 가지 적절하지 않게 선택된 potential의 예에서 볼 수 있듯이, potential method를 사용해 amortized analysis를 할 때는 좋은 potential function을 고르는 것이 중요하다.

## Splay 연산의 amortized time complexity

이제 potential method를 이용해 splay 연산의 amortized cost를 구해보자. Splay tree의 potential function을 정의하기 위해 몇 가지 값들을 먼저 정의해야 한다. Splay tree의 각 노드 `$x$`는 양의 실수 **weight** `$w(x)$`를 가지는데, 이 값은 임의로 정할 수 있지만 한번 정해지면 바뀌지 않는다. 이 값이 어떻게 되든 분석엔 영향이 없지만, 직관적으로는 `$w(x)$`를 노드 `$x$`가 접근될 확률로 생각해도 좋다. 각 노드 `$x$`의 **size** `$s(x)$`는 자신의 subtree의 weight의 합으로 정의한다. 각 노드 `$x$`의 **rank** `$r(x)$`는 `$\log s(x)$`으로 정의한다. 마지막으로, 트리의 **potential**은 모든 노드의 rank의 합으로 정의한다.

#### 왜 이렇게 potential을 정의했는가

Potential을 왜 이렇게 정의했는지 (엄밀하지는 않지만) 직관적으로 이해해 볼 수 있다. 트리의 각 노드 `$x_i$`에 대해 **path length** `$l_i$`를 루트로부터 `$x_i$`까지의 거리로 정의하자. 그러면 트리 전체의 **weighted path length**는 `$\sum w_i l_i$`이다. `$w_i$`에 노드 `$x_i$`가 접근될 확률을 대입하면, BST의 임의의 노드에 접근 연산을 할 때 드는 비용의 기댓값은 다음과 같다.

`$$O(1 + \sum_{i=1} ^n w_i l_i)$$`

이제 모든 노드의 size `$s(x_i)$`를 모두 합해보자. 각 `$s(x_i)$`는 자신의 subtree 노드들의 `$w$`를 포함하므로, `$\sum s(x_i)$`에는 노드 `$x_i$`의 `$w_i$`가 (`$x_i$`의 조상의 개수 + 1)개 만큼 포함된다. `$x_i$`의 조상의 개수는 `$l_i$`과 같으므로, 다음 식을 얻는다.

`$$\sum_{i=1} ^n s(x_i) = \sum_{i=1} ^n w_i (l_i + 1)$$`

따라서 `$\sum s(x_i)$`를 작게 유지한다는 것은 접근 연산의 비용의 기댓값을 작게 유지할 수 있다는 뜻이다. 실제로는 `$\sum s(x_i)$`가 아닌 `$\sum \log s(x_i) = \sum r(x_i)$`를 potential function으로 두고 분석을 진행한다.

#### Access Lemma

Splay 연산의 real cost는 splay 연산 중 일어나는 rotation의 개수로 하자. 만약 splay 하는 노드가 이미 루트여서 rotation이 없다고 하면 연산 자체 비용 1을 부여한다. 앞에서 설명한 potential method의 다음 식을 이용해 amortized time의 upper bound를 구할 것이다.

`$$a_i = c_i + \Phi(s_i) - \Phi(s_{i-1})$$`

Splay 연산의 amortized cost는 **Access Lemma**를 증명해 얻을 수 있다.

###### Access Lemma. 루트가 `$t$`인 트리에서 노드 `$x$`를 splay 하는 것의 amortized cost는 최대 다음과 같다:

`$$3(r(t) - r(x)) + 1 = O(\log(s(t)/s(x)))$$`

Rotation이 없을 때 bound는 자명하므로 rotation이 한 번 이상 발생할 때를 가정하자. Splay에서 한개의 step을 고려해보자. **zig**, **zig-zig**, **zig-zag**중 하나가 실행된다. 이 때 `$s$`, `$r$`은 스텝 직전의 size와 rank, `$s'$`, `$r'$`은 스텝 직후의 size와 rank를 뜻한다고 하자. 우리는 zig의 amortized time이 최대 `$3(r'(x) - r(x)) + 1$`이고, zig-zig, zig-zag는 최대 `$3(r'(x) - r(x))$`임을 보일 것이다. `$x$`의 부모를 `$y$`, `$y$`의 부모를 (있다면) `$z$`라고 하자.

**1. zig**: 한번의 rotation이 일어나므로 amortized time은
`$$
\eqalign {
&1 + r'(x) + r'(y) - r(x) - r(y) \\
\le& 1 + r'(x) - r(x) &(\because r'(y) - r(y) \le 0) \\
\le& 1 + 3(r'(x) - r(x)) &(\because r'(x) - r(x) \ge 0)
}
$$` 
![zig-step](/images/blog/2021/04/zig-2.png#center)

**2. zig-zig**: 두번의 rotation이 일어나므로 amortized time은
`$$
\eqalign {
&2 + r'(x) + r'(y) + r'(z) - r(x) - r(y) - r(z) \\
=& 2 + r'(y) + r'(z) - r(x) - r(y) &(\because r'(x) = r(z)) \\
\le& 2 + r'(x) + r'(z) - 2 r(x) &(\because r'(x) \ge r'(y) \text{  and  } r(y) \ge r(x))
}
$$`

![zig-zig-step](/images/blog/2021/04/zig-zig-2.png#center)  

이제 다음을 보일것이다.

`$$
\eqalign {
2 + r'(x) + r'(z) - 2 r(x) &\le 3(r'(x) - r(x))\\
-2r'(x) + r'(z) + r(x) &\le -2\\
\log (s'(z)/s'(x)) + \log(s(x)/s'(x)) &\le -2
}
$$`

이 때 `$s'(z) + s(x) \le s'(x)$`이므로 `$s'(z)/s'(x) + s(x)/s'(x) \le 1$`이다. `$x + y \le 1$`일 때 `$xy$`의 최대 값은 둘 다 `$1/2$`일 때 `$1/4$`이므로 `$\log (s'(z)/s'(x)) + \log(s(x)/s'(x)) \le -2$`가 성립한다. 따라서 위의 식을 보였다.

**3. zig-zag**: amortized time은

`$$
\eqalign {
&2 + r'(x) + r'(y) + r'(z) - r(x) - r(y) - r(z) \\
=& 2 + r'(y) + r'(z) - r(x) - r(y) &(\because r'(x) = r(z)) \\
\le& 2 + r'(y) + r'(z) - 2 r(x) &(\because r(y) \ge r(x))
}
$$` 

![zig-zag-step](/images/blog/2021/04/zig-zag-2.png#center)  

이제 다음을 보일것이다.

`$$
\eqalign {
2 + r'(y) + r'(z) - 2 r(x) &\le 2(r'(x) - r(x)) \\
-2r'(x) + r'(y) + r'(z) &\le -2\\
\log (s'(y)/s'(x)) + \log(s'(z)/s'(x)) &\le -2
}
$$`

`$s'(y) + s'(z) \le s'(x)$`이므로 2번에서 본 것과 동일하게 증명 가능하다. 위 식을 보였고 따라서 `$2(r'(x) - r(x)) \le 3(r'(x) - r(x))$`이다. 

이렇게 각 step에서 amortized cost를 구했다. 이제 splay 연산의 amortized cost를 구하기 위해 모든 step에서 amortized cost를 합하자. 이번 스텝의 `$r'(x)$`가 다음 스텝의 `$r(x)$` 이므로 중간 항들이 모두 상쇄된다. 따라서 합은 최대 `$3(r(t) - r(x)) + 1$`이 되므로 Access Lemma를 증명했다. (1이 한번만 더해지는 이유는 zig step은 `$x$`가 루트가 되기 직전 한번만 실행되기 때문이다.)

이제 `$w(x)$`에 적당한 값을 넣으면 `$O(a_i)$`를 결정할 수 있다. 그런데 우리가 원하는 `$O(\sum c_i)$`를 구하기 위해서는 `$O(\sum a_i)$`뿐만 아니라 오차 `$\Phi(s_0) - \Phi(s_n)$`역시 알아야 한다. 따라서 `$\Phi$`의 upper bound와 lower bound를 구해보자. 먼저 upper bound는 모든 `$r(x)$`가 가능한 최댓값 `$\log {\sum w(i)}$`이라고 하면 구할 수 있다. 앞으로 `$\sum w(i) = W$`라고 하자. `$\Phi = \sum r(x)$`이므로 `$\Phi$`의 최댓값은 `$n \log W$`이다. 반대로 lower bound는 모든 `$r(x)$`가 가능한 최솟값 `$\log w(x)$`이라고 하면 된다. `$\Phi$`의 최소값은 `$\sum \log w(i)$`이다. 따라서 다음이 성립한다.

`$$\Phi(s_0) - \Phi(s_n) = O(\sum_{i = 1} ^n \log {W \over w(i)}) $$`

이제 `$w(i) = 1 / n$`를 대입하자. 그러면 `$W = 1$`이므로 `$\Phi(s_0) - \Phi(s_n) = O(n \log n)$`이다. 또 splay 연산의 amortized cost는 최대 `$3(r(t) - r(x)) + 1 = O(\log n + 1)$`이므로 전체 splay 연산의 수가 `$m$`개 일 때 `$\sum a_i = O(m \log n + m)$`이다. 따라서 다음 식을 얻는다.

`$$\sum c_i = O((m + n) \log n + m)$$`

결론적으로 splay 연산의 수가 충분히 많을 때 (`$m \ge n$`) splay 연산 하나의 시간복잡도는 `$amortized \space O(\log n)$`이다.

#### 사족

`$w(i)$`에 다른 값들(접근되는 비율 등)을 대입해 특정 상황에서 연산의 시간복잡도가 `$amortized \space O(\log n)$`보다 작음을 보일 수 있다(자세한 정보는 논문이나 다른 자료를 참고하라).

Dynamic optimality conjecture가 참이라면 splay tree는 모든 상황에서 다른 BST와 적어도 같거나 더 나은 시간복잡도를 가진다. 아주 간단한 로직을 가진 splay tree가 가장 강력한 BST일 수도 있다는 점이 신기하지 않을 수 없다.

## 삽입, 삭제의 amortized time complexity

이제 splay 연산을 기반으로 한 여러 쿼리들이 어떻게 `$amortized \space O(\log n)$`의 시간복잡도를 가지는지 알 수 있다. 그런데 여기서 한 가지의 질문이 생긴다. 삽입, 삭제를 하면 tree의 노드가 새로 생기거나 없어지는데, 이게 시간복잡도에 영향을 미치지 않는다는 것을 확신할 수 있을까?

<br/><br/>
**출처**

- Lecture 04, 09/13: Splay Trees [(링크)](https://www.youtube.com/watch?v=QnPl_Y6EqMo)
- Lecture 05, 09/16: Integer Shortest Paths (초반부) [(링크)](https://www.youtube.com/watch?v=rn3xjYpJWi0)
- MIT Open Course Ware - Advanced Data Structures - 5. Dynamic Optimality I [(링크)](https://www.youtube.com/watch?v=DZ7jt1F8KKw)
- Notes on Amortization [(링크)](https://www.cs.cmu.edu/afs/cs/academic/class/15451-s06/www/lectures/amortize.pdf)
- Sleator, Daniel D.; Tarjan, Robert E. (1985). "Self-Adjusting Binary Search Trees" [(링크)](https://www.cs.cmu.edu/~sleator/papers/self-adjusting.pdf)
- Standford lecture note [(링크)](https://web.stanford.edu/class/archive/cs/cs166/cs166.1146/lectures/08/Small08.pdf)
- Wikipedia Amortized analysis 항목 [(링크)](https://en.wikipedia.org/wiki/Amortized_analysis)