function bundlingMT4

I = double(imread('D:\matlab\CTC\Matt\A549_CTL_DA.TIF')); % Matt's bad example pos 350 DAPI/blue merging detected cells
It = double(imread('D:\matlab\CTC\Matt\A549_CTL_TU.TIF')); % Matt's bad example pos 350 DAPI/blue merging detected cells

% I = Gauss2D(I,2);

[detectionResults, detectionMask] = spotDetector(I, 3, 5, 1);% default S=4, thre=5, level=1 /// spotDetector(I, 4, 15, 2);

figure; 
 imagesc(I); colormap(gray(256)); axis image; title('Raw Data - Image 13');
%  figure
%  imagesc(detectionMask); colormap(gray(256)); axis image; title('Wavelet Segmentation');
%  
    X = bwlabel(detectionMask);
 
    stats1 = regionprops(X,'all'); 
    
     bw1 = ismember(X, find([stats1.Area] >= 40  ));%default bw1 = ismember(Lbw, find([s.MeanIntensity] < 
     bw1=bwlabel(bw1);% OLD MATLAB
%      bw1 = bw1.*I;
% figure,imshow(double(bw1),[])

  bw2 = ismember(X, find([stats1.Area] < 40  ));%default bw1 = ismember(Lbw, find([s.MeanIntensity] < 

% figure,imshow(double(bw2),[]) 
% Id=bw2;
 Id = bwmorph(bw2,'dilate');% ONLY DILATE THE SMALL ONES
%  Id = bwmorph(Ia,'dilate');% ONLY DILATE THE SMALL ONES
%  Id = Id.*I;
%  figure,imshow(Id,[])
 
 stats = regionprops(bw1,'all'); 
 
%  figure,imshow(bw1,[])
%  hold on
%  for k = 1:length(stats)
%     x = stats(k).Centroid(1);
%     y = stats(k).Centroid(2);
% 
%  
% 
%     plot(x,y,'*r' );
%  end
%  
  Id=bwlabel(Id);% OLD MATLAB
  statss = regionprops(Id,'all'); 
 
%  figure,imshow(Id,[])
%  hold on
%  for k = 1:length(statss)
%     x = statss(k).Centroid(1);
%     y = statss(k).Centroid(2);
% 
%  
% 
%     plot(x,y,'*b' );
%  end
 
 
 figure, imshow(I,[])
 hold on
  for k = 1:length(stats)
    x = stats(k).Centroid(1);
    y = stats(k).Centroid(2);

 

    plot(x,y,'*r' );
 end
 for k = 1:length(statss)
    x = statss(k).Centroid(1);
    y = statss(k).Centroid(2);

 

    plot(x,y,'*b' );
 end
 figure, imshow(It,[])
 hold on
  for k = 1:length(stats)
    x(k) = stats(k).Centroid(1);
    y(k) = stats(k).Centroid(2);

 

    plot(x(k),y(k),'*r' );
 end
 for k1 = 1:length(statss)
    x1(k1) = statss(k1).Centroid(1);
    y1(k1) = statss(k1).Centroid(2);

 

    plot(x1(k1),y1(k1),'*b' );
 end
%   Perim=bwperim(bw1);
%    Per1=bwperim(Id);
%    Pe = Perim | Per1;
%  figure,imshow(Pe ,[])
%  
%   hold on
%   for k = 1:length(stats)
%     x(k) = stats(k).Centroid(1);
%     y(k) = stats(k).Centroid(2);
% 
%  
% 
%     plot(x(k),y(k),'*r' );
%  end
%  for k1 = 1:length(statss)
%     x1(k1) = statss(k1).Centroid(1);
%     y1(k1) = statss(k1).Centroid(2);
% 
%  
% 
%     plot(x1(k1),y1(k1),'*b' );
%  end
D=createDistanceMatrix([y',x'],[y1',x1']); % GET RID OF BLUE (secondary) TOO CLOSE TO RED (primary)

x2=[x,x1];
y2=[y,y1];

% v1 = [-12 12];
% 
%         v2 = [-10 10];
%         v3 = [0 0];
%         [xGrid,yGrid]=arbitraryGrid(e1,e2,e3,Ori,v1,v2,v3);
%         
%         Crop(:,:,j) = I(x
%         figure, imshow(Crop(:,:,j),[])
%         CropDA(:,:,j) = interp2(Idapi,xGrid,yGrid);
%         figure, imshow(CropDA(:,:,j),[])
%         
%         Crop(:,:,j) = interp2(I,xGrid,yGrid);
%         figure, imshow(Crop(:,:,j),[])
%                 Crop(:,:,j) = interp2(I,xGrid,yGrid,'*linear');
