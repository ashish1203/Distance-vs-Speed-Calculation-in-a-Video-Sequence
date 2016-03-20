fire = mmreader('4.avi');

nFrames = fire.NumberOfFrames;
vidHeight = fire.Height;
vidWidth = fire.Width;

mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
mov1(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
mov2(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
for k = 1 : nFrames
    mov(k).cdata = read(fire, k);
    a= mov(k).cdata;
    mov1(k).cdata=rgb2hsv(a);
    mov2(k).cdata = rgb2ycbcr(a);
end
ymean=zeros(1,nFrames);
cbmean=zeros(1,nFrames);
crmean=zeros(1,nFrames);
for k = 1 : nFrames
   ymean(k)=mean((mean(mov2(k).cdata(:,:,1))),2);
   cbmean(k)=mean((mean(mov2(k).cdata(:,:,2))),2);
   crmean(k)=mean((mean(mov2(k).cdata(:,:,3))),2);
end
count_ycbcr=zeros(1,nFrames);
for k = 1 : nFrames
    for i = 1 : vidHeight
        for j = 1 : vidWidth
            if ((mov2(k).cdata(i,j,1)>mov2(1,k).cdata(i,j,2)))
                if ((mov2(1,k).cdata(i,j,3)>mov2(1,k).cdata(i,j,2)))
                    if ((mov2(1,k).cdata(i,j,1)>ymean(k)))
                        if ((mov2(1,k).cdata(i,j,2)<cbmean(k)))
                            if ((mov2(1,k).cdata(i,j,3)>crmean(k)))
                        count_ycbcr(k)=count_ycbcr(k)+1;
                            end
                        end
                    end
                end
            end
        end
    end
end
fycbcr = zeros(1,nFrames);
fireycbcr =0;
for k = 2 : nFrames
    if (count_ycbcr(k)>count_ycbcr(1)+100)
        fycbcr(k)=1;
    end
    fireycbcr=fycbcr(k)+fireycbcr;
end

count_smoke=zeros(1,nFrames);
for k = 1 : nFrames
    for i = 1 : vidHeight
        for j = 1 : vidWidth
            if ((mov(1,k).cdata(i,j,1))-5<=mov(1,k).cdata(i,j,2)<=(mov(1,k).cdata(i,j,1)))
                if ((mov(1,k).cdata(i,j,2))-5<=mov(1,k).cdata(i,j,3)<=(mov(1,k).cdata(i,j,2)))
                   count_smoke(k)=count_smoke(k)+1;
                end
            end
        end
    end
end
                              
fsmoke = zeros(1,nFrames);
firesmoke=0;
for k = 2 : nFrames
    if (count_smoke(k)>count_smoke(1)+20)
        fsmoke(k)=1;
    end
    firesmoke=fsmoke(k)+firesmoke;
end
    
count_rgb=zeros(1,nFrames);
for k = 1 : nFrames
    for i = 1 : vidHeight
        for j = 1 : vidWidth
            if ((mov(1,k).cdata(i,j,1))>=230)
                if ((mov(1,k).cdata(i,j,1))>mov(1,k).cdata(i,j,2))
                    if ((mov(1,k).cdata(i,j,2))>mov(1,k).cdata(i,j,3))
                        if (((mov(1,k).cdata(i,j,3))>100)&&((mov(1,k).cdata(i,j,3))<200))
                   count_rgb(k)=count_rgb(k)+1;
                        end
                    end
                end
            end
        end
    end
end
                     
                             
frgb = zeros(1,nFrames);
firergb = 0;
for k = 2 : nFrames
    if (count_rgb(k)>count_rgb(1)+20)
        frgb(k)=1;
    end
    firergb=frgb(k)+firergb;
end


count_hsv=zeros(1,nFrames);
for k = 1 : nFrames
    for i = 1 : vidHeight
        for j = 1 : vidWidth
            if ((mov(1,k).cdata(i,j,1))>=223)
                if ((mov(1,k).cdata(i,j,1))>mov(1,k).cdata(i,j,2))
                    if ((mov(1,k).cdata(i,j,2))>mov(1,k).cdata(i,j,3))
                        if ((mov1(1,k).cdata(i,j,2))>=(((255-mov(1,k).cdata)*0.3722)/236))
                            
                   count_hsv(k)=count_hsv(k)+1;
                        end
                    end
                end
            end
        end
    end
end

                       
                              
fhsv = zeros(1,nFrames);
firehsv=0;
for k = 2 : nFrames
    if (count_hsv(k)>count_hsv(1)+15)
        fhsv(k)=1;
    end
    firehsv=fhsv(k)+firehsv;
end
