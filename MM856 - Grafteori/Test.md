# Connectivity and Paths

## Cuts and Connectivity {#sec:4.1}

We aim to have networks that remain stable (connected) even when some
edges or vertices fail. For the rest of this chapter, we assume all
graphs to have **no loops**, as they are irrelevant to connectivity.

A **seperating set** (or **vertex cut**) of a graph $G$ is a set
$S \subseteq V(G)$ such that $G - S$ has more than one component. The
**connectivity** of $G$, $\kappa(G)$ is the minimum size of a set
$S \subseteq V(G)$, such that $G-S$ is disconnected or has only one
vertex. We say that $G$ is $k$-connected if it has connectivity at least
$k$.

The connectivity of the complete graph $K_{n}$ is $n-1$. I.e., you would
have to remove all vertices save 1. However, if $G$ is not a complete
graph, then $\kappa(G) \le n-2$. For complete bipartite graphs, then
$\kappa(K_{m,n}) = \min\{n,m\}$.

**Harary graphs** are well-known graphs in Graph Theory. Let $k < n$, we
define $H_{k,n}$ to be a Harary Graph. We distinguish between two cases:

(Note from lecture: Connects to the $\frac{k}{2}$ preceding and
$\frac{k}{2}$ following vertices.)

1.  $k$ is even:

    -   We let $V(H_{k,n}) = \{v_{0}, v_{1}, \ldots, v_{n-1}\}$.

    -   We add edges from $v_{i}$ to
        $v_{i-\frac{k}{2}}, v_{i-\frac{k}{2}k+1}, \ldots, v_{i-1}, v_{i+1}, v_{i+2}, \ldots, v_{i+\frac{k}{2}}$.

    -   Here we treat all indices with modulo $n$.

    -   In essence, this means we connect $v_{i}$ to the preceding
        $\frac{k}{2}$ vertices and the following $\frac{k}{2}$ vertices
        in the cyclic order.

2.  $k$ is odd and $n$ is even:

    -   Make each vertex adjacent to the nearest $\frac{k-1}{2}$
        vertices in each direction and to the diametrically opposite
        vertex.

    -   (note from lecture): See it as the unique diametrically oposite
        vertex. THis is guaranteed as $n$ is even.

3.  $k$ is odd and $n$ is odd:

    -   Start with $H_{k-1,n}$ and then add edges from $v_{i}$ to
        $v_{i+(n-1)/2}$ for all $0 \le i \le \frac{n-1}{2}$.

------------------------------------------------------------------------

**Theorem 1.1** *(Harary, 1962)*:

\\kappa(H\_{k,n}) = k, and hence the minimum number of edges in a k-connected graph on n vertices is \\lceil kn / 2 \\rceil

------------------------------------------------------------------------

In a $k$-connected graph, every vertex has a degree of at least $k$
(since if $d(x) < k$, then $N(x)$ is a cut-set of size less than $k$,
which is a contradiction). So if $G$ is $k$-connected, then
$2|E(G)| = \sum_{u \in V(G)} d(u) \ge kn$. Thus $|E(G)|\ge \frac{kn}{2}$
and as $|E(G)|$ is an integer we always have the following:
$$|E(G)| \ge \left \lceil \frac{kn}{2}  \right \rceil$$

The Harary graphs show that this is best possible, as
$|E(H_{k,n})| = \lceil \frac{kn}{2}  \rceil$.

A **disconnecting set** of edges is a set $F \subseteq E(G)$, such that
$G - F$ has more than one component. A graph $G$ is
$k$**-edge-connected** if every disconnecting set has at least $k$
edges. The **edge-connectivity** of $G$, $\kappa'(G)$, is the minimum
size of a disconnecting set in $G$. We denote by $[S, T]$ all the edges
between vertex sets $S$ and $T$. An **edge-cut** is an edge set
$[S, \overline{S}]$, where $\emptyset \subset S \subset V(G)$ (i.e. $S$
is a non-empty proper subset of $V(G)$). Thus the edge-cut
$[S, \overline{S}]$ connects all vertices in $S$ to all other vertices,
and if cut, will disconnect the graph.

