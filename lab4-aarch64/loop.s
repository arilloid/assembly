.text
.globl _start

min = 0                          /* Starting value for the loop index (constant) */
max = 31                         /* Loop exits when the index hits this number (i < max) */

_start:
    mov     x19, min            /* Initialize loop counter (x19) with starting value (0) */

loop:
    /* Load divisor (10) into a register */
    mov     x22, 10             /* Load the constant 10 into x22 */

    /* Divide loop index by 10 to find the first digit (quotient) */
    udiv    x20, x19, x22       /* x20 = x19 / 10 (quotient for first digit) */
    
    /* Calculate the remainder using msub */
    msub    x21, x20, x22, x19  /* x21 = x19 - (x20 * 10); use xzr for zero register to ensure correct operation */

    /* Convert first digit to ASCII */
    add     w20, w20, #48       /* Convert integer in x20 to ASCII ('0' = 48) */
    adr     x23, msg_digit       /* Load address of the first digit placeholder in the message buffer */
    strb    w20, [x23]          /* Store the first digit in the message buffer */

    /* Convert second digit to ASCII */
    add     w21, w21, #48       /* Convert integer in x21 to ASCII ('0' = 48) */
    adr     x25, msg_digit + 1   /* Load address of the second digit placeholder in the message buffer */
    strb    w21, [x25]          /* Store the second digit in the message buffer */

    /* Write message to stdout */
    mov     x0, 1                /* File descriptor: 1 corresponds to stdout */
    adr     x1, msg              /* Load address of the message to be printed */
    mov     x2, len              /* Load the length of the message */
    mov     x8, 64               /* Specify syscall number for write (syscall #64) */
    svc     0                    /* Invoke syscall to write the message */

    /* Increment loop counter and check for loop continuation */
    add     x19, x19, 1          /* Increment loop counter (x19) by 1 */
    cmp     x19, max             /* Compare loop counter with the maximum value */
    b.ne    loop                 /* Branch to 'loop' if the counter has not reached max */

    /* Exit the program after completing the loop */
    mov     x0, 0                /* Set exit status to 0 (indicates successful termination) */
    mov     x8, 93               /* Specify syscall number for exit (syscall #93) */
    svc     0                    /* Invoke syscall to exit the program */

.data
msg:     .ascii      "Loop: ##\n"  /* Message template containing placeholders for the two digits */
msg_digit = msg + 6              /* Position of the first digit placeholder in the message (6 bytes in) */
len =    . - msg                 /* Calculate the length of the message for the write syscall */
