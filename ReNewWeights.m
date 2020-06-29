function [W1,W2] = ReNewWeights(W1,W2,W3,X,D)
    
    alpha = 0.3;
    
    % 数据长度
    training_data_lenth = size(D);
    training_data_lenth = training_data_lenth(1,1);
    
    for i = 1:training_data_lenth
        
        % 第i行,转置得到列向量
        x = X(i,:)';

        % 第i行
        d = D(i,:);
        
        % 正向传播 1-->2
        v1 = W1 * x;
        y1 = ReLU(v1);
        
        % 正向传播 2-->3
        v2 = W2 * y1;
        y2 = ReLU(v2);

        % 正向传播 3-->4
        v3 = W3 * y2;
        y3 = ReLU(v3);
        
        delta1 = d-y2;
        
        % e1等于误差乘以W2的转置
        % （前面正向传播是乘以W2，这里反向传播就是乘以W2的转置变回去）
        %  这个是隐藏层的目标函数，不像前面一样直接相减
        e1 = W2'*delta1;
        % 这里是固定公式，求出隐藏层的误差delta2
        delta2 = y1.*(1-y1).*e1;
        
        % 输出对于W2的反向传播与更新
        dW2 = alpha * delta1 * y1';
        W2 = W2 + dW2;
        
        % 更新权重
        dW1 = alpha * delta2 * x';
        W1 = W1 + dW1;

    end
end

