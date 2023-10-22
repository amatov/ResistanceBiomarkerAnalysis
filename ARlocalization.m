function ARlocalization

% LUIGI files

% open file manually

        [fileName,dirName] = uigetfile('*.tif','Choose a .tif file');
        I = imread([dirName,fileName]);
        Idapi = imread([dirName,fileName(1:end-7),'Dapi.tif']);


        % FFT of image (to see if MT mesh will form a rectangle
        ih = fft2(I);
ih1 = log(1+abs(ih));
   figure,imshow(ih1,[])

I  = double(I);Idapi = double(Idapi);
   % Sum up Dapi and Mt channels
  In=Idapi/2+I;
figure, imshow(In,[])

% filter highly (maybe Median?)
Ign=Gauss2D(In,10);
figure, imshow(Ign,[])

Ign1 = Gauss2D(In,1)
figure, imshow(Ign1,[])

% looks for Edges/Contour

 %%% STEP 4: Calculate the Sobel image, which reflects gradients, which will
        %%% be used for the watershedding function.
        %%% Calculates the 2 sobel filters.  The sobel filter is directional, so it
        %%% is used in both the horizontal & vertical directions and then the
        %%% results are combined.
        filter1 = fspecial('sobel');
        filter2 = filter1';
        %%% Applies each of the sobel filters to the original image.
        I1 = imfilter(Ign1, filter1);
        I2 = imfilter(Ign1, filter2);
        %%% Adds the two images.
        %%% The Sobel operator results in negative values, so the absolute values
        %%% are calculated to prevent errors in future steps.
        AbsSobeledImage = abs(I1) + abs(I2);
        figure,imshow(AbsSobeledImage,[])
% DoG

% I=double(I);
%      Idapi = double(Idapi);

     [cutoffInd4, cutDAPI] = cutFirstHistMode(Idapi,0);
 Idapi2 = Idapi>cutDAPI*2;

 figure,imshow(Idapi2,[])

 distance_image = bwdist(~Idapi2);

figure, imshow(distance_image,[])
colormap(bone)
colorbar

Id2 = bwmorph(Idapi2,'dilate');
Id3 = bwmorph(Id2,'dilate');
Id4 = bwmorph(Id3,'dilate');
Id5 = bwmorph(Id4,'dilate');
Id6 = bwmorph(Id5,'dilate');
Id7 = bwmorph(Id6,'dilate');
Idn = Id7 - Idapi2;

    X = bwlabel(Idn);

    stats = regionprops(X,'all');

% list = stats(5).PixelIdxList;
% Itest = zeros(size(I,1),size(I,2));
% Itest(list) = I(list);
% figure,imshow(Itest,[])

Iaux = Idn.*I;
figure,imshow(Iaux,[])
colormap(jet)
colorbar

hold on

for i = 1: length(stats)
    s(i) = ceil(sum(I(stats(i).PixelIdxList))/length(stats(i).PixelIdxList));


text(stats(i).Centroid(1)-5,stats(i).Centroid(2)-5,[num2str(s(i))],'Color','r');

end








% [aux, Iw] = spotDetector(double(I));
% figure, imshow(Iw,[])

    figure,imshow(I,[]) % ORIGINAL IMAGE
    figure,imshow(Idapi,[])
    aux = Gauss2D(I,1);%1
    sigma = 1.25;
    I2 = Gauss2D(I,sigma);
    I3 = aux - I2;
% figure,imshow(I3,[])
% unimodal
        I3(find(I3<0))=0; % clipping

        % HOUGH TRANSFORM FIND CIRCLES

        figure,imshow(I3,[]) %




  % SET TO ZERO AREAS WHERE THERE IS DAPI

  % GET THE RINGS FROM DILATION AROUND DAPI
  %---------------------------------------------------

%         Inew3 = I3 - double(Idapi);
%
%         figure, imshow (Inew3,[])
%         Inew3(find(Inew3<0))=0; % clipping
%                 figure, imshow (Inew3,[])
%
%
%             [cutoffInd3, cut3] = cutFirstHistMode(I3,0);
%             I33 = I3>cut3*26;
%             figure, imshow(I33,[])
%           Y = bwlabel(I33);
%           figure, imshow(Y,[])
%
%
%     [cutoffInd, cutoffV] = cutFirstHistMode(I,0); % or I3? % GET THE OUTLINE - check with DAPI to confirm cell
%
%
%     % coef = 4 Katsu; coef = 1 Claudio; coef = 1 Lisa_xju103_r11;
%     I4 = I>cutoffV*1;%2.5; % REMOVE THE NOISE FEATURES %no 3
%
%     figure, imshow(I4,[])
%     X = bwlabel(I4);
%
%     stats = regionprops(X,'all');
%
%     Iaux = I4.*I;
% figure,imshow(Iaux,[])
% hold on
%
% phi = linspace(0,2*pi,50);
% cosphi = cos(phi);
% sinphi = sin(phi);
%
% for k = 1:length(stats)
%     xbar = stats(k).Centroid(1);
%     ybar = stats(k).Centroid(2);
%
%     a = stats(k).MajorAxisLength/2;
%     b = stats(k).MinorAxisLength/2;
%
%     theta = pi*stats(k).Orientation/180;
%     R = [ cos(theta)   sin(theta)
%          -sin(theta)   cos(theta)];
%
%     xy = [a*cosphi; b*sinphi];
%     xy = R*xy;
%
%     x = xy(1,:) + xbar;
%     y = xy(2,:) + ybar;
%
%     plot(x,y,'r','LineWidth',2);
% end
% hold off
% % multiply 1-0 mask with orginial image
% %     bw1 = ismember(Lbw, find([s.MeanIntensity] < 0.01 & [s.Area] > 20 & [s.Area] < 140 ));%default bw1 = ismember(Lbw, find([s.MeanIntensity] < 0.01 & [s.Area] > 20
% %     Inew = I.*bw1;
% % read dapi to get 1-0 nucleus
%
% Idapi = double(Idapi);
% % all regions with dapi = 0
% [cutoffInd1, cutoffV1] = cutFirstHistMode(Idapi,0);
%   Idapi1 = Idapi>cutoffV1*1;
%
% Ifinal = (I4-Idapi1).*I;
%
% % region props devide I per area
%
% % first debug plot
%      X1 = bwlabel(Ifinal);
%
%     stats1 = regionprops(X1,'all');
%
%     Iaux = I4.*I;
% figure,imshow(Iaux,[])
% hold on
%
% phi = linspace(0,2*pi,50);
% cosphi = cos(phi);
% sinphi = sin(phi);
%
% for k = 1:length(stats)
%     xbar = stats(k).Centroid(1);
%     ybar = stats(k).Centroid(2);
%
%     a = stats(k).MajorAxisLength/2;
%     b = stats(k).MinorAxisLength/2;
%
%     theta = pi*stats(k).Orientation/180;
%     R = [ cos(theta)   sin(theta)
%          -sin(theta)   cos(theta)];
%
%     xy = [a*cosphi; b*sinphi];
%     xy = R*xy;
%
%     x = xy(1,:) + xbar;
%     y = xy(2,:) + ybar;
%
%     plot(x,y,'r','LineWidth',2);
% end
% hold off
% Ifinal = (I4-Idapi1).*I;
%
% % second debug plot
%
% figure,imshow(X1,[])
% hold on
%
% phi = linspace(0,2*pi,50);
% cosphi = cos(phi);
% sinphi = sin(phi);
%
% for k1 = 1:length(stats1)
%     xbar1 = stats1(k1).Centroid(1);
%     ybar1 = stats1(k1).Centroid(2);
%
%     a1 = stats1(k1).MajorAxisLength/2;
%     b1 = stats1(k1).MinorAxisLength/2;
%
%     theta1 = pi*stats1(k1).Orientation/180;
%     R1 = [ cos(theta1)   sin(theta1)
%          -sin(theta1)   cos(theta1)];
%
%     xy1 = [a1*cosphi; b1*sinphi];
%     xy1 = R*xy;
%
%     x1 = xy1(1,:) + xbar1;
%     y1 = xy1(2,:) + ybar1;
%
%     plot(x1,y1,'r','LineWidth',2);
% end
% hold off
% % region props Ecc
%
