"""
这个脚本的目的是把数据中出现频率前1534名的关键词跳出来
由TestDataDistribution.py脚本可以知道前1534名的关键词正好就是出现次数不小于20的公文
"""

import json
# 读取数据
with open('数据处理\\输入神经元与初始权重\\2_word_weights.json', 'r', encoding='utf-8') as f:
    _data = json.loads(f.read())

new_data_list = {}
# 找到并存储出现次数超过38的关键词
for keyword in _data.keys():
    if _data[keyword]['total_doc_num'] >= 20:
        new_data_list[keyword] = _data[keyword]

# 写入数据
with open('数据处理\\输入神经元与初始权重\\3_word_weights.json', 'a+', encoding='utf-8') as f:
    f.write(json.dumps(new_data_list, ensure_ascii=False))
