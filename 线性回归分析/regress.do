clear
cls
import excel "D:\数学建模练习\线性回归分析\奶粉数据.xlsx", sheet("Sheet1") firstrow
summarize 团购价元 评价量 商品毛重kg
tabulate 配方,gen(A)
tabulate 奶源产地 ,gen(B)
tabulate 国产或进口 ,gen(C)
tabulate 适用年龄岁 ,gen(D)
tabulate 包装单位 ,gen(E)
tabulate 分类 ,gen(F)
tabulate 段位 ,gen(G)
// 下面进行回归
regress 评价量 团购价元 商品毛重kg
// 下面的语句可帮助我们把回归结果保存在Word文档中
// 在使用之前需要运行下面这个代码来安装下这个功能包（运行一次之后就可以注释掉了）
// ssc install reg2docx, all replace
// 如果安装出现connection timed out的错误，可以尝试换成手机热点联网，如果手机热点也不能下载，就不用这个命令吧，可以自己做一个回归结果表，如果觉得麻烦就直接把回归结果截图。
est store m1
reg2docx m1 using m1.docx, replace
// *** p<0.01  ** p<0.05 * p<0.1

// Stata会自动剔除多重共线性的变量
regress 评价量 团购价元 商品毛重kg A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 B8 B9 C1 C2 D1 D2 D3 D4 D5 E1 E2 E3 E4 F1 F2 G1 G2 G3 G4
est store m2
reg2docx m2 using m2.docx, replace

// 得到标准化回归系数
regress 评价量 团购价元 商品毛重kg, b 

// 画出残差图
regress 评价量 团购价元 商品毛重kg A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 B8 B9 C1 C2 D1 D2 D3 D4 D5 E1 E2 E3 E4 F1 F2 G1 G2 G3 G4
rvfplot 
// 残差与拟合值的散点图
graph export a1.png ,replace
// 残差与自变量团购价的散点图
rvpplot  团购价元
graph export a2.png ,replace

// 为什么评价量的拟合值会出现负数？
// 描述性统计并给出分位数对应的数值
summarize 评价量,d

// 作评价量的概率密度估计图
kdensity 评价量 
graph export a3.png ,replace

// 异方差BP检验
estat hettest ,rhs iid

// 异方差怀特检验
estat imtest,white

// 使用OLS + 稳健的标准误
regress 评价量 团购价元 商品毛重kg A1 A2 A3 B1 B2 B3 B4 B5 B6 B7 B8 B9 C1 C2 D1 D2 D3 D4 D5 E1 E2 E3 E4 F1 F2 G1 G2 G3 G4, r
est store m3
reg2docx m3 using m3.docx, replace

// 计算VIF
estat  vif

// 逐步回归（一定要注意完全多重共线性的影响）
// 向前逐步回归（后面的r表示稳健的标准误）
stepwise reg 评价量 团购价元 商品毛重kg A1 A3 B1 B2 B3 B4 B5 B6 B7 B9 C1 D1 D2 D3 D4 E1 E2 E3 F1 G1 G2 G3,  r pe(0.05)
// 向后逐步回归（后面的r表示稳健的标准误）
stepwise reg 评价量 团购价元 商品毛重kg A1 A3 B1 B2 B3 B4 B5 B6 B7 B9 C1 D1 D2 D3 D4 E1 E2 E3 F1 G1 G2 G3,  r pr(0.05)
// 向后逐步回归的同时使用标准化回归系数（在r后面跟上一个b即可）
stepwise reg 评价量 团购价元 商品毛重kg A1 A3 B1 B2 B3 B4 B5 B6 B7 B9 C1 D1 D2 D3 D4 E1 E2 E3 F1 G1 G2 G3,  r b pr(0.05)


// 补充语法 (大家不需要具体的去学Stata软件，掌握我课堂上教给大家的一些命令应对数学建模比赛就可以啦)
// 事实上大家学好Excel，学好后应对90%的数据预处理问题都能解决
// (1) 用已知变量生成新的变量 
generate lny = log(评价量)  
generate price_square = 团购价元 ^2
generate interaction_term = 团购价元*商品毛重kg

// (2) 修改变量名称，因为用中文命名变量名称有时候可能容易出现未知Bug
rename 团购价元 price

