function n = findpeaks1(x)
% Find peaks. �Ҽ���ֵ�㣬���ض�Ӧ����ֵ�������
n    = find(diff(diff(x) > 0) < 0); % �൱���Ҷ��׵�С��0�ĵ�
u    = find(x(n+1) > x(n));
n(u) = n(u)+1;  
end