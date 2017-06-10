function IMF_all=TwoD_EMD(A,imf_num,errmax,imax); 
%INPUT: 
%   A is the image to be decomposed, given as a rectangular matrix 
%   imf_num is the number of intrinsic mode functions to be taken from A 
%   errmax is the maximum error for sift_bicubic 
%   imax is the maximum number of iterations in sift_bicubic 
%------------------------------------------------------------------- 
%OUTPUT: 
%   IMF_all is a 3D array containing each instrinsic mode function 
%       as well as the final residue 
figure(1) 
imagesc(A); 
colormap(gray); 
IMF_all=[]; 
[m,n]=size(A); 
dx=1/n; 
dy=1/m; 
for it=1:imf_num 
    IMF=sift_bicubic(errmax,imax,dx,dy,A); 
    figure(it+5) 
    imagesc(IMF); 
    colormap(gray); 
    A=A-IMF; 
    IMF_all(:,:,it)=IMF; 
end 
IMF_all(:,:,it+1)=A; 
figure(30) 
imagesc(A); 
colormap(gray); 

