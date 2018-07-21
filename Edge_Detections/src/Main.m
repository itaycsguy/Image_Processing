%Main Script
%Submitters:
% Itay Guy,I.D- 305104184  
% Judit Riss,I.D. - 302925474

%############################################################################################
disp('---------------------------Start-Script--------------------------');
%############################################################################################
disp('----------------------------Question-1---------------------------');
%1)
balls1 = imread('balls1.tif');
Sx = (1/8)*[-1 0 1;-2 0 2;-1 0 1]; %sobel x derivative
Sy = (1/8)*[1 2 1;0 0 0;-1 -2 -1]; %sobel y derivative
threshold = 15.5;
G1 = conv2(balls1,Sx,'same');
G2 = conv2(balls1,Sy,'same');
Gv = sqrt(G1.^2 + G2.^2); %sobel magnitude
Gv(Gv < threshold) = 0;
Gv(Gv >= threshold) = 255;
imshow(Gv);
title("Sobel edge detection");
disp("Using sobel magnitude with x derivative matrix and y derivative matrix.");
disp("Computing the conv2 between source to Sx, and source to Sy. than calculating the magnitude image using sqrt(Gx.^2 + Gy.^2).");
disp("For output binary magnitude image - using threshold = 15.5");
disp("press enter to continue...");
pause;
clf;
close all;

%############################################################################################
%2)
disp('-----------------------------Question-2------------------------');
OrigCoins1= imread('coins1.tif');
%Canny Edge detection: Find the edge boundary of the coins
%edge(I,'Canny',threshold,sigma)
img1=edge(OrigCoins1,'Canny',0.37,7.4);
figure('Name','Original picture:coins1','NumberTitle','off');
subplot(1,2,1), imshow(OrigCoins1);
title('Original Image');
subplot(1,2,2), imshow(img1);
title('Canny Edge detection boundaries of coins' );
disp('We need to find with canny Edge detection complete coin boundaries with as minimum internal edge clutter as possible.');
disp('So we choose the thershold to be 0.37 and the sigma to be 7.4, to the better result');
disp("press enter to continue...");
pause;
clf;
close all;

%############################################################################################
disp('----------------------------Question-3---------------------------');
%3)
%  Canny Edge detection: Find the edge boundary of the balls1 in image
%edge(I,'Canny',threshold,sigma)
balls1 = imread('balls1.tif');
balls2 = imread('balls2.tif');
img2=edge(balls1,'Canny',[0.05 0.17],1.01);
figure('Name','Original picture:balls1','NumberTitle','off');
subplot(1,2,1), imshow(balls1);
title('Original Image');
subplot(1,2,2), imshow(img2);
title('Canny Edge detection boundaries of balls1' );
disp('We need to find with canny Edge detection complete balls boundaries with as minimum internal edge clutter as possible.');
disp('So we choose the thershold to be [0.05 - 0.17] and the sigma to be 1.01 to the better result');
close(figure);
disp("press enter to continue...");
pause;
disp('---------------------------------------------------------------------------------------------');
%edge(I,'Canny',threshold,sigma)
img3=edge(balls2,'Canny',[0.011 0.3],1.299);
figure('Name','Original picture:balls1','NumberTitle','off');
subplot(1,2,1), imshow(balls2);
title('Original Image');
subplot(1,2,2), imshow(img3);
title('Canny Edge detection boundaries of balls2' );
disp('We need to find with canny Edge detection complete balls boundaries with as minimum internal edge clutter as possible.');
disp('So we choose the thershold to be [0.011 - 0.3] and the sigma to be 1.299 to the better result');
close(figure);
disp("press enter to continue...");
pause;
clf;
close all;

%############################################################################################
disp('----------------------------Question-4---------------------------');
%4)
coins3 = imread('coins3.tif');
subplot(1,2,1),imshow(coins3);
title("Source image");
coins3_edges = edge(coins3,'canny'); %edge detector using canny technique
radii = 15:1:80; %range checker for circles
hough = circle_hough(coins3_edges, radii, 'same', 'normalise');
peaks = circle_houghpeaks(hough, radii, 'nhoodxy', 15, 'nhoodr', 25, 'npeaks', 12);
subplot(1,2,2),imshow(coins3);
title("Canny circle hough detection");
hold on;
for peak = peaks
    [x, y] = circlepoints(peak(3));
    plot(x+peak(1), y+peak(2), 'g-');
end
hold off
disp("Using Canny edge detection with default threshold and sigma=sqrt(2). Using also circle_hough and circle_houghpeaks to find 12 peaks in rage of 15 to 80 pixels.");
disp("press enter to continue...");
pause;
clf;
close all;
%############################################################################################
disp('----------------------------Question-5---------------------------');
%5)
boxChoc2Rot = imread('boxOfChocolates2rot.tif');
%rotI = imrotate(boxChoc2Rot,45,'crop');
boxChoc2RotEdges = edge(boxChoc2Rot,'canny',[0.01 0.3],1.9); %edge detector using canny technique 
subplot(1,3,1);
markHoughLines(boxChoc2Rot,boxChoc2RotEdges,lines,14,0.389,70,50);
title("boxChocolate2rot");
disp("Using Canny edge detection with threshold of [0.01 - 0.3]  an sigma 1.9. Using also hough transform,houghlines and houghpeaks with number of line=14,hough threshold=0.389, fill gap=70 and min length=50.");
disp("press enter to continue...");
pause;
clf;
close all;
disp('---------------------------------------------------------------------------------------------');
boxChoc2 = imread('boxOfChocolates2.tif');
boxChoc2Edges = edge(boxChoc2,'canny',[0.1 0.3],1.74); %edge detector using canny technique 
subplot(1,3,2);
markHoughLines(boxChoc2,boxChoc2Edges,lines,10,0.62,100,10);
title("boxOfChocolates2");
disp("Using Canny edge detection with threshold of [0.1 - 0.3]  an sigma 1.74. Using also hough transform,houghlines and houghpeaks with number of line=10,hough threshold=0.62, fill gap=100 and min length=10.");
disp("press enter to continue...");
pause;
clf;
close all;
disp('---------------------------------------------------------------------------------------------');
boxChoc1 = imread('boxOfChocolates1.tif');
boxChoc1Edges = edge(boxChoc1,'canny',[0.01 0.35],2.60); %edge detector using canny technique 
subplot(1,3,3);
markHoughLines(boxChoc1,boxChoc1Edges,lines,12,0.2,110,90);
title("boxOfChocolates1");
disp("Using Canny edge detection with threshold of [0.01 - 0.35]  an sigma 2.60. Using also hough transform,houghlines and houghpeaks with number of line=12,hough threshold=0.2, fill gap=110 and min length=90.");
disp("press enter to finish...");
pause;
clf;
close all;
%############################################################################################
disp("Thanks.");
disp('----------------------------End-Script---------------------------');
clf;
close all;