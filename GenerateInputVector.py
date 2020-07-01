import requests
import hashlib
import time
import json
import random
import string
from urllib.parse import quote


# 调用api，对公文标题进行分词
class getAPI():

    @staticmethod
    def curlmd5(src):
        m = hashlib.md5(src.encode('UTF-8'))

        # 将得到的MD5值所有字符转换成大写
        return m.hexdigest().upper()

    @staticmethod
    def get_params(text):

        # 请求时间戳（秒级），用于防止请求重放（保证签名5分钟有效） 
        t = time.time()
        time_stamp = str(int(t))

        # 请求随机字符串，用于保证签名不可预测  
        nonce_str = ''.join(random.sample(
            string.ascii_letters + string.digits, 10))

        # 腾讯云可以免费开通使用，但是有并发量限制  
        app_id = '2131825293'
        app_key = 'oV8RSUibqk37pcLg'
        params = {
            'app_id': app_id,
            'time_stamp': time_stamp,
            'nonce_str': nonce_str,
            'text': text
        }

        sign_before = ''

        # 要对key排序再拼接
        for key in sorted(params):

            # 键值拼接过程value部分需要URL编码，URL编码算法用大写字母，例如%E8。quote默认大写。
            sign_before += '{}={}&'.format(key, quote(params[key], safe=''))

        # 将应用密钥以app_key为键名，拼接到字符串sign_before末尾
        sign_before += 'app_key={}'.format(app_key)

        # 对字符串sign_before进行MD5运算，得到接口请求签名  
        sign = getAPI.curlmd5(sign_before)

        params['sign'] = sign

        return params

    @staticmethod
    def get_content(text):

        # 去掉特殊字符
        text = text.replace(' ', '').replace('~', '')

        # print('输入内容：' + text)

        # 由于使用的是免费的api接口，需要保证一定的访问时间差，采用这种方法保证时间间隔
        while True:
            with open('数据处理\\api_timestamp.txt', 'a+', encoding='utf-8') as f:
                last_timestamp = f.read()

                if last_timestamp == '':

                    f.seek(0, 0)
                    f.truncate()
                    f.write(str(time.time()))
                    break

                if time.time() - float(last_timestamp) < 1:
                    time.sleep(2)

                else:
                    f.seek(0, 0)
                    f.truncate()
                    f.write(str(time.time()))
                    break

        # API地址
        url = "https://api.ai.qq.com/fcgi-bin/nlp/nlp_wordpos"

        # 获取请求参数    
        try:
            text = text.replace('\u2022','').replace('\ufffd','').replace('・','').encode('gbk')
        except:

            for each_char in text:
                try:
                    each_char.encode( 'gbk' )
                except:
                    text = text.replace(each_char,'')
            else:
                try:
                    text = text.encode('gbk')
                except:
                    print('遇到了编码问题，请剔除标题中的特殊字符串')
                    raise UnicodeEncodeError

        payload = getAPI.get_params(text)

        while True:
            try:
                respond_dict = requests.post(url, data=payload).json()
                break
            except:
                time.sleep(3)

        if respond_dict['ret'] != 0:

            print('调用接口失败，原因是%s' % respond_dict['msg'])
            return 0

        else:
            # 屏蔽掉一些没用的词
            fittered_list = [0, 1, 4, 5, 7, 8, 9, 15, 23, 24,
                             25, 26, 27, 28, 29, 30, 34, 35, 49, 50, 51, 52, 55]
            respond_dict = respond_dict['data']['mix_tokens']

            result_list = []
            for x in respond_dict:
                if not x['pos_code'] in fittered_list:
                    result_list.append(x['word'])
            else:
                del x

        return(result_list)


def Generate(title):
    """
    生成公文标题对应的初始神经元输入
    """

    # 调用腾讯云api将标题中的关键词分割出来
    title_keyword_list = getAPI.get_content(title)

    with open('数据处理\\处理到最后投入使用的数据\\输入神经元与序号.json','r',encoding='utf-8') as f:
        keyword_and_order_dict = json.loads(f.read())

    input_vector = []

    print('\n分词结果:',title_keyword_list,'\n\n')
    for keyword in title_keyword_list:

        if keyword_and_order_dict.__contains__(keyword):

            # 关键词转化为对应的序号，发送给matlab
            input_vector.append(keyword_and_order_dict[keyword])

    return input_vector

if __name__ == "__main__":
    """
    上面函数是test时MATLAB调用的，
    在训练中无需使用到
    当MATLAB版本过低无法直接调用Python时，需要运行main函数
    """
    input_vector = Generate(input('输入要预测的公文标题：'))
    print('请运行Test2.m，然后把下列的输出复制后输入Test2.m(连同中括号一起复制)\n\n',input_vector,'\n')
    
