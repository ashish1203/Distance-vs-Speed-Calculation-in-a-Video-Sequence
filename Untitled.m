xyloObj = mmreader('e.avi');

nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

mov = read(xyloObj);
bearing_cov=0.01;

bg = mov(:,:,:,20);
imtool(bg);
frm_b = mov(:,:,:,84);
frm_0 = mov(:,:,:,85);
%imtool(frm_0);
frm_1 = mov(:,:,:,86);
%imtool(frm_1);
obj_b = bg - frm_b ;
obj_0 = bg - frm_0 ;

%imtool(obj_0);
%obj_1 = frm_1 - bg ;
obj_1 = bg - frm_1  ;

obj_b=rgb2gray(obj_b);

obj_b=imadjust(obj_b);
level = graythresh(obj_b);
obj_b=im2bw(obj_b,level);

obj_b = bwareaopen(obj_b, 500);
%imtool(obj_b);
cc = bwconncomp(obj_b,8);
data = regionprops(cc, 'basic');
p=data(1).BoundingBox;
centroid_b = [p(1)+(p(3)/2),p(2)+(p(4)/2)];
%centroid_b = nearest(centroid_b);

obj_0=rgb2gray(obj_0);

obj_0=imadjust(obj_0);
level = graythresh(obj_0);
obj_0=im2bw(obj_0,level);

obj_0 = bwareaopen(obj_0, 500);

cc = bwconncomp(obj_0,8);
data = regionprops(cc, 'basic');
p=data(1).BoundingBox;
centroid_0 = [p(1)+(p(3)/2),p(2)+(p(4)/2)];
%centroid_0 = nearest(centroid_0);

obj_1=rgb2gray(obj_1);

obj_1=imadjust(obj_1);
level = graythresh(obj_1);
obj_1=im2bw(obj_1,level);

obj_1 = bwareaopen(obj_1, 500);

cc = bwconncomp(obj_1,8);
data = regionprops(cc, 'basic');
p=data(1).BoundingBox;
centroid_1 = [p(1)+(p(3)/2),p(2)+(p(4)/2)];