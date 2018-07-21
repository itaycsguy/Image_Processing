function [imagePts1,imagePts2] = getImagePts(im1,im2)
    %% Submitters:
    %%   Itay Guy,I.D. - 305104184
    %%   Judit Riss,I.D. - 302925474
    %% inputs: im1,im2 - two image to pick corresponding pairs of points from them
    %% outputs: [imagePts1,imagePts2] - two set of corresponded points
    %initialize 2 arrays
    imagePts1 = [] ;
    imagePts2 = [];
    button=1;
    while button==1
    figure(1); % create first figure
    subplot(1,1,1);
    imshow(im1);
    title("Choose corresponding points [First]");
    [x,y,button] = ginput(1);%returns the x-coordinates, the y-coordinates, and the button or key designation. 
                             %button is a vector of integers indicating which mouse buttons you pressed (1 for left, 2 for middle, 3 for right)    
    if button == 3 % if we dont want to select points anymore
       break;
    end
    imagePts1 = [imagePts1; [x,y]]; % save the point[x,y] in the array.
    
    figure(2);%create second figure
    f2 = gcf;  %get current figure
    figure(f2);% show current figure
    imshow(im2);
    title("Choose corresponding points [Second]");
    
    button = 3;
    while button ~=1 % we must choose a point in the other picture
       [x,y,button] = ginput(1);
    end
    imagePts2 = [imagePts2; [x,y]]; % save the point [x,y] in the array.
    end     
    clf;
    close all;
end
     