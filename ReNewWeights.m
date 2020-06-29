function [W1,W2] = ReNewWeights(W1,W2,W3,X,D)
    
    alpha = 0.3;
    
    % ���ݳ���
    training_data_lenth = size(D);
    training_data_lenth = training_data_lenth(1,1);
    
    for i = 1:training_data_lenth
        
        % ��i��,ת�õõ�������
        x = X(i,:)';

        % ��i��
        d = D(i,:);
        
        % ���򴫲� 1-->2
        v1 = W1 * x;
        y1 = ReLU(v1);
        
        % ���򴫲� 2-->3
        v2 = W2 * y1;
        y2 = ReLU(v2);

        % ���򴫲� 3-->4
        v3 = W3 * y2;
        y3 = ReLU(v3);
        
        delta1 = d-y2;
        
        % e1����������W2��ת��
        % ��ǰ�����򴫲��ǳ���W2�����ﷴ�򴫲����ǳ���W2��ת�ñ��ȥ��
        %  ��������ز��Ŀ�꺯��������ǰ��һ��ֱ�����
        e1 = W2'*delta1;
        % �����ǹ̶���ʽ��������ز�����delta2
        delta2 = y1.*(1-y1).*e1;
        
        % �������W2�ķ��򴫲������
        dW2 = alpha * delta1 * y1';
        W2 = W2 + dW2;
        
        % ����Ȩ��
        dW1 = alpha * delta2 * x';
        W1 = W1 + dW1;

    end
end

