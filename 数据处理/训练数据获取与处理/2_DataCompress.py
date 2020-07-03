"""
这个脚本的目的对训练数据进行处理和压缩
生成最后的 4_compressed_training_data.json ，用于训练的数据
"""

import json

# 读取数据
with open('数据处理\\训练数据获取与处理\\3_training_data.json', 'r', encoding='utf-8') as f:
    training_data_dict = json.loads(f.read())

with open('数据处理\\处理到最后投入使用的数据\\输入神经元与序号.json', 'r', encoding='utf-8') as f:
    keyword_and_order_dict = json.loads(f.read())

new_data_list = []

for i in training_data_dict.keys():

    # 点击量过小的数据剔除掉
    if training_data_dict[i]['click_times'] <= 50:
        continue

    # 点击量过大也扔掉
    if training_data_dict[i]['click_times'] >= 1000:
        continue

    # 获取关键词列表
    keyword_list = training_data_dict[i]['keyword']

    # 用来装每一则训练数据
    training_datum_set = []

    # 遍历列表中每一则关键词
    for j in keyword_list:

        if keyword_and_order_dict.__contains__(j):

            # 规定training_datum_set中第一个元素为期望值，后面元素为每个词对应的位置，以达到压缩效果
            # 将keyword数据转化为对应编号存储
            training_datum_set.append(keyword_and_order_dict[j])

    # 遍历完成后
    else:
        # 如果数据量不为0
        if len(keyword_and_order_dict):

            # 在training_datum_set第一号元素插入click_times
            training_datum_set.insert(0, training_data_dict[i]['click_times'])

            # 最后完成
            new_data_list.append(training_datum_set)

# 写入数据
with open('数据处理\\训练数据获取与处理\\4_compressed_training_data.json', 'a+', encoding='utf-8') as f:
    f.write(json.dumps(new_data_list, ensure_ascii=False))
