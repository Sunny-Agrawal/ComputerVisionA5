function [accs] = fiveFoldAdaTest(wC1, wC2, wC3, wC4, wC5, wC6, wC7, wC8, wC9, wC10, trainingIntegrals, trainingLabels, testingIntegrals, testingLabels, numIterations)
accMat = zeros(5, 10);


for fold = 1 : 5
   foldIntegrals = trainingIntegrals(:, :, :, fold);
   foldLabels = trainingLabels(:, :, fold);
   [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, cAll] = trainScript(wC1, wC2, wC3, wC4, wC5, wC6, wC7, wC8, wC9, wC10, foldIntegrals, foldLabels, numIterations);
   for cNum = 1 : 10
      [r, acc] = adaTestScript(cAll, testingIntegrals, testingLabels, cNum - 1); 
      accMat(fold, cNum) = acc;
   end
end

accs = sum(accMat, 1);
accs = accs / 5;