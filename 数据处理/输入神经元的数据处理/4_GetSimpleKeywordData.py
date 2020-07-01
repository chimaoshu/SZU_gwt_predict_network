"""
这个脚本的目的是把其中其他数据剔除掉，只保留1534个关键词的key-value数据
"""

import json
# 读取数据
with open('数据处理\\输入神经元的数据处理\\3_word_weights.json', 'r', encoding='utf-8') as f:
    _data = json.loads(f.read())

new_data_list = {}

for keyword in _data.keys():
    new_data_list[keyword] = _data[keyword]['weight']

# 写入数据
with open('数据处理\\输入神经元的数据处理\\4_word_weights.json', 'a+', encoding='utf-8') as f:
    f.write(json.dumps(new_data_list, ensure_ascii=False))
