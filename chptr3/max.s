.section .data
data_items:
    .long 3, 67, 123, 1, 23, 43, 7, 44, 26, 222, 255

count:
		.long 11

.section .text

.globl _start
_start:
    movl $0, %edi
#		movl $11, %edx
    movl data_items(, %edi, 4), %eax
    movl %eax, %ebx

	movl $data_items, %ecx
	movl count, %edx
	imul $4, %edx
	addl %ecx, %edx

start_loop:
	cmpl %ecx, %edx
	je loop_exit
#		cmpl %edx, %edi
#		je loop_exit

    incl %edi
    movl data_items(,%edi, 4), %eax
	add $4, %ecx

#		cmpl $255, %eax
#       je loop_exit

	cmpl %ebx, %eax
    jle start_loop

    movl %eax, %ebx
    jmp start_loop

loop_exit:
    movl $1, %eax
    int $0x80
