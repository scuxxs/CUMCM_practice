clear;clc
s = [1 1 1 2 3 3 4  5 5 5 5 6  6 7 9 9];
t = [2 3 4 5 2 4 6  4 6 7 8 5  7 8 5 8];
w = [6 3 1 1 2 2 10 6 4 3 6 10 2 4 2 3];
G = digraph(s,t,w);
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2);
set( gca, 'XTick', [], 'YTick', [] );
[P,d] = shortestpath(G, 1, 8);
myplot = plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2);
highlight(myplot, P, 'EdgeColor', 'r');
res = d;