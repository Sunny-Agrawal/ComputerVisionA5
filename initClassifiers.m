function classifiers = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, class)
numIntegrals = size(trainingIntegrals, 3);
numFeatures = size(harFeatures, 1);
classifiers = zeros(numFeatures, 6);
classifiers(:, 1:5) = harFeatures;
featVals = zeros(numFeatures, numIntegrals);

%Calculate all feature values
for integralNum = 1 : numIntegrals
    integral = trainingIntegrals(:, :, integralNum);
    for featNum = 1 : numFeatures
        f = harFeatures(featNum, 1:5);
        featVals(featNum, integralNum) = harInterp(integral, f);
    end 
end

%Determine all threshold possibilities for each feature.
threshPossibilities = zeros(numFeatures, numIntegrals - 1);
for threshIndex = 1 : size(threshPossibilities, 2) 
    threshPossibilities(:, threshIndex) = (featVals(:, threshIndex) + featVals(:, threshIndex + 1))/2;
end
errors = zeros(numFeatures, numIntegrals);