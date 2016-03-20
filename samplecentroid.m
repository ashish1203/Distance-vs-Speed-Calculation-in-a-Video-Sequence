source = aviread('road.avi');
thresh = 25; 

bg = source(1).cdata; % read in 1st frame as background frame
bg_bw = rgb2gray(bg); 
fr_size = size(bg); 
width = fr_size(2);
height = fr_size(1);
fg = zeros(height, width);
prev=zeros(1, 2);


for i = 2:length(source);

    fr = source(i).cdata; % read in frame
    
    fr_bw = rgb2gray(fr); % convert frame to grayscale
    
    fr_diff = abs(double(fr_bw) - double(bg_bw));
    for j=1:width % if fr_diff > thresh pixel in foreground
        for k=1:height
            if ((fr_diff(k,j) > thresh))
                fg(k,j) = fr_bw(k,j);
            else
                fg(k,j) = 0;
            end
        end
    end
    bg_bw = fr_bw;
    
    figure(1),subplot(3,1,1),imshow(fr)
  
    subplot(3,1,2),imshow(uint8(fg))
    cform = makecform('srgb2lab');
     J = applycform(fr,cform);

    K=J(:,:,2);
    L=graythresh(J(:,:,2));
   BW1=im2bw(J(:,:,2),L);
   M=graythresh(J(:,:,3));

BW2=im2bw(J(:,:,3),M);

O=BW1.*BW2;
% Bounding box
P=bwlabel(O,8);
BB=regionprops(P,'Boundingbox');
st=regionprops(P,'Centroid');

%cur = [st.Centroid]; %here i want to calculate the centroid of dimension 1X2 but it is greater than that 

%size(cur)
BB1=struct2cell(BB);
BB2=cell2mat(BB1);

[s1 s2]=size(BB2);
mx=0;
for k=3:4:s2-1
    p=BB2(1,k)*BB2(1,k+1);
    if p>mx & (BB2(1,k)/BB2(1,k+1))<1.8
        mx=p;
        j=k;
    end
end
subplot(3,1,3),imshow(fr);
%hold on;
rectangle('Position',[BB2(1,j-2),BB2(1,j-1),BB2(1,j),BB2(1,j+1)],'EdgeColor','r' )

%speed=sqrt(st.*st-prev.*prev);
%if(speed>10)
%disp(sprintf('running'));
%else
%disp(sprintf('Standing'));
%end
%prev=BB(i,j);
end