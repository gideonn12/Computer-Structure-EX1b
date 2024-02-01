/* Gideon Neeman 329924567 */
.extern printf
.extern scanf
.extern pstrlen
.section .rodata
choise_31:
    .string "first pstring length: %d, second pstring length :%d\n"
choise_33:
    .string "length: %d,string: %s\n"
choise_34:
    .string "text"
invalid_opt:
    .string "invalid option!\n"

.section .text
.globl run_func
.type   run_func, @function
run_func:
    pushq %rbp
    movq %rsp, %rbp     # enter
    
    cmp $31, %rdi       # check if user wants option 31
    je opt_31
    cmp $33, %rdi       # check if user wants option 33
    je opt_33
    cmp $34, %rdi       # check if user wants option 33
    je opt_34
    jmp invalid         # invalid option         

opt_31:
    movq %rsi, %rdi     # move first pstring to rdi 
    call pstrlen        # call func for opt 31
    movb %al, %dl       # first pstrlen
    xorq %rax, %rax
    movq $choise_31, %rdi
    movq %r15, %rsi
    call printf
    jmp exit
opt_33:
    jmp exit

opt_34:
    jmp exit
invalid:            # print invalid option
    xorq %rax, %rax
    movq  $invalid_opt, %rdi
    call printf
    jmp exit

exit:
    xorq %rax, %rax     # exit 
    movq %rbp, %rsp
    popq %rbp
    ret
