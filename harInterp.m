function result = harInterp(integral, harInfo)
%integral is the integral image
%harInfo is an array as follows 
%[topLeftRow, topLeftColumn, bottomRightRow, bottomRightColumn, featureType]

topRow = harInfo(1);
leftCol = harInfo(2);
botRow = harInfo(3);
rightCol = harInfo(4);
fType = harInfo(5);
result = 0;
%type 1 subtracts left half from right half
%type 2 subtracts bottom half from top half
%type 3 subtracts left and right thirds from middle third
%type 4 subtracts top-left and bottom-right fourths from top-right and bottom-left thirds 

switch fType
    case 1
        leftHalfRightCol = (leftCol + rightCol - 1)/2;
        rightHalfLeftCol = leftHalfRightCol + 1;
        leftHalf = sumFromIntegral(integral, topRow, leftCol, botRow, leftHalfRightCol);
        rightHalf = sumFromIntegral(integral, topRow, rightHalfLeftCol, botRow, rightCol);
        result = rightHalf - leftHalf;
    case 2
        topHalfBotRow = (topRow + botRow - 1)/ 2;
        botHalfTopRow = topHalfBotRow + 1;
        topHalf = sumFromIntegral(integral, topRow, leftCol, topHalfBotRow, rightCol);
        botHalf = sumFromIntegral(integral, botHalfTopRow, leftCol, botRow, rightCol);
        result = topHalf - botHalf;
    case 3
        thirdWidth = (rightCol - (leftCol - 1))/3;
        leftThirdRightCol = thirdWidth + leftCol - 1;
        midThirdLeftCol = leftThirdRightCol + 1;
        midThirdRightCol = midThirdLeftCol + thirdWidth - 1;
        rightThirdLeftCol = midThirdRightCol + 1;
        leftThird = sumFromIntegral(integral, topRow, leftCol, botRow, leftThirdRightCol);
        midThird = sumFromIntegral(integral, topRow, midThirdLeftCol, botRow, midThirdRightCol);
        rightThird = sumFromIntegral(integral, topRow, rightThirdLeftCol, botRow, rightCol);
        result = midThird - leftThird - rightThird;
    case 4
        leftHalfRightCol = (leftCol + rightCol - 1)/2;
        rightHalfLeftCol = leftHalfRightCol + 1;
        topHalfBotRow = (topRow + botRow - 1)/ 2;
        botHalfTopRow = topHalfBotRow + 1;
        tl = sumFromIntegral(integral, topRow, leftCol, topHalfBotRow, leftHalfRightCol);
        tr = sumFromIntegral(integral, topRow, rightHalfLeftCol, topHalfBotRow, rightCol);
        bl = sumFromIntegral(integral, botHalfTopRow, leftCol, botRow, leftHalfRightCol);
        br = sumFromIntegral(integral, botHalfTopRow, rightHalfLeftCol, botRow, rightCol);
        result = tr + bl - tl - br;
end