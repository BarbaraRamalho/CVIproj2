function [ bkg ] = Bkgimage( path )

frameIdComp = 6;

str = ['%s%.' num2str(frameIdComp) 'd.%s'];
nFrame = 300;

for k = 1: 1 : nFrame
    str1 = sprintf(str, path,k,'jpg')
    img = imread(str1);
    vid4D(:,:,:,k) = img;
    
end

bkg = median(vid4D,4);

imwrite(bkg,'background.jpg');

