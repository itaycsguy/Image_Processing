%Main Script
%Submitters:
% Itay Guy,I.D- 305104184  
% Judit Riss,I.D. - 302925474
%-----------------------------------------------START-HOUSE-MOTION-BLURRING-----------------------------------------------
disp("------------------------------------START-SCRIPT----------------------------------------------");
disp('----------------------------------------HOUSE-------------------------------------------------');
house = imread('house.tif');
[r,c] = size(house);
mask = zeros([r,c]);
gaussian_size = 10;
%gaussian mask -> x axis style -> builder:
mask(1,1:gaussian_size) = 1/gaussian_size; %mask
fft_mask = fft2(mask);
fft_house = fft2(house);
f = ifft2(fft_house./fft_mask); %inverse method
figure('Name','Image 1: House motion blurring','NumberTitle','off');
subplot(1,2,1);
imshow(uint8(house));
title('Original Image');
subplot(1,2,2);
imshow(uint8(f));
title('Fixed Image');
disp("The image is suffering of motion blurring. as we can see in the left up pixel corner, there is x-axis gaussin filter usage with the real image.");
disp("According inverse filtering -> we can divide the image by [10 pixels with 1/10 value at each cell] the fft2 of this gaussian mask and to get good enought appproximation of the source image.");
pause;
clf;
close all;
%-----------------------------------------------END-HOUSE-MOTION-BLURRING-------------------------------------------
%-----------------------------------------------START-CUPS-RINGGING-------------------------------------------------
disp('---------------------------------------CUPS-------------------------------------------------------------------');
cups = imread('cups.tif');
[r,c] = size(cups);
mask = ones([r,c]);
%rect mask -> builder:
x = 20;
y = 20;
mask((129-x):(129+x),(129-y):(129+y)) = 2; %rect  mask
fft_cups = fftshift(fft2(cups));
f = ifft2(fftshift(fft_cups.*mask));%save the low frequency in the rect
figure('Name','Image 2: Cups ringing','NumberTitle','off');
subplot(1,2,1);
imshow(uint8(cups));
title('Original Image');
subplot(1,2,2);
imshow(uint8(f));
title('Fixed Image');
disp("The image is suffering of ringing artifact. as we know from the lecture -> it could be done using convolution of the source image with sinc function. in addition, there is not decreasing as natural image should be.");
disp("According to convolution theorem and the inverse method -> we can divide the image by the fft2 of sinc function which is the rect mask.");
disp("we would like to fix the rect values so we saw the rect in the power spectrum and measured the size and the placement,");
disp("this datums helped us to define the fit rect mask.");
disp("The rect height got value 2 because of the 'distanct' between of the rect contour value that we can see in the power spectrum to the next value is approximately 2.");
pause;
clf;
close all;
%-----------------------------------------------END-CUPS-RINGGING---------------------------------------------------
%-----------------------------------------------START-UMBRELLA-ECHO-------------------------------------------------
disp('---------------------------------------UMBRELLA---------------------------------------------------------------');
umbrella = imread('umbrella.tif');
[r,c] = size(umbrella);
delta_mask = zeros([r,c]);
%echo mask -> builder -> need sum up to one!:
delta_mask(1,1) = 0.50;
delta_mask(5,80) = 0.50;
fft_mask = fft2(delta_mask);
fft_umbrella = fft2(umbrella);
F = zeros([r,c]);
for i = 1:r
    for j = 1:c
        if fft_mask(i,j) > 0.0000000001 %threshold
            F(i,j) = fft_umbrella(i,j)/fft_mask(i,j); %according to inverse method -> 0 if fft_mask(i,j) == 0 else divide
        end
    end
end
f = ifft2(F);
figure('Name','Image 3: duplicate umbrella','NumberTitle','off');
subplot(1,2,1);
imshow(uint8(umbrella));
title('Original Image');
subplot(1,2,2);
imshow(uint8(f));
title('Fixed Image');
disp("The image is duplicated, due to the lecture we know that there is using with duplication mask [- which is [0.5 0 ... 0 0.5 0 ... 0 ..0]] the first 0.5 is in (1,1) and the other is in (5,80).");
disp("We used inverse filtering to solve the problem.");
pause;
clf;
close all;
%-----------------------------------------------END-UMBRELLA-ECHO---------------------------------------------------
%-----------------------------------------------START-BABY-SALT-AND-PEPPER------------------------------------------
disp('---------------------------------------BABY-------------------------------------------------------------------');
baby_source = imread('baby.tif');
new_baby_bom = cleanImageMedian(baby_source,1);
load pts1.txt;
load pts2.txt;
figure('Name','Image 4: baby salt&pepper','NumberTitle','off');
subplot(1,2,1);
imshow(uint8(baby_source));
title('Original Image');
subplot(1,2,2);
createMorphSequence(baby_source,new_baby_bom,[1],0,pts1,pts2);
title('Fixed Image');
disp("The image is suffering of salt&pepper noising -> trivial solution by the lecture is to use median cleanning.");
disp("But, because we would not like to corrupt image edges and to keep the image much smooth we did the next steps:");
disp("1. use clearImageMedian -> using radius=1");
disp("2. use mapImage -> from the source image to the result we got from the clearImageMedian");
disp("it is working because we cleaned the image and resereved edges and making morphing as well using the mapping.");
disp("[actually - it made kind of median between all morphed images and that is the final solution]");
pause;
clf;
close all;
%-----------------------------------------------END-BABY-SALT-AND-PEPPER--------------------------------------------
%-----------------------------------------------START-Windmill------------------------------------------------------
disp('--------------------------------------------WINDMILL----------------------------------------------------------');
img = imread('windmill.tif');

