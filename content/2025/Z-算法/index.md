+++
title="Z-算法是什么？"
date=2025-09-18
draft=false
[taxonomies]
tags=["algorithm", "cpp"]
+++

## Z算法核心
和KMP算法类似，Z算法大核心也是那一个数组，或者叫z函数。

首先我们定义一下什么叫z数组。

一句话说：在一个字符串里面，从当前符号匹配字符串开头，能匹配到的最大长度。

举个例子：

```cpp
s: abcabca
z: 0004001
```
需要注意的是z[0]=0。为什么z[3]=4?可以把从i=3这个字符串抽出来，我们比较
```cpp
s:  abcabca
i=3 abca  
```
可以看到从i=3开始，这个和s前缀比较最大长度就是4。

## 如何得到z数组
首先我们来看暴力法怎么做：
```cpp
vector<int> z_brute_force(string s) {
	auto N = s.size();
	vector<int> z(N);
	for(int i = 0; i < N; i++) {
		// 这里的z[i]可以理解为前缀的一个长度，i+z[i]就是当前点i，和对应长度的字符，和前缀的比较。如果相等，就可以一直往后走下去
		while (i + z[i] < n && s[z[i]] == s[i + z[i]]) {
			z[i]++;
		}
	}
	return z;
}
```
暴力法的时间复杂度是$O(n^2)$，但类似于KMP算法，我们也可以利用之前已经得到的信息，就可以优化这个时间。

我们可以维护一个[l, r]的范围，在这个范围里面，我们是知道这一段和前缀是匹配的。

但i在这个范围内的时候，我们是知道这个范围的信息的，因此可以把这个范围的信息给利用起来。

那么我们在更新z[i]的时候，就可以更快。z[i]的上限是r-i,z[i-1]。
因此：
```cpp
z[i] = min(r - i, z[i - l]);
```
完整C++实现：

```cpp
vector<int> z_function(string s) {
	auto N = s.size();
	vector<int> z(N);
	int l = 0, r = 0;
	for(int i = 1; i < N; ++i) {
		if(i < r) {
			z[i] = min(r - i, z[i - l]);
		}
		// 如果不在已知的范围内，那么久退回到暴力法
		while (i + z[i] < n && s[z[i]] == s[z[i - l]]) {
			z[i]++;
		}
		// 如果超过了这个
		if(i + z[i] > r) {
			l = i;
			r = i + z[i];
		}
	}
	return z;
}
```

