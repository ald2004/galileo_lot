#dart wz-h3-k formaldehyde sensor
import mraa,time,sys
port = "/dev/ttyUSB0"
u = mraa.Uart(port)
u.setBaudRate(9600)
u.setMode(8, mraa.UART_PARITY_NONE, 1)
u.setFlowcontrol(False, False)

def read_all_data():
  yy=[]
  while u.dataAvailable():
    xx = ''.join('{:02x}'.format(x) for x in u.read(9))
    #print xx
    yy.append(xx)
  return yy


#switch to qa mode
def goto_qa():
  ret=u.write(bytearray("FF0178410000000046".decode("hex")))
  assert ret==9

#switch auto upload mode
def goto_auto():
  ret=u.write(bytearray("FF0178400000000047".decode("hex")))
  assert ret==9


#read formaldehyde
def read_formaldehyde():
  ret=u.write(bytearray("FF0186000000000079".decode("hex")))
  assert ret==9
  return ''.join('{:02x}'.format(x) for x in u.read(9))

'''
>>> goto_qa()
>>> xx=read_formaldehyde()
>>> xx
'ff7841000000000047'
>>> goto_auto()
>>> read_all_data()
['ff860000000000007a', 'ff7840000000000048', 'ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039']
>>> goto_qa()
>>> read_all_data()
['ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039', 'ff17040002d307d039', 'ff7841000000000047']
>>> xx=read_formaldehyde()
>>> xx
'ff8602ec0000025e2c'
>>>
'''
