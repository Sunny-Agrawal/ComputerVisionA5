function[data, labels, u, v, tp, proj, data_shrunk] = pca(data, labels)
%Perform principle component analysis on data set of row-vectorized images
%and plot the variation. This plot can be used to decide which columns of
%the u matrix to keep as a projection matrix to shrink the data set.
data = cast(data, 'double');
labels = cast(labels, 'double');
data = data';
tp = mean(data')';
tp = data - tp*ones(1, size(data, 2));
tp = tp*tp';
[u, v] = eig(tp);
proj = u(:, 3000:3072);
data_shrunk = proj' * data;
plot(sqrt(diag(v)'));