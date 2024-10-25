.text
.globl _start
min = 0                          /* starting value for the loop index; **note that this is a symbol (constant)**, not a variable */
max = 31                         /* loop exits when the index hits this number (loop condition is i<max) */
divisor = 10                     /* divisor for 2-digit conversion */
_start:
    /*
        register assignmnets
        ---------------------
        r19 = loop index  
        r20 = divisor
        r21 = 1st digit of loop index
        r22 = 2nd digit of loop index
        r23 = adress of the digit in the message buffer
     */
    mov     x19, min   
    mov     x20, divisor   
    loop:
        /* divide loop index by 10 to find the first digit (quotient) */
        udiv    x21, x19, x20       /* quotient for first digit = x21 = index / 10 */
        
        /* calculate the remainder (second digit) using msub */
        msub    x22, x21, x20, x19  /* x22 = index - (quotient * divisor) */

        /* convert first digit to ASCII */
        add     w21, w21, #48       /* convert the 1st digit to ASCII */
        adr     x23, msg_digit_1    /* load address of the first digit placeholder in the message buffer */
        strb    w21, [x23]          /* store the first digit in the message buffer */

        /* convert second digit to ASCII */
        add     w22, w22, #48       /* convert the 2nd digit to ASCII */
        adr     x23, msg_digit_2    /* load address of the second digit placeholder in the message buffer */
        strb    w22, [x23]          /* store the second digit in the message buffer */

        /* write message to stdout */
        mov     x0, 1       /* file descriptor: 1 is stdout */
        adr     x1, msg   	/* message location (memory address) */
        mov     x2, len   	/* message length (bytes) */
        mov     x8, 64     	/* write is syscall #64 */
        svc     0          	/* invoke syscall */

        /* looping */
        add     x19, x19, 1     /* increment the loop counter */
        cmp     x19, max        /* see if we've hit the max */
        b.ne    loop            /* if not, then continue the loop */

        /* exit the program after loop exit */
        mov     x0, 0           /* set exit status to 0 */
        mov     x8, 93          /* exit is syscall #93 */
        svc     0               /* invoke syscall */

.data
msg: 	.ascii      "Loop: ##\n"
len= 	. - msg
/* positions of the digit placeholders */
msg_digit_1 = msg + 6     
msg_digit_2 = msg + 7

