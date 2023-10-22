function detectCTCs1(I1,I2,I3,x,y,ind,pos)

% SYNOPSIS detectCTCs1(Ick,Ida,Icd,x1,y1,lenght_im_ind,position);

s = 1;
 strg=sprintf('%%.%dd',s);
    indxStr=sprintf(strg,ind);

    [aux1, I1w] = spotDetector(double(I1));
[aux2, I2w] = spotDetector(double(I2));
% [aux3, I3w] = spotDetector(double(I3));

% vij dali centroid na CK ima DAPI>0 to confirm CK labeling is in a cell

% 
% figure,imshow(I2w,[])
% hold on
% plot(x,y,'g*')
% title('Nucleus WAVELET (w manual selection in green asterik)')

Ir = I1./I3; % DALI each pixel of average for areas?

% figure,imshow(Ir,[])
% hold on
% plot(x,y,'g*')
% title('Ratio CK/CD45 (w manual selection in green asterik)')

Inew = Ir.*I2w; % WHY MULTIPLIED
% figure, imshow(Inew,[])
% hold on
% plot(x,y,'g*')
% title('Ratio times Wavelet DAPI (w manual selection in green asterik)')

COEF1 = 7;
COEF2 = 20;
COEF3 = 0.8;% 0.6 is perfect for IMAGE 4 / 0.3 for images 3,4,5
% % retain only pixel intensities which are similar
[cutoffInd, cutoffV] = cutFirstHistMode(Inew,0);
Icut = Inew>cutoffV*COEF1; % REMOVE THE NOISE FEATURES %no 3

% figure,imshow(Icut,[])
% hold on
% plot(x,y,'g*')
% title('Unimodal hist (w manual selection in green asterik)')

X = bwlabel(Icut);
stats1 = regionprops(X,'all');

% cut areas by size
Ar = [stats1.Area];
% figure,hist(Ar);
[In_Ar,Cut_Ar]=cutFirstHistMode(Ar,0);% switch to 1 to see HIST
goodAr = find(Ar>(Cut_Ar*COEF3)); % SPOTS WHICH are big enough
stats = stats1(goodAr);
h = figure,imshow(I1,[])
hold on
for i = 1:length(stats)
    plot(stats(i).Centroid(1),stats(i).Centroid(2),'rs')
    text(stats(i).Centroid(1)+2,stats(i).Centroid(2)+2,[num2str(i)],'Color','r');

end
plot(x,y,'g*')
title(['POS ',pos,', CK channel: automated selection in red squares, manual selection in green asteriks'])

% saveas(h,(['CTCs_',indxStr,'.fig']),'fig');
% close

% Initialize 'feats' structure
% feats=struct(...
%     'pos',[0 0],...                   
%     'ecc',0,...                       
%     'ori',0);    
% 
% for j = 1:length(stats)
%     feats.pos(j,1) = stats(j).Centroid(1);
%     feats.pos(j,2) = stats(j).Centroid(2);
%     feats.ecc(j,1) = stats(j).Eccentricity;
%     feats.ori(j,1) = stats(j).Orientation;
%     feats.len(j,1) = stats(j).MajorAxisLength;
%     
%     e1 = [-cos(stats(j).Orientation*pi/180) sin(stats(j).Orientation*pi/180) 0];
%     e2 = [sin(stats(j).Orientation*pi/180) cos(stats(j).Orientation*pi/180) 0];
%     e3 = [0 0 1];
%     Ori = [stats(j).Centroid  0];
%     v1 = [-10 10];
%     v2 = [-5 5];
%     v3 = [0 0];
%     [xGrid,yGrid]=arbitraryGrid(e1,e2,e3,Ori,v1,v2,v3);
%     Crop(:,:,j) = interp2(I1,xGrid,yGrid); % READ FROM RAW DATA CYTOKERATIN
%     e1 = [];e2 = [];e3 = []; Ori = []; v1 = []; v2 = []; xGrid = []; yGrid = [];
% end
% 
% Cm = nanmean(Crop,3); % MEAN/REPRESENTATIVE CTC CROP
% Crop(isnan(Crop))=0;% border effect - some NaN
% Cm1 = bwlabel(Cm);
% statsC = regionprops(Cm1,'all');
% 
% B = Cm(:); % MEAN CTC
% A = ones(length(B),2);
% 
% for m = 1:size(Crop,3)
%     CR = Crop(:,:,m);
%     A(:,2) = CR(:); % INDIVIDUAL CTC
%     goodRows = find(A(:,2) ~= 0 & isfinite(B));
%     XX = lscov(A(goodRows,:),B(goodRows));
%     RES = B(goodRows) - A(goodRows,:)*XX;
%     OUT(m,:) = [mean(RES(:).^2),XX'];
% end
% 
% [Ind,V]=cutFirstHistMode(OUT(:,1),0);% switch to 1 to see HIST
% 
% goodFeats = find(OUT(:,1)<(V*COEF2)); % SPOTS WHICH FIT WELL WITH THE MEAN CTC SPOT
% 
% featNames = fieldnames(feats);
% 
% for field = 1:length(featNames)
%     feats.(featNames{field}) = feats.(featNames{field})(goodFeats,:);
% end

aaux = 0;%5
 
h=figure,
If=I3; 
imshow(If(1+aaux:end-aaux,1+aaux:end-aaux),[]);
title(['POS ',pos,', CD45 channel: automated selection in red squares, manual selection in green asteriks'])
hold on
 
for i = 1:length(stats)
    plot(stats(i).Centroid(1),stats(i).Centroid(2),'rs')
        text(stats(i).Centroid(1)+2,stats(i).Centroid(2)+2,[num2str(i)],'Color','r');

end
hold on
plot(x-aaux,y-aaux,'g*')

% saveas(h,(['Leukocytes_',indxStr,'.fig']),'fig');
% close
%-----------------------
h = figure,imshow(I2,[])
hold on
for i = 1:length(stats)
    plot(stats(i).Centroid(1),stats(i).Centroid(2),'rs')
        text(stats(i).Centroid(1)+2,stats(i).Centroid(2)+2,[num2str(i)],'Color','r');

end
plot(x,y,'g*')
title(['POS ',pos,', Nucleus (w manual selection in green asterik)'])

% saveas(h,(['Nucleus_',indxStr,'.fig']),'fig');
% close

%------------------------------------------------
% get centroids and plot together w handclicked

% get centroids and go back to original image to obtain connected component
% labeling properties

%