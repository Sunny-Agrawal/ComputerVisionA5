function coords = harCoords(imHeight, imWidth, numFeatures)
%return a random subset of coordinates for har features of an image
%of given height and width. Will return slightly fewer than requested after
%removing invalid features from randomly generated subset.
%Coordinates are for the top-left and bottom-right corners of the rectangle
%for the har image. Format for the coordinates will be row and column of
%the top left followed by row and column of the bottom right in each row.
%The fifth column will have values 1-4, which dictate which type of feature
%it is.
%set minimum left and top coords to 2 to avoid padding complications.
coords = zeros(numFeatures, 5);
coords(:, 1) = round((imHeight - 3) * rand(numFeatures, 1)) + 2;
coords(:, 2) = round((imWidth - 3) * rand(numFeatures, 1)) + 2;
rowRange = (imHeight - 1) * ones(numFeatures, 1)- coords(:, 1);
colRange = (imWidth - 1) * ones(numFeatures, 1) - coords(:, 2);
rowIncrement = round(rowRange.*rand(numFeatures, 1)) + 1;
colIncrement = round(colRange.*rand(numFeatures, 1)) + 1;
coords(:, 3) = coords(:, 1) + rowIncrement(:, 1);
coords(:, 4) = coords(:, 2) + colIncrement(:, 1);

%assign feature types based on dimensions
for featNum = 1 : numFeatures
   width = colIncrement(featNum, 1) + 1;
   height = rowIncrement(featNum, 1) + 1;
   type = 0;
   
   if rem(width, 2) == 0 && rem(height, 2) == 0
       type = 4;
   elseif rem(width, 3) == 0
       type = 3;
   elseif rem(height, 2) == 0
       type = 2;
   elseif rem(width, 2) == 0
       type = 1;
   end
   coords(featNum, 5) = type;
end
%type 0 is invalid and should be removed
typesArray = (coords(:, 5))';
invalids = find(typesArray == 0);
invalids = sort(invalids, 'descend');

for i = 1 : size(invalids, 2)
    rowNum = invalids(i);
    coords(rowNum, :) = [];
end

%type 1 subtracts left half from right half
%type 2 subtracts bottom half from top half
%type 3 subtracts left and right thirds from middle third
%type 4 subtracts top-left and bottom-right fourths from top-right and bottom-left thirds 