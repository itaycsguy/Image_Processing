function createMorphSequence(im1,im2,t_list,transformType,pts1,pts2)
	%Developer: Itay Guy
    %% inputs: im1 - image1, im2 - image2 ,t_list - list of percentage to show part of ways for each image from the input,transformType - 0: affine,1: projective
    %% pts1,pts2 - input data points to find the transformation
    %% outputs: T - Projective transformation from pointSet1 to pointSet2
    T = [];
    %{
    [pts1,pts2] = getImagePts(im1,im2);
    %}
    if transformType == 0
        T = findAffineTransform(pts1,pts2);
    else
        T = findProjectiveTransform(pts1,pts2);
    end
    for t = t_list
        source = mapImage(im1,(t).*T + (1-t).*eye(size(T)),size(im1));
        dest = mapImage(im2,(1-t).*T + (t).*eye(size(T)),size(im2));
        crossDis = (1-t).*source + (t).*dest;
        subplot(1,1,1);
        imshow(crossDis);
    end
end