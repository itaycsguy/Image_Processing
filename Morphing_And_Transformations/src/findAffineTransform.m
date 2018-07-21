function T = findAffineTransform(pointsSet1,pointsSet2)
	%Developer: Itay Guy
    %% input: pointsSet1 - set of points from image A,pointsSet2 - set of points from image B
    % each two points are selected corresponding using image A and image B in the same time
    %% output: T =  affine transformation to these set of points
   s = size(pointsSet1); %size(pointsSet1) == size(pointsSet2)
   set_len = s(1);
   if set_len == 0
      disp("No set of points are avaliable.");
      T = []; %edge issue
      return;
   else if set_len < 3
      disp("3 pairs at least is required.");
      T = []; %edge issue
      return;
   end
   X = [pointsSet1(1,:) 0 0 1 0;0 0 pointsSet1(1,:) 0 1];
   Y = transpose(pointsSet2(1,:));
   for i = 2:set_len
      source = [pointsSet1(i,:) 0 0 1 0;0 0 pointsSet1(i,:) 0 1];
      X = [X;source];
      Y = [Y;transpose(pointsSet2(i,:))];
   end
   %T = inv(transpose(X)*X)*transpose(X)*Y = pinv(X)*Y!
   T = pinv(X)*Y; %under matlab docomentation pinv should multiply from the left side
   % T = [a b e;c d f;0 0 1]
   T = [T(1) T(2) T(5);T(3) T(4) T(6);0 0 1];
end