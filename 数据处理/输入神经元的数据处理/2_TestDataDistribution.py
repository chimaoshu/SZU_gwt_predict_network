"""
这个脚本是在设计阶段，辅助进行判断
通过重复测试发现，从2013年至今，出现次数大于20次的关键词正好有1534个
我们就采用这1534个关键词来做神经元的输入层，用0和1表示关键词的出现与否
"""
import json

# 读取数据
with open('数据处理\\输入神经元的数据处理\\2_word_weights.json', 'r', encoding='utf-8') as f:
    _data = f.read()
    _data = json.loads(_data)

while 1:
    # 输入数字
    max_num = input('输入数字：')
    total_num = 0

    # 遍历检查，计算出现次数不小于输入数字的公文数目
    for keyword in _data.keys():
        if _data[keyword]['total_doc_num'] >= int(max_num):
            total_num += 1

    print('几年以来出现次数超过%s的关键词的总数为%s\n' % (max_num, total_num))

