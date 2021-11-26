function coords = harCoords(imHeight, imWidth, numFeatures)
%return a random subset of coordinates for har features of an image
%of given height and width.
%Coordinates are for the top-left and bottom-right corners of the rectangle
%for the har image. Format for the coordinates will be row and column of
%the top left followed by row and column of the bottom right in each row.
coords = zeros(numFeatures, 4);
coords(:, 1) = round(imHeight * rand(numFeatures, 1));
coords(:, 2) = round(imWidth * rand(numFeatures, 1));
rowRange = imHeight * ones(numFeatures, 1)- coords(:, 1);
colRange = imWidth * ones(numFeatures, 1) - coords(:, 2);
rowIncrement = round(rowRange.*rand(numFeatures, 1));
colIncrement = round(colRange.*rand(numFeatures, 1));
coords(:, 3) = coords(:, 1) + rowIncrement(:, 1);
coords(:, 4) = coords(:, 2) + colIncrement(:, 1);