The difference between and edge-cut and a disconnecting set, is that a
disconnecting set *may* not be an edge cut, however, a *minimal
disconnecting set* is an edge-cut and vice-versa.

------------------------------------------------------------------------

**Theorem 1.2**:

\\kappa(G) \\le \\kappa\'(G) \\le \\delta(G)

------------------------------------------------------------------------

That is, the connectivity is smaller than or equal to the edge
connectivity which is smaller than or equal to the minimum degree.

------------------------------------------------------------------------

**Proof**:

We prove in two parts:

------------------------------------------------------------------------

------------------------------------------------------------------------

**Theorem 1.3**:

If G is a 3-regular graph, then \\kappa(G) = \\kappa\'(G).

------------------------------------------------------------------------

We omit the proof.

::: proposition
Let $S \subseteq V(G)$ be arbitrary. Then

$$|[S, \overline{S}]| = \left( \sum_{v \in S} d(v) \right) - 2|E(G[S])|$$
:::

That is, the edge cut's size is equal to the degree of all vertices in
$S$ summed, subtract twice the induced subgraph of $S$.

::: corollary
If $G$ is a simple graph and $|[S, \overline{S}]| < \delta(G)$, then
$|S| > \delta(G)$.
:::

We refer to a minimal non-empty edge cut as a **bond**.

::: proposition
If $G$ is a connected graph, then an edge cut $F$ is a bond if and only
if $G-F$ has exactly two components.
:::

We define a **block** of a graph to be a maximal connected subgraph of
$G$ that has no cut-vertex. If $G$ itself has no cut-vertex and is
connected, then we say that $G$ itself is a block.

::: proposition
Two blocks in a graph share at most one vertex.
:::

------------------------------------------------------------------------

**Proof**:

Given two blocks B\_{1} and B\_{2}. Assume for the sake of contradiction, that they share at least two vertices.

------------------------------------------------------------------------

The blocks of the graph *decompose* the graph (i.e., each block shares
no edge with other blocks, but may share a vertex (if it wasn't blocks,
the definition would instead be *vertices*)).

## $k$-connected graphs {#sec:4.2}

We say that two $(u,v)$-paths are **internally disjoint** if they have
no common internal vertex. Recall that an internal vertex is every
vertex in the path except $u$ and $v$.

------------------------------------------------------------------------

**Theorem 1.4**:

A graph G with n(G) \\ge 3 is 2-connected if and only if for each u,v \\in V(G) there exist two internally disjoint (u,v)-paths in G.

------------------------------------------------------------------------

Recall that $k$-connectivity means that at least $k$ vertices need to be
deleted, in order for the graph to end up disconnected.

------------------------------------------------------------------------

**Proof**:

We prove both directions: "\\forall u,v \\in V(G): G contains two internally disjoint (u,v)-paths \\Rightarrow G is 2-connected." Choose an arbitrary z \\in V(G). We will show that G - z is connected. Choose arbitrary u, v \\in V(G-z). From the assumption, we know that there exist two internally disjoint (u,v)-paths. At least one of these do not contain z, thus this path exists in G-z. So there is a (u,v)-path in G-z. As u and v were arbitrary, G-z is connected. As z was arbitrary, G is 2-connected. "G is 2-connected \\Rightarrow \\forall u,v \\in V(G): G contains two internally disjoint (u,v)-paths." We will prove that there exists two internally disjoint (u,v)-paths by induction on d(u,v). Base Case, d(u,v) = 1: Let w \\in N(u) \\setminus \\{v\\}. We know such a vertex exists, as it wouldn't be 2-connected otherwise. Then there is a (w,v)-path, P in G-u. We now have two internally disjoint paths: uv and uP = uwv. Inductive Step, d(u,v) \> 1: We assume the statement holds for all pairs of vertices at distance less than d(u,v) (induction hypothesis). Let up\_{1}\\ldots,p\_{l}v be a shortest (u,v)-path in G. By induction there exists internally disjoint (u,p\_{l})-paths, P and Q as d(u,p\_{l}) \< d(u,v) which we have assumed to be true.

