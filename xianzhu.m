%% 
%% 显著性测试的函数，因为随机性，所以采用多重矫正分析的方法，确保显著性的稳定性，并采用了95%的置信区间
function [significant_idx]= xianzhu(x,y)
n_iterations = 5000
p_values_all = zeros(n_iterations, 46); 
for iter = 1:n_iterations
    %% 
    %% 生成随机样本数据
    data1 = x;                 % 组1,固定值给出
    %% 这里是随机给出的
    mu = 0.5;   % 均值
    sigma = sum(y/46);  % 标准差（方差的平方根）
    n = 26;    % 数据点数量
    data = normrnd(mu, sigma, [1, n]);  % 生成 1×26 的数据
    data_expanded1 = repmat(data, size(data1, 1), 1);
    data2 =  data_expanded1 ;         % 组2 (效应略高)
    alpha_value = 0.05
    % 对每个变量分别进行 t 检验
 
    [h1, p] = ttest(data1', data2','Alpha', alpha_value);       % 双样本 t 检验
    p_values_all(iter,:) = p;                     % 记录 p 值
  
end
p_CI = zeros(46, 2);  % 存储每个检验的置信区间 (下限, 上限)
for i = 1:46
    p_values = p_values_all(:, i);                  % 取第 i 个变量的所有 p 值
    % 计算均值和标准误差
    mean_p = mean(p_values);
    sem_p = std(p_values) / sqrt(n_iterations);     % 标准误差

    % 计算 95% 置信区间
    p_CI(i,1) = mean_p - 1.96 * sem_p;             % 下限
    p_CI(i,2) = mean_p + 1.96 * sem_p;             % 上限
end
significant_idx = find(p_CI(:,2) < 0.01); 