+++
title="倍增法例题：# Company Queries II"
date=2025-09-07
draft=false
[taxonomies]
tags=["algorithm", "cpp"]
+++
题目来自于[cses: # Company Queries II](https://cses.fi/problemset/task/1688/)

解体思路：
这是关于树问题比较典型的问题求最小公共祖先。
首先想到的应该是把两个需要查询的节点首先拉到一层，之后一层一层的网上查找。

但是这样的时间复杂度是：$O(q \times (lgn + n)$。接近$O(N^2)$时间复杂度肯定是不行的。
现在的问题就是如何去优化*一层一层查找*这个过程。

其实也可以用倍增法。

在把两个节点拉到同一水平之后，贪心的思想，让节点同时尽可能往上面跳跃。但是不能让他们跳到相同的点，因为相同点其实就是根节点1了。因为所有数都是可以用二进制表示的，参考[[倍增法/index|index]]。
那么可以让节点跳到最小共同祖先之前的一个节点，然后返回父节点就可以了。
最终C++代码如下：
```cpp
int main() {

fastio;

int n, q;

cin >> n >> q;

int LOG = 1;

while ((1 << LOG) <= n)

++LOG;

vector<vi> g(n + 1), up(n + 1, vi(LOG));

vi depth(n + 1, 0);

rep(i, 2, n + 1) {

int e;

cin >> e;

g[e].eb(i);

g[i].eb(e);

up[i][0] = e;

}

// dfs get depth of every node

auto dfs = [&](auto &&self, int u) -> void {

for (auto &&v : g[u]) {

if (depth[v] == 0 && v != 1) {

depth[v] = depth[u] + 1;

self(self, v);

}

}

};

dfs(dfs, 1);

// get the lower depth, both of them jump to it, same node v ? v : jump one

// level higher

for (int j = 1; j < LOG; j++) {

for (int i = 1; i <= n; i++) {

int mid = up[i][j - 1];

up[i][j] = mid == 0 ? 0 : up[mid][j - 1];

}

}

while (q--) {

int a, b;

cin >> a >> b;

if (a == 1 || b == 1) {

cout << 1 << endl;

continue;

}

if (a == b) {

cout << a << endl;

continue;

}

while (a != b) {

int da = depth[a], db = depth[b];

if (da == db) {

for (int j = LOG - 1; j >= 0; --j) {

if (up[a][j] != up[b][j]) {

a = up[a][j];

b = up[b][j];

}

}

cout << up[a][0] << endl;

break;

}

// 如果不在同一层，那么首先拉到同一层

int min_depth = min(da, db);

// ka, kb指的是需要跳跃的层次

int ka = da - min_depth, kb = db - min_depth;

da -= ka;

db -= kb;

for (int j = 0; j < LOG; j++) {

if (ka & (1 << j)) {

a = up[a][j];

}

if (kb & (1 << j)) {

b = up[b][j];

}

}

if (a == b) {

cout << a << endl;

break;

}

}

}

}
```
