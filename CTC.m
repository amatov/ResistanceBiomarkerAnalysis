function [ CTC, CD45 ] = CTC()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% read 3 images
I4 = imread('C:\matov\data\CTC\G_PT1_T48\G Pt1 T48 Pos 1-224\G Pt 1 T48-0022_p000048t00000001z003c04.tif');
I3 = imread('C:\matov\data\CTC\G_PT1_T48\G Pt1 T48 Pos 1-224\G Pt 1 T48-0022_p000048t00000001z003c03.tif');
I2 = imread('C:\matov\data\CTC\G_PT1_T48\G Pt1 T48 Pos 1-224\G Pt 1 T48-0022_p000048t00000001z003c02.tif');

% crop debug area of all 3 images
I4c = I4(1:50,1:50);
I3c = I3(1:50,1:50);
I2c = I2(1:50,1:50);

%---------------------------------------------
% SEGMENT FOREGROUND FOR ALL THREE CHANNELS

Ida = double(I4c); % Matt's bad example pos 48 DAPI/blue not detected any DAPI reasons
[detResDa, detMaskDa] = spotDetector(Ida);
% get rid of small dapi
figure,imshow(detMaskDa,[min(detMaskDa(:)) max(detMaskDa(:))/1])
% figure,imshow(detResDa,[])

Icd = double(I3c); % Matt's bad example pos 48 CD45/green
[detResCd, detMaskCd] = spotDetector(Icd);

Icy = double(I2c); % Matt's bad example pos 48 Cytok(CTC)/red
[detResCy, detMaskCy] = spotDetector(Icy);


%------------------------------------------------
% USE DAPI CHANNEL INFO TO CONFIRM CD45 and CTC



%-----------------------------------------------------
% READ ALL CENTROIDS INTENSITY & AREA FOR CD45 and CTC
% X1(1,:) = Red in -> detResCd
% X1(2,:) = Green in 
% X2(1,:) = Red in -> detResCy
% X2(2,:) = Green in 
%-------------------------------------------
% CLUSTER INTENSITY VECTORS (use Size info?)


%--------------------------------------------
% PLOT ONLY GREEN AREAS, PLOT ONLY RED AREAS
X(:,1) = c11;
X(:,2) = c22;
% X = [randn(100,2)+ones(100,2);...
%      randn(100,2)-ones(100,2)];
opts = statset('Display','final');

[idx,ctrs] = kmeans(X,2,...
                    'Distance','city',...
                    'Replicates',5,...
                    'Options',opts);

plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(ctrs(:,1),ctrs(:,2),'kx',...
     'MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko',...
     'MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
%---------------------
% SAVE RESULTS TO DISK




% end

