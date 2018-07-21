%Main Script
%Submitters:
% Itay Guy,I.D- 305104184  
% Judit Riss,I.D. - 302925474
function markHoughLines(image,edges,lines,numLines,thresh,fillGap,minLength)
    [H,theta,rho] = hough(edges);
    peaks = houghpeaks(H,numLines,'threshold',ceil(thresh*max(H(:))));
    lines = houghlines(edges,theta,rho,peaks,'FillGap',fillGap,'MinLength',minLength);
    figure, imshow(image,[],'InitialMagnification','fit'), hold on
    max_len = 0;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

       % Determine the endpoints of the longest line segment
       len = norm(lines(k).point1 - lines(k).point2);
       if(len > max_len)
          max_len = len;
          xy_long = xy;
       end
    end
end