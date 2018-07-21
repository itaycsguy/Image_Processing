%Main Script
%Submitters:
% Itay Guy,I.D- 305104184  
% Judit Riss,I.D. - 302925474

clear;
clc;
close all;
disp("Script Part 1: Spatial operations");

disp("press enter to continue...");
pause;

sp_lownoise=imread('splow_noise.jpg');
sp_highnoise=imread('sphigh_noise.jpg');
gau_lownoise=imread('gaulow_noise.jpg');
gau_highnoise=imread('gauhigh_noise.jpg');

disp("---------------------------------------------THE-START-OF-PART-1---------------------------------------------------");

disp("-----------------------------------------------------1---------------------------------------------------------------------");
img1=imread('splow_median.jpg');
img2=imread('splow_mean.jpg');
img3=imread('splow_blf.jpg');

disp(" The rank for the 3 cleaning methods according to how well they denoise for S&P low noised images are: ");
disp("1- is the best, 2- median, 3-the worst from left to right.");
figure('name','The image with sp low noise,with parameter p= 0.1');
imshow(sp_lownoise);

disp("press enter to continue...");
pause;

close;
figure('name',' The rank for the 3 cleaning methods according to how well they denoise for S&P low noised images are');
subplot(1,3,1);
imshow(img1);
title("rank 1: cleanImageMedian ");
subplot(1,3,2);
imshow(img2);
title("rank 2: cleanImageMean");
subplot(1,3,3);
imshow(img3);
title("rank 3: bilateralFilt");
hold off;

close all;
disp("Conclusion: ");
disp("The best method for sp low noise level is Median.");
disp("The worst method for sp low noise level is Blf.");

disp("press enter to continue...");
pause;

disp("----------------------------------------------------2-----------------------------------------------------------");
img4=imread('sphigh_median.jpg');
img5=imread('sphigh_mean.jpg');
img6=imread('sphigh_blf.jpg');
disp(" The rank for the 3 cleaning methods according to how well they denoise for S&P high noised images are: ");
disp("1- is the best, 2- median, 3-the worst");
figure('name','The image with sp high noise,with parameter p= 0.5');
imshow(sp_highnoise);

disp("press enter to continue...");
pause;

close;
figure('name',' The rank for the 3 cleaning methods according to how well they denoise for S&P high noised images are');

hold on;
subplot(1,3,1);
imshow(img4);
title("rank 1: cleanImageMedian ");
subplot(1,3,2);
imshow(img5);
title("rank 2: cleanImageMean");
subplot(1,3,3);
imshow(img6);
title("rank 3: bilateralFilt");
hold off;

close all;
disp("Conclusion: ");
disp("The best method for sp high noise level is Median.");
disp("The worst method for sp high noise level is Blf.");

disp("press enter to continue...");
pause;

disp("-----------------------------------------------3--------------------------------------------------------");
img7=imread('gau_low_median.jpg');
img8=imread('gau_low_mean.jpg');
img9=imread('gau_low_blf.jpg');
disp(" The rank for the 3 cleaning methods according to how well they denoise for Gaussian low noised images are: ");
disp("1- is the best, 2- median, 3-the worst");
figure('name','The image with gussian high noise,with parameter s= 30');
imshow(gau_lownoise);

disp("press enter to continue...");
pause;

close;
figure('name',' The rank for the 3 cleaning methods according to how well they denoise for Gaussian low noised images are');

hold on;
subplot(1,3,1);
imshow(img8);
title("rank 1: bilateralFilt ");
subplot(1,3,2);
imshow(img8);
title("rank 2: cleanImageMean");
subplot(1,3,3);
imshow(img7);
title("rank 3: cleanImageMedian ");
hold off;

close all;
disp("Conclusion: ");
disp("The best method for sp high noise level is Blf.");
disp("The worst method for sp high noise level is Median.");

disp("press enter to continue...");
pause;

disp("---------------------------------------------------4----------------------------------------------------------");
img10=imread('gau_high_median.jpg');
img11=imread('gau_high_mean.jpg');
img12=imread('gauhigh_blf.jpg');
disp(" The rank for the 3 cleaning methods according to how well they denoise for Gaussian high noised images are: ");
disp("1- is the best, 2- median, 3-the worst");
figure('name','The image with gussian high noise,with parameter s= 70');
imshow(gau_highnoise);

close;
figure('name',' The rank for the 3 cleaning methods according to how well they denoise for Gaussian high noised images are');
hold on;
subplot(1,3,1);
imshow(img12);
title("rank 1: bilateralFilt ");
subplot(1,3,2);
imshow(img11);
title("rank 2: cleanImageMean");
subplot(1,3,3);
imshow(img10);
title("rank 3: cleanImageMedian ");
hold off;

close all;
disp("Conclusion: ");
disp("The best method for sp high noise level is Blf.");
disp("The worst method for sp high noise level is Median.");

disp("press enter to continue...");
pause;

disp("---------------------------------------------THE-END-OF-PART-1---------------------------------------------------");

disp("---------------------------------------------THE-START-OF-PART-2---------------------------------------------------");

