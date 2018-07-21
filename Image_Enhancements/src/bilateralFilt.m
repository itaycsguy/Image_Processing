function cleanIm = bilateralFilt(im,radius,stdSpatial,stdIntensity)
%%  Inputs: im - grayscale image, radius - radius around the pixel [squere] to make the median calculation,stdSpatial - std of spatial,stdIntensity - std of photometric
%%  Outputs: cleanIm - image that cleaned using bilateral filter technique
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
                cleanIm(i,j) = 0;
            else %here there is no any exceeding for sure!
                Ix = double(im(i,j)); %current color
                x = [i;j]; %current index pair
                Iy = double(im(vecX,vecY)); %submatrix as relative to the radius window
                [y1,y2] = meshgrid(vecX,vecY); %y1 = x's and y2 = y's

                subt = sqrt(((x(1)-y1).^2) + ((x(2)-y2).^2)); %euclidian index distances
                Isubt = abs(Ix-Iy); %color pixel distances

                spa = exp(-((subt./stdSpatial).^2)); %gaussian index distances
                photo = exp(-((Isubt./stdIntensity).^2)); %gaussian photometric distances
                wU = sum(sum(spa.*photo.*Iy));
                wD = sum(sum(spa.*photo));
                cleanIm(i,j) = wU/wD;
            end
        end
    end
end