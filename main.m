clear all, close all
% VARIABLES AND STUFF
%--------------------------------------------------------------------
imgs_path = '3DMOT2015\\3DMOT2015\\train\\PETS09-S2L1\\img1\\'; %localization of the images
frame_num = 795 %the number of frames that exist, change this number if more is present
thr = 70 %threashold of the image

min_area = 100 %min area for the labels

frameIdComp = 6; %number of possible digits that exists in the images
str = ['%s%.' num2str(frameIdComp) 'd.%s']; %this creates the ready name of the images

se = strel('disk', 3); %you know what this does

teste = 1;
File = ['gt.txt'];
f = fopen(File, 'r');
C = textscan(f, '%d%d%d%d%f%f%d%f%f%f', 'Delimiter', ',');
fn = C{1}; in = C{2}; bbl = C{3}; bbt = C{4}; bbw = C{5};
bbh = C{6}; conf = C{7}; dx = C{8}; dy = C{9}; dz = C{10};
%fclose(f);


%--------------------------------------------------------------------


%verifications of the images
%--------------------------------------------------------------------
if exist('background.jpg', 'file') == 2
    bkgimage = imread('background.jpg');
else
    Bkgimage(imgs_path);
    bkgimage = imread('background.jpg');
end

%figure, imshow(bkgimage)
%--------------------------------------------------------------------

%REMOVE THE BACKGROUND AND SEE DIFFERENCESW
for k = 1: 1 : frame_num
    str1 = sprintf(str, imgs_path,k,'jpg')
    imgfr = imread(str1);
    


    
    imgdif=...
        (abs(double(imgfr(:,:,1)) - double(bkgimage(:,:,1))) > thr) | ...
        (abs(double(imgfr(:,:,2)) - double(bkgimage(:,:,2))) > thr) | ...
        (abs(double(imgfr(:,:,3)) - double(bkgimage(:,:,3))) > thr);
    
    bw = imclose(imgdif, se);
    
    [lb num] = bwlabel(bw);
    regions_img = regionprops(lb, 'area', 'FilledImage', 'Centroid');
    
    inds = [];
    

    
    for m = 1 : length(regions_img)
        if find([regions_img(m).Area] > min_area)
            inds = [inds m];
        end
    end
    imshow(imgfr); hold on,
    
    num_tot_reg = length(inds);

    if num_tot_reg
        for j=1:num_tot_reg
            [lin col] = find(lb == inds(j));
            upLPoint = min([lin col])
            dWindow = max([lin col]) - upLPoint + 1;
            
            width_heigth = fliplr(dWindow);
                             
            if(width_heigth(2) >= width_heigth (1))
                rectangle('Position', [fliplr(upLPoint) fliplr(dWindow)],...
                'EdgeColor', [1 1 0], 'linewidth', 1);
            
                while fn(teste) == k % Se a bounding box pertence ao frame actual
                    rectangle('Position',[bbl(teste) bbt(teste) bbw(teste) bbh(teste)], 'EdgeColor', [1 0 1])
                    teste = teste + 1;
                end

            end          
              
            
            
%     while fn(teste) == f % Se a bounding box pertence ao frame actual
%         rectangle('Position',[bbl(teste) bbt(teste) bbw(teste) bbh(teste)], 'EdgeColor', 'k')
%         teste = teste + 1;
%     end
%     
%     drawnow;   
      
          
            
            %disp('UPLPOINT:')
            %disp(upLPoint)
            %disp('DWINDOWS:')
            %disp(dWindow)
            
            %disp('FLIPED UPLPOINT:')
            %disp(fliplr(upLPoint))
            %disp('DLIPED DWINDOWS:')
            %disp(fliplr(dWindow))
           
        end
    end
    drawnow
end
