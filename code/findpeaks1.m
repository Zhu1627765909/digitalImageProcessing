function n = findpeaks1(x)
% Find peaks. 找极大值点，返回对应极大值点的坐标
n    = find(diff(diff(x) > 0) < 0); % 相当于找二阶导小于0的点
u    = find(x(n+1) > x(n));
n(u) = n(u)+1;  
end