function cleanIm = cleanImageMedian(im,radius)
%%  Inputs: im - grayscale image, radius - radius around the pixel [squere] to make the median calculation
%%  Outputs: cleanIm - image that cleaned using median technique
    [r,c] = size(im);
    cleanIm = zeros(r,c);
    for i = 1:r
        for j = 1:c
            isextending = 0; % if isextending == 1 -> there is some exceeding -> put 0 as the pixel value
            kiMore = (i+radius);
            kiLess = (i-radius);
            if le(kiLess,0) || gt(kiMore,r)
                isextending = 1;
                kiMore = r;
                kiLess = 1;
            end
            kjMore = (j+radius);
            kjLess = (j-radius);
            if le(kjLess,0) || gt(kjMore,c)
                isextending = 1;
                kjMore = c;
                kjLess = 1;
            end
            
            vecX = kiLess:kiMore;
            vecY = kjLess:kjMore;
            
            if eq(isextending,1)
                cleanIm(i,j) = im(i,j);
            else
                subIm = im(vecX,vecY);
                subIm = subIm(:); % take sub-matrix using radius size from im
                cleanIm(i,j) = median(subIm);
            end
        end
    end
end