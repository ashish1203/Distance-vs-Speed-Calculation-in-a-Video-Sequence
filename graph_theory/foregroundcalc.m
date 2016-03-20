function [ data ,n] = foregroundcalc(foreground)
%this function will return the objects with the centroid in them 


foreground=uint8(foreground);
foreground1=rgb2gray(foreground);
foreground1=imadjust(foreground1);
thresh=graythresh(foreground1);
foreground2=im2bw(foreground1,.2);
foreground2=bwareaopen(foreground2,20);


[L,n]=bwlabel(foreground2,8);
data1= regionprops(L,'basic');

%for i=1:5  
  % if (abs(foreground(data1(i).centroid(1),data1(i).centroid(2))-foreground(data1(i).centroid(1)+30,data1(i).centroid(2)))>50)
   %    data1(i)=0;
   %end
   %if (abs(foreground(data1(i).centroid(1),data1(i).centroid(2))-foreground(data1(i).centroid(1),data1(i).centroid(2)+30))>50)
   %    data1(i)=0;
   %end
%end
for i =1:numel(data1)
    if (data1(i).Area<8)
        data1(i).Area=0;
        data1(i).Centroid(1)=0;
        data1(i).Centroid(2)=0;
        data1(i).BoundingBox(1)=0;
        data1(i).BoundingBox(2)=0;
        data1(i).BoundingBox(3)=0;
        data1(i).BoundingBox(4)=0;
    end
    
end
data=data1;


end

