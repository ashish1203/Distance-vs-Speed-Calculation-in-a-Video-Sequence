fire=mmreader('ddd.avi');
nFrames = fire.NumberOfFrames;
vidHeight = fire.Height;
vidWidth = fire.Width;

mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
    a=read(fire,100);
    mov(553).cdata = read(fire, 553);
    firstframe=mov(553).cdata;
    firstimage=abs(a-firstframe);
   for  i=1:240
     for j=1:320
        for z=1:3
            if(firstimage(i,j,z)<=5) 
                firstimage(i,j,z)=0;
            end 
        end
    end
end;
Bw=im2bw(firstimage,0.05);
imshow(Bw);
[L,n]=bwlabel(Bw,8);
data=regionprops(L,'centroid');%no of centroids in firstframe
Nd=cat(1,data.Centroid);      %centroids of objects in first frame
p=zeros(2,2,50);              %matrix to store the distance b/w objects in each frame
Spd=zeros(n,1,50);
 r=1;
 ND1=zeros(n,2,50);           %matrix to store the centroids of each object in each frame
  for k = 553:600
    mov(k).cdata = read(fire, k);
    b=mov(k).cdata;
    c=abs(a-b);
   for  i=1:240
     for j=1:320
        for z=1:3
            if(c(i,j,z)<=20)
                c(i,j,z)=0;
            end 
        end
    end
end;
Bw1=im2bw(c,0.04);
imshow(Bw1);
[L1,n1]=bwlabel(Bw1,8);
data=regionprops(L1,'centroid');
centroids=cat(1,data.Centroid);%centroid of object in present frame
imtool(c);
hold(imgca,'on');
plot(imgca,centroids(:,1),centroids(:,2),'r*');
hold(imgca,'off');

for i=1:n
x=[Nd(i,1),Nd(i,2);centroids];
y=pdist(x);
z1=squareform(y);%distance of objects in present frame from nodes in last frame
m=size(z1);
Mn=min(z1(1,2:m(1,1)));%minimum distance of node(i) from objects in present frame
m1=m(1,1)-1;
for o=1:m1
    if(z1(1,(o+1))<=Mn)
        Nd(i,:)=[centroids(o,1),centroids(o,2)];%assigning node(i) in present frame by minimum distance
    Spd(i,:,r)=[Mn./25];
    end
end
for g1=1:2
ND1(i,g1,r)=Nd(i,g1);
end
end
y1=pdist(ND1(:,:,r));
squareform(y1)
z2=squareform(y1);
Sz=size(z2);
for g=1:Sz(1,1)
    for h=1:Sz(1,2)
p(g,h,r)=z2(g,h);
    end
end
r=r+1;
  end
  a=b;
  
  