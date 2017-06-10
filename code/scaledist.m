function [maxmin] = scaledist(maxmin,A); 
%INPUT: 
%   maxmin is the array indicating local extrema on A 
%       with 1's and having 0's elsewhere 
%   A is the image 
%********************************************************************* 
%OUTPUT: 
%   [maxmin] is the array indicating characteristic points of A, including 
%       the corners, with 1's and having 0's elsewhere 
[m,n] = size(maxmin); 
h=0; 
for ii=1:m 
    for jj=1:n 
        if (maxmin(ii,jj)==1) 
            for kk=-h:h 
                for ll=-h:h 
                    ik=ii+kk; 
                    jl=jj+ll; 
                    if ((kk~=0)|(ll~=0))&(ik>=1)&(ik<=m)&(jl>=1)&(jl<=n) 
                        maxmin(ik,jl)=0; 
                    end 
                end 
            end 
        end 
    end 
end 
maxmin(1,1) = 1; 
maxmin(m,1) = 1; 
maxmin(1,n) = 1; 
maxmin(m,n) = 1;
