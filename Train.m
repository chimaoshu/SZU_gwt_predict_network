clear all

% ��ȡѵ������
file = fileread('���ݴ���/ѵ������/2_compressed_training_data.json');
training_data = jsondecode(file);

% ��ȡ��ʼȨ��
init_weight = load('���ݴ���/������Ԫ���ʼȨ��/7_init_weight.txt');

% ��ʼ��W1������ʼȨ��
W1 = zeros(750,1534);
for i = 1:750
  W1(i,:) = init_weight;
end

% ��ʼ��W2��W3
W2 = 100*rand(300,750);
W3 = 100*rand(1,300);

% ѵ�����ݵ�����
training_data_lenth = size(training_data);
training_data_lenth = training_data_lenth(1,1);

% ��ʼ��X��ÿһ�о���һ����������
X = zeros(training_data_lenth,1534);

% ��ʼ��D��ÿһ�о���һ������ֵ
D = zeros(training_data_lenth,1);

% ��ѹ�������������ɶ�Ӧ������������������
for i = 1:training_data_lenth

  % ȡ����Ӧ������
  data_array = training_data{i};

  % ȡ������ֵ������D�Ķ�Ӧ��
  D(i,1) = data_array(1);

  % ɾ������ֵ��ʣ�µ�����������
  data_array(1) = [];

  % ȡ���������ݣ�ת��Ϊ��Ӧ��������󣬸���X��Ӧ����
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
