function [W1, W2, cost_trend] = ReNewWeights(W1, W2, X, D, cost_trend, alpha)
    % �����������������ѵ���������
    
    % ���ѵ����������
    training_data_lenth = length(D);

    % ת��ΪGPU������в��м��㣬����ת��Ϊ�����������GPU�����������
    % �����������û��NVIDIA��CUDA����MATLAB��parallel computing toolbox
    % ע�����������д��뼴��
    W1 = gpuArray(single(W1));
    W2 = gpuArray(single(W2));
    X  = gpuArray(single(X));
    D  = gpuArray(single(D));
    
    % ��ÿ�����ݽ���һ��ѵ��
    for i = 1:training_data_lenth
        
        % ��i��,ת�õõ�����������
        x = X(i,:)';
        
        % ���򴫲� 1-->2
        % ʵ�����˴����ļ������ϣ���������ﲻ�ʺ�ʹ�ü������
        % ʹ��Sigmoid�ȼ��������ΪԤ����ֵ��������ݶ���ʧ
        % ʹ��ReLU�����׳�����Ԫ������ʹ��Softmax��LeakyReLU��Ч��Ҳ����
        % ʹ��LeakyReLU���ھ�����������ԭ���ݶȵ�����£������ʹ��ReLU������Ԫ����������
        v1 = W1 * x;
        y1 = LeakyReLU(v1);

        
        % ���򴫲� 2-->3
        v2 = W2 * y1;
        y2 = v2;
        %y2 = LeakyReLU(v2);

        % ��ȡԤ��ֵ
        d = D(i,:);
        
        % ���򴫲� 3-->2
        e2 = d - y2;
        delta2 = e2;

        % ÿ500��ѵ���ͼ�¼һ����ʧ�����ڷ���ѵ��״̬
        if mod(i,500) == 0
            cost_trend(length(cost_trend)+1) = delta2;
        end
        
        % ���򴫲� 2-->1
        e1 = W2'*delta2;

        % LeakyReLU�ĵ���
        delta1 =  (v1 > 0).*e1 + (v1 < 0).*e1.*0.1;
        
        % ����W2Ȩ��
        dW2 = alpha*delta2*y1';
        W2  = W2 + dW2;

        % ����W1Ȩ��
        dW1 = alpha*delta1*x';
        W1  = W1 + dW1;

    end
end

