function u = isimf(x)
N  = length(x);
u1 = sum(x(1:N-1).*x(2:N) < 0);                     % �����ĸ���
u2 = length(findpeaks1(x))+length(findpeaks1(-x));    % ��ֵ��ĸ���
if abs(u1-u2) > 1
    u = 0;
else
    u = 1;
end
end