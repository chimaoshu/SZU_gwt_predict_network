clear all

% 读取训练数据
file = fileread('数据处理/训练数据/2_compressed_training_data.json');
training_data = jsondecode(file);

% 读取初始权重
init_weight = load('数据处理/输入神经元与初始权重/7_init_weight.txt');

% 初始化W1并赋初始权重
W1 = zeros(750,1534);
for i = 1:750
  W1(i,:) = init_weight;
end

% 初始化W2和W3
W2 = 100*rand(300,750);
W3 = 100*rand(1,300);

% 训练数据的组数
training_data_lenth = size(training_data);
training_data_lenth = training_data_lenth(1,1);

% 初始化X，每一行就是一次输入数据
X = zeros(training_data_lenth,1534);

% 初始化D，每一行就是一个期望值
D = zeros(training_data_lenth,1);

% 从压缩的数据中生成对应的输入矩阵和期望矩阵
for i = 1:training_data_lenth

  % 取出对应的数据
  data_array = training_data{i};

  % 取出期望值，赋给D的对应行
  D(i,1) = data_array(1);

  % 删除期望值，剩下的是输入数据
  data_array(1) = [];

  % 取出输入数据，转化为对应的输入矩阵，赋给X对应的行
  for j = data_array
    X(i,j) = 1;
  end
end

% for epoch = 1:1
%   [W1, W2] = ReNewWeights(W1, W2, X, D);
% end


% N = 5;                       
% for k = 1:N
%   x  = reshape(X1(:, :, k), 25, 1);
%   v1 = W1*x;
%   y1 = Sigmoid(v1);
%   v  = W2*y1;
%   y  = Sigmoid(v)
  
% end
