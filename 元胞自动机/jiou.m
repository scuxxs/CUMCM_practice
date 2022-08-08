%%奇偶规则游戏
clear;clc;
n = 200;%指定边界长度
Se = zeros(n);
z = zeros(n);
Se(n/2-2:n/2+2,n/2-2:n/2+2)=1;  %初始化中间的点
Ch = imagesc(Se);
axis square;
Sd = zeros(n+2);  %边界
while(true) %死循环
    Sd(2:n+1,2:n+1) = Se;
    sumValue = Sd(1:n,2:n+1)+Sd(3:n+2,2:n+1)+Sd(2:n+1,1:n)+Sd(2:n+1,3:n+2);
    Se = mod(sumValue,2);
    set(Ch,'cdata',Se);
    pause(0.03)
end
