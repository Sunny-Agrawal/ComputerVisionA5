function y = adaTrain(harCoords, trainingIntegrals, trainingLabels, numIterations, numNegatives, numPositives)

%create classifier set by assigning weights to har features.
weights = zeros(size(harCoords, 2));
weights(:, 1) = weights(:, 1) + 1/(2*numNegatives);
weights(:, 2) = weights(:, 2) + 1/(2*numPositives);

%hyperparameter
threshold = .1;


for round = 1 : numIterations
    
   
   %adjust weights
   
   
   %normalize weights
   weights(:, 1) = (weights(:, 1))/sum(weights(:, 1));
   weights(:, 2) = (weights(:, 2))/sum(weights(:, 2));
end