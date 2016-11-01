function processAllImages()
images = {};

for i=2:100
    fileName = strcat('img' , sprintf('%04d' , i) , '.jpg');
    completePath = '/Users/gaurav/Vision/TrackingDataset/BoBot/Vid_A_ball/';
    completePath = strcat(completePath , fileName);
    image = imread(completePath);
    images{i} = rgb2gray(image);
end

bgModel = computeBackgroundModel(images);

foreground = im2double(images{40}) - bgModel ;

imshow(im2bw(foreground));

Ia = single(im2bw(foreground)) ;
[fa,da] = vl_sift(Ia) ;

perm = randperm(size(fa,2)) ;
sel = perm(1:10) ;
h1 = vl_plotframe(fa(:,sel)) ;
h2 = vl_plotframe(fa(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;