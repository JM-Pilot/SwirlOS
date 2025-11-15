#ifndef FRAMEBUFFER_H
#define FRAMEBUFFER_H

#include "../../limine.h"
#include "../../lib/kstdtype.h"

void init_framebuffer();
void plot_pix(int x, int y, uint32_t col);
#endif