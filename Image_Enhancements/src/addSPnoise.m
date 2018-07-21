function    noisyIm = addSPnoise(im, p)
%%
%Submitters:
% Itay Guy,I.D- 305104184  
% Judit Riss,I.D. - 302925474
% add saul and pepper form of noise
    s = size(im); % Get the size of the image
    RandNumbers = randi(2,1,round(p*s(1)*s(2))); %s(1)= number of rows, s(2)=number of cols
    RandNumbers(RandNumbers==1) = 0; % All the pixels that are equal to 1 are changed to 0
	RandNumbers(RandNumbers==2) = 255; % All the pixels that are equal to 2 are changed to 255
    im(randperm(s(1)*s(2),round(p*s(1)*s(2))))=RandNumbers; % We choose (size*p) fixels randomly, those pixels will get the new values.(size=s(1)*s(2))
    noisyIm=im;
    

end   