%% 提取表格中的数据，进行统计
%% 表格中的数据是经过一定涮选得出来的结果，虽然目标趋势图一致，但个体数据会有细微差距
clc;
clear;
%% 所有被试平均后的code 分析，以及图形展示过程
FileName1 = '/Users/lchunyu/python-code/Mac-data/source-time/conn-decode/150-ROI/A_J_data.xlsx'
FileName2 = '/Users/lchunyu/python-code/Mac-data/source-time/conn-decode/150-ROI/A_S_data.xlsx'
FileName3 = '/Users/lchunyu/python-code/Mac-data/source-time/conn-decode/150-ROI/A_F_data.xlsx'
FileName4 = '/Users/lchunyu/python-code/Mac-data/source-time/conn-decode/150-ROI/F_J_data.xlsx'
FileName5 = '/Users/lchunyu/python-code/Mac-data/source-time/conn-decode/150-ROI/F_S_data.xlsx'
FileName6 = '/Users/lchunyu/python-code/Mac-data/source-time/conn-decode/150-ROI/J_S_data.xlsx'
%%
opts = detectImportOptions(FileName1, 'Sheet', 1);
opts = detectImportOptions(FileName2, 'Sheet', 1);
opts = detectImportOptions(FileName3, 'Sheet', 1);
opts = detectImportOptions(FileName4, 'Sheet', 1);
opts = detectImportOptions(FileName5, 'Sheet', 1);
opts = detectImportOptions(FileName6, 'Sheet', 1);
%opts = detectImportOptions(Filename1, 'Sheet', 1);
%%
A_J_data=readmatrix(FileName1, 'Sheet', 1, 'Range', 'A2:Z47');
A_S_data=readmatrix(FileName2, 'Sheet', 1, 'Range', 'A2:Z47');
A_F_data=readmatrix(FileName3, 'Sheet', 1, 'Range', 'B2:AA47');
F_J_data=readmatrix(FileName4, 'Sheet', 1, 'Range', 'A2:Z47');
F_S_data=readmatrix(FileName5, 'Sheet', 1, 'Range', 'A2:Z47');
J_S_data=readmatrix(FileName6, 'Sheet', 1, 'Range', 'A2:Z47');
X = 0:45;
Y1 = mean(A_F_data,2);
Y2 = mean(A_S_data,2);
Y3 = mean(A_J_data,2);
Y4 = mean(F_J_data,2);
Y5 = mean(F_S_data,2);
Y6 = mean(J_S_data,2);
%%
%% 显著性的分析以及std的阴影图
%（1）每列的std计算如下,包含上下两侧的分析
A_F_std = std(A_F_data,0,2)/2;
A_J_std = std(A_J_data,0,2)/2;
A_S_std = std(A_S_data,0,2)/2;
F_J_std = std(F_J_data,0,2)/2;
F_S_std = std(F_S_data,0,2)/2;
J_S_std = std(J_S_data,0,2)/2;
%% 随机数据
%% 显著点的查询
%%
sig_cols1 = xianzhu(A_F_data,A_F_std);
sig_cols2 = xianzhu(A_S_data,A_S_std);
sig_cols3 = xianzhu(A_J_data,A_J_std);
sig_cols4 = xianzhu(F_J_data,F_J_std);
sig_cols5 = xianzhu(F_S_data,F_S_std);
sig_cols6 = xianzhu(J_S_data,J_S_std);

%%
colors = [
    178, 255, 191;  % 薄荷绿
    135, 206, 250;  % 天蓝色
    72, 209, 204;   % 青蓝色
    147, 112, 219;  % 冰紫蓝
    65, 105, 225;   % 深湖蓝
    25, 25, 112     % 深海蓝
] / 255;


subplot(2, 3, 1); % 第一个小图
hold on;

x2 = [X, fliplr(X)];  % 创建 x 轴数据，使阴影闭合
y1 = [Y1'- A_F_std/2', fliplr(Y1' + A_F_std/2')]*100;  % 创建 y 轴数据

