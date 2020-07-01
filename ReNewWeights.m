function [W1, W2, cost_trend] = ReNewWeights(W1, W2, X, D, cost_trend, alpha)
    % 这个函数是用来进行训练神经网络的
    
    % 获得训练数据组数
    training_data_lenth = length(D);

    % 转化为GPU数组进行并行计算，并且转化为单精度以提高GPU计算的优先性
    W1 = gpuArray(single(W1));
    W2 = gpuArray(single(W2));
    X  = gpuArray(single(X));
    D  = gpuArray(single(D));

    % D是公文的预期热度，除以10会稍微降低训练准确性
    % 但是可以有效防止因为梯度爆炸而出现NaN的问题
    D = D / 10;
    
    % 对每组数据进行一次训练
    for i = 1:training_data_lenth
        
        % 第i行,转置得到输入列向量
        x = X(i,:)';
        
        % 正向传播 1-->2
        % 实践试了大量的激活函数组合，最后发现这里不适合使用激活函数，
        % 使用Sigmoid等激活函数会因为预计数值大而出现梯度消失
        % 使用ReLU很容易出现神经元死亡，使用Softmax、LeakyReLU的效果也不好
        % 使用LeakyReLU就不如直接原样输出
        v1 = W1 * x;
        y1 = v1;

        
        % 正向传播 2-->3
        % 使用LeakyReLU是在尽量保持原数据梯度的情况下，防止ReLU下神经元死亡
        % 是大量实验后得出的结论
        v2 = W2 * y1;
        y2 = LeakyReLU(v2);

        % 获取预期值
        d = D(i,:);
        
        % 反向传播 3-->2
        e2 = d - y2;
        delta2 = e2;

        % 每500次训练就记录一次误差，便于分析训练状态
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

