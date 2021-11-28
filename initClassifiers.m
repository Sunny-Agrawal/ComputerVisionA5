function classifiers = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, class)

%classifiers will have 8 values as follows
%[TopRow, LeftCol, BottomRow, RightCol, featureType, threshold, pWeight, nWeight]
numIntegrals = size(trainingIntegrals, 3);
numFeatures = size(harFeatures, 1);
classifiers = zeros(numFeatures, 8);
classifiers(:, 1:5) = harFeatures;
featVals = zeros(numFeatures, numIntegrals);

%assign weights
positives = trainingLabels == class;
negatives = trainingLabels ~= class;
numPositives = sum(positives);
numNegatives = sum(negatives);
weights = zeros(size(harFeatures, 1), 2);
posWeight = 1/(2*numPositives);
negWeight = 1/(2*numNegatives);
weights(:, 1) = weights(:, 1) + posWeight;
weights(:, 2) = weights(:, 2) + negWeight;
classifiers(:, 7:8) = weights;



%Calculate all feature values
for integralNum = 1 : numIntegrals
    integral = trainingIntegrals(:, :, integralNum);
    for featNum = 1 : numFeatures
        f = harFeatures(featNum, 1:5);
        featVals(featNum, integralNum) = harInterp(integral, f);
    end 
end

%sort feature values in ascending order
sortedFeatVals = zeros(numFeatures, numIntegrals);
for featNum = 1 : numFeatures
   sortedFeatVals(featNum, :) = sort(featVals(featNum, :)); 
end

%Determine all threshold possibilities for each feature.
numThreshPos = numIntegrals - 1;
threshPossibilities = zeros(numFeatures, numThreshPos);
greatestCols = 0;
for threshIndex = 1 : size(threshPossibilities, 2) 
    threshPossibilities(:, threshIndex) = (sortedFeatVals(:, threshIndex) + sortedFeatVals(:, threshIndex + 1))/2;
end
%shrink possibilities by removing as many duplicates as possible
shrunkThreshPos = zeros(numFeatures, numThreshPos);
numThreshPos = 0;
for featNum = 1 : numFeatures
    possibilities = unique(threshPossibilities(featNum,:));
    numPos = size(possibilities, 2);
    shrunkThreshPos(featNum, 1:numPos) = possibilities;
    if numPos > numThreshPos
        numThreshPos = numPos;
    end
end
threshPossibilities = zeros(numFeatures, numThreshPos);
threshPossibilities = threshPossibilities + shrunkThreshPos(1:numFeatures, 1:numThreshPos);


%run classifications by comparing feature values with possible thresholds

valsCompMat = zeros(numFeatures, numIntegrals, numThreshPos);
valsCompMat = valsCompMat + sortedFeatVals;
valsCompMat = permute(valsCompMat, [1, 3, 2]);

threshCompMat = zeros(numFeatures, numThreshPos, numIntegrals);
threshCompMat = threshCompMat + threshPossibilities;

positivesPage = zeros(numFeatures, numIntegrals) + positives';
positivesMat = zeros(numFeatures, numIntegrals, numThreshPos) + positivesPage;
positivesMat = permute(positivesMat, [1, 3, 2]);
positiveWeightsMat = posWeight * positivesMat;

negativesPage = zeros(numFeatures, numIntegrals) + negatives';
negativesMat = zeros(numFeatures, numIntegrals, numThreshPos) + negativesPage;
negativesMat = permute(negativesMat, [1, 3, 2]);
negativeWeightsMat = negWeight * negativesMat;
weightsMat = negativeWeightsMat + positiveWeightsMat;

classifications = valsCompMat < threshCompMat;
errors = weightsMat.*abs(classifications - positivesMat); 
errors = sum(errors, 3);
[minError, threshIndex] = min(errors, [], 2);
thresholds = zeros(numFeatures, 1);
for featNum = 1 : numFeatures
   thresholds(featNum) = threshPossibilities(featNum, threshIndex(featNum)); 
end
classifiers(:, 6) = thresholds;





