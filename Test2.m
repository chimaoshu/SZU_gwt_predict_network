% ����ű�����MATLAB�汾�ϵͶ��޷�ֱ�ӵ���Python�����ʹ�õ�
vector = input('����Python�ű����ص�������');

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
    y1 = LeakyReLU(v1);

    % ���򴫲� 2-->3
    v2 = W2*y1;
    y2 = ReLU(v2);

end

% ���AI��Ԥ����
disp(['�˹��ĵĵ����Ԥ��ֵ�ǣ�',num2str(y2)])