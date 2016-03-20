 fire=mmreader('sport1.avi');
nFrames = fire.NumberOfFrames;
vidHeight = fire.Height;
vidWidth = fire.Width;

mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
    a1=uint16(read(fire,10));
    for k = 11:20
    mov(k).cdata = read(fire, k);
    b1=uint16(mov(k).cdata)
    a1=a1+b1;
    end
    a1=a1./11;
    a=uint8(a1);
    mov(3300).cdata = read(fire, 3300);
    firstframe=mov(3300).cdata;
    firstimage=abs(a-firstframe);
    [data1,n]=foregroundcalc(firstimage);
Nd=cat(1,data1.Centroid);
Node=zeros(n,2,50);
DETail=zeros(4,1,50,n);
p=zeros(n,n,50);               %matrix to store the distance b/w objects in each frame
Spd=zeros(n,1,50);
Avspd=zeros(n,1);
X=zeros(1,n,50);
Y=zeros(1,n,50);
 r=1;
 ND1=zeros(n,2,50);            %matrix to store the centroids of each object in each frame
  for k =3301:3330
    mov(k).cdata = read(fire, k);
    b=mov(k).cdata;
    c=abs(a-b);
   [data,n1]=foregroundcalc(c);
centroids=cat(1,data.Centroid);  %centroid of object in present frame
imtool(c);
hold(imgca,'on');
plot(imgca,centroids(:,1),centroids(:,2),'r*');
hold(imgca,'off');
for i=1:n
x=[Nd(i,1),Nd(i,2);centroids];
y=pdist(x);
z1=squareform(y);        %distance of objects in present frame from nodes in last frame
m=size(z1);
Mn=min(z1(1,2:m(1,1)));  %minimum distance of node(i) from objects in present frame
m1=m(1,1)-1;
for o=1:m1
    if(z1(1,(o+1))==Mn)
        Nd(i,:)=[centroids(o,1),centroids(o,2)]; %assigning node(i) in present frame by minimum distance
    Spd(i,:,r)=[Mn*25];
    end
    X(1,i,r)=Nd(i,1);
    Y(1,i,r)=Nd(i,2);
end
plot(X(:,:,r),Y(:,:,r));
hold on;
X1=[X(1,1,r) X(1,n,r)];
Y1=[Y(1,1,r) Y(1,n,r)];
plot(X1,Y1);
hold off;
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
for i=1:r-1
    Avspd=Avspd+Spd(:,:,i);
end
Avspd=Avspd./(r-1);
AVspd=Avspd;
Mean=0;
for j=1:n
    Mx=max(AVspd(1:n,1));
    Mean=Mean+Avspd(j,1);
for k=1:n
    if(AVspd(k,1)==Mx)
DETail(1,1,:,j)=j;
for l=1:r-1
    DETail(2,1,l,j)=Spd(k,1,l);
    DETail(3,1,l,j)=l
    Node(j,:,l)=ND1(k,:,l);
end
    end
AVspd(k,1)=0;
DETail(4,1,:,j)=100./Avspd(k,1);
end
    end
  Mean=Mean./n;
  
      