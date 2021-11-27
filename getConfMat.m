function [confMat, confMatPctgs] = getConfMat(testLabels, resultMat)
testLabels = testLabels + 1;
resultMat = resultMat + 1;
confMat = zeros(10, 10);
confMatPctgs = zeros(10, 10);
numTests = size(testLabels, 1);
for testNum = 1:numTests
   testClass = testLabels(testNum);
   for row = 1:10
       resultClass = resultMat(row, testNum);
       confMat(testClass, resultClass) = confMat(testClass, resultClass) + 1;
   end
end
for row = 1:10
   totalTests = sum(confMat(row, :));
   confMatPctgs(row, :) = confMat(row, :) / totalTests;
end