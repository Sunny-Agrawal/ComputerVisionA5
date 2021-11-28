function [c2, c3, c4, c5, c6, c7, c8, c9, c10] = initScript(harFeatures, trainingIntegrals, trainingLabels)

c2 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 2);
c3 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 3);
c4 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 4);
c5 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 5);
c6 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 6);
c7 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 7);
c8 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 8);
c9 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 9);
c10 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 10);
