/* Gideon Neeman 329924567 */
.extern printf
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
    movq %rdi, %r8 # save the pointer to the pstring
    incq %rdi      
    jmp .loop

.loop:
    cmpb $0x0,(%rdi)   # if the char is null nothing to change
    je exit
    cmpb $'A',(%rdi)    # check if maybe it is not letters
    jl .next
    cmpb $'z',(%rdi)    # check if it is not letters
    jg .next    
    cmpb $'a',(%rdi)     # check if it is lower case
    jge  upperCase    # if it is lower case then change to upper
    movb (%rdi), %al
    addb $0x20, %al
    movb %al, (%rdi) # change to lower case
    jmp .next
upperCase:
    movb (%rdi), %al
    addb $-0x20, %al
    movb %al, (%rdi) # change to upper case
    jmp .next

.next:
    incq %rdi
    jmp .loop
exit:
    movq %r8, %rax # return the pointer to the string
    movq %rbp, %rsp # callee conv. free activation frame and restore main frame
    popq %rbp
    ret

.globl pstrijcpy
.type   pstrijcpy, @function
pstrijcpy:
    pushq %rbp      # callee conv. backup RBP and set RBP to Activation Frame
    movq %rsp, %rbp
    movq %rdi, %r8      # save the pointer to the pstring
    addq %rdx, %rsi     # move the pointer to index i-1
    addq %rdx, %rdi     # move the pointer to index i-1
    incq %rdi           # move the pointer to index i
    incq %rsi           # move the pointer to index i
    jmp .looper
    
.looper:
    movb (%rsi), %al    # move the char from src do dest
    movb %al,(%rdi)
    incq %rsi
    incq %rdi           # move the pointer to index i+1
    incq %rdx

.contr:
    cmpq %rdx, %rcx     # check if i<=j
    jl exit2
    jmp .looper
exit2:
    movq %r8, %rax      # return the pointer to the string
    movq %rbp, %rsp     # callee conv. free activation frame and restore main frame
    popq %rbp
    ret


