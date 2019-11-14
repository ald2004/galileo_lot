/* standard headers */
#include <iostream>
#include <signal.h>
#include <stdlib.h>

/* mraa headers */
#include "mraa/aio.hpp"
#include "mraa/common.hpp"
#ifdef _WIN32
#define LOG_CRIT        2
#include <windows.h>
#define SLEEP(a) Sleep(a)  //dwMilliseconds
#else
#include <unistd.h>
#define SLEEP(a) usleep(a*1000) //microseconds * 10^3
#endif

/* AIO port */
#define AIO_PORT 0

volatile sig_atomic_t flag = 1;

void
sig_handler(int signum)
{
	if (signum == SIGINT) {
		std::cout << "Exiting..." << std::endl;
		flag = 0;
	}
}

int
main(void)
{
	uint16_t value;
	float float_value;

	signal(SIGINT, sig_handler);

	//! [Interesting]
	/* initialize AIO */
	mraa::Aio aio(AIO_PORT);

	while (flag) {
		value = aio.read();
		float_value = aio.readFloat();
		std::cout << "ADC A0 read %X - %d" << value << value << std::endl;
		std::cout << "ADC A0 read float - %.5f" << float_value << std::endl;
		SLEEP(500);
	}
	//! [Interesting]

	return EXIT_SUCCESS;
}
/*

ADC A0 read % X - % d00
ADC A0 read float - % .5f0
ADC A0 read % X - % d00
ADC A0 read float - % .5f0
ADC A0 read % X - % d223223
ADC A0 read float - % .5f0.217986
ADC A0 read % X - % d223223
ADC A0 read float - % .5f0.217986
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.218964
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.218964
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.218964
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.218964
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.218964
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.217986
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.218964
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.218964
ADC A0 read % X - % d224224
ADC A0 read float - % .5f0.218964
ADC A0 read % X - % d00
ADC A0 read float - % .5f0
ADC A0 read % X - % d00
ADC A0 read float - % .5f0
ADC A0 read % X - % d00
ADC A0 read float - % .5f0
ADC A0 read % X - % d00

*/
