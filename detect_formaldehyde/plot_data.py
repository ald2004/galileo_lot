# -*- coding: UTF-8 -*-
#!/usr/bin/python

import json
# time, os, sys
# import pandas as pd
# import seaborn as sns
import matplotlib.pylab as plt
from PIL import Image

if __name__ == '__main__':
    time, datadetail = [], []
    truetime = ''
    with open(f'test_0_json.json', 'r') as fp:
        jsondata = json.load(fp)
        jsondata = jsondata["Data"]["ResultList"]["ResultList"]
        truetime = jsondata[0]['time'].split(' ')[0]
    for i in range(90):
        with open(f'test_{i}_json.json', 'r') as fp:
            jsondata = json.load(fp)
            jsondata = jsondata["Data"]["ResultList"]["ResultList"]
            if len(jsondata) > 0:
                '''
                {'time': '2019-12-01 10:01:35', 'data': 'CH4:0.04106|CH2O:0.0000 mg/m3'}, {'time': '2019-12-01 14:27:29', 'data': 'CH4:0.03715|CH2O:0.0000 mg/m3'}, 
                {'time': '2019-12-01 01:01:31', 'data': 'CH4:0.04008|CH2O:0.0000 mg/m3'}
                '''
                for xx in jsondata:
                    try:
                        a = xx['time'].split(' ')[1]
                        b = xx['data'].split('|')[1].split(' ')[0].split(':')[1]
                        time.append(a)
                        datadetail.append(b)
                    except:
                        continue

                # print(f'time is :{time}, datadetail is :{datadetail}')
    print(f'total data size is :{len(datadetail)}, and len(time) is {len(time)}')
    print(time)
    # print(datadetail)
    # times = pd.date_range(start='2019-12-01',end='2019-12-02',periods=len(time)/3600)
    for i in range(len(time)):
        if i % 3455:
            time[i] = ''

    plt.plot(time, datadetail)
    plt.savefig(f'get_data_{truetime}.png')
    # plt.show()
    image = Image.open(f'get_data_{truetime}.png')
    # image=image.resize((128,64))
    gay=image.convert("1")
    gay.save(f'get_data_{truetime}.png')
