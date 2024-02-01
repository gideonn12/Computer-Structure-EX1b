/* Gideon Neeman 329924567 */
.section .rodata
test:
    .string "The length of the string is: %d\n"
.section .text

.globl pstrlen
.type   pstrlen, @function 
pstrlen:
    pushq %rbp      # callee conv. backup RBP and set RBP to Activation Frame
    movq %rsp, %rbp
    movb (%rdi), %al # move the char that is the number to al: al=rax 

    movq %rbp, %rsp # callee conv. free activation frame and restore main frame
    popq %rbp
    ret
