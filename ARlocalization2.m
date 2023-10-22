
function NUC_TO_CYTO_AR = MTbundling3(dirName)

% MATT BARAK1

% open file manually
if nargin == 0
        [fileName,dirName] = uigetfile('*.tif','Choose a .tif file');
else
fileName='\Tub.tif';
end
        I = imread([dirName,fileName]);
        Idapi = imread([dirName,fileName(1:end-6),'DA.tif']);
% Iar = imread([dirName,fileName(1:end-7),'ARGFP.tif']);
% DoG
    nor=1;%2^16;
    Ior=I;
I=double(I)/nor;
% Iar=double(Iar)/nor;
     Idapi = double(Idapi)/nor;

     % WAVELET
     [detResDa, detMaskDa] = spotDetector(Idapi);
% get rid of small dapi
figure,imshow(detMaskDa,[min(detMaskDa(:)) max(detMaskDa(:))/1])
    figure,imshow(Idapi,[])
    aux = Gauss2D(Idapi,1);%1
    sigma = 1.25;
    I2 = Gauss2D(Idapi,sigma);
    I3 = aux - I2;
% figure,imshow(I3,[])
% unimodal
        I3(find(I3<0))=0; % clipping

        % HOUGH TRANSFORM FIND CIRCLES

        figure,imshow(I3,[])
        I3a=imfill(I3);
        figure,imshow(I3a,[])%

Ico = I3 | detMaskDa;
Ico=double(Ico);
figure,imshow(Ico,[])

    XX = bwlabel(Ico);

     ss1 = regionprops(XX);
     bw1 = ismember(XX, find([ss1.Area] > 50  ));%default bw1 = ismember(Lbw, find([s.MeanIntensity] <
figure,imshow(double(bw1),[])

%      [cutoff1, cut1] = cutFirstHistMode(Ico,1);
%  Ico1 = Idapi>cut1*2 ;
%  figure,imshow(Ico1,[])

     [cutoffInd4, cutDAPI] = cutFirstHistMode(Idapi,0);
 Idapi2 = Idapi>cutDAPI*2 ;

 In=Ico.*Idapi2;
figure,imshow(In,[])% BEST SO FAR

 Icc=Idapi2&detMaskDa;
 Perim=bwperim(Idapi2);
 figure,imshow(Perim,[])
%  figure,imoverlay(Ior,Perim,'g')

  figure,imshow(Idapi,[])
 figure,imshow(Idapi2,[])


%  distance_image = bwdist(~Idapi2);
%
% figure, imshow(distance_image,[])
% colormap(bone)
% colorbar

Id2 = bwmorph(Idapi2,'dilate');
Id7 = bwmorph(Id2,'dilate');
% Id2 = bwmorph(Id3,'dilate');
% Id5 = bwmorph(Id4,'dilate');
% Id6 = bwmorph(Id5,'dilate');
% Id7 = bwmorph(Id6,'dilate');
Idn = Id7 - Idapi2;
figure,imshow(Idn,[])

    X = bwlabel(Idn);

    stats = regionprops(X,'all');



% INTENSITY BRIGHTNESS OF TU RING AROUND DILATED NUC

Iaux = Idn.*I; % read the TU channel
figure,imshow(Iaux,[])
colormap(jet)
colorbar

hold on

for i = 1: length(stats) % I RING DILATED
    s(i) = ceil(sum(I (stats(i).PixelIdxList))/length(stats(i).PixelIdxList)); % NORMALIZE TU INT PER AREA


text(stats(i).Centroid(1)-5,stats(i).Centroid(2)-5,[num2str(s(i))],'Color','r');

end
%-------------------------------------------------------------
 % ECCENTRICITY OF TU ARE (CYTO)  (OR THRESHOLDED AREA
% OF TU CROPPED AROUND NUC )

%     X1 = bwlabel(Idapi2);
 X1 = bwlabel(Icc );
    stats1 = regionprops(X1,'all');



for j = 1:length(stats1)
        feats.pos(j,1) = stats1(j).Centroid(1);
        feats.pos(j,2) = stats1(j).Centroid(2);
        feats.ecc(j,1) = stats1(j).Eccentricity;
        feats.ori(j,1) = stats1(j).Orientation;
        feats.len(j,1) = stats1(j).MajorAxisLength;
%
%         e1 = [-cos(stats1(j).Orientation*pi/180) sin(stats1(j).Orientation*pi/180) 0];
%         e2 = [sin(stats1(j).Orientation*pi/180) cos(stats1(j).Orientation*pi/180) 0];
%         e3 = [0 0 1];
%         Ori = [stats1(j).Centroid  0];
%         v1 = [-12 12];
%         v2 = [-10 10];
%         v3 = [0 0];
%         [xGrid,yGrid]=arbitraryGrid(e1,e2,e3,Ori,v1,v2,v3);
%
%         Crop(:,:,j) = interp2(I,xGrid,yGrid);
%         figure, imshow(Crop(:,:,j),[])
%         CropDA(:,:,j) = interp2(Idapi,xGrid,yGrid);
%         figure, imshow(CropDA(:,:,j),[])
%
%         Crop(:,:,j) = interp2(I,xGrid,yGrid);
%         figure, imshow(Crop(:,:,j),[])
%                 Crop(:,:,j) = interp2(I,xGrid,yGrid,'*linear');
%
%         e1 = [];e2 = [];e3 = []; Ori = []; v1 = []; v2 = []; xGrid = []; yGrid = [];
end

x = feats.pos(:,1);
y = feats.pos(:,2);
[vx, vy] = voronoi(x,y);

figure,imshow(I,[])
hold on
plot(x,y,'r+',vx,vy,'b-');% axis equal
figure,imshow(Idapi,[])
hold on
plot(x,y,'r+',vx,vy,'b-');% axis equal
% READ EACH VORONIN AREA of I


% figure,imshow(I,[])
% hold on
% x(:,1) = feats.pos(:,1);
% x(:,2) = feats.pos(:,2);
% [v , c] = voronoin(x);
% for i = 1 : size(c ,1)
%     ind = c{i}';
%     tess_area(i,1) = polyarea( v(ind,1) , v(ind,2) );
% end
%  for i = 1:length(c), disp(c{i}), end
% figure,tess_are
%
%
% [v,c]=voronoin(x);
% for i = 1:length(c)
% if all(c{i}~=1)   % If at least one of the indices is 1,
%                   % then it is an open region and we can't
%                   % patch that.
% patch(v(c{i},1),v(c{i},2),i); % use color i.
% end
% end

% Iaux1 = Idapi2.*I ; % read the AR channel
% figure,imshow(Iaux1,[])
% colormap(jet)
% colorbar
%
% hold on
%
% for i = 1: length(stats1) % NUCLEAR
%     s1(i) = ceil(sum(I (stats1(i).PixelIdxList))/length(stats1(i).PixelIdxList));% NORMALIZE AR INT PER AREA
%
%
% text(stats1(i).Centroid(1)-5,stats1(i).Centroid(2)-5,[num2str(s1(i))],'Color','r');
%
% end

sa=sort(s);
s1a=sort(s1);

dirName
NUC_TO_CYTO_AR = mean(s1a(end-5:end))/mean(sa(end-5:end))



