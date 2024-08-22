.section .data
.section .text

.globl _start
_start:
    pushl $0
    pushl $3
    call power
		add $8, %esp
		push %eax
    movl %eax, %ebx

    movl $1, %eax
    int $0x80


    .type power, @function
    power:
            pushl %ebp
            movl %esp, %ebp

            movl 8(%ebp), %ebx          # ebx = number
            movl 12(%ebp), %ecx         # ecx = power

            subl $4, %esp               # get room for local storage
            movl %ebx, -4(%ebp)         # save current result in local storage

            power_loop_start:
                cmpl $0, %ecx
								je zero_power

								cmpl $1, %ecx           # if power = 1
                je end_power          # jump end of function


                movl -4(%ebp), %eax     # save current result in temp storage
                imull %ebx, %eax        # current result = current result * number
                movl %eax, -4(%ebp)     # save current result in local storage

                decl %ecx               # decrement power
                jmp power_loop_start

            movl -4(%ebp), %eax         # set result in return value

        end_power:
						movl -4(%ebp), %eax
            movl %ebp, %esp
            popl %ebp
            ret
				zero_power:
						movl $1, %eax
						movl %ebp, %esp
						popl %ebp
						ret
