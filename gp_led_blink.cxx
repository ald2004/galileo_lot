/* standard headers */
#include <iostream>
#include <signal.h>
#include <stdlib.h>

#ifdef _WIN32
#define LOG_CRIT        2
#include <windows.h>
#define SLEEP(a) Sleep(a)
#else
#include <unistd.h>
#define SLEEP(a) sleep(a)
#endif

/* mraa headers */
#include "mraa/common.hpp"
#include "mraa/gpio.hpp"

/* gpio declaration */
#define GPIO_PIN_1 3

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
main(int argc, char** argv)
{
	mraa::Result status;

	/* install signal handler */
	signal(SIGINT, sig_handler);
	//! [Interesting]
	/* initialize GPIO pin */
	int GPIO_PORT= GPIO_PIN_1;
	if (argc > 1)GPIO_PORT = atoi(argv[1]);
	mraa::Gpio gpio_1(GPIO_PORT, true, true);


	/* set GPIO to output */
	status = gpio_1.dir(mraa::DIR_OUT);
	if (status != mraa::SUCCESS) {
		printError(status);
		return EXIT_FAILURE;
	}


	/* toggle both GPIO's */
	while (flag) {
		status = gpio_1.write(1);
		if (status != mraa::SUCCESS) {
			printError(status);
			return EXIT_FAILURE;
		}
		std::cout << "1" << std::endl;
		SLEEP(1);

		status = gpio_1.write(0);
		if (status != mraa::SUCCESS) {
			printError(status);
			return EXIT_FAILURE;
		}
		std::cout << "0" << std::endl;

		SLEEP(1);
	}

	return EXIT_SUCCESS;
}
