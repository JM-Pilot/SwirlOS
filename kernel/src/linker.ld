OUTPUT_FORMAT(elf64-x86-64)
ENTRY(kernel_main)
SECTIONS
{
	. = 0xffffffff80000000;

	.text (READONLY) :
	{
		*(.text)
	}
	.data (READONLY) :
	{
		*(.data)
	}
	.rodata (READONLY) :
	{
		*(.rodata)
	}
	.bss (READONLY) :
	{
		*(.bss)
	}
}