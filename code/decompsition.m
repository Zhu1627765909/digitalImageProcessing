function  [imf_de res_de]=decompsition(input_img)

[width height]=size(input_img);
x=1:width;
y=1:height;
input_img_temple=input_img;

while(1)
    [zmax imax zmin imin]=extrema2(input_img_temple);  %%%%ͼ����漫ֵ��
    [xmax ymax]=ind2sub(size(input_img_temple),imax);
    [xmin ymin]=ind2sub(size(input_img_temple),imin);

    [zmaxgrid,~,~]=gridfit(ymax,xmax,zmax,y,x);  %%%%������ϣ�Ѱ�Ұ�����ĵļ�ֵ��
    [zmingrid,~,~]=gridfit(ymin,xmin,zmin,y,x);


    zavggrid=(zmaxgrid+zmingrid)/2;   %%%%�����ֵ

    %%%%%%IMF�����ж�%%%%%

    imf_de=input_img_temple-zavggrid;
    SD=sum(sum(imf_de-input_img_temple).^2)/sum(sum(imf_de).^2);

    if SD<0.25
        break
    else 
        input_img_temple=imf_de;
    end

end

res_de=input_img-imf_de;

end
