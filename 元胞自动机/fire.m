clear;clc;
%火灾
n = 300;                           % 定义表示森林的矩阵大小
k = 30000;                         % 迭代次数
Pground = 0.8;                     % 从着火变成空地的概率
Plight = 5e-6; Pgrowth = 1e-3;      % 定义闪电和生长的概率  
P2=0.7; %旁边有火，树着火的概率
UL = [n,1:n-1]; DR = [2:n,1];      % 定义上左，下右邻居
veg=zeros(n,n)+2;                    % 初始化表示森林的矩阵
imh = image(cat(3,veg,veg,veg));   % 可视化表示森林的矩阵
Sd = zeros(n+2);                 %边界
% veg = 空地为0 着火为1 树木为2
for i=1:k
    Sd(2:n+1,2:n+1) = veg;
    sumValue = (Sd(1:n,2:n+1)==1)+(Sd(2:n+1,1:n)==1)+(Sd(2:n+1,3:n+2)==1)+(Sd(3:n+2,2:n+1)==1);
    for p=1:n
        for q=1:n
            if((sumValue(p,q)>0||rand()<Plight)&&veg(p,q)==2&&rand()<P2)
                %首先要是树，而且需要邻居有火或者被雷劈了，就会一定概率着火
                veg(p,q)=1;
            elseif(veg(p,q)==1&&rand()<Pground)
                %如果是火且满足概率，则变为空地
                veg(p,q) = 0;
            elseif(veg(p,q)==0&&sumValue(p,q)==0&&rand()<Pgrowth)
                %如果是空地，且周围没有火，那么以一定概率长成树
                veg(p,q) = 2;
            end
        end
    end
    set(imh, 'cdata', cat(3,(veg==1),(veg==2),zeros(n)))
    drawnow  
end
