function noisyIm = addGaussianNoise(im, s)
%%
%Submitters:
% Itay Guy,I.D- 305104184  
% Judit Riss,I.D. - 302925474
% add gaussian noise to some im [image] 
noisyIm = (double(im) + s*randn(size(im))); %sqrt(variance)= s , Add to all the pixels the noise
noisyIm(noisyIm>255)=255; %Check if after we add noise its bigger then 255, its going to be 255
noisyIm(noisyIm<0)=0; %Check if after we add noise its smaller then 0, its going to be 0

end