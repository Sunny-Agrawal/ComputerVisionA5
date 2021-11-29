function [results, acc] = adaTestScript(cascade, integrals, labels, class)

numIntegrals = size(integrals, 3);
results =  zeros(3, numIntegrals);
for integralNum = 1 : numIntegrals
   results(1, integralNum) = adaTest(cascade, integrals(:, :, integralNum)); 
end

results(2, :) = labels == class;
results(3, :) = results(1, :) == results(2,:);

acc = sum(results(3, :), 'all') / numIntegrals;