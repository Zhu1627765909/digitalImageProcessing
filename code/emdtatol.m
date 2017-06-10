function imf = emd(x)
% Empiricial Mode Decomposition (Hilbert-Huang Transform)
% EMD分解或HHT变换
% 返回值为cell类型，依次为一次IMF、二次IMF、...、最后残差
x   = transpose(x(:));
imf = [];
while ~ismonotonic(x)
    x1 = x;
    sd = Inf;
    while (sd > 0.1) || ~isimf(x1)
        s1 = getspline(x1);         % 极大值点样条曲线
        s2 = -getspline(-x1);       % 极小值点样条曲线
        h = x1-(s1+s2)/2;

        sd = sum((x1-h).^2)/sum(x1.^2);
        x1 = h;
    end

    imf{end+1} = x1;
    x          = x-x1;
end
imf{end+1} = x;
end
% 是否单调
function u = ismonotonic(x)
u1 = length(findpeaks1(x))*length(findpeaks1(-x));
if u1 > 0
    u = 0;
else
    u = 1;
end
end
% 是否IMF分量
function u = isimf(x)
N  = length(x);
u1 = sum(x(1:N-1).*x(2:N) < 0);                     % 过零点的个数
u2 = length(findpeaks1(x))+length(findpeaks1(-x));    % 极值点的个数
if abs(u1-u2) > 1
    u = 0;
else
    u = 1;
end
end
% 据极大值点构造样条曲线
function s = getspline(x)
N = length(x);
p = findpeaks1(x);
s = spline([0 p N+1],[0 x(p) 0],1:N);
end
function n = findpeaks1(x)
% Find peaks. 找极大值点，返回对应极大值点的坐标
n    = find(diff(diff(x) > 0) < 0); % 相当于找二阶导小于0的点
u    = find(x(n+1) > x(n));
n(u) = n(u)+1;  
end
function [imf_matrix]=bemd(img)

%%输入一副灰度图像
[row,col,dep] = size(img);%  row, col and depth of original image
if dep ~= 1
    img = im2double(rgb2gray(img));
else
    img = im2double(img);  
end

%%%%%主函数
% 分解IMF个数设置为3(加上残余量为4个分解量)（可根据实际情况修改）
m=4;
k=1;
input_img=img;
while(k<m)
    [imf_de res_de]=decompsition(input_img);  %% 通过分解得到IMF分量和余项
    imf_matrix(:,:,k)=imf_de;%%保存IMF分量
    input_img=res_de; %%将余项作为新信号，再次分解
    k=k+1;
end
imf_matrix(:,:,k)=res_de;%%保存残余量
end 


function  [imf_de res_de]=decompsition(input_img)

[width height]=size(input_img);
x=1:width;
y=1:height;
input_img_temple=input_img;

while(1)
    [zmax imax zmin imin]=extrema2(input_img_temple);  %%%%图像表面极值点
    [xmax ymax]=ind2sub(size(input_img_temple),imax);
    [xmin ymin]=ind2sub(size(input_img_temple),imin);

    [zmaxgrid,~,~]=gridfit(ymax,xmax,zmax,y,x);  %%%%曲面拟合，寻找包络面的的极值点
    [zmingrid,~,~]=gridfit(ymin,xmin,zmin,y,x);


    zavggrid=(zmaxgrid+zmingrid)/2;   %%%%包络均值

    %%%%%%IMF分量判断%%%%%

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


