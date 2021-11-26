function [overallAcc, accMat, confMat] = run_K_nearest(testData, testLabels, trainingData, trainingLabels, k)
numTests = size(testData, 2);
accMat = zeros(1, numTests);
confMat = zeros(k, numTests);
for testNum = 1 : numTests
    [rNeigh, rLabels, rAcc, rConfMat] = k_nearest_neighbor(testData(:, testNum), testLabels(testNum), trainingData, trainingLabels, k);
    accMat(1, testNum) = rAcc;
    confMat(:, testNum) = rConfMat;
end
overallAcc = sum(accMat)/numTests;