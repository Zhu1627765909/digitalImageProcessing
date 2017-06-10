function u = ismonotonic(x)
u1 = length(findpeaks1(x))*length(findpeaks1(-x));
if u1 > 0
    u = 0;
else
    u = 1;
end
end