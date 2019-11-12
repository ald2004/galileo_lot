SHELL = /bin/sh
TARGET_BIN    = dsp
TARGET_ARCH   = -m32 -march=i586 --sysroot=/opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc
INCLUDE_DIRS  = -I . \
				-I $(TOOLDIR)../include \
				-I $(TOOLDIR)../include/c++ \
				-I $(TOOLDIR)../lib/i586-poky-linux-uclibc/gcc/i586-poky-linux-uclibc/4.7.2/include 
LIBRARY_DIRS  = -L $(TOOLDIR)../../lib \
				-L $(TOOLDIR)../lib \
				-L $(TOOLDIR)../lib/i586-poky-linux-uclibc/4.7.2 \
				-L $(TOOLDIR)../lib/i586-poky-linux-uclibc/4.7.2 
COMPILE_OPTS  = -O2 -pipe -g -feliminate-unused-debug-types -fpermissive -Wall $(INCLUDE_DIRS) 

TOOLDIR = /opt/clanton-tiny/1.4.2/sysroots/pokysdk/usr/bin/i586-poky-linux-uclibc/
CC      = $(TOOLDIR)i586-poky-linux-uclibc-g++
CXX     = $(CC)
AS      = $(CC)
LD      = $(CC)
AR      = $(TOOLDIR)i586-poky-linux-uclibc-ar
CFLAGS  = $(COMPILE_OPTS)
CXXFLAGS= $(COMPILE_OPTS)
LDFLAGS = -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed $(LIBRARY_DIRS) -lstdc++ -lpthread

all: target

target: $(patsubst %.c,%.o,$(wildcard *.c)) $(patsubst %.cpp,%.o,$(wildcard *.cpp)) 
	$(LD) $(LDFLAGS) $(TARGET_ARCH) $^ -o $(TARGET_BIN) -lpthread 
	scp dsp root@galileo:/opt
	ssh root@galileo /opt/dsp


dsp: dsp.c 
	$(CXX) $(CXXFLAGS) $(TARGET_ARCH) dsp.c i2c.c pwm.c -Wno-write-strings -o dsp -lrt 
	scp dsp root@192.168.123.50:
#	ssh root@192.168.123.50 ./dsp

clean:
	rm -f $(TARGET_BIN) *.o
