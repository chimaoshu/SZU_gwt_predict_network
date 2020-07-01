clear all

% 读取训练数据
file = fileread('数据处理/处理到最后投入使用的数据/训练数据.json');
training_data = jsondecode(file);

% 定义一个三层的神经网络
input_layer_size = 1534;
hidden_layer_1_size = 300;
output_layer_size = 1;

% 随机初始化W1（实践证明用rand的效果大大好过用zeros）
W1 = rand(hidden_layer_1_size,input_layer_size);

% 初始化W2
W2 = rand(output_layer_size,hidden_layer_1_size);

% 获取训练数据的组数
training_data_lenth = length(training_data);

% 初始化X，X的每一行就是一条的训练数据
X = zeros(training_data_lenth,input_layer_size);

% 初始化D，每一行就是一个期望值
D = zeros(training_data_lenth,1);

% 从压缩过的数据中生成对应的输入矩阵X和期望矩阵D
for i = 1:training_data_lenth

  % 取出对应的数据
  data_array = training_data{i};

  % 取出期望值，赋给D的对应行
  D(i,1) = data_array(1);

  % 删除期望值，剩下的是输入数据
  data_array(1) = [];

  % 取出输入数据，转化为对应的输入矩阵，赋给X对应的行
  for j = (1:length(data_array))
    X(i,data_array(j)) = 1;
  end
end

clear training_data init_weight file

% 训练次数
training_times = 5;

% 初始学习率
init_alpha = 0.001;

% 进行训练
for epoch = 1:training_times  

    % 用来存储损失loss，方便可视化分析训练情况
    cost_trend = gpuArray([]);
    
    % 每次训练学习率减少，防止梯度爆炸
    alpha = init_alpha * 0.5^(epoch-1);

    % 训练
    [W1, W2, cost_trend] = ReNewWeights(W1, W2, X, D, cost_trend, alpha); 
    disp(['已经训练了', num2str(epoch) ,'次'])

    % 画loss变化趋势图
    plot(cost_trend)
    hold on
    
end
