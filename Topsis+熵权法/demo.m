clear;clc
data = xlsread('20条河流的水质情况数据',1,'B2:E21');
[n,m] = size(data);
%正向化
data(:,2) = MidtoMax(data(:,2),7.4);
data(:,3) = MintoMax(data(:,3));
data(:,4) = IntertoMax(data(:,4),12,18);
%标准化
data_norm = data./repmat(sum(data.*data).^0.5,n,1);
%计算距离，得分
dis_Max = sum([(data_norm - repmat(max(data_norm),n,1)).^2],2).^0.5;
dis_Min = sum([(data_norm - repmat(min(data_norm),n,1)).^2],2).^0.5;
score = dis_Min ./ (dis_Max + dis_Min);
score_norm = score/sum(score);
[sort_score,index] = sort(score_norm,'descend');

