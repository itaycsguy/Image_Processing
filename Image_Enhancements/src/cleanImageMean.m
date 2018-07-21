function cleanIm = cleanImageMean(im, radius,maskSTD)
%%  Inputs: im - grayscale image, radius - radius around the pixel [squere] to make the median calculation,maskSTD - the std of the Gaussian mask
%%  Outputs: cleanIm - image that cleaned using gaussian mean technique
    mask = zeros(2*radius+1);
    for i = (-radius:radius)
        for j = (-radius:radius) 
            power = (-((i^2)/(2*maskSTD^2))-((j^2)/(2*(maskSTD^2))));
            mask(i+radius+1,j+radius+1) = exp(power);
        end
    end
    normalizeSum = sum(sum(mask));
    if normalizeSum < 1
        normalizeSum = 1;
    end
    cleanIm = conv2(im,mask,'same')./normalizeSum;
end