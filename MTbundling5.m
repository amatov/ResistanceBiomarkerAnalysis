function [st,et] = MTbundling5(dirName)

st=[];
et=[];
for i = 1:10
    % MATT BARAK1
    strg=sprintf('%%.%dd',2);
    indxStr=sprintf(strg,i);
    
    % open file manually
    if nargin == 0
        [fileName,dirName] = uigetfile('*.tif','Choose a .tif file');
    else
        fileName=[dirName(65:end),'_',indxStr,'_TU.tif'];
    end
    I = imread([dirName,fileName]);
    Idapi = imread([dirName,fileName(1:end-6),'DA.tif']);
    
    nor=1;%2^16;
    Ior=I;
    I=double(I)/nor;
    
    Idapi = double(Idapi)/nor;
    
    % WAVELET---------------------------------------------------
    [detResDa, detMaskDa] = spotDetector(Idapi);
    
    aux = Gauss2D(Idapi,1);%1
    sigma = 1.25;
    I2 = Gauss2D(Idapi,sigma);
    I3 = aux - I2;
    
    I3(find(I3<0))=0; % clipping
    
    %         figure,imshow(I3,[])
    I3a=imfill(I3);
    %         figure,imshow(I3a,[])%
    
    Ico = I3 | detMaskDa;
    Ico=double(Ico);
    % figure,imshow(Ico,[])
    
    XX = bwlabel(Ico);
    
    ss1 = regionprops(XX);
    bw1 = ismember(XX, find([ss1.Area] > 50  ));%default bw1 = ismember(Lbw, find([s.MeanIntensity] <
    % figure,imshow(double(bw1),[])
    %
    %
    [cutoffInd4, cutDAPI] = cutFirstHistMode(Idapi,0);
    Idapi2 = Idapi>cutDAPI*2 ;
%     %
    In=Ico.*Idapi2;
    % figure,imshow(In,[])% BEST SO FAR
    Ina=imfill(In);
    % figure,imshow(Ina,[])% BEST SO FAR
    
    %----------------------------------------------
    %  Icc=Idapi2&detMaskDa;
    %  figure,imshow(Icc,[])
    %  Perim=bwperim(Idapi2);
    %  figure,imshow(Perim,[])
    %  figure,imoverlay(Ior,Perim,'g')
    
    %   figure,imshow(Idapi,[])
    %  figure,imshow(Idapi2,[])
    
    
    %  distance_image = bwdist(~Idapi2);
    %
    % figure, imshow(distance_image,[])
    % colormap(bone)
    % colorbar
    
    Id7 = bwmorph(Idapi2,'dilate');
    Id7 = bwmorph(Ina,'dilate');
%     
%     Id7 = bwmorph(Id7,'dilate');
%     Id7 = bwmorph(Id7,'dilate');
    
    % Id5 = bwmorph(Id4,'dilate');
    % Id6 = bwmorph(Id5,'dilate');
    % Id7 = bwmorph(Id6,'dilate');
    
    Idn = Id7 - Ina;
%      Idn = Id7 - Idapi2;
    % figure,imshow(Idn,[])
    
    X = bwlabel(Idn);
    
    stats = regionprops(X,'all');
    
    
    
%     % INTENSITY BRIGHTNESS OF TU RING AROUND DILATED NUC
%     
% % %     Iaux = Idn.*I; % read the TU channel
% %  aux = Gauss2D(I,1);%1
% %     I2 = Gauss2D(I,sigma); %4 (Yukako 10)
% %     I  = aux - I2;
% %         I (find(I <0))=0; % clipping
% %     figure,imshow(Iaux,[])
% %     colormap(jet)
% %     colorbar
% %     
% %     hold on
% %     
    for i = 1: length(stats) % I RING DILATED
        s(i) = ceil(sum(I (stats(i).PixelIdxList))/length(stats(i).PixelIdxList)); % NORMALIZE TU INT PER AREA
%         s(i) = std(I (stats(i).PixelIdxList)); % TAKE MEDIAN, MAX, STD
        
%         text(stats(i).Centroid(1)-5,stats(i).Centroid(2)-5,[num2str(s(i))],'Color','r');
        
    end
    st=[st,s];
% %     et=[et,e];
% 

 [cutof, cutI] = cutFirstHistMode(I,0);
    Ic = I>cutI*3 ;
%     figure,imshow(Ic,[])
      X = bwlabel(Ic);
    %     warningState = warning;
    %     warning off all
    %     intwarning off
    s1 = regionprops(X,'all');

e=s1.Eccentricity
et=[et,e];
end




    
% NUMBER_OF_CELLS = length(st)
% figure,hist(st)