F=fftshift(fft2(img));
%We found with ginput the points with the problem 

%First point 125,101
Window = F(123:127,99:103);
Window = Window(:);
M = mean(Window);
F(125,101) = M;
%Second point 133,157
Window = F(131:135,155:159);
Window = Window(:);
M = mean(Window);
F(133,157) = M;

im = ifft2(ifftshift(F));
figure('Name','Image 5: Windmill frequency','NumberTitle','off');
subplot(1,2,1), imshow(img);
title('Original Image, with frequency noise');
subplot(1,2,2), imshow(uint8(im));
title('fixed image');

disp('Explanation: To fix the problen we worked in Frequency world, first we need to make the image(F) : log10(1 +abs(F))');
disp('Then we find the points by using imagesc');
disp('We choose the points with the problem, first point(125,101), second point(133,157) and find the mean of every point between all their neighbors');
disp('And then we put the new value in the points and the image has been fixed');
pause;
clf;
close all;
%-----------------------------------------------Windmill-END--------------------------------------------------------
%------------------------------------------------START-USA-flag-----------------------------------------------------
disp('--------------------------------------USA-FLAG----------------------------------------------------------------');
Orig= imread('USAflag.tif');
Fix=Orig;

%We will divide the image to 3 parts and work on its part seperat

%First part- right to the stars
%We get the co-ordinates of this area by ginput;
FirstPart=CleanImageWidthMedian(Fix(1:92,143:300),4);
Fix(1:92,143:300)=FirstPart;

%Second part- all the above(under the stars and the area in first part).
%We get the co-ordinates of this area by ginput;
SecondPart=CleanImageWidthMedian(Fix(93:168,1:300),4);
Fix(93:168,1:300)=SecondPart;

%Third part - clean again this area from puxels with problem that stayed after we did the fix above
%We get the co-ordinates of this area by ginput;
ThirdPart=CleanImageWidthMedian(Fix(93:168,1:300),4);
Fix(93:168,1:300)=ThirdPart;

figure('Name','Image 6: USA flag','NumberTitle','off');
subplot(1,2,1), imshow(Orig);
title('Original Image, image with noise');
subplot(1,2,2), imshow(uint8(Fix));
title('Cleand image all 3 part together');

disp('Explanation: We used in "cleanImageMedianwidth" function, a function that clean the image with medain clean');
disp('The function is diffrent then the original clean median, she claen the image only to the width.');
disp('We dont want to harm the stripes so we use this function');
disp('We divided the clean to 3 parts:');
disp('First part: we cleaned the area right to the stars');
disp('Second part: we cleaedn the area under the stars and the area in the first part(all the bottom)');
disp('Third part: we cleaned again all the buttom because after the second part remain some unclean areas');
disp('At last: the image is cleaned');
pause;
clf;
close all;
%------------------------------------------------END-USA-flag-------------------------------------------------------
%------------------------------------------------START-Watermelon---------------------------------------------------
disp('------------------------------------Watermelon----------------------------------------------------------------');
Fixedmelon= imread('watermelon.tif');
%We choose the best value for lambda
lambda=22;
Currentfix=Sharpimg(double(Fixedmelon),lambda);
figure('Name','Image 7: Watermelon','NumberTitle','off');
subplot(1,2,1), imshow(Fixedmelon);
title('Original Image, image with blur');
subplot(1,2,2), imshow(uint8(Currentfix));
title('Fixed image: Edge Enhancement by Filtering');
disp('Explanation: A sharpening filter is applied in order to enhance edges and fine details (high frequency) in this image');
('We used in Shrping(method we wrote) to fix the problen above');
pause;
clf;
close all;
%------------------------------------------------END-Watermelon-----------------------------------------------------
%------------------------------------------------START-Bears--------------------------------------------------------
disp('--------------------------------------------Bears-------------------------------------------------------------');
img=imread('bears.tif');
% We need the image will be in double to do on her arithmetic operations
BearsTest= double(img);
%We need to find the smallest value of fixel
Minval =double( min(min(BearsTest)));
%We need to find the biggest value of fixel
Maxval=double( max(max(BearsTest)));
Bear = BearsTest-Minval;%For every pixel in the matrix we sub from his value the Minval
%now we normalize the values of every pixel in the matrix to be between 0-255
BearsFix=(((Bear)./(Maxval-Minval))*255);

%pause;
figure('Name','Image 8: bears','NumberTitle','off');
subplot(1,2,1), imshow(uint8(BearsTest));
title('Original Image with low contrast');
subplot(1,2,2), imshow(uint8(BearsFix));
title('Fixed image');
disp('We used in histogram equalization to fix the image.');
disp('For a better visual discrimination of an image we would like to re-assign gray-levels so that gray-level resource will be optimally assigned.');

pause;
clf;
close all;
%------------------------------------------------END-Bears----------------------------------------------------------
%------------------------------------------------END-SCRIPT---------------------------------------------------------
disp('------------------------------------END-SCRIPT-THANKS---------------------------------------------------------');