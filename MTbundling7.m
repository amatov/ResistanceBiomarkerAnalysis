
function NUC_TO_CYTO_AR = MTbundling7(dirName)

% Luigi AR localization

% open file manually
if nargin == 0
        [fileName,dirName] = uigetfile('*.tif','Choose a .tif file');
else
fileName='\Tub.tif';
end
        I = imread([dirName,fileName]);
        Idapi = imread([dirName,fileName(1:end-8),'Dapi1.tif']);
Iar = imread([dirName,fileName(1:end-8),'ARGFP1.tif']);
% DoG
    nor=1;%2^16;
    Ior=I;
I=double(I)/nor;
Iar=double(Iar)/nor;
     Idapi = double(Idapi)/nor;

     [cutoffInd4, cutDAPI] = cutFirstHistMode(Idapi,0);
 Idapi2 = Idapi>cutDAPI*2;


     X = bwlabel(Idapi2);

    stats = regionprops(X,'all');


 for i = 1: length(stats) % get each nucleus

     % GET AVERAGE INT
    s(i) = ceil(sum(Iar(stats(i).PixelIdxList))/length(stats(i).PixelIdxList)); % NORMALIZE AR INT PER AREA


    % DILATE AND FIND INT FOR RING
    Id2 = bwmorph(Idapi2,'dilate');

    % GET AVERAGE INTENSITY FOR DILATE


    % CALCULATE AND DISPLAY RATIO
text(stats(i).Centroid(1)-5,stats(i).Centroid(2)-5,[num2str(s(i))],'Color','r');

    % KEEP PLOTTING RINGS ON ORIGINAL IMAGE

end







  figure,imshow(Idapi,[])
 figure,imshow(Idapi2,[])
   figure,imshow(Iar,[])
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

    X = bwlabel(Idn);

    stats = regionprops(X,'all');

% list = stats(5).PixelIdxList;
% Itest = zeros(size(I,1),size(I,2));
% Itest(list) = I(list);
% figure,imshow(Itest,[])

Iaux = Idn.*Iar; % read the AR channel
figure,imshow(Iaux,[])
colormap(jet)
colorbar

hold on

for i = 1: length(stats) % CYTOPLASM
    s(i) = ceil(sum(Iar(stats(i).PixelIdxList))/length(stats(i).PixelIdxList)); % NORMALIZE AR INT PER AREA


text(stats(i).Centroid(1)-5,stats(i).Centroid(2)-5,[num2str(s(i))],'Color','r');

end
%-------------------------------------------------------------


    X1 = bwlabel(Idapi2);

    stats1 = regionprops(X1,'all');



Iaux1 = Idapi2.*Iar; % read the AR channel
figure,imshow(Iaux1,[])
colormap(jet)
colorbar

hold on

for i = 1: length(stats1) % NUCLEAR
    s1(i) = ceil(sum(Iar(stats1(i).PixelIdxList))/length(stats1(i).PixelIdxList));% NORMALIZE AR INT PER AREA


text(stats1(i).Centroid(1)-5,stats1(i).Centroid(2)-5,[num2str(s1(i))],'Color','r');

end

sa=sort(s);
s1a=sort(s1);

dirName
NUC_TO_CYTO_AR = mean(s1a(end-5:end))/mean(sa(end-5:end))


cs [sdlc 
`````````````````````````````````````````````````````````````````````````````````````````````````````