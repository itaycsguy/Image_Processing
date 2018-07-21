%Developer: Itay Guy
%% Keep attention - we were write notes and answers as print to the console!!!

img1 = imread('Face1.tif');
img2 = imread('Face2.tif');

disp("a. Average of 2 faces");
avg = img1.*0.5 + img2.*0.5;
hold on;
subplot(1,3,1);
imshow(img1);
title("First");
subplot(1,3,2);
imshow(avg);
title("Average");
subplot(1,3,3);
imshow(img2);
title("Second");
hold off;
pause;
close all;

disp("b. Morph sequence of 8 images between source image to destination image");
load Face1Pts.txt;
load Face2Pts.txt;
hold on
createMorphSequence(img1,img2,[0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0],0,Face1Pts,Face2Pts);
hold off;
pause;
close all;


disp("c. An example that projective transform is working better than affine transform");
trapez = imread('trapez.tif');
squere = imread('squere.tif');
load trapezPts.txt;
load squerePts.txt;

%{
%print all points!
[trapezPts,squerePts] = getImagePts(trapez,squere);%(quadliteral1,quadliteral2);
disp(trapezPts);
disp("-----");
disp(squerePts);
%}

affineImg = mapImage(trapez,findAffineTransform(trapezPts,squerePts),size(squere));
projectiveImg = mapImage(trapez,findProjectiveTransform(trapezPts,squerePts),size(squere));
hold on;
subplot(1,4,1);
imshow(trapez);
title("Source");
subplot(1,4,2);
imshow(squere);
title("Target");
subplot(1,4,3);
imshow(affineImg);
title("Affine");
subplot(1,4,4);
imshow(projectiveImg);
title("Projective");
hold off;
disp("Explanation:");
disp("As we can see, the mathematic expectations are working. we made up a transformation between source image to the target image.");
disp("Affine transformation can change under: rotation, scaling, sheer. That's why no changing to angles have been taken.");
disp("Moreover, Projective transformation can change the angles using two more freedom parameters.");
disp("The Projective have this power because he is extending the affine transform using 8 freedom parameters instead of 6 that the affine holds.");
disp("Note: The Trapez [affine col] looks weight too much because of the difference between the length of the Trapez to the length of the squere!");
pause;
close all;


disp("d. Explanation why the choice of number of selected pairs affects morphing result:");
img5 = imread('Face5.tif');
img6 = imread('Face6.tif');
load Face5LessPts.txt;
load Face6LessPts.txt;
load Face5MorePts.txt;
load Face6MorePts.txt;
hold on;
lessPtsImg = mapImage(img5,findAffineTransform(Face5LessPts,Face6LessPts),size(img6));
subplot(1,3,1);
imshow(img6);
title("Target");
subplot(1,3,2);
imshow(lessPtsImg);
title("Less points");
fullPtsImg = mapImage(img5,findAffineTransform(Face5MorePts,Face6MorePts),size(img6));
subplot(1,3,3);
imshow(fullPtsImg);
title("Many points");
hold off;
disp("Using less points, we can see that the image is a little bit spread out and less fit to the face contour as expected of mapping to that target image.");
disp("In addition, using many points cannot say immidiately that the transformation will be well view. But, if we try to put some attention");
disp("about the pixels that we can pick, we would enhance the mapping for sure!");
disp("Due to the transformation operation we can learn that for each pixel there is another pixel that match it in the apposite image.");
disp("That is the reason why we must choose presented pixels that can characterize the image that we are looking at.");
disp("If we would not keep this rule of thumb, the first image will transform to the second image according to a transform matrix that used those pixels to be built - spread out fitting as we are expected from the data ['Face5LessPts.txt'].");
disp("Important note: this is very easy to think about pixels that could make worse mapping, for example: background pixels only without any contour,");
disp("no series points, and so on.");
pause;
close all;

disp("d. Explanation why the choice of position of selected pairs affects morphing result:");
trapez = imread('trapez.tif');
squere = imread('squere.tif');
load trapezPts.txt;
load squerePts.txt;
load trapezPtsExp.txt;
load squerePtsExp.txt;

affineImgDump = mapImage(trapez,findAffineTransform(trapezPtsExp,squerePtsExp),size(squere));
hold on;
subplot(1,3,1);
imshow(trapez);
title("Source");
subplot(1,3,2);
imshow(squere);
title("Target");
subplot(1,3,3);
imshow(affineImgDump);
title("Affine");
hold off;
affineImgSmart = mapImage(trapez,findAffineTransform(trapezPts,squerePts),size(squere));
hold on;
subplot(1,3,1);
imshow(trapez);
title("Source");
subplot(1,3,2);
imshow(squere);
title("Target");
subplot(1,3,3);
imshow(affineImgSmart);
title("Affine");
hold off;
disp("e. The choice gives us more power in the trasformation.");
disp("We know the transformation match vectors from the source image to the destination image,");
disp("if we would try to choose the pairs selectively, such as: angles, edges, cotours and so on, the pairs could be more presented.");
disp("the pairs will give us appropriate place to get the color from and that is the reason of smart choosing the pairs.");
disp("As we can see, using less presented pairs gave us a transformation from the source to the source!");
disp("As opposed to the many presented points that actually made the transformation from the source to the destination.");
disp("Important note: The Trapez [affine col] looks weight too much because of the difference between the length of the Trapez to the length of the squere!");
pause;
close all;

disp("END! Thanks.");