clear all, close all

% EX 1
%------------------------------------------------

myPath = '3DMOT2015\\3DMOT2015\\train\\PETS09-S2L1\\img1\\';
frameIdComp = 6;

str = ['%s%.' num2str(frameIdComp) 'd.%s'];
nFrame = 300;
step = 4;

for k = 1: 1 : nFrame
    str1 = sprintf(str, myPath,k,'jpg')
    img = imread(str1);
    vid4D(:,:,:,k) = img;
    %imshow(img); drawnow
    
end

%alpha = 0.015; % CHANGEN THIS VALUE FOR EPICNESS FADES, THIS IS HORROR MATERIAL

% for k = 1: 1 : nFrame
%     if k == 1
%         str1 = sprintf(str, myPath,k,'jpg')
%         img = imread(str1);
%         Bkg = zeros(size(img));
%     end
%     str1 = sprintf(str, myPath,k,'jpg')
%     img = imread(str1);
%     Bkg = alpha * double(img) + (1 - alpha) * double(Bkg);
%     imshow(uint8(Bkg)); drawnow
%     pause(.2)
%     %imshow(img); drawnow
%     
% end

bkg = median(vid4D,4);

figure, imshow(uint8(bkg));


%------------------------------------------------

% EX 2
%------------------------------------------------
%myPath = 'Z:\Desktop\some_test\MATERIAL\Ist\';



%------------------------------------------------


% APONTAMENTOS
%------------------------------------------------
%{
    frameIdComp = 4;

    str = ['%s%.' num2str(frameIdComp) 'd.%s'];
    str1 = sprintf(str, myPath,k,'png')

    the result of this will be (the path + the digitnumber (0000 as
    exmple)+ . + png in other words,  mypath\0000.png
%}