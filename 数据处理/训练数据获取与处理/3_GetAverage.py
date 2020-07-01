"""
这个脚本的目的对训练数据进行分析
"""

import json

# 读取数据
with open('数据处理\\训练数据\\1_training_data.json', 'r', encoding='utf-8') as f:
    data = json.loads(f.read())

k = []
num = 0
sum1 = 0
for i in data.keys():

    if not 100<= data[i]['click_times'] <= 1000:
        continue

    k.append(data[i]['click_times'])
    num += 1
    sum1 += data[i]['click_times']

else:
    AVERAGE = int( sum1 / num )

# 345
print(AVERAGE)

while 1:
    a = int(input('偏差'))
    i = 0
    for k1 in k:
        
        if (AVERAGE - a) <= k1 <= (AVERAGE + a):
            i += 1

    else:
        print( i / len(k) ,'\n')

# 测试发现，数据集2百分之85的数据坐落在 100~~595 之间
# 数据集1，百分之85的数据坐落在 118~~718 之间