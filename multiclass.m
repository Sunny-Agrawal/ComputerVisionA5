function [results, accs, netAcc] = multiclass (cascades, integrals, labels)

numIntegrals = size(integrals, 3);
numClasses = size(cascades, 3);
accs = zeros(1, numClasses);
results =  zeros(3, numIntegrals, numClasses);

for classNum = 1 : numClasses
    [results(:, :, classNum), accs(1, classNum)] = adaTestScript(cascades(:,:, classNum), integrals, labels, classNum - 1);
end

netAcc = sum(accs, 'all') / numClasses;