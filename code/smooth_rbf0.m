function  [z,tri]=smooth_rbf0(xy,z); 
%INPUT: 
%   xy is the set of coordinates of A with each (xy(1,i),xy(2,i)) 
%       corresponding to a characteristic point of A 
%   z is the vector of values of A's characteristic points, z(i) 
%       corresponding to the coordinates (xy(1,i),xy(2,i)) 
%----------------------------------------------------------------- 
%OUTPUT: 
%   z is the vector of smoothed values of the characteristic 
%       points of A 
%   tri is a set of triangles partitioning A, with nodes 
%       at the characteristic points, each triple giving 
%       the indices on the columns of xy defining  
%       the nodes 
numb = length(z); 
tri=delaunay(xy(1,:),xy(2,:)); 
[kelem,nnode] = size(tri); 
figure(200) 
triplot(tri,xy(1,:),xy(2,:)); 
[p2p]=calcu_coef(numb,tri); 
itg=15; 
alpha = 0.8; 
for ii=1:itg 
    z0=z; 
    for jj=1:numb 
        z(jj)=0.0; 
        for kk=1:p2p(jj,1) 
            kp = p2p(jj,kk+1); 
            z(jj) = z(jj)+z0(kp); 
        end 
        z(jj) = z(jj)/p2p(jj,1); 
        z(jj) = alpha*z0(jj)+(1.0-alpha)*z(jj); 
    end 
end

