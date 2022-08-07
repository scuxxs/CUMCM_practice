clear;clc
%读取数据
x = xlsread('主成分分析_学生成绩样例.xlsx',1,'B2:J11');
%n为样本个数，p为指标个数
[n,p] = size(x);
%计算相关系数矩阵
c = corrcoef(x);
disp('样本相关系数矩阵为：');
disp(c);
% C同时是对称矩阵，Matlab在处理对称矩阵时，会将特征值按照从小到大排列
[V,D] = eig(c);  % eig()：计算特征值和特征向量
                 % V 特征向量矩阵  D是由特征值构成的对角矩阵
lambda = diag(D);  % diag()：用于得到一个矩阵的主对角线元素值(返回的是列向量)

lambda = lambda(end:-1:1);  % 因为lambda向量是从小大到排序的，我们将其调个顺序

contribution_rate = lambda / sum(lambda);              % 计算贡献率

cum_contribution_rate = cumsum(lambda)/ sum(lambda);   % 计算累计贡献率  cumsum()：求累加值的函数

disp('特征值为：')
disp(lambda')        


disp('贡献率为：')
disp(contribution_rate')


disp('累计贡献率为：')
disp(cum_contribution_rate')


disp('与特征值对应的特征向量矩阵为：')   % 注意：这里的特征向量要和特征值一一对应，之前特征值相当于颠倒过来了，因此特征向量的各列需要颠倒过来
V=rot90(V)';                          % rot90()：可以使一个矩阵逆时针旋转90度，然后再转置，就可以实现将矩阵的列颠倒的效果
disp(V)

xlswrite('主成分分析_学生成绩样例.xlsx',lambda,2);   % 把特征值写入当前文件的 脚本2 里面
xlswrite('主成分分析_学生成绩样例.xlsx',V,3);        % 把特征向量写入当前文件的 脚本3 里面

anss = zeros([10,4]);
res = zeros([10,1]);

for w = 1:10
    for i = 1:4
        for j = 1:9
            anss(w,i) = anss(w,i) +  V(j,i)*x(w,j);
            res(w,1) = lambda(i)*anss(w,i)/(lambda(1) + lambda(2) + lambda(3) + lambda(4));
        end
    end
end


