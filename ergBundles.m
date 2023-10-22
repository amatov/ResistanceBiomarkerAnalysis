function ergBundles


% open image
[fileName,dirName] = uigetfile('*.tif','Choose a .tif file');
        I = imread([dirName,filesep,fileName]);
I=double(I);

aux=70
I1 = I(aux:end-aux,aux:end-aux);
figure,imshow(I1,[])
% unimodal
coef = 1
    [cutoffInd, cutoffV] = cutFirstHistMode(I1,0);    
    
    
    I2 = I1>cutoffV*coef; % REMOVE THE NOISE FEATURES %no 3
    figure,imshow(I2,[])
    l2=length(find(I2))
    
    
    VAR = var(I2(:))
    ENT = entropy(I2)
    
% plot upper band
cut = 120
I4 = I1>cut;
l1 = length(find(I4))
figure,imshow(I4,[])


PERCENT_BUNDLE = l1/l2*100

a