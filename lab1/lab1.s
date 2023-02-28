.section .text

.globl measure_latency
.globl measure_throughput

measure_latency:
    movl %edi, %ecx
    imull $8, %edi
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    cvtsi2sdl %edi, %xmm1

    lfence
    movq $0, %rax
    rdtsc
    shlq $32, %rdx
    orq %rdx, %rax
    movq %rax, %rdi

    lfence
.loop:
    imul %r8, %r8
    imul %r8, %r8
    imul %r8, %r8
    imul %r8, %r8
    imul %r8, %r8
    imul %r8, %r8
    imul %r8, %r8
    imul %r8, %r8

    subl $1, %ecx
    jnz .loop

    lfence
    movq $0, %rax

    rdtsc
    shlq $32, %rdx
    orq %rdx, %rax
	
    subq %rdi, %rax
    cvtsi2sdq %rax, %xmm0

    divsd %xmm1, %xmm0
    ret


measure_throughput:
    movl %edi, %ecx
    imull $8, %edi
    pxor %xmm0, %xmm0
    pxor %xmm1, %xmm1
    cvtsi2sdl %edi, %xmm1

    lfence

    rdtsc
    shlq $32, %rdx
    orq %rdx, %rax

    movq %rax, %rdi
	lfence

.loop1:
    imul %r8, %r8
    imul %r9, %r9
    imul %r10, %r10
    imul %r11, %r11
    imul %r12, %r12
    imul %r13, %r13
	imul %r14, %r14
	imul %r15, %r15

    subl $1, %ecx
    jnz .loop1

    lfence
	
    rdtsc
    shlq $32, %rdx
    orq %rdx, %rax
	
    subq %rdi, %rax
    cvtsi2sdq %rax, %xmm0

    divsd %xmm1, %xmm0
    ret
