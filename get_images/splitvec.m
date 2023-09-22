function [Y] = splitvec(X)

offset = floor(numel(X)/10);
Y = [];
for i = 0:9

    Y = [Y X(i*offset + 1:(i+1)*offset)];
end

end