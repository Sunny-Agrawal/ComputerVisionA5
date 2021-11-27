function [overallAcc, accMat, resultMat, successMat] = run_K_nearest(testData, testLabels, trainingData, trainingLabels, k)
numTests = size(testData, 2);
accMat = zeros(1, numTests);
resultMat = zeros(k, numTests);
successMat = zeros(k, numTests);
for testNum = 1 : numTests
    [rNeigh, rLabels, rAcc, rSuccessMat] = k_nearest_neighbor(testData(:, testNum), testLabels(testNum), trainingData, trainingLabels, k);
    accMat(1, testNum) = rAcc;
    resultMat(:, testNum) = rLabels;
    successMat(:, testNum) = rSuccessMat;
end
overallAcc = sum(accMat)/numTests;
