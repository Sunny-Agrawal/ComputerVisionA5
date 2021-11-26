function integral = image_integral(imageVec)
%assuming a square RGB image
imDim = sqrt((size(imageVec, 1) / 3);
im = reshape(imageVec, [imDim, imDim, 3]);
grayed = im2gray(im);
