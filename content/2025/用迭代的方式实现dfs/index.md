+++
title="如何用迭代的方式实现DFS？"
date=2025-09-13
draft=false
[taxonomies]
tags=["algorithm", "cpp"]
+++
DFS，深度优先遍历，图的一种常用的遍历方式。核心思想是从每个节点，沿着子节点一直走，走到最深，因此叫做深度优先。

常见的方式是用递归的方法实现的，但是递归有一个问题需要注意递归的深度，因此在某些情况下需要用到迭代到方式。

DFS的本质是一个栈的形式。栈是一种后进先出的数据结构，也就是说会优先处理最近添加的数据。这个和DFS的处理方法不谋而合。因此我们可以用这个栈来模拟DFS过程。

为了防止重复访问节点，因此需要一个visit数组来去重。

迭代实现cpp代码如下：

```cpp
# 传入一个根节点
# 我们采用邻接表的方式表示一个图。邻接表就是给定一个节点，可以找到这个节点的全部邻居。
#include <stack>
#include <vector>
using namespace std;
void dfs(int root, vector<bool>& vis, const vector<vector<int>>& g) {
	stack<int> s;
	vis[root] = true;
	s.emplace(root);
	while (!s.empty()) {
		auto u = s.top(); s.pop();
		for(auto v : g[u])
		if (!vis[v]) {
			s.emplace(v);
			visit[v] = true;
		}
	}
}
```

