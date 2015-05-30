#  "productKey": "111111111",
#  "deviceName": "2222222222",
#  "deviceSecret": "33333333333",
#  "region": "cn-shanghai"
CC       = g++
LD       = ld
CFLAGS	 = -Wall -O -g -std=c++11
OBJS     = sample.o
INCLUDE  = -I ./include -I ./include/exports/ -I ./
TARGET	 = quickstart
LIBVAR	+= -liot_sdk \
           -liot_hal \
           -liot_tls \
           -lpthread \
           -lmraa \
           -lrt
LIBPATH = -L ./lib -L ./

vpath %.c ./

PK = 111111
DN = 2222222222
DS = 3333333333
DOMAIN = iot-as-mqtt.cn-shanghai.aliyuncs.com
DID = -DDEVICE_NAME=\"${DN}\" \
	  -DPRODUCT_KEY=\"${PK}\" \
	  -DDEVICE_SECRET=\"${DS}\" \
	  -DMQTT_DOMAIN=\"${DOMAIN}\"



OBJS= sample.o

.PHONY:all
all:$(OBJS)
	$(CC) $(CFLAGS) $(INCLUDE) -o $(TARGET) $(OBJS) $(LIBVAR) $(LIBPATH)
	$(TARGET) 3
sample.o:sample.c
	make clean -s
	$(CC) $(CFLAGS) $(INCLUDE) ${DID} -c $^
	rm -rf $(TARGET)
.PHONY:clean
clean:
	rm -f *.o
	rm -f $(TARGET)
