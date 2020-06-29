"""
这个脚本的目的是把其中单字的关键词剔除掉
"""

import json
# 读取数据
with open('数据处理\\输入神经元与初始权重\\1_word_weights.json', 'r', encoding='utf-8') as f:
    _data = json.loads(f.read())

new_data_list_len = 0
new_data_list = {}

# 找到并存储前500名关键词
for keyword in _data.keys():
    if len(keyword) == 1:
        continue
    new_data_list[keyword] = _data[keyword]

# 写入数据
with open('数据处理\\输入神经元与初始权重\\2_word_weights.json', 'a+', encoding='utf-8') as f:
    f.write(json.dumps(new_data_list, ensure_ascii=False))
