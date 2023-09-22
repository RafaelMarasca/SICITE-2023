function [mins, mins_indices, G] = rede(I,k)

img = im2gray(imread(I));

offsets = [ 0 1; 0 2; 0 3; 0 4;
           -1 1; -2 2; -3 3; -4 4;
           -1 0; -2 0; -3 0; -4 0;
           -1 -1; -2 -2; -3 -3; -4 -4];
glcms = graycomatrix(img, "Offset", offsets);
stats = graycoprops(glcms);

V = [];

for i = 1:16
    V = [V; [stats.Contrast(i) stats.Correlation(i)  stats.Energy(i) stats.Homogeneity(i)]];
end

distances = [];

for i = 1:16
    norms = [];
    for j = 1:16
        if j ~= i
            norms = [norms, norm(V(i,:) - V(j,:))];
        else
            norms = [norms, inf];
        end
    end
    distances = [distances; norms];
end

mins = [];
mins_indices = [];
for i = 1:16
    [values,indices]=mink(distances(i,:), k);
    mins = [mins; values];
    mins_indices = [mins_indices; indices];
end

G = graph([],[],[],16);

for i = 1:16
    for j = 1:k
        if ~findedge(G,mins_indices(i,j),i)
        %if ~findedge(G,j,i)
            G = addedge(G,i,mins_indices(i,j));

        end

    end
end

%figure

%plot(G);

%axis tight

end