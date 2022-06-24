clear;
close all;

image1=imread("data\문제1.png");
image2=imread("data\문제2.png");
image3=imread("data\문제3.png");
image4=imread("data\문제4.png");
image5=imread("data\문제5.png");

imshow(image1);
image1HSV = rgb2hsv(image1);
imshow(image1HSV)
image1H = image1HSV(:,:,1);
image1S = image1HSV(:,:,2);
image1V = image1HSV(:,:,3);

imageG_H = image1H >= 0.32 & image1H <= 0.36;
imageG_S = image1S >= 0.55 & image1S <= 0.68;
imageG_V = image1V >= 0.4 & image1V <= 0.6;
imageG_combi = imageG_H & imageG_S & imageG_V;

figure();
imshow(imageG_combi);hold on;

% stats = [regionprops(imageG_combi); regionprops(not(imageG_combi))]
stats = regionprops(imageG_combi);

centerCheck=0;
centerIdx=0;
for i = 1:numel(stats)
    if stats(i).Area>2000
        centerCheck=centerCheck+1;
        centerIdx=i;
    end
end

if centerCheck==1
    disp(['x=' num2str(stats(centerIdx).Centroid(1))])
    disp(['y=' num2str(stats(centerIdx).Centroid(2))])
end

for i = 1:numel(stats)
    rectangle('Position', stats(i).BoundingBox, ...
    'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
end

