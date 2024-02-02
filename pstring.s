/* Gideon Neeman 329924567 */
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

.globl swapCase
.type   swapCase, @function
swapCase:
    pushq %rbp      # callee conv. backup RBP and set RBP to Activation Frame
    movq %rsp, %rbp

    cmpb $0,1(%rdi)   # if the char is null nothing to change
    je exit

    cmpb $'a',1(%rdi) # check if it is lower case
    jge  upperCase    # if it is lower case then change to upper
    movb $'v',1(%rdi) # change to lower case
    jmp exit
upperCase:
    movb $'W',1(%rdi) # change to upper case
    jmp exit
exit:
    movq %rdi, %rax # return the pointer to the string
    movq %rbp, %rsp # callee conv. free activation frame and restore main frame
    popq %rbp
    ret