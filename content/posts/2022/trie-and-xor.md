---
title: "Trie와 Xor"
date: 2022-01-16T06:39:34+09:00
description: "Trie를 활용한 문제 풀이 테크닉"
categories:
    - Algorithm
tags:
    - Trie
    - Data structure
    - Problem solving
---

[Codeforce #765 (Div. 2)의 D. Binary Spiders](https://codeforces.com/contest/1625/problem/D)를 풀다가 익혀두면 좋을 것 같은 trie의 활용법이 있어 정리해보고자 한다.

<!--more-->

## 간단한 문제 설명

k와 set of numbers가 주어진다. Set of numbers에서 최대한 많은 원소를 선택해 subset을 만들되, subset의 모든 원소의 pairwise xor이 k 이상이어야 한다.

## 문제 풀이 1 - minimum pairwise xor

다음은 [editorial](https://codeforces.com/blog/entry/99031)의 내용을 조금 더 이해하기 쉽게 풀어서 다시 쓴 것이다.

먼저 set of numbers에서 **minimum pairwise xor**을 찾아야 한다고 해보자. 나이브하게 모든 pair에 대해 확인하면 `$O(n^2)$`이겠지만, 원소들을 정렬한 후 인접한 원소끼리의 xor만 고려하는 방법으로 `$O(n \log n)$`만에 minimum pairwise를 찾을 수 있다.

**증명**: 어떤 세 숫자 `$a \gt b \gt c$`가 있다고 하자. 그러면 `$a$`와 `$c$`가 서로 다른 bit를 가지는 첫 번째 위치가 있을 것이다. `$a \gt c$` 이므로 `$a$`는 bit 1을 가지고, `$c$`는 bit 0을 가진다. 또 이 위치에서 `$a \oplus c$`는 첫 번째 1 bit을 가진다. `$a \gt b \gt c$`이므로 `$b$` 역시 해당 위치까지는 prefix가 `$a$`, `$c$`와 같고, 해당 위치에서 bit가 1 혹은 0일 것이다. 따라서 `$a \oplus b$`나 `$b \oplus c$`둘 중 하나는 해당 위치 bit가 0이므로 `$a \oplus c$`보다 작다. 귀납적으로 set of numbers에도 적용할 수 있다.

이 성질을 이용하면 먼저 set of numbers를 정렬한 후 다음과 같은 `$O(n^2)$` dp식을 짤 수 있다.
`$$dp_i = \max(dp_j) + 1 \space\space (j \lt i \space \text{and} \space a_j \oplus a_i \ge k)$$`
이때 `$dp_i$`는 `$i$`번째 원소 `$a_i$`가 subset의 가장 큰 수일 때 가능한 subset 크기의 최대이다.

풀이의 시간복잡도가 `$O(n^2)$`인 이유는 `$j$`가 `$a_j \oplus a_i \ge k$`를 만족하는지 모두 확인해야 하기 때문이다. 이때 시간 복잡도를 `$O(n \log \max{a_i})$`로 줄이기 위해 trie를 사용할 수 있다.

각 원소의 bit로 0/1 trie를 구성하자. 모든 vertex는 자신의 subtree에 들어 있는 모든 원소 `$a_j$`에 대해 `$\max{dp_j}$` 값을 관리한다. 그러면 새롭게 `$dp_i$`를 구하기 위해서 (즉 `$a_j \oplus a_i \ge k$`인 `$j$`에 대해 `$\max(dp_j)$`를 구하기 위해) trie를 탐색하자. 이때 탐색하는 경로와 `$a_i$`의 xor이 `$k$`와 같도록 유지하면서 경로를 택한다. 예를 들어, `$a_i = 01011$`, `$k = 00101$`이라면 `$x = 01110$`일 때 `$x \oplus a_i = k$`이므로 `$x = 01110$`의 경로대로 탐색한다. 즉 `$k$`의 bit가 0이면 `$a_i$`의 bit와 같게, `$k$`의 bit가 1이면 `$a_i$`의 bit와 반대로 탐색한다.

경로를 내려가는 도중 `$k$`의 bit가 0일 때, 탐색하지 **않는** 경로를 만약 택한다면 그 경로와 `$a_i$`의 xor이 1이 되므로, 이 경로의 subtree에 있는 모든 원소 `$a_j$`는 `$a_j \oplus a_i \ge k$`를 만족한다는 뜻이다. 따라서 `$k$`의 bit가 0일 때 마다 **가지 않는 경로**의 vertex의 `$\max{dp_j}$`값을 새로운 `$dp_i$`의 후보로 고려해 주면 된다. 또 leaf에 다다르면 xor이 k와 같은 상태이므로 이 leaf node에서의 `$\max{dp_j}$` 값 역시 고려해야 한다.

이렇게 `$dp_i = \max(dp_j) + 1$`를 구하고 나면, 이제 `$a_i$`의 경로를 따라서 다시 trie를 탐색하며 경로상의 vertex에서 `$\max{dp_j}$`을 업데이트해 주면 된다.

[실제 풀이](https://codeforces.com/contest/1625/submission/142900670)를 보면 이해가 더 쉬울 수 있다.

## 문제 풀이 2 - maximum pairwise xor

다음은 [tourist의 풀이](https://www.twitch.tv/videos/1261190048?t=01h09m29s)를 조금 변형해 정리한 것이다.

흥미롭게도 문제를 조금만 다른 시각으로 접근하면 위와 정 반대로 **maximum pairwise xor**을 빠르게 구해야 하는 문제로 환원된다.

k의 첫 번째 1이 x 번째 bit일 때, set of numbers의 각 원소를 x 번째 초과의 bit와 x 번째 이하의 bit로 나누자. 예를 들어 `$k = 00101$`일 때

`$a_1 = 00|010$`\
`$a_2 = 00|011$`\
`$a_3 = 00|101$`\
`$a_4 = 01|110$`\
`$a_5 = 11|011$`

처럼 prefix와 suffix로 나누는 것이다. 이때 prefix가 다른 원소끼리는 xor이 무조건 k 이상인 것을 알 수 있다. 또 prefix가 같은 원소는 3개 이상 subset에 들어갈 수 없고 (prefix가 같은 원소가 3개 이상이라면 xor의 x 번째 bit이 0인 쌍이 한 개 이상이기 때문에), suffix에 따라 한 개 혹은 두 개 들어갈 수 있음을 알 수 있다. 이 prefix가 같은 그룹에서 maximum pairwise xor를 구해 그것이 k 이상이라면 두 개의 원소를 subset에 넣을 수 있다는 뜻 이다. 이것 역시 trie를 이용해 구할 수 있다.

먼저 prefix가 같은 그룹의 모든 원소를 이용해 trie를 만들자. `$a_i$`와 xor을 했을 때 가장 큰 값을 내는 `$a_j$`를 trie를 탐색하며 구하기 위해서는, `$a_i$`와 bit가 **최대한 다른** 경로로 탐색을 하면 된다. 예를 들어 `$a_i$`의 bit가 1일 때 0으로 가는 경로가 있다면 이 경로로 탐색한다. 그렇게 해서 leaf node까지 도달하면 이 노드에 대응하는 `$a_j$`에 대해 `$a_j \oplus a_i$`가 최대 xor이고, 이것이 k 이상인지 확인하면 된다. 하나의 원소에 대해 탐색이 `$O(\log \max{a_i})$`만큼 걸리므로 모든 원소에 대해 탐색을 하면 maximum pairwise xor를 `$O(n \log \max{a_i})$`에 구할 수 있다.

## 결론

Trie의 여러 활용법에 대해 조금더 고찰할 수 있는 문제였다.

