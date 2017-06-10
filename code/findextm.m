function [maxi,mini] = findextm(B); 
%INPUT: 
%   B is the image 
%----------------------------------------------- 
%OUTPUT: 
%   maxi is the transform matrix of A with 1's indicating 
%       a local maximum and 0's elsewhere 
%   mini is the transform matrix  of A with 1's indicating 
%       a local minimum and 0's elsewhere 
    kscale = 1; 
    [m,n] = size(B); 
    maxi = imextendedmax(B,0); 
    mini = imextendedmin(B,0); 
    maxi_d = bwdist(maxi); 
    mini_d = bwdist(mini); 
    maxi_w = watershed(maxi_d); 
    mini_w = watershed(mini_d);     
    % deal with the maxmium 
    tmax = max(max(maxi_w)); 
    index(1:tmax)=0;     
    for ii=1:m 
        for jj=1:n 
            if (maxi_w(ii,jj)>0) 
                index(maxi_w(ii,jj)) = index(maxi_w(ii,jj))+1; 
            end 
        end 
    end 
    tmin = min(index(1:tmax)); 
    for ii=1:m 
        for jj=1:n 
            if (maxi(ii,jj)==1)&(index(maxi_w(ii,jj)) <= kscale*tmin) 
                maxi(ii,jj)=0; 
            end 
        end 
    end 
    % deal with the minmium 
    tmax = max(max(mini_w)); 
    index(1:tmax)=0; 
    for ii=1:m 
        for jj=1:n 
            if (mini_w(ii,jj)>0) 
                index(mini_w(ii,jj)) = index(mini_w(ii,jj))+1; 
            end 
        end 
    end 
    tmin = min(index(1:tmax)); 
    for ii=1:m 
        for jj=1:n 
            if (mini(ii,jj)==1)&(index(mini_w(ii,jj)) <= kscale*tmin) 
                mini(ii,jj)=0; 
            end 
        end 
    end

