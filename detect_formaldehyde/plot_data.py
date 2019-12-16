# -*- coding: UTF-8 -*-
# !/usr/bin/python

import json
import datetime
import pandas as pd
import matplotlib.pylab as plt
import matplotlib.dates as md
# import matplotlib.ticker as mticker

from matplotlib.pyplot import MultipleLocator
from PIL import Image

datadir = '/tmp/'
savedir = '/root/'
width = 2

if __name__ == '__main__':
    time, datadetail = [], []
    time_now = datetime.datetime.now()
    truetime = f'{time_now.year}-{time_now.month:0{width}d}-{time_now.day:0{width}d}'

    for i in range(90):
        try:
            with open(f'{datadir}test_{i}_json.json', 'r') as fp:
                jsondata = json.load(fp)
                if not jsondata['Success']: continue
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
                            datadetail.append(float(b))
                        except:
                            continue
        except FileNotFoundError:
            continue
            # print(f'time is :{time}, datadetail is :{datadetail}')
    print(f'total data size is :{len(datadetail)}, and len(time) is {len(time)}')
    maxdata = max(datadetail)
    print(maxdata)
    # print(datadetail)
    # times = pd.date_range(start='2019-12-01',end='2019-12-02',periods=len(time)/3600)

    df = pd.DataFrame({'toronto_time': time, 'description': datadetail})
    df['toronto_time'] = pd.to_datetime(df['toronto_time'], format='%H:%M:%S')
    fig, ax = plt.subplots(figsize=(8, 6))
    plt.plot('toronto_time', 'description', data=df)
    ax.set_xlim(df['toronto_time'].min() - pd.Timedelta(1, 'h'),
                df['toronto_time'].max() + pd.Timedelta(1, 'h'))
    ax.xaxis.set_major_locator(md.HourLocator(interval=1))
    ax.xaxis.set_major_formatter(md.DateFormatter('%H:%M:%S'))
    # ax.xaxis.set_major_locator(mticker.MultipleLocator())
    # y_major_locator = MultipleLocator()
    # ax.yaxis.set_major_locator(y_major_locator)
    # plt.tick_params(axis='y', which='major', labelsize=12)
    fig.autofmt_xdate()
    ax.set_xlabel('time')
    ax.set_ylabel('mg/m^3')
    ax.set_title('formaldehyde')
    try:
        maxdata=float(maxdata)
        if maxdata>0.08:
            plt.axhline(y=0.08, ls="-", c="red")  # draw a Horizontal GB 0.08 line.
    except:
        pass                                                         
    # plt.show()
    plt.savefig(f'{savedir}get_data_{truetime}.png')
    image = Image.open(f'{savedir}get_data_{truetime}.png')
    # image = image.resize((128, 64))
    gay = image.convert("1")
    gay.save(f'{savedir}get_data_{truetime}.png')
