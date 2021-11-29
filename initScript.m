function [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10] = initScript(harFeatures, trainingIntegrals, trainingLabels)

c1 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 0);
c2 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 1);
c3 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 2);
c4 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 3);
c5 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 4);
c6 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 5);
c7 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 6);
c8 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 7);
c9 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 8);
c10 = initClassifiers(harFeatures, trainingIntegrals, trainingLabels, 9);
