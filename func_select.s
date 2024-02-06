/* Gideon Neeman 329924567 */
.extern printf
.extern scanf
.extern pstrlen
.extern pstrijcpy
.extern swapCase
.section .rodata
choise_31:
    .string "first pstring length: %d, second pstring length : %d\n"
choise_33:
    .string "length: %d, string: %s\n"
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
    cmp $34, %rdi       # check if user wants option 34
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
    movq %rsi, %r13
    call pstrlen        # get length of first pstring
    movq %rax, %r14      # set it in r14

    movq %rdx, %r15     # move second pstring to r15
    movq %r13, %rdi
    call swapCase       # swap for first string
    movq $choise_33, %rdi
    xorq %rax, %rax
    movq %r14, %rsi      # length of first pstring 
    movq %r13, %rdx     # string itself
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
    movq %rsi, %r15     # backup the pstrings
    movq %rdx, %r12
    movq %rsi, %rdi     # move first pstring to rdi
    call pstrlen        # get length of first pstring
    movq %rax, %r13
    movq %rdx, %rdi     # move second pstring to rdi
    call pstrlen        # get length of second pstring
    movq %rax, %r14
    sub $16, %rsp
    movq $choise_34, %rdi
    leaq -16(%rbp), %rsi    # move first number to rsi
    leaq -12(%rbp), %rdx    # move second number to rdx
    xorq %rax, %rax
    call scanf
    # check cases
    movq %r15, %rdi
    movq %r12, %rsi
    movzbq -16(%rbp), %rdx
    movzbq -12(%rbp), %rcx
    cmpq %rdx, %rcx    # check if j>=i
    jl invalid_opt34
    cmpq %rcx, %r13   # check if j is in range
    jl invalid_opt34
    cmpq %rcx, %r14  # check if j is in range
    jl invalid_opt34
    call pstrijcpy
    #print
    movq $choise_33, %rdi   # print the 2 strings with the changes
    movq %r13, %rsi
    movq %r15, %rdx
    xorq %rax, %rax
    call printf
    movq $choise_33, %rdi
    movq %r14, %rsi
    movq %r12, %rdx
    xorq %rax, %rax
    call printf
    jmp exit

invalid_opt34:
    xorq %rax, %rax    # print invalid option and the 2 strings without changes
    movq $invalid_opt, %rdi
    call printf
    xorq %rax, %rax
    movq $choise_33, %rdi
    movq %r13, %rsi
    movq %r15, %rdx
    call printf
    xorq %rax, %rax
    movq $choise_33, %rdi
    movq %r14, %rsi
    movq %r12, %rdx
    call printf
    jmp exit
    
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
