function integrals = image_integral(images, height, width)
%assuming RGB image column vectors

integrals = zeros(height, width, size(images, 2));
for imNum = 1 : size(images, 2)
    imageVec = images(:, imNum);
    im = reshape(imageVec, [height, width, 3]);
    grayed = im2gray(im);
    integral = integralImage(grayed);
    integrals(:, :, imNum) = integral(2:height+1, 2:width+1);
end

