clear all, close all

% EX 1
%------------------------------------------------
%{
img = imread('rabbitBW.jpg');

figure, hold on;
imshow(img);
se = strel('disk',3);

for k = 1: 30
    k
    %img = imerode(img,se);  %will remove information
    img = imdilate(img,se);  %will add information
    imshow(img); drawnow
    pause(.2)
end
%}
%------------------------------------------------

% EX 2
%------------------------------------------------
%{
%thr = 200;
minArea = 20;

imgg = imread('eight.tif');
%figure,imshow(imgg);

thr = input('Tell me the threshold? -> ');

if thr == 0
    thr = floor(graythresh(imgg) * 256);
end

se = strel('disk',3);
bw1 = imgg < thr;
imshow(bw1);

bw2 = imclose(bw1,se);
imshow(bw2);

[lb num]=bwlabel(bw2);
regionProps = regionprops(lb,'area','FilledImage','Centroid');
inds = find([regionProps.Area]>minArea);


hold on
for i=1:length(inds)
    %figure,imshow(regionProps(inds(i)).FilledImage);
    props = regionprops(double(regionProps(inds(i)).FilledImage),...
        'Orientation','MajorAxisLength','MinorAxisLength');
    ellipse(props.MajorAxisLength/2,props.MinorAxisLength/2,-props.Orientation*pi/180,...
      regionProps(inds(i)).Centroid(1),regionProps(inds(i)).Centroid(2),'r');
    
    plot(regionProps(inds(i)).Centroid(1),regionProps(inds(i)).Centroid(2),'g*')
    if exist('propsT')
        propsT = [propsT props];
    else
        propsT = props;
    end
end
N = length(inds)
str1 = sprintf('%s%d','O nº de objectos é ',N)

%}
%------------------------------------------------


%EX3
%------------------------------------------------
imgbk = imread('MATERIAL\\PETS09-S2L1\\img1\\000001.jpg');

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
    imgfr = imread(sprintf('MATERIAL\\PETS09-S2L1\\img1\\000%.3d.jpg',baseNum+i));
    imshow(imgfr);
    imgdif=...
        (abs(double(imgbk(:,:,1)) - double(imgfr(:,:,1))) > thr) | ...
        (abs(double(imgbk(:,:,2)) - double(imgfr(:,:,2))) > thr) | ...
        (abs(double(imgbk(:,:,3)) - double(imgfr(:,:,3))) > thr);
    bw = imclose(imgdif, se);
    [lb num] = bwlabel(bw);
    myRegions = regionprops(lb, 'area', 'FilledImage', 'Centroid');
    inds = find([myRegions.Area] > minArea);
    
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