disp("-----------------------------------------------------5---------------------------------------------------------------------");
close all;
lena_gray = imread('lena.jpg');%rgb2gray(imread('lena.jpg'));
disp("5) a. power spectrum in the middle , b. phase in the right side");
subplot(1,3,1);
imshow(lena_gray);
lena_fft2 = fft2(lena_gray);
power_spectrum = log(abs(fftshift(lena_fft2)).^2);
subplot(1,3,2);
imagesc(power_spectrum);
% there is no solution for the scaling numbers at the sides using imagesc
colormap('gray');
set(gca,'dataAspectRatio',[1 1 1]);
phase = atan(imag(lena_fft2)./real(lena_fft2));
subplot(1,3,3);
imshow(phase);
pause;
clf;
close all;
MSE = sum(sum((abs(lena_fft2).^2 - abs(fftshift(lena_fft2)).^2)));
disp("Translation property: We can see that the MSE between image fft power spectrum and its translation is : [" + MSE + "] ~ 0 (Exactly as we learned in class)");

disp("press enter to continue...");
pause;

disp("-----------------------------------------------------6---------------------------------------------------------------------");
disp("6) Show that if image g = alpha*f1 + betta*f2 -> fft2(g) = alpha*fft2(f1) + betta*fft2(f2)");
alpha = 6;
betta = 13;
f1 = [1 5 8 2 6 5];
f2 = [8 9 6 4 4 1];
g = alpha*f1 + betta*f2;
G = alpha*fft2(f1) + betta*fft2(f2);
disp("alpha = " + alpha);
fprintf("f1 = ");
disp(f1);
disp("betta = " + betta);
fprintf("f2 = ");
disp(f2);
fprintf("g = alpha*f1 + betta*f2 -> fft2(g) = ");
disp(fft2(g));
fprintf("G = alpha*fft2(f1) + betta**fft2(f2) -> G = ");
disp(G);
disp("As result, we can see that the linearity property is viewed and fft2(g) = G.");

disp("press enter to continue...");
pause;

disp("-----------------------------------------------------7---------------------------------------------------------------------");
disp("7) Show Parseval's theorem:");
f1 = [1 5 8 2 6 5];
fprintf("f1 = ");
disp(f1);
f_norm = norm(f1)^2;
disp("sum for each squered norma of item in f1 = " + f_norm);
F_norm = (1/6)*norm(fft2(f1))^2;
% must divide by 1/N   because fft2 implementation is not making  this
% operation -> 1/N  is operation under ifft2 implementation
disp("sum for each squered norma of item in fft2(f1) = " + F_norm);

disp("press enter to continue...");
pause;

disp("-----------------------------------------------------8---------------------------------------------------------------------");
disp("8) Show that the Fourier transform is conjugate-symmetric:");
f1 = [1 5 8 2 6 5];
fprintf("f1 = ");
disp(f1);
F1 = fft2(f1);
fprintf("F1 = ");
disp(F1);
fprintf("F1* = ");
disp(conj(F1));
fprintf("F1(2) = ");
disp(F1(2));
fprintf("F1*(6) = ");
disp(conj(F1(6)));
% index 1 is reserved for the DC coffitiant

disp("press enter to continue...");
pause;

disp("-----------------------------------------------------9---------------------------------------------------------------------");
disp("9) Show that cyclic shift of an image preserves the power Spectrum:");
subplot(1,2,1);
imagesc(power_spectrum);
colormap('gray');
set(gca,'dataAspectRatio',[1 1 1]);
lena_fft2_circshift = circshift(lena_fft2,100);
circ_power_spectrum = log(abs(fftshift(lena_fft2_circshift)).^2);
subplot(1,2,2);
imagesc(circ_power_spectrum);
colormap('gray');
set(gca,'dataAspectRatio',[1 1 1]);
disp("sum of difference image between regular power spectrum and the circshift one = " + (sum(sum(power_spectrum-circ_power_spectrum))) + " ~ 0");

disp("press enter to continue...");
pause;

clf;
close all;

disp("-----------------------------------------------------10---------------------------------------------------------------------");
disp("10) Show that rotating the Fourier Transform of an image an image by 90 degrees, rotates the image by same amount:");
disp("We can clearly see that 90 degrees rotation of the image cause to the fft of that image to be rotated.");
disp("left = the source image");
disp("middle = the fft of that source image");
disp("right = the fft rotation");
f_rot = rot90(lena_gray);
F_rot = fftshift(fft2(f_rot));
subplot(1,3,1);
imshow(uint8(f_rot));
subplot(1,3,2);
lena_fft_shift = fftshift(lena_fft2);
imshow(real(lena_fft_shift));
subplot(1,3,3);
imshow(real(F_rot));
MSE = sum(sum((abs(F_rot).^2 - abs(lena_fft_shift).^2)));
disp("More over, we can see that the MSE between the source fft of that image and its rotation is: " + MSE + " ~ 0");
pause;
clf;
close all;

disp("---------------------------------------------THE-END-OF-PART-2---------------------------------------------------");
disp("---------------------------------------------END-OF-THE-MAIN-SCRIPT---------------------------------------------------");
disp("Thanks.");