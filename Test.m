% ����Python����
% Python���������ı��⴫����Ѷ�Ʒִ�AI��api�ӿڵõ��ָ��Ĵ���
% Ȼ���޳�������Ĵʣ�����������Ĵʺ󴫸�MATLAB
cell_list = cell(py.GenerateInputVector.Generate(input('����ҪԤ��Ĺ��ı��⣺','s')));

% ���ݹٷ��ĵ���ʾ������Python��list����ת��ΪMatlab�е�����
vector = zeros(1, numel(cell_list));
for n = 1:numel(cell_list)
    vector(1,n) = double(cell_list{n});
end

% ����Ĵ����ǽ���������ת��Ϊ���������������
input_layer_size = 1534;
input_vector = zeros(input_layer_size,1);

keyword_num = 0;
for n = 1:length(vector)
    if vector(n) <= input_layer_size
        input_vector(vector(n),1) = 1;
        keyword_num = keyword_num + 1;
    end
end

disp(['����ĺϸ�ؼ�����ĿΪ',num2str(keyword_num)])

% ����������ѵ���ú��������

% ����������ⲻ����Ԥ���1534������ͨ��������,ֱ�����0
if keyword_num == 0

    y2 = 0;

else

    % ���򴫲� 1-->2
    v1 = W1 * input_vector;
    y1 = v1;

    % ���򴫲� 2-->3
    v2 = W2*y1;
    y2 = LeakyReLU(v2) * 10;

end

% ���AI��Ԥ����
disp(['�˹��ĵĵ����Ԥ��ֵ�ǣ�',num2str(y2)])