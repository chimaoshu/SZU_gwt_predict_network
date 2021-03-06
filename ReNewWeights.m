function [W1, W2, cost_trend] = ReNewWeights(W1, W2, X, D, cost_trend, alpha)
    % 这个函数是用来进行训练神经网络的
    
    % 获得训练数据组数
    training_data_lenth = length(D);

    % 转化为GPU数组进行并行计算，并且转化为单精度以提高GPU计算的优先性
    % 如果电脑里面没有NVIDIA的CUDA或者MATLAB的parallel computing toolbox
    % 注释下面这四行代码即可
    W1 = gpuArray(single(W1));
    W2 = gpuArray(single(W2));
    X  = gpuArray(single(X));
    D  = gpuArray(single(D));
    
    % 对每组数据进行一次训练
    for i = 1:training_data_lenth
        
        % 第i行,转置得到输入列向量
        x = X(i,:)';
        
        % 正向传播 1-->2
        % 实践试了大量的激活函数组合，最后发现这里不适合使用激活函数，
        % 使用Sigmoid等激活函数会因为预计数值大而出现梯度消失
        % 使用ReLU很容易出现神经元死亡，使用Softmax、LeakyReLU的效果也不好
        % 使用LeakyReLU，在尽量保持数据原有梯度的情况下，解决了使用ReLU出现神经元死亡的问题
        v1 = W1 * x;
        y1 = LeakyReLU(v1);

        
        % 正向传播 2-->3
        v2 = W2 * y1;
        y2 = v2;
        %y2 = LeakyReLU(v2);

        % 获取预期值
        d = D(i,:);
        
        % 反向传播 3-->2
        e2 = d - y2;
        delta2 = e2;

        % 每500次训练就记录一次损失，便于分析训练状态
        if mod(i,500) == 0
            cost_trend(length(cost_trend)+1) = delta2;
        end
        
        % 反向传播 2-->1
        e1 = W2'*delta2;

        % LeakyReLU的导数
        delta1 =  (v1 > 0).*e1 + (v1 < 0).*e1.*0.1;
        
        % 更新W2权重
        dW2 = alpha*delta2*y1';
        W2  = W2 + dW2;

        % 更新W1权重
        dW1 = alpha*delta1*x';
        W1  = W1 + dW1;

    end
end

