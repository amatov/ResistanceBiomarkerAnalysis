    fltr4accum = [1 2 1; 2 6 2; 1 2 1];
    fltr4accum = fltr4accum / sum(fltr4accum(:));
    rawimg = double(imread('C:\Documents and Settings\amatov.LCCBWS035\Desktop\Matt\SD images\A549_PTX\A549_PTX_TU.TIF'));
        rawimg1 = double(imread('C:\Documents and Settings\amatov.LCCBWS035\Desktop\Matt\SD images\A549_PTX\A549_PTX_DA.TIF'));
    tic;
    [accum, circen,cirrad,dbg_LMmask] = CircularHough_Grd(rawimg, ...
        [4 14], 10, 4, 0.5, fltr4accum);
    toc;
    figure(1); imagesc(accum); axis image;
    title('Accumulation Array from Circular Hough Transform');
    figure(2); imagesc(rawimg); colormap('gray'); axis image;
    hold on; plot(circen(:,1), circen(:,2), 'r+'); 
t=0:.2:2*pi;
for i =1:length(cirrad)
    
%     r=cirrad(i)
% 
% plot(r*sin(t)+circen(i,1),r*cos(t)+circen(i,2),'r'); % r is the radius

text(circen(i,1)+5,circen(i,2)+5,[num2str(i)],'Color','r');
end
    hold off;
    title('Raw Image TUB with Circles Detected (center positions marked)');
%     
%         figure(3); imagesc(rawimg1); colormap('gray'); axis image;
%     hold on; plot(circen(:,1), circen(:,2), 'r+'); 
% % t=0:.2:2*pi;
% % for i =1:length(cirrad)
% %     r=cirrad(i)
% % 
% % plot(r*sin(t)+circen(i,1),r*cos(t)+circen(i,2),'r'); % r is the radius
% % end
%     hold off;
%     title('Raw Image DAPI with Circles Detected (center positions marked)');
    
    
        fltr4accum = [1 2 1; 2 6 2; 1 2 1];
    fltr4accum = fltr4accum / sum(fltr4accum(:));
    rawimg = double(imread('C:\Documents and Settings\amatov.LCCBWS035\Desktop\Matt\SD images\B1KD_PTX\B1KD_PTX_TU.TIF'));
    tic;
    [accum, circen,cirrad,dbg_LMmask] = CircularHough_Grd(rawimg, ...
        [4 14], 10, 4, 0.5, fltr4accum);
    toc;
    figure(3); imagesc(accum); axis image;
    title('Accumulation Array from Circular Hough Transform');
    figure(4); imagesc(rawimg); colormap('gray'); axis image;
    hold on; plot(circen(:,1), circen(:,2), 'r+'); 
t=0:.2:2*pi;
for i =1:length(cirrad)
%     r=cirrad(i)
% 
% plot(r*sin(t)+circen(i,1),r*cos(t)+circen(i,2),'r'); % r is the radius

text(circen(i,1)+5,circen(i,2)+5,[num2str(i)],'Color','r');
end
    hold off;
    title('Raw Image with Circles Detected (center positions marked)');
    
%  radrange:    The possible minimum and maximum radii of the circles
%               to be searched, in the format of
%               [minimum_radius , maximum_radius]  (unit: pixels)
%               **NOTE**:  A smaller range saves computational time and
%               memory.
%
%  grdthres:    (Optional, default is 10, must be non-negative)
%               The algorithm is based on the gradient field of the
%               input image. A thresholding on the gradient magnitude
%               is performed before the voting process of the Circular
%               Hough transform to remove the 'uniform intensity'
%               (sort-of) image background from the voting process.
%               In other words, pixels with gradient magnitudes smaller
%               than 'grdthres' are NOT considered in the computation.
%               **NOTE**:  The default parameter value is chosen for
%               images with a maximum intensity close to 255. For cases
%               with dramatically different maximum intensities, e.g.
%               10-bit bitmaps in stead of the assumed 8-bit, the default
%               value can NOT be used. A value of 4% to 10% of the maximum
%               intensity may work for general cases.
%
%  fltr4LM_R:   (Optional, default is 8, minimum is 3)
%               The radius of the filter used in the search of local
%               maxima in the accumulation array. To detect circles whose
%               shapes are less perfect, the radius of the filter needs
%               to be set larger.
%
% multirad:     (Optional, default is 0.5)
%               In case of concentric circles, multiple radii may be
%               detected corresponding to a single center position. This
%               argument sets the tolerance of picking up the likely
%               radii values. It ranges from 0.1 to 1, where 0.1
%               corresponds to the largest tolerance, meaning more radii
%               values will be detected, and 1 corresponds to the smallest
%               tolerance, in which case only the "principal" radius will
%               be picked up.
%
%  fltr4accum:  (Optional. A default filter will be used if not given)
%               Filter used to smooth the accumulation array. Depending
%               on the image and the parameter settings, the accumulation
%               array built has different noise level and noise pattern
%               (e.g. noise frequencies). The filter should be set to an
%               appropriately size such that it's able to suppress the
%               dominant noise frequency.