------------------------------------------------------------------------

::: lemma
[]{#lemma:expansion label="lemma:expansion"} If $G$ is a $k$-connected
graph and $G'$ is obtained from $G$ by adding a new vertex $y$ with at
least $k$ neighbours in $G$, then $G'$ is connected.
:::

------------------------------------------------------------------------

**Theorem 1.5**:

Let G be a graph with n(G) \\ge 3. The following conditions are now equivalent:

------------------------------------------------------------------------

------------------------------------------------------------------------

**Proof**:

We prove:

------------------------------------------------------------------------

A **subdivision** of an edge $uv$ in a graph $G$ is the operation of
replacing $uv$ with a path $uwv$ through new vertex $v$. I.e., you add a
new vertex which will be in the middle of the $uv$ path.

::: corollary
If $G$ is $2$-connected, then the graph $G'$ obtained by subdividing an
edge $G$ is $2$-connected.
:::

We define an **ear** of a graph to be the maximal path whose internal
vertices have degree $2$ in $G$. Furthermore, an **ear decomposition**
of $G$ is a decomposition $P_{0},P_{1},\ldots, P_{k}$ such that $P_{0}$
is a cycle and $P_{i}$ is an ear in $P_{0} \cup \cdots \cup P_{i}$ for
all $i = 1, 2, \ldots, k$.

------------------------------------------------------------------------

**Theorem 1.6**:

A graph is 2-connected if and only if it has an ear-decomposition.

------------------------------------------------------------------------

A **closed-ear** of a graph is a cycle, $C$, such that all vertices on
$C$ have degree 2, except one. A **closed-ear decomposition** of $G$ is
a decomposition $P_{0},P_{1}, \ldots, P_k$ such that $P_{0}$ is a cycle
and $P_{i}$ is either a closed-ear or an open ear in
$P_{0} \cup \cdots \cup P_{i}$ for all $i = 1, 2, \ldots, k$.

------------------------------------------------------------------------

**Theorem 1.7**:

A graph is 2-edge-connected if and only if it has a closed-ear decomposition.

------------------------------------------------------------------------

We now turn our attention to connectivity in digraphs. We define
connectivity analogously to graphs. A **seperating set** or **vertex
cut** of a digraph $D$ is a set $S \subseteq V(D)$ such that $D-S$ is
not strongly connected. A digraph is $k$-connected if every vertex cut
has at least $k$ vertices. The minimum size of a vertex cut is the
connectivity $\kappa(D)$.

For $S, T \subseteq V(G)$ let $[S, T]$ denote all arcs from $S$ to $T$
(Not the other way around, nor is it interchangeable!). An **arc cut**
is the set $[S, \overline{S}]$ for some $\emptyset \ne S \subset V(D)$.
A digraph is $k$-**arc-connected** if every arc cut has at least $k$
edges. The minimum size of the arc cut is the **arc-connectivity**
$\kappa'(D)$.

::: proposition
Adding a directed ear to a strong digraph $D$ produces another (larger)
strong digraph $D'$.
:::

While we will not show a direct proof, there are two main ways of
proving this:

1.  Show that every set $\emptyset \ne S \subset V(D')$ has an arc out
    of it.

2.  Show that for every $x,y \in V(D')$ there is a $(x,y)$-path in $D'$.

An **orientation** of a graph is a digraph obtained by directing each
edge.

------------------------------------------------------------------------

**Theorem 1.8**:

A graph G has a strong orientation if and only if G is 2-edge-connected.

------------------------------------------------------------------------

**"Strong Orientation $\Rightarrow$ 2-edge-connected"**: We can either
prove this directly or by contradiction.

**"Strong Orientation $\Leftarrow$ 2-edge-connected"**: We prove this by
considering an ear decomposition of $G$.

Given $x, y \in V(G)$, a set $S \subseteq V(G) \setminus \{x,y\}$ is a
$(x,y)$-**seperator** (or $(x,y)$-cut) if $G-S$ has no $(x,y)$-path. We
let $\kappa(x,y)$ be the minimum size of a $(x,y)$-cut. Let
$\lambda(x,y)$ be the maximum number of pairwise internally disjoint
$(x,y)$-paths. For $X, Y \subseteq V(G)$ we define an $(X,Y)$-path to be
a path starting in $X$ and ending in $Y$, and having no internal
vertices in $X \cup Y$. We always have $\kappa(x,y) \ge \lambda(x,y)$ as
there cannot be fewer cuts than paths.

------------------------------------------------------------------------

**Theorem 1.9** *(Menger, 1927)*:

Let x,y \\in V(G) be arbitrary such that xy \\notin E(G). Then \\kappa(x,y) = \\lambda(x,y)

------------------------------------------------------------------------

That is, the minimum size of a $(x,y)$-cut is equal to the maximum
amount of pairwise internally disjoint $(x,y)$-paths.

------------------------------------------------------------------------

**Proof**:

We have shown that \\kappa(x,y) \\ge \\lambda(x,y), thus to complete the proof we shall show that \\kappa(x,y) \\le \\lambda(x,y) thus making \\kappa(x,y) = \\lambda(x,y). Let S be a minimum (x,y)-cut. Then there is no (x,y)-path in G-S and \|S\| = \\kappa(x,y). To complete the proof, we show that there are \|S\| pairwise internally disjoint (x,y)-paths. We prove by induction on n = n(G). Base Case n = 2: In this case V(G) = \\{x,y\\}. As xy \\notin E(G), we have \\kappa(x,y) = 0 = \\lambda(x,y). Inductive Step n \> 2: We assume the theorem holds for graphs of order \< n. We consider two cases: 1. There exists a minimum (x,y)-cut different than N(x) and N(y). Let S be such a cut. We define V\_{1} to contain all vertices on (x,S)-paths in G, and V\_{2} to contain all vertices on (S,y)-paths in G. We will then show that S = V\_{1} \\cap V\_{2}. As S is minimal (x,y)-cut, S \\subseteq V\_{1} \\cap V\_{2}. If V\_{1} \\cap V\_{2}, then v \\in S, as S is a (x,y)-cut. So S = V\_{1} \\cap V\_{2}, as desired. ◻

------------------------------------------------------------------------

The **line graph** of a graph $G$, written $L(G)$, is defined as
follows: $$V(L(G)) = E(G)$$
$$E(L(G)) = \{ef \mid \text{ e and f  have a common end-point}\}$$

We can also define *line digraphs* for directed graphs as follows:

$$A(L(D)) = \{(e,f) \mid e = uv \text{ and } f = vw \text{ where } e, f \in A(D)\}$$

::: lemma
[]{#lemma:deletionofedge label="lemma:deletionofedge"} Deletion of an
edge reduces the connectivity by at most 1.
:::

------------------------------------------------------------------------

**Theorem 1.10**:

The connectivity of G equals the maximum k such that \\lambda(x,y) \\ge k for all x,y \\in V(G). The edge connectivity of G equals the maximum k such that \\lambda\'(x,y) \\ge k for all x,y \\in V(G).

------------------------------------------------------------------------

Both statements
([\[lemma:deletionofedge\]](#lemma:deletionofedge){reference-type="ref"
reference="lemma:deletionofedge"} and
[1.10](#the:coinnectivity){reference-type="ref"
reference="the:coinnectivity"}) hold for both graphs and digraphs.

Let's now look at the applications of Menger's Theorem.

Given an arbitrary vertex $x$, and a set
$U \subseteq V(G) \setminus \{x\}$, an $(x,U)$**-fan** is a set of paths
from $x$ to $U$ such that any two of them share only the vertex $x$.

------------------------------------------------------------------------

**Theorem 1.11**:

A graph G is k-connected if and only if it has at least k+1 vertices and for every choice of x and U \\subseteq V(G) \\setminus \\{x\\} with \|U\| \\ge k, it has an (x,U)-fan of size k (i.e. with k paths).

------------------------------------------------------------------------

------------------------------------------------------------------------

**Proof**:

G is k-connected if and only if there is a (x,U)-fan of size k for all x, U (\|U\| \\ge k).

------------------------------------------------------------------------

------------------------------------------------------------------------

**Theorem 1.12**:

If G is a k-connected graph where k \\ge 2, and S is a set of k vertices in G, then G has a cycle containing all vertices from S.

------------------------------------------------------------------------

------------------------------------------------------------------------

**Proof**:

We prove by induction on the size of k.

------------------------------------------------------------------------

## Network Flow Problems {#sec:label}

A *network* is a digraph, with an associated capacity function $c(e)$ on
each edge $e$. A network distinguishes between two types of vertices: a
**source vertex** denoted by $s$, and a **sink vertex** denoted by $t$.
A **flow** $f$ assigns a value $f(e)$ to each edge $e$. We define two
values $f^{+}(e)$ and $f^{-}(e)$ to be the total flow on edges leaving
$v$ and the total flow on edges entering $v$, respectively.

We say that a flow is **feasible** if it satisfies the **capacity
constraints** which are $0 \le f(e) \le c(e)$ and the **conservation
constraint** $f^{+}(v) = f^{-}(v)$ for all $v \notin \{s,t\}$. I.e., the
flow of an edged should be less than or equal to the capacity of that
edge (such that it doest overflow), and the input should be equal to the
output. By a simple observation, you can see that if the input was not
equal to the output, there would either be coming flow out, that come
from nowhere, or flow would transport to the void.

We define the **value** of a flow to be $val(f) = f^{-}(t) - f^{+}(t)$,
where $t$ is the sink vertex. As a side note, one can show that this is
equal to the $f^{+}(s) - f^{-}(s)$ where $s$ is the source node. A
**maximum flow** is a feasible flow of maximum value. We distinguish the
*zero flow* as a flow which assigns zero to each edge.

Given any flow, we want to be able to decide if we can *push* more flow
from $s$ to $t$. We will do this using a new concept, the **residual
network**. Assume we are given a network, $N$, and a flow, $f$. If
$f(e) < c(e)$ then we can push up to $c(e)-f(e)$ more flow through $e$.
If $e = uv$ and $f(uv) > 0$, then we can push up to $f(vu)$ flow through
$e$, as it will "cancel out". Thus the residual network shows how much
more flow we can push through any arc (or back through an arc). Here
comes an important point about residual networks: If we cannot push any
more flow through an arc, i.e., from $u$ to $v$, we do not include
$e = uv$ in the residual network. Given a network, along with a residual
network, given we can find an $(s,t)$-path, we can push more flow by
"augmenting" (increasing the flow) through this path. Once we have no
$(s,t)$-paths we have obtained a "maximum flow", that is, a flow which
cannot be augmented any more.

The method described above is called the *Ford-Fulkerson* method. As you
have already seen, the algorithm is quite simple, but let's break it
down into some easy to understand steps:

1.  Start with any flow $f$ (this may be the zero flow)

2.  Build the residual network $N'$ with relation to the flow $f$

3.  Decide if there is an $(s,t)$-path in $N'$.

    -   If yes, then push the flow through $f$ and go back to step 2.

    -   If no, then the algorithm terminates.

If $S \subseteq V(N)$ is a set such that $s \in S$ and $t \notin S$,
then let $T = \bar{S}$ and denote $[S, T]$ as a **source/sink cut**.

The capacity of $[S, T]$ is the sum of the capacities on the arcs in
$[S,T]$.

------------------------------------------------------------------------

**Theorem 1.13** *(Max-flow, Min-cut)*:

In every network, the maximum value of a feasible flow is equal to the minimum capacity of a source/sink cut.

------------------------------------------------------------------------

Before proving this, we need a lemma. Before getting to the lemma, we
need the following definitions: Let $f^{+}(S)$ denote the sum of the
flows of the arcs *out of $S$*, i.e., in $[S, \bar{S}]$. Let $f^{-}$
denote the sum of the flows of the arcs *into $S$*, i.e., in
$[\bar{S}, S]$.

::: lemma
[]{#lemma:4.3.7 label="lemma:4.3.7"} Let $[S, T]$ be a source/sink cut
in the network $N$, then $val(f) = f^{+}(S)  - f^{-}(S)$.
:::

------------------------------------------------------------------------

**Proof**:

\\sum\_{v \\in T} (f\^{-} - f\^{+}(v)) = f\^{+}(S) - f\^{-}(S)

------------------------------------------------------------------------

::: proof
*Max-flow, Min-cut.* We construct a maximum flow using Ford-Fulkerson's
Algorithm. As is ensured by the algorithm, there will be no $(s,t)$-path
in the residual network $N'$ when the algorithm terminates. Let
$S = \{x \mid \exists (s,x)\text{-path in }N' \}$. Let $T = \bar{S}$ and
note that $t \in T$.

We now observer that $f(e) = c(e)$ for all $e \in [S, T]$ and
$f(e') = 0$ for all $e' \in [T, S]$. This comes from the fact that we
defined $S$ to only contain paths. As there is a path, we know it has
been augmented.

Therefore, $val(f) = f^{+}(S) - f^{-}(S)$ by
Lemma [\[lemma:4.3.7\]](#lemma:4.3.7){reference-type="ref"
reference="lemma:4.3.7"}.

So, the capacity of the source/sink cut $[S, \bar{S}]$ is equal to the
value of a maximum feasible flow. There cannot be a source/sink cut
$[S', \bar{S'}]$ with lower capacity, as then
$val(f) = f^{+}(S) - f^{-}(S) \le c^{+}(S') < c^{+}(S) = val(f)$. Thus
$[S, \bar{S}]$ is the source/sink cut of minimum capacity and this is
equal to the maximum flow $f$. ◻
:::

::: corollary
If all capacities in the network are integers, then there is a maximum
flow assigning integral flow to each edge.
:::

While we will not show a proof, the main idea of the proof would be that
every step of the Ford-Fulkerson algorithm augments the flow by an
integer.

We will now look at Menger's Theorem and Max-flow, Min-cut. Let $D$ be a
digraph and $s, t \in V(D)$. Construct a network by putting capacity 1
on every arc. Let $f$ be a maximum $(s,t)$-flow (i.e., a maximum valued
feasible flow with source $s$ and sink $t$). $f$ corresponds to $val(f)$
arc disjoint paths in $D$ (plus maybe some cycles which we can ignore).
This is because all edges have capacity one, and by the max-flow min-cut
theorem we have found the min-cut. The capacity of a source/sink cut
$[S,T]$ is equal to the number of arcs in the $(s,t)$-arc-cut $[S,T]$,
and the number of arcs in a $(s,t)$-arc-cut $[S,T]$ is equal to the
capacity of the source/sink-cut $[S,T]$.

We can also use max-flow to find internally disjoint paths. Without
modifying the capacity of the edges, we can restrict the amount of flow
going through a vertex $v$, by "splitting" it into two vertices, $v^{-}$
which takes the incoming arcs, and $v^{+}$ which takes the outgoing
arcs. Then, between these two vertices we add an arc with the restricted
value $r$, which will then restrict the flow.

We can also use flows on undirected graphs. We replace each edge
$e = uv$ with two arcs $a = uv$ and $a = vu$. Now we look at the
question posed earlier, about the feasibility of finding internally
disjoint paths with max-flow.

Let $G$ be a graph and $s, t \in V(D)$. Make $G$ into a digraph $D$, by
replacing each edge with an arc in each direction (as stated earlier).
Let all capacities be $1$. Using the splitting transformation described
earlier, let each vertex have a bottleneck edge of capacity 1. Now find
the maximum flow in this resulting network. This flow transforms
$val(f)$ into internally disjoint $(s,t)$-paths. Any $k$ internally
disjoint $(s,t)$-paths would give rise to a flow of value $k$. So this
gives us the maximum number of internally disjoint $(s,t)$-paths in $G$.
