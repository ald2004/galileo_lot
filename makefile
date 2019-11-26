#  "productKey": "a1lzEibT7GB",
#  "deviceName": "uebZRgkXXWI0uJhzghix",
#  "deviceSecret": "qd3VaPSws2MRBuVZCElQorUAHO452v6p",
#  "region": "cn-shanghai"
CC       = g++
LD       = ld
CFLAGS	 = -Wall -O -g -std=c++11
OBJS     = sample.o
INCLUDE  = -I ./include -I ./include/exports/ -I ./ -I /usr/include/upm
TARGET	 = quickstart
LIBVAR	+= -liot_sdk \
           -liot_hal \
           -liot_tls \
           -lpthread \
           -lmraa \
           -lupm-lcd \
           -lupm-utilities \
           -lupmc-utilities \
           -lrt
LIBPATH = -L ./lib -L ./ -L /usr/lib

vpath %.c ./

PK = a1lzEibT7GB
DN = uebZRgkXXWI0uJhzghix
DS = qd3VaPSws2MRBuVZCElQorUAHO452v6p
DOMAIN = iot-as-mqtt.cn-shanghai.aliyuncs.com
DID = -DDEVICE_NAME=\"${DN}\" \
	  -DPRODUCT_KEY=\"${PK}\" \
	  -DDEVICE_SECRET=\"${DS}\" \
	  -DMQTT_DOMAIN=\"${DOMAIN}\"



OBJS= sample.o

.PHONY:all
all:$(OBJS)
	echo $(DID)
	$(CC) $(CFLAGS) $(INCLUDE) -o $(TARGET) $(OBJS) $(LIBVAR) $(LIBPATH)
#	$(TARGET) 3
sample.o:sample.c
	make clean -s
	$(CC) $(CFLAGS) $(INCLUDE) ${DID} -c $^
	rm -rf $(TARGET)
.PHONY:clean
clean:
	rm -f *.o
	rm -f $(TARGET)
