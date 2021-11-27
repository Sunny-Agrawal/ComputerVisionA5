function result = sumFromIntegral(integral, topRow, leftCol, botRow, rightCol)
%return the sum of the window of an image spanned by a top left and bottom
%right corner of an image using the image's integral.

area = integral(botRow, rightCol);
topRect = integral(topRow - 1, rightCol);
leftRect = integral(botRow, leftCol - 1);
trRect = integral(topRow - 1, leftCol - 1);

result = area - topRect - leftRect + trRect;