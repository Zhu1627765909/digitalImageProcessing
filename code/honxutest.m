clc
clear
clf%����ͼ��
a=csvread('D:\xixi\3111.CSV',4);   %���ݵĴ���λ��
x=a(:,1);y=a(:,2);x1=x(1:15:length(x));y1=y(1:15:length(x));
plot(x,y,'b-.');    %x1,y1,�ӵ��λ��
hold on     %����ͼ�� S11 simulation

x=a(:,1);y=a(:,3);x1=x(1:15:length(x));y1=y(1:15:length(x));
plot(x,y,'k','MarkerSize',3);    %x1,y1,�ӵ��λ��
hold on     %����ͼ�� S21 simulation
%axis([0,12 -40 0]);   %ȷ��������ķ�Χ
grid off   %������
xlabel('Frequency[Unit:GH]');ylabel('S-parameters[Unit:dB]');   %��x��y��˵��
legend('S21 Measurement');