/* Gideon Neeman 329924567 */
.extern printf
.extern scanf
.extern pstrlen
.extern swapCase
.section .rodata
choise_31:
    .string "first pstring length: %d, second pstring length :%d\n"
choise_33:
    .string "length: %d,string: %s\n"
choise_34:
    .string "%d %d"
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
    movq %rax, %rsi     # first pstrlen
    movq %rdx, %rdi     # move second pstring to rdi
    call pstrlen        # call func for opt 31
    movq %rax, %rdx
    xorq %rax, %rax
    movq $choise_31, %rdi
    call printf
    jmp exit


opt_33:
    movq %rsi, %rdi     # move first pstring to rdi 
    movq %rsi, %r11
    call pstrlen        # get length of first pstring
    movq %rax, %r14      # set it in r14

    movq %rdx, %r15     # move second pstring to r15
    movq %r11, %rdi
    call swapCase       # swap for first string
    movq $choise_33, %rdi
    xorq %rax, %rax
    movq %r14, %rsi      # length of first pstring 
    movq %r11, %rdx     # string itself
    call printf
    movq %r15, %rdi
    call pstrlen
    movq %rax, %r14      # set length of second pstring in r14
    movq %r15, %rdi     
    call swapCase       # swap for second string
    movq $choise_33, %rdi
    xorq %rax, %rax
    movq %r14, %rsi      # length of second pstring
    movq %r15, %rdx     # string itself
    call printf
    jmp exit

opt_34:
    sub $16, %rsp
    movq $choise_34, %rdi
    leaq -16(%rbp), %rsi    # move first number to rsi
    leaq -12(%rbp), %rdx    # move second number to rdx
    xorq %rax, %rax
    call scanf
    xorq %rax, %rax
    movq $choise_34, %rdi
    movq -16(%rbp), %rsi    # move first number to rsi
    movq -12(%rbp), %rdx    # move second number to rdx
    call printf
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
