function cascade = adaTrain(classifiers, trainingIntegrals, trainingLabels, classLabel, numIterations)

cascade = zeros(numIterations, 7);
%the cascade is a series of classifiers with the first 6 columns being the
%classifier info and the 7th column being the alpha
%[TopRow, LeftCol, BottomRow, RightCol, featureType, threshold, alpha]
numIntegrals = size(trainingIntegrals, 3);
numClassifiers = size(classifiers, 1);
featVals = zeros(numClassifiers, numIntegrals);
thresholds = zeros(numClassifiers, numIntegrals) + classifiers(:, 6);
pWeights = classifiers(:, 7);
nWeights = classifiers(:, 8);

%Calculate all feature values
for integralNum = 1 : numIntegrals
    integral = trainingIntegrals(:, :, integralNum);
    for featNum = 1 : numClassifiers
        f = classifiers(featNum, 1:5);
        featVals(featNum, integralNum) = harInterp(integral, f);
    end 
end

%get classifications
classifications = featVals < thresholds;
positives = trainingLabels == classLabel;
negatives = trainingLabels ~= classLabel;
positivesPage = zeros(numClassifiers, numIntegrals) + positives';
successes = abs(classifications - positivesPage);
[successRows, successCols] = find(successes);
numSuccesses = size(successRows);

%make weights page
    pWeightsPage = zeros(numClassifiers, numIntegrals) + pWeights;
    pWeightsPage = pWeightsPage.*positivesPage;
    negativesPage = zeros(numClassifiers, numIntegrals) + negatives';
    nWeightsPage = zeros(numClassifiers, numIntegrals) + nWeights;
    nWeightsPage = nWeightsPage.*negativesPage;
    weightsPage = pWeightsPage + nWeightsPage;

for round = 1 : numIterations
    %normalize weights
    weightsPage = weightsPage / sum(weightsPage, 'all');
    
    %get errors
    errorsPage = weightsPage.*successes;
    errors = sum(errorsPage, 2);
    [lowest, classifierIndex] = min(errors);
    beta = lowest/(1-lowest);
    
    %adjust weights
   for s = 1 : numSuccesses
       sR = successRows(s);
       sC = successCols(s);
       w = weightsPage(sR, sC);
       ei = errorsPage(sR, sC);
       newW = w * beta^(1 - ei);
       weightsPage(sR, sC) = newW;
   end
   %record cascade values
   alpha = log(1/beta);
   c = classifiers(classifierIndex, 1 : 6);
   cascade(round, 1 : 6) = c(1, 1:6);
   cascade(round, 7) = alpha;
end