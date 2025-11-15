#include "../../include/kernel.h"

void kernel_panic(){
	for (;;){
		asm volatile("hlt");
	}
}