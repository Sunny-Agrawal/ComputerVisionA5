function [overallAccs, accMats] = fiveFoldK(testData, testLabels, trainingData, trainingLabels, kScale)
overallAccs = zeros(1, 5);
numTests = size(testData, 2);
accMats = zeros(1, numTests, 5);

for fold = 1 : 5
    td = trainingData(:, :, fold);
    tl = trainingLabels(:, :, fold);
    k = fold * kScale;
    [overallAcc, accMat, resultMat, successMat] = run_K_nearest(testData, testLabels, td, tl, k);
    overallAccs(1, fold) = overallAcc;
    accMats(:, :, fold) = accMat;  
end