%axis([0 45 46 60]);
%xticks(0:5:44);
%ylim([45, 50])
%yticks(45:3:60);
fill(x2, y1, [0.95, 0.95, 0.95], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(gca, 'Layer', 'top');
plot(X, Y1*100,'Color',colors(1,:),'LineWidth', 2); 
hold on
% 显著点的标记
sig_x = sig_cols1;
sig_y = 50 * ones(size(sig_x));
plot(sig_x, sig_y, 'b*', 'MarkerSize', 0.5);
box on;
axis([0 45 47 59]);
xlabel('Time'); % 设置X轴标签
ylabel('Accuracy(%)'); % 设置Y轴标签
title('Anger-Fear');
%%
subplot(2, 3, 2); % 第一个小图
hold on;
x2 = [X, fliplr(X)];  % 创建 x 轴数据，使阴影闭合
y2 = [Y2'- A_S_std/2', fliplr(Y2' + A_S_std/2')]*100;  % 创建 y 轴数据
box on;
xticks(0:5:45);
yticks(45:3:59);
fill(x2, y2, [0.95, 0.95, 0.95], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(gca, 'Layer', 'top');
plot(X, Y2*100,'Color',colors(2,:),'LineWidth', 2); 
hold on
% 显著点的标记
sig_x = sig_cols2;
sig_y = 50 * ones(size(sig_x));
plot(sig_x, sig_y, 'b*', 'MarkerSize', 0.5);
xlabel('Time'); % 设置X轴标签
ylabel('Accuracy(%)'); % 设置Y轴标签
title('Anger-Sad');
%%
subplot(2, 3, 3); % 第一个小图
hold on;
x2 = [X, fliplr(X)];  % 创建 x 轴数据，使阴影闭合
y3 = [Y3'- A_J_std/2', fliplr(Y3' + A_J_std/2')]*100;  % 创建 y 轴数据

fill(x2, y3, [0.95, 0.95, 0.95], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(gca, 'Layer', 'top');
box on;
axis([0 45 47 59]);
plot(X, Y3*100,'Color',colors(3,:),'LineWidth', 2); 
hold on
% 显著点的标记
sig_x = sig_cols3;
sig_y = 50 * ones(size(sig_x));
plot(sig_x, sig_y, 'b*', 'MarkerSize', 0.5);
xlabel('Time'); % 设置X轴标签
ylabel('Accuracy(%)'); % 设置Y轴标签
title('Anger-Joy');
%%
subplot(2, 3, 4); % 第一个小图
hold on;
x2 = [X, fliplr(X)];  % 创建 x 轴数据，使阴影闭合
y4 = [Y4'- F_J_std/2', fliplr(Y4' + F_J_std/2')]*100;  % 创建 y 轴数据
fill(x2, y4, [0.95, 0.95, 0.95], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(gca, 'Layer', 'top');
plot(X, Y4*100,'Color',colors(4,:),'LineWidth', 2); 
hold on
% 显著点的标记
sig_x = sig_cols4;
sig_y = 50 * ones(size(sig_x));
plot(sig_x, sig_y, 'b*', 'MarkerSize', 0.5);
xlabel('Time'); % 设置X轴标签
ylabel('Accuracy(%)'); % 设置Y轴标签
box on;
axis([0 45 47 59]);
title('Fear-Joy');
%%
subplot(2, 3, 5); % 第一个小图
hold on
x2 = [X, fliplr(X)];  % 创建 x 轴数据，使阴影闭合
y5 = [Y5'- F_S_std/2', fliplr(Y5' + F_S_std/2')]*100;  % 创建 y 轴数据

fill(x2, y5, [0.95, 0.95, 0.95], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(gca, 'Layer', 'top');
plot(X, Y5*100,'Color',colors(5,:),'LineWidth', 2); 
hold on
% 显著点的标记
sig_x = sig_cols5;
sig_y = 50 * ones(size(sig_x));
plot(sig_x, sig_y, 'b*', 'MarkerSize', 0.5);
box on;
axis([0 45 47 59]);
xlabel('Time'); % 设置X轴标签
ylabel('Accuracy(%)'); % 设置Y轴标签
title('Fear-Sad');
%%
subplot(2, 3, 6); % 第一个小图
hold on
x2 = [X, fliplr(X)];  % 创建 x 轴数据，使阴影闭合
y6 = [Y6'- J_S_std/2', fliplr(Y6' + J_S_std/2')]*100;  % 创建 y 轴数据

fill(x2, y6, [0.95, 0.95, 0.95], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(gca, 'Layer', 'top');
plot(X, Y6*100,'Color',colors(6,:),'LineWidth', 2); 
hold on
% 显著点的标记
sig_x = sig_cols6;
sig_y = 50 * ones(size(sig_x));
plot(sig_x, sig_y, 'b*', 'MarkerSize', 0.5);
%grid on;

% 启用四周框
box on;
axis([0 45 47 59]);
xlabel('Time'); % 设置X轴标签
ylabel('Accuracy(%)'); % 设置Y轴标签
title('Joy-Sad');
%% 所有二分类的情况总结过程
figure;
All_data = [Y1,Y2,Y3,Y4,Y5,Y6];
mean_data = mean(All_data,2);
%% 添加阴影和显著性区标表示
%%
two_data = (A_J_data+A_S_data+A_F_data+F_J_data+F_S_data+J_S_data)/6;
two_std = (A_F_std+A_J_std+A_S_std+F_J_std+F_S_std+J_S_std)/6
sig_cols7 = xianzhu(two_data,two_std);
Y7 = mean_data
x2 = [X, fliplr(X)];  % 创建 x 轴数据，使阴影闭合
y7 = [Y7'- two_std/4', fliplr(Y7' + two_std/4')]*100;  
%fill(x2, y7, [0.95, 0.95, 0.95], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
plot(X,mean_data*100,'LineWidth', 2)
hold on
%two_data = (A_J_data+A_S_data+A_F_data+F_J_data+F_S_data+J_S_data)/6;
fill(x2, y7, [0.95, 0.95, 0.95], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(gca, 'Layer', 'top');
plot(X,mean_data*100,'LineWidth', 2)
sig_x = sig_cols7;
sig_y = 50 * ones(size(sig_x));
plot(sig_x, sig_y, 'b*', 'MarkerSize', 0.5);
xlabel('Time'); % 设置X轴标签
ylabel('Accuracy(%)'); % 设置Y轴标签
title('Two-class');
%%