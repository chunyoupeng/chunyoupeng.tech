+++
title="BIT（Binary indexed tree）笔记"
date=2025-09-14
draft=false
[taxonomies]
tags=["algorithm", "cpp"]
+++

BIT是什么？全称Binary indexed tree，或者Fenwick tree。用在区间查询和更新里面。相对于前缀和数组的一个优势在于可以动态更新数据，复杂度是$O(logn)$

核心公式：

$tree[k]= sum_q(k− p(k)+ 1,k)$
> $p(k)$代表可以被k整除的最大的2的幂数。$p(k)=k\&-k$。为什么？由于$k\&-k$得到的是k的最低有效位，实际上k的最低有效位就是刚好能被k整除的数。因此可以快速的算$p(k)$。

这个公式的规律就是如果是奇数那么这个范围就是只有自己。

## 核心实现
>由于$sum(a, b) = sum(1, b) - sum(1, a-1)$，那么我们只需要知道$sum(1, k)$，就可以把任意区间和求解出来。下面给出C++实现。

求1-k的和：
```cpp
int sum(int k) {
	int res = 0;
	while(k >= 1) {
		res += tree[k];
		k -= k & -k;
	}
	return res;
}
```
代码说明：

因为tree[k]存的就是p(k)这么长的原数组数据，核心思路就是把这段数据加上然后继续往前走，继续处理，直到k是第一个。

数据更新：

相比于前缀和，BIT的优势在于可以动态的更新数据。

```cpp
void add(int k, int x) {
	while(k<=n) {
		tree[k] += x;
		k += k & -k;
	}
}
```

代码说明：

对于更新数据，实际上前面存的是不受影响的，受影响的是后面的，因此后面的会按照之前的规则逐个增加x。