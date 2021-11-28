function y = adaTrain(harFeatures, trainingIntegrals, trainingLabels, classLabel, numIterations, numNegatives, numPositives)

%create classifier set by assigning weights to har features.
weights = zeros(size(harFeatures, 2));
weights(:, 1) = weights(:, 1) + 1/(2*numNegatives);
weights(:, 2) = weights(:, 2) + 1/(2*numPositives);

%hyperparameter
threshold = 100;


for round = 1 : numIterations
    errors = zeros(size(harFeatures,2));
    for integralNum = 1 : size(trainingIntegrals, 3)
       integral = trainingIntegrals(:, :, integralNum);
       dataLabel = trainingLabels(integralNum);
       for featNum = 1 : size(harFeatures, 2)
           feature = harFeatures(featNum, :)';
           featVal = sumFromIntegral(integral, feature(1), feature(2), feature(3), feature(4), feature(5));
           success = 0;
           
           if dataLabel == classLabel
               if featVal > threshold
                   success = 1;
               end
           else
               if featVal < threshold
                   success = 1;
               end
           end
           
           
       end
    end
   
   %adjust weights
   
   
   %normalize weights
   weights(:, 1) = (weights(:, 1))/sum(weights(:, 1));
   weights(:, 2) = (weights(:, 2))/sum(weights(:, 2));
end