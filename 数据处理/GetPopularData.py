"""
这个脚本的目的是把数据中出现频率前600名的关键词跳出来
出现频率前600名的关键词，由TestDataDistribution.py脚本可以
"""
import json
with open('data\\word_weights.json', 'r', encoding='utf-8') as f:
    _data = json.loads(f.read())

new_data_list = {}
for keyword in _data.keys():
    if _data[keyword]['total_doc_num'] >= 200:
        new_data_list[keyword] = _data[keyword]

with open('data\\popular_keyword_data.json', 'a+', encoding='utf-8') as f:
    f.write(json.dumps(new_data_list, ensure_ascii=False))
