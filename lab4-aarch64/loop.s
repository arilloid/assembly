 .text
 .globl _start
 min = 0                          /* starting value for the loop index; **note that this is a symbol (constant)**, not a variable */
 max = 10                         /* loop exits when the index hits this number (loop condition is i<max) */
 _start:
    mov     x19, min
 loop:

    /* ... body of the loop ... do something useful here ... */

    add     x19, x19, 1     /* increment the loop counter */
    cmp     x19, max        /* see if we've hit the max */
    b.ne    loop            /* if not, then continue the loop */

    mov     x0, 0           /* set exit status to 0 */
    mov     x8, 93          /* exit is syscall #93 */
    svc     0               /* invoke syscall */