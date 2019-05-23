clear all, close all


%EX3
%------------------------------------------------
imgbk = imread('3DMOT2015\\3DMOT2015\\train\\PETS09-S2L1\\img1\\000001.jpg');

thr = 40;
minArea = 200;


%baseNum = 1374
%seqLength = 0;
%imgshow(imgdif)

baseNum = 2;
seqLength = 800;

se = strel('disk', 3);
figure;

for i=0:seqLength
    imgfr = imread(sprintf('3DMOT2015\\3DMOT2015\\train\\PETS09-S2L1\\img1\\000%.3d.jpg',baseNum+i));
    
    imgdif=...
        (abs(double(imgbk(:,:,1)) - double(imgfr(:,:,1))) > thr) | ...
        (abs(double(imgbk(:,:,2)) - double(imgfr(:,:,2))) > thr) | ...
        (abs(double(imgbk(:,:,3)) - double(imgfr(:,:,3))) > thr);
    bw = imclose(imgdif, se);
    [lb num] = bwlabel(bw);
    myRegions = regionprops(lb, 'area', 'FilledImage', 'Centroid');
    inds = find([myRegions.Area] > minArea);
    
    %imshow(imgfr); hold on,
    imshow(imgfr); hold on,
    
    regnum = length(inds);
    
    if regnum
        for j=1:regnum
            [lin col] = find(lb == inds(j));
            upLPoint = min([lin col])
            dWindow = max([lin col]) - upLPoint + 1;
            
            rectangle('Position', [fliplr(upLPoint) fliplr(dWindow)],...
                'EdgeColor', [1 1 0], 'linewidth', 2);
        end
    end
    drawnow
    
end




%------------------------------------------------

% APONTAMENTOS
%------------------------------------------------
%{
    imerode will subtract information from the original image
    imdilate will add information from the original image

    These operations can be used to do some cleaning on the images
    ----
    
    [lb num] -> count the number of reagions and give them a value
    
    regionprops -> returns a structer with a number of fields
    (informations) 
    
    inds -> will return the area of the areas which are > 20
%}


%Tirar o background

