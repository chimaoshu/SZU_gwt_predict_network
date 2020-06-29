"""
这个脚本的目的是生成关键词与对应序号：final_keyword_and_order_6.json
"""

import json

# 读取数据
with open('数据处理\\输入神经元与初始权重\\5_final_word_weights.json', 'r', encoding='utf-8') as f:
    _data = json.loads(f.read())

new_data_list = {}

order = 0

for keyword in _data.keys():

    order += 1
    new_data_list[keyword] = order

# 写入数据
with open('数据处理\\输入神经元与初始权重\\6_final_keyword_and_order.json', 'a+', encoding='utf-8') as f:
    f.write(json.dumps(new_data_list, ensure_ascii=False))
