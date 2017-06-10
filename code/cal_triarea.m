function area = cal_triarea(x1,y1,x2,y2,x3,y3); 
%INPUT: 
%   (x1,y1),(x2,y2), and (x3,y3) are the coordinates of 
%       the pixels in A 
%****************************************************** 
%OUTPUT: 
%   area is the area of the triangle defined on the nodes 
%       (x1,y1),(x2,y2),(x3,y3) 
area=(x2-x1)*(y3-y1)-(x3-x1)*(y2-y1);
