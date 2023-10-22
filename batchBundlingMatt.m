function batchBundlingMatt






 %  click on the folder with the images when the dialog box opens
 listOfFiles = searchFiles('\.txt',[],'ask');


 
 le = length(listOfFiles);


for i = 1:le
close all
    dirName = fullfile(listOfFiles{i,2})
    [aux,e] = MTbundling6(dirName)
    
   I(i).s=aux;
    E(i).s=e;
end

s100=I(1).s;
s60=I(2).s;
s50=I(3).s;
s30=I(4).s;

ssi = max([size(s100,2),size(s60,2),size(s50,2),size(s30,2)]);

sN00(1:ssi - size(s100,2))=nan;
s100b = [s100,sN00];
sN60(1:ssi - size(s60,2))=nan;
s60b = [s60,sN60];
sN50(1:ssi - size(s50,2))=nan;
s50b = [s50,sN50];
sN30(1:ssi - size(s30,2))=nan;
s30b = [s30,sN30];


figure, boxplot([s100b',s60b',s50b',s30b'],'notch','on','whisker',1.5,  ...
   'widths', 0.8, 'labels', {'A549 CTL','A549 PTX', 'B1KD CTL', 'B1KD PTX'},...
     'positions' , [ 1, 3, 5, 7]);%,'FontSize', 20) ;
% ylim([0 22])
ylabel('Ring Intensity','FontSize', 20) ;

figure, boxplot([s60b',s30b'],'notch','on','whisker',1.5,  ...
   'widths', 0.8, 'labels', {'A549 PTX', 'B1KD PTX'},...
     'positions' , [ 1, 3]);%,'FontSize', 20) ;
% ylim([0 22])
ylabel('Ring Intensity','FontSize', 20) ;

% 
% s100=E(1).s;
% s60=E(2).s;
% s50=E(3).s;
% s30=E(4).s;
% 
% ssi = max([size(s100,2),size(s60,2),size(s50,2),size(s30,2)]);
% 
% sN00(1:ssi - size(s100,2))=nan;
% s100b = [s100,sN00];
% sN60(1:ssi - size(s60,2))=nan;
% s60b = [s60,sN60];
% sN50(1:ssi - size(s50,2))=nan;
% s50b = [s50,sN50];
% sN30(1:ssi - size(s30,2))=nan;
% s30b = [s30,sN30];
% 
% 
% figure, boxplot([s100b',s60b',s50b',s30b'],'notch','on','whisker',1.5,  ...
%    'widths', 0.8, 'labels', {'A549 CTL','A549 PTX', 'B1KD CTL', 'B1KD PTX'},...
%      'positions' , [ 1, 3, 5, 7]);%,'FontSize', 20) ;
% % ylim([0 22])
% ylabel('Tubulin Eccentricity','FontSize', 20) ;

a