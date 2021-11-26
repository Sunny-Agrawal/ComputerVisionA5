function [nearest_neighbors, nearest_labels, accuracy, confMat] = k_nearest_neighbor(testIm, testLabel, data, dataLabels, k)
%return the k nearest neighbors in the data set to the testIm.
%testIm is column vectorized image and data is a matrix of
%column-vectorized images
imSize = size(data, 1);
numDataIms = size(data, 2);
nearest_neighbors = zeros(imSize, k);
nearest_labels = zeros(1, k);
confMat = zeros(1, k);
%get the sum of squared differences for each image
pixDifferences = (testIm * ones(1, numDataIms)) - data;
ssds = sum(pixDifferences.^2);
[ssd, imIndices] = sort(ssds);
for i = 1 : k
    imIndex = imIndices(i);
    nearest_neighbors(:, i) = data(:, imIndex);
    nearest_labels(1, i) = dataLabels(imIndex);
    if nearest_labels(1, i) == testLabel
        confMat(1, i) = 1;
    end
end
accuracy = sum(confMat)/k;