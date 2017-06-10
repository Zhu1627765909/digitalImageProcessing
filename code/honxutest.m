clc
clear
clf%消除图像
a=csvread('D:\xixi\3111.CSV',4);   %数据的储存位置
x=a(:,1);y=a(:,2);x1=x(1:15:length(x));y1=y(1:15:length(x));
plot(x,y,'b-.');    %x1,y1,加点的位置
hold on     %保持图像 S11 simulation

x=a(:,1);y=a(:,3);x1=x(1:15:length(x));y1=y(1:15:length(x));
plot(x,y,'k','MarkerSize',3);    %x1,y1,加点的位置
hold on     %保持图像 S21 simulation
%axis([0,12 -40 0]);   %确定坐标轴的范围
grid off   %打网线
xlabel('Frequency[Unit:GH]');ylabel('S-parameters[Unit:dB]');   %加x和y轴说明
legend('S21 Measurement');