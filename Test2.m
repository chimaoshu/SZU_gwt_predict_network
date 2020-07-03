% 这个脚本是在MATLAB版本较低而无法直接调用Python的情况使用的
vector = input('输入Python脚本返回的向量：');

% 下面的代码是将上述数据转化为输入神经网络的向量
input_layer_size = 1534;
input_vector = zeros(input_layer_size,1);

keyword_num = 0;
for n = 1:length(vector)
    if vector(n) <= input_layer_size
        input_vector(vector(n),1) = 1;
        keyword_num = keyword_num + 1;
    end
end

disp(['输入的合格关键词数目为',num2str(keyword_num)])

% 将向量输入训练好后的神经网络

% 如果上述标题不包含预设的1534个公文通常见词语,直接输出0
if keyword_num == 0

    y2 = 0;

else

    % 正向传播 1-->2
    v1 = W1 * input_vector;
    y1 = LeakyReLU(v1);

    % 正向传播 2-->3
    v2 = W2*y1;
    y2 = ReLU(v2);

end

% 输出AI的预测结果
disp(['此公文的点击量预测值是：',num2str(y2)])