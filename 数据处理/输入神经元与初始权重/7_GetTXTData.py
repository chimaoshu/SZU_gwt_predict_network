"""
这个脚本的目的是给数据排序,得到初始权重：init_weight.txt
"""

import json
# 读取数据
with open('数据处理\\输入神经元与初始权重\\5_word_weights.json', 'r', encoding='utf-8') as f:
    _data = json.loads(f.read())

new_data_list = ''

for i in _data.keys():
    new_data_list += str(_data[i]) + '\n'


# 写入数据
with open('数据处理\\输入神经元与初始权重\\7_init_weight.txt', 'a+', encoding='utf-8') as f:
    f.write(new_data_list)
