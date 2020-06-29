"""
这个脚本的目的是给数据排序,得到数据集：5_word_weights.json
"""

import json
# 读取数据
with open('数据处理\\输入神经元与初始权重\\4_word_weights.json', 'r', encoding='utf-8') as f:
    _data = json.loads(f.read())

new_data_list_1 = reversed( sorted(_data.items(),key=lambda x:x[1]) )
new_data_list_2 = {}

for i in new_data_list_1:
    new_data_list_2[i[0]] = i[1]


# 写入数据
with open('数据处理\\输入神经元与初始权重\\5_word_weights.json', 'a+', encoding='utf-8') as f:
    f.write(json.dumps(new_data_list_2, ensure_ascii=False))
