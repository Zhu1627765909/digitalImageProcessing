function imf = emd(x)
% Empiricial Mode Decomposition (Hilbert-Huang Transform)
% EMD�ֽ��HHT�任
% ����ֵΪcell���ͣ�����Ϊһ��IMF������IMF��...�����в�
x   = transpose(x(:));
imf = [];
while ~ismonotonic(x)
    x1 = x;
    sd = Inf;
    while (sd > 0.1) || ~isimf(x1)
        s1 = getspline(x1);         % ����ֵ����������
        s2 = -getspline(-x1);       % ��Сֵ����������
        h = x1-(s1+s2)/2;

        sd = sum((x1-h).^2)/sum(x1.^2);
        x1 = h;
    end

    imf{end+1} = x1;
    x          = x-x1;
end
imf{end+1} = x;
end