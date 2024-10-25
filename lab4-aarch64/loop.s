.text
.globl _start
min = 0                          /* starting value for the loop index; **note that this is a symbol (constant)**, not a variable */
max = 10                         /* loop exits when the index hits this number (loop condition is i<max) */
_start:
    mov     x19, min
    loop:
        /* convert loop index to ASCII and store it in message buffer */
        add     w20, w19, #48        /* convert integer in w19 to ASCII character '0'-'9' */
        adr     x21, msg_digit       /* load address of digit placeholder in message buffer */
        strb    w20, [x21]           /* store the digit in the place of the placeholder */

        /* write message to the screen */
        mov     x0, 1       /* file descriptor: 1 is stdout */
        adr     x1, msg   	/* message location (memory address) */
        mov     x2, len   	/* message length (bytes) */
        mov     x8, 64     	/* write is syscall #64 */
        svc     0          	/* invoke syscall */

        /* looping functionality */
        add     x19, x19, 1     /* increment the loop counter */
        cmp     x19, max        /* see if we've hit the max */
        b.ne    loop            /* if not, then continue the loop */

        /* exiting the program when loop ends */
        mov     x0, 0           /* set exit status to 0 */
        mov     x8, 93          /* exit is syscall #93 */
        svc     0               /* invoke syscall */

.data
msg: 	.ascii      "Loop: 0\n"
/* position of the digit placeholder */
msg_digit = msg + 6
len= 	. - msg
