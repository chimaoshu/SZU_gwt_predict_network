"""
这个脚本是在设计阶段，辅助进行判断
通过重复测试发现，从2013年至今，出现次数大于200次的关键词正好有600个
我们就采用这600个关键词来做神经元的输入层，用0和1表示关键词的出现与否
"""
import json
with open('data\\word_weights.json', 'r', encoding='utf-8') as f:
    data = f.read()
    data = json.loads(data)

while 1:
    max_num = input('输入数字：')
    total_num = 0
    for keyword in data.keys():
        if data[keyword]['total_doc_num'] >= int(max_num):
            total_num += 1

    print('几年以来公文数目超过%s的关键词的总数为%s\n' % (max_num, total_num))

