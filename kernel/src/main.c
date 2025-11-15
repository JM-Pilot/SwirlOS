#include "../../include/drivers/video/framebuffer.h"
void kernel_main(){
	init_framebuffer();
	plot_pix(5, 5, 0xFF0000);
	for (;;){
		asm volatile("hlt");
	}
}