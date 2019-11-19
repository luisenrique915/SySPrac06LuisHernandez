
% $$(S+3)/(S^2+3S+2) $$
n=[1 3];
d=[1 3 2];
G=tf(n,d)
pole(G);
step(G);