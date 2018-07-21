function cleanIm = CleanImageWidthMedian(im,radius)
%This function clean the image with median cleaning to the width
[row,col]=size(im);
i=1;
j=1;
cleanIm = im();

    for indexi= i:row
        for indexj =  j:col
           if(indexj>=(radius+1) && indexj<=(col-radius))
           imgT = im(indexi,indexj-radius:indexj+radius);
           cleanIm(indexi,indexj)=median(imgT);
           end
        end
    end
end