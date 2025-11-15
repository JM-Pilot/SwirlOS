#include "../../include/drivers/video/framebuffer.h"
#include "../../include/limine.h"
#include "../../include/kernel.h"

struct limine_framebuffer *framebuffer;
__attribute__((used, section(".limine_requests")))
static volatile struct limine_framebuffer_request framebuffer_request = {
    .id = LIMINE_FRAMEBUFFER_REQUEST_ID,
    .revision = 0
};


void init_framebuffer(){
	if (framebuffer_request.response == NULL || framebuffer_request.response->framebuffer_count < 1) {
		kernel_panic();
	}
	framebuffer = framebuffer_request.response->framebuffers[0];
}

void plot_pix(int x, int y, uint32_t col){
	volatile uint32_t *fb_ptr = framebuffer->address;
        fb_ptr[y * framebuffer->width + x] = col;
}