function s = getspline(x)
N = length(x);
p = findpeaks1(x);
s = spline([0 p N+1],[0 x(p) 0],1:N);
end
