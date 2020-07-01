function y = LeakyReLU(x)
   % 改进的ReLU函数，可以避免神经元死亡的问题
   y = max(0.1*x, x);
end