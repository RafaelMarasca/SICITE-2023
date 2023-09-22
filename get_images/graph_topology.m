function [cluster_coef, average_degree, assort] = graph_topology(G)

adj = zeros(16,16);

for i = 1:16
    for j = 1:16
        if findedge(G,i,j)
            adj(i,j) = 1;
            adj(j,i) = 1;
        end
    end
end

degree = sum(adj,2);
average_degree = sum(degree)/16;

e = zeros(16,1);

for i = 1:16
    k = find(adj(i,:));

    for j = k
        v = find(adj(j,:));
        e(i) = e(i) + numel(intersect(k,v));
    end
end

CCi_den = degree.*(degree - 1);

CCi = (e./CCi_den);

cluster_coef = sum(CCi)/16;

[sOut,tOut] = findedge(G);
E = numel(sOut);
E_inv = E^-1;

sum_mul = sum(degree(sOut).*degree(tOut));
sum_sum = sum(degree(sOut) + degree(tOut));
sum_square = sum((degree(sOut).^2) + (degree(tOut).^2));

num = (E_inv * sum_mul) - ((E_inv/2)*sum_sum)^2;
den = ((E_inv/2)*sum_square) - ((E_inv/2)*sum_sum)^2;

assort = num/den; 

end