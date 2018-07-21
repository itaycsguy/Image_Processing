function S= Sharpimg(im,lambda)
%This function sharp the image,  The parameter lambda controls the amount of amplification

%Initializing matrix 3*3
imtest =  zeros(3,3);
imtest(2,1)=(1/6);imtest(2,3)=(1/6);imtest(1,2)=(1/6);imtest(3,3)=(1/6);
imtest(2,2)=(2/6);
Bblur=conv2(im,imtest,'same');
%Bsharp=im-Bblur
S= im +( lambda * (im-Bblur));
 
end