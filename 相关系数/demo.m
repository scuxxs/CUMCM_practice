clear;clc
Test = xlsread('八年级女生体测数据',1,'A2:F592');
[R,P] = corrcoef(Test);