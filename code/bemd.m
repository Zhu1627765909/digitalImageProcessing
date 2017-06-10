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
subplot(2,2,1);imshow(imf_matrix(:,:,1));
subplot(2,2,2);imshow(imf_matrix(:,:,2));
subplot(2,2,3);imshow(imf_matrix(:,:,3));
subplot(2,2,4);imshow(imf_matrix(:,:,4));
end 