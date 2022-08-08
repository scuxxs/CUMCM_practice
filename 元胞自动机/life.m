clear;clc;
%%生命游戏
n = 200;
p = 0.4;
z = zeros(n);
Se = rand(n)<p;
Sd = zeros(n+2);
Ph = imagesc(Se);
while(true)
    Sd(2:n+1,2:n+1)=Se;
    sumValue = Sd(1:n,1:n)+Sd(1:n,2:n+1)+Sd(1:n,3:n+2)+Sd(2:n+1,1:n)+Sd(2:n+1,3:n+2)+Sd(3:n+2,1:n)+Sd(3:n+2,2:n+1)+Sd(3:n+2,3:n+2);
    for i=1:n
        for j=1:n
            if(sumValue(i,j)==3||(sumValue(i,j)==2&&Se(i,j)==1))
                Se(i,j) = 1;
            else
                Se(i,j) = 0;
            end
        end
    end
    set(Ph,'cdata',Se);
    pause(0.05);
end
