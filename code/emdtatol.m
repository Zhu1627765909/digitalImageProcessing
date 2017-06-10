function imf = emd(x)
% Empiricial Mode Decomposition (Hilbert-Huang Transform)
% EMD�ֽ��HHT�任
% ����ֵΪcell���ͣ�����Ϊһ��IMF������IMF��...�����в�
x   = transpose(x(:));
imf = [];
while ~ismonotonic(x)
    x1 = x;
    sd = Inf;
    while (sd > 0.1) || ~isimf(x1)
        s1 = getspline(x1);         % ����ֵ����������
        s2 = -getspline(-x1);       % ��Сֵ����������
        h = x1-(s1+s2)/2;

        sd = sum((x1-h).^2)/sum(x1.^2);
        x1 = h;
    end

    imf{end+1} = x1;
    x          = x-x1;
end
imf{end+1} = x;
end
% �Ƿ񵥵�
function u = ismonotonic(x)
u1 = length(findpeaks1(x))*length(findpeaks1(-x));
if u1 > 0
    u = 0;
else
    u = 1;
end
end
% �Ƿ�IMF����
function u = isimf(x)
N  = length(x);
u1 = sum(x(1:N-1).*x(2:N) < 0);                     % �����ĸ���
u2 = length(findpeaks1(x))+length(findpeaks1(-x));    % ��ֵ��ĸ���
if abs(u1-u2) > 1
    u = 0;
else
    u = 1;
end
end
% �ݼ���ֵ�㹹����������
function s = getspline(x)
N = length(x);
p = findpeaks1(x);
s = spline([0 p N+1],[0 x(p) 0],1:N);
end
function n = findpeaks1(x)
% Find peaks. �Ҽ���ֵ�㣬���ض�Ӧ����ֵ�������
n    = find(diff(diff(x) > 0) < 0); % �൱���Ҷ��׵�С��0�ĵ�
u    = find(x(n+1) > x(n));
n(u) = n(u)+1;  
end
function [imf_matrix]=bemd(img)

%%����һ���Ҷ�ͼ��
[row,col,dep] = size(img);%  row, col and depth of original image
if dep ~= 1
    img = im2double(rgb2gray(img));
else
    img = im2double(img);  
end

%%%%%������
% �ֽ�IMF��������Ϊ3(���ϲ�����Ϊ4���ֽ���)���ɸ���ʵ������޸ģ�
m=4;
k=1;
input_img=img;
while(k<m)
    [imf_de res_de]=decompsition(input_img);  %% ͨ���ֽ�õ�IMF����������
    imf_matrix(:,:,k)=imf_de;%%����IMF����
    input_img=res_de; %%��������Ϊ���źţ��ٴηֽ�
    k=k+1;
end
imf_matrix(:,:,k)=res_de;%%���������
end 


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

    if SD<0.2
        break
    else 
        input_img_temple=imf_de;
    end

end

res_de=input_img-imf_de;

end


