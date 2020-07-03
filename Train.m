clear all

% ��ȡѵ������
file = fileread('���ݴ���/�������Ͷ��ʹ�õ�����/ѵ������.json');
training_data = jsondecode(file);

% ����һ�������������
input_layer_size = 1534;
hidden_layer_1_size = 300;
output_layer_size = 1;

% �����ʼ��W1��ʵ��֤����rand��Ч�����ù���zeros��
W1 = rand(hidden_layer_1_size,input_layer_size);

% ��ʼ��W2
W2 = rand(output_layer_size,hidden_layer_1_size);

% ��ȡѵ�����ݵ�����
training_data_lenth = length(training_data);

% ��ʼ��X��X��ÿһ�о���һ����ѵ������
X = zeros(training_data_lenth,input_layer_size);

% ��ʼ��D��ÿһ�о���һ������ֵ
D = zeros(training_data_lenth,1);

% ��ѹ���������������ɶ�Ӧ���������X����������D
for i = 1:training_data_lenth

  % ȡ����Ӧ������
  data_array = training_data{i};

  % ȡ������ֵ������D�Ķ�Ӧ��
  D(i,1) = data_array(1);

  % ɾ������ֵ��ʣ�µ�����������
  data_array(1) = [];

  % ȡ���������ݣ�ת��Ϊ��Ӧ��������󣬸���X��Ӧ����
  for j = (1:length(data_array))
    X(i,data_array(j)) = 1;
  end
end

clear training_data init_weight file

% ѵ������
training_times = 10;

% ��ʼѧϰ��
alpha = 0.0001;

% ����ѵ��
for epoch = 1:training_times

    % �����洢��ʧloss��������ӻ�����ѵ�����
    cost_trend = [];

    % �����������û��NVIDIA��CUDA����MATLAB��parallel computing toolbox
    % ע���������д��뼴��
    cost_trend = gpuArray(cost_trend);

    % ѵ��
    [W1, W2, cost_trend] = ReNewWeights(W1, W2, X, D, cost_trend, alpha); 
    disp(['�Ѿ�ѵ����', num2str(epoch) ,'��'])

    % �����ʧС��ĳ������ֵ�������ѧϰ
    if (all (cost_trend < 1.5) && all(cost_trend > -1.5))
        disp('ѵ�����')
        break
    end

    % ÿn��ѭ����һ��ͼ
    if mod(epoch,1) == 0
      % ��loss�仯����ͼ
      plot(cost_trend)
      hold on
    end

end
