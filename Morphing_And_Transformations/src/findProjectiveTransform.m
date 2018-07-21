function T = findProjectiveTransform(pointsSet1,pointsSet2)
	%Developer: Itay Guy
    %% inputs: set of point of im1 and set of point of im2
    %% outputs: T - Projective transformation from pointSet1 to pointSet2
   s = size(pointsSet1); %size(pointsSet1) == size(pointsSet2)
   set_len = s(1);
   if set_len == 0
      disp("No set of points are avaliable.");
      T = []; %edge issue
      return;
   else if set_len < 4
      disp("4 pairs at least is required.");
      T = []; %edge issue
      return;
   end
   sourceXY = pointsSet1(1,:); %source image
   resXY = pointsSet2(1,:); %target image
   % X = [x y 0 0 1 0 -xx' -yx']
   % Y = [0 0 x y 0 1 -xy' -yy']
   X = [sourceXY 0 0 1 0 (-1)*(sourceXY(1)*resXY(1)) (-1)*sourceXY(2)*resXY(1);0 0 sourceXY 0 1 (-1)*sourceXY(1)*resXY(2) (-1)*sourceXY(2)*resXY(2)];
   Y = transpose(resXY);
   for i = 2:set_len
      sourceXY = pointsSet1(i,:);
      resXY = pointsSet2(i,:);
      source = [sourceXY 0 0 1 0 (-1)*(sourceXY(1)*resXY(1)) (-1)*sourceXY(2)*resXY(1);0 0 sourceXY 0 1 (-1)*sourceXY(1)*resXY(2) (-1)*sourceXY(2)*resXY(2)];
      X = [X;source];
      Y = [Y;transpose(resXY)];
   end
   T = pinv(X)*Y; %under matlab docomentation pinv should multiply from the left side
   % T = [a b e;c d f;g h 1]
   T = [T(1) T(2) T(5);T(3) T(4) T(6);T(7) T(8) 1];
end