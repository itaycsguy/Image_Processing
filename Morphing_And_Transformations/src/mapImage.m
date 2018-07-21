function newIm = mapImage(im,T,sizeOutIm)
    %% Submitters:
    %%   Itay Guy,I.D. - 305104184
    %%   Judit Riss,I.D. - 302925474
    %% inputs: im - image to map,T - transformation [affine or projective],sizeOutIm - size of the destination image
    %% outputs: new mapped image
    r = sizeOutIm(1); % x axis
    c = sizeOutIm(2); % y axis
    [X,Y] = meshgrid(1:c,1:r);
    Z = ones(r,c);
    mat = ([X(:) Y(:) Z(:)]');
    sourceCoor = pinv(T)*mat;
    
    Zs = sourceCoor(3,:);
    Xs = sourceCoor(1,:)./Zs;
    Ys = sourceCoor(2,:)./Zs;

    indx = Xs < 1 | Xs > r;
    Xs(indx) = 1;
    Ys(indx) = 1;
    indy = Ys < 1 | Ys > c;
    Xs(indy) = 1;
    Ys(indy) = 1;
    
    alpha_Xs = (Xs - floor(Xs));
    alpha_Ys = (Ys - floor(Ys));
    
    
    NW = (((floor(Xs)-1).*r)+floor(Ys)+1);
    NE = (((floor(Xs)).*r)+floor(Ys)+1);
    SW = (((floor(Xs)-1).*r)+floor(Ys));
    SE = (((floor(Xs)).*r)+floor(Ys));
    
    
    maxLen = r*c;
    NW(NW < 1 | NW > maxLen) = 1;
    NE(NE < 1 | NE > maxLen) = 1;
    SW(SW < 1 | SW > maxLen) = 1;
    SE(SE < 1 | SE > maxLen) = 1;
    
    N = alpha_Xs.*double(im(NE)) + double(im(NW)).*(1-alpha_Xs);
    S = alpha_Xs.*double(im(SE)) + double(im(SW)).*(1-alpha_Xs);
    V = alpha_Ys.*double(N) + double(S).*(1-alpha_Ys);
    
    V(indx) = 255;
    V(indy) = 255;
    newIm = reshape(uint8(V),r,c);
end