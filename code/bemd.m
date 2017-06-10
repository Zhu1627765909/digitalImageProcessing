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
subplot(2,2,1);imshow(imf_matrix(:,:,1));
subplot(2,2,2);imshow(imf_matrix(:,:,2));
subplot(2,2,3);imshow(imf_matrix(:,:,3));
subplot(2,2,4);imshow(imf_matrix(:,:,4));
end 