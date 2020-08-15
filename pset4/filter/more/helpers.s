	.file	"helpers.c"
	.text
	.globl	is_border
	.type	is_border, @function
is_border:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	%ecx, -16(%rbp)
	cmpl	$0, -4(%rbp)
	jne	.L2
	movl	$1, %eax
	jmp	.L3
.L2:
	movl	-12(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -4(%rbp)
	jne	.L4
	movl	$1, %eax
	jmp	.L3
.L4:
	cmpl	$0, -8(%rbp)
	jne	.L5
	movl	$1, %eax
	jmp	.L3
.L5:
	movl	-16(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -8(%rbp)
	jne	.L6
	movl	$1, %eax
	jmp	.L3
.L6:
	movl	$0, %eax
.L3:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	is_border, .-is_border
	.globl	is_corner
	.type	is_corner, @function
is_corner:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	%ecx, -16(%rbp)
	cmpl	$0, -4(%rbp)
	jne	.L8
	cmpl	$0, -8(%rbp)
	jne	.L9
	movl	$1, %eax
	jmp	.L10
.L9:
	movl	-16(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -8(%rbp)
	jne	.L11
	movl	$2, %eax
	jmp	.L10
.L11:
	movl	$0, %eax
	jmp	.L10
.L8:
	movl	-12(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -4(%rbp)
	jne	.L12
	cmpl	$0, -8(%rbp)
	jne	.L13
	movl	$3, %eax
	jmp	.L10
.L13:
	movl	-16(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -8(%rbp)
	jne	.L14
	movl	$4, %eax
	jmp	.L10
.L14:
	movl	$0, %eax
	jmp	.L10
.L12:
	movl	$0, %eax
.L10:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	is_corner, .-is_corner
	.globl	grayscale
	.type	grayscale, @function
grayscale:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movl	%edi, -52(%rbp)
	movl	%esi, -56(%rbp)
	movq	%rdx, -64(%rbp)
	movl	-56(%rbp), %ebx
	movslq	%ebx, %rax
	subq	$1, %rax
	movq	%rax, -24(%rbp)
	movslq	%ebx, %rax
	movq	%rax, %r8
	movl	$0, %r9d
	imulq	$24, %r9, %rdx
	imulq	$0, %r8, %rax
	leaq	(%rdx,%rax), %rcx
	movl	$24, %eax
	mulq	%r8
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movl	$0, -28(%rbp)
	jmp	.L16
.L20:
	movl	$0, -32(%rbp)
	jmp	.L17
.L19:
	movl	$0, -36(%rbp)
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-64(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %ecx
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-64(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addl	%eax, %ecx
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-64(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addl	%ecx, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movq	%xmm2, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %eax
	movl	%eax, -36(%rbp)
	cmpl	$255, -36(%rbp)
	jle	.L18
	movl	$255, -36(%rbp)
.L18:
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-64(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-36(%rbp), %eax
	movl	%eax, %ecx
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	movb	%cl, (%rax)
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-64(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-36(%rbp), %eax
	movl	%eax, %ecx
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$1, %rax
	movb	%cl, (%rax)
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-64(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-36(%rbp), %eax
	movl	%eax, %ecx
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$2, %rax
	movb	%cl, (%rax)
	addl	$1, -32(%rbp)
.L17:
	movl	-32(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jl	.L19
	addl	$1, -28(%rbp)
.L16:
	movl	-28(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jl	.L20
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	grayscale, .-grayscale
	.globl	sepia
	.type	sepia, @function
sepia:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 3, -24
	movl	%edi, -68(%rbp)
	movl	%esi, -72(%rbp)
	movq	%rdx, -80(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	-72(%rbp), %ebx
	movslq	%ebx, %rax
	subq	$1, %rax
	movq	%rax, -48(%rbp)
	movslq	%ebx, %rax
	movq	%rax, %r8
	movl	$0, %r9d
	imulq	$24, %r9, %rdx
	imulq	$0, %r8, %rax
	leaq	(%rdx,%rax), %rcx
	movl	$24, %eax
	mulq	%r8
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movl	$0, -52(%rbp)
	jmp	.L23
.L29:
	movl	$0, -56(%rbp)
	jmp	.L24
.L28:
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	movsd	.LC1(%rip), %xmm0
	mulsd	%xmm0, %xmm1
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movsd	.LC2(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movsd	.LC3(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movq	%xmm1, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %eax
	movl	%eax, -36(%rbp)
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	movsd	.LC4(%rip), %xmm0
	mulsd	%xmm0, %xmm1
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movsd	.LC5(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movsd	.LC6(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movq	%xmm1, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %eax
	movl	%eax, -32(%rbp)
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	movsd	.LC7(%rip), %xmm0
	mulsd	%xmm0, %xmm1
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movsd	.LC8(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movsd	.LC9(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movq	%xmm1, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %eax
	movl	%eax, -28(%rbp)
	movl	$0, -60(%rbp)
	jmp	.L25
.L27:
	movl	-60(%rbp), %eax
	cltq
	movl	-36(%rbp,%rax,4), %eax
	cmpl	$255, %eax
	jle	.L26
	movl	-60(%rbp), %eax
	cltq
	movl	$255, -36(%rbp,%rax,4)
.L26:
	addl	$1, -60(%rbp)
.L25:
	cmpl	$2, -60(%rbp)
	jle	.L27
	movl	-36(%rbp), %ecx
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	movb	%cl, (%rax)
	movl	-32(%rbp), %ecx
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$1, %rax
	movb	%cl, (%rax)
	movl	-28(%rbp), %ecx
	movl	-52(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-80(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$2, %rax
	movb	%cl, (%rax)
	addl	$1, -56(%rbp)
.L24:
	movl	-56(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jl	.L28
	addl	$1, -52(%rbp)
.L23:
	movl	-52(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.L29
	nop
	movq	-24(%rbp), %rax
	subq	%fs:40, %rax
	je	.L31
	call	__stack_chk_fail@PLT
.L31:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	sepia, .-sepia
	.globl	reflect
	.type	reflect, @function
reflect:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)
	movl	%esi, -40(%rbp)
	movq	%rdx, -48(%rbp)
	movl	-40(%rbp), %ecx
	movslq	%ecx, %rax
	subq	$1, %rax
	movq	%rax, -8(%rbp)
	movslq	%ecx, %rax
	movq	%rax, %r8
	movl	$0, %r9d
	imulq	$24, %r9, %rdx
	imulq	$0, %r8, %rax
	leaq	(%rdx,%rax), %rsi
	movl	$24, %eax
	mulq	%r8
	addq	%rdx, %rsi
	movq	%rsi, %rdx
	movl	$0, -12(%rbp)
	movl	-40(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	jne	.L33
	movl	-40(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, -12(%rbp)
	jmp	.L34
.L33:
	movl	-40(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, -12(%rbp)
.L34:
	movl	$0, -16(%rbp)
	jmp	.L35
.L38:
	movl	$0, -20(%rbp)
	jmp	.L36
.L37:
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ecx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-48(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	movzwl	(%rax), %edx
	movw	%dx, -23(%rbp)
	movzbl	2(%rax), %eax
	movb	%al, -21(%rbp)
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ecx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-48(%rbp), %rax
	leaq	(%rdx,%rax), %rdi
	movl	-40(%rbp), %eax
	subl	$1, %eax
	subl	-20(%rbp), %eax
	movl	%eax, %esi
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ecx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-48(%rbp), %rax
	leaq	(%rdx,%rax), %r8
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	leaq	(%r8,%rax), %rdx
	movslq	%esi, %rsi
	movq	%rsi, %rax
	addq	%rax, %rax
	addq	%rsi, %rax
	addq	%rdi, %rax
	movzwl	(%rax), %esi
	movw	%si, (%rdx)
	movzbl	2(%rax), %eax
	movb	%al, 2(%rdx)
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movslq	%ecx, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-48(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-40(%rbp), %eax
	subl	$1, %eax
	subl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	movzwl	-23(%rbp), %edx
	movw	%dx, (%rax)
	movzbl	-21(%rbp), %edx
	movb	%dl, 2(%rax)
	addl	$1, -20(%rbp)
.L36:
	movl	-20(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.L37
	addl	$1, -16(%rbp)
.L35:
	movl	-16(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L38
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	reflect, .-reflect
	.globl	blur
	.type	blur, @function
blur:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$168, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, -148(%rbp)
	movl	%esi, -152(%rbp)
	movq	%rdx, -160(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	movl	-152(%rbp), %r12d
	movslq	%r12d, %rax
	subq	$1, %rax
	movq	%rax, -104(%rbp)
	movslq	%r12d, %rax
	movq	%rax, %rcx
	movl	$0, %ebx
	imulq	$24, %rbx, %rdx
	imulq	$0, %rcx, %rax
	leaq	(%rdx,%rax), %rsi
	movl	$24, %eax
	mulq	%rcx
	leaq	(%rsi,%rdx), %rcx
	movq	%rcx, %rdx
	movq	%rsp, %rax
	movq	%rax, -200(%rbp)
	movl	-152(%rbp), %eax
	leal	2(%rax), %edi
	movl	-148(%rbp), %eax
	leal	2(%rax), %r13d
	movslq	%edi, %rax
	subq	$1, %rax
	movq	%rax, -96(%rbp)
	movslq	%edi, %rax
	movq	%rax, %r8
	movl	$0, %r9d
	imulq	$24, %r9, %rdx
	imulq	$0, %r8, %rax
	leaq	(%rdx,%rax), %rcx
	movl	$24, %eax
	mulq	%r8
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movslq	%edi, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	leaq	(%rax,%rdx), %rbx
	movslq	%r13d, %rax
	subq	$1, %rax
	movq	%rax, -88(%rbp)
	movslq	%edi, %rax
	movq	%rax, -192(%rbp)
	movq	$0, -184(%rbp)
	movslq	%r13d, %rax
	movq	%rax, -176(%rbp)
	movq	$0, -168(%rbp)
	movq	-192(%rbp), %r8
	movq	-184(%rbp), %r9
	movq	%r9, %rdx
	imulq	-176(%rbp), %rdx
	movq	-168(%rbp), %rax
	imulq	%r8, %rax
	leaq	(%rdx,%rax), %rcx
	movq	%r8, %rax
	mulq	-176(%rbp)
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	imulq	$24, %rdx, %rsi
	imulq	$0, %rax, %rcx
	addq	%rsi, %rcx
	movl	$24, %esi
	mulq	%rsi
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movslq	%edi, %rax
	movq	%rax, %r14
	movl	$0, %r15d
	movslq	%r13d, %rax
	movq	%rax, %r10
	movl	$0, %r11d
	movq	%r15, %rdx
	imulq	%r10, %rdx
	movq	%r11, %rax
	imulq	%r14, %rax
	leaq	(%rdx,%rax), %rcx
	movq	%r14, %rax
	mulq	%r10
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	imulq	$24, %rdx, %rsi
	imulq	$0, %rax, %rcx
	addq	%rsi, %rcx
	movl	$24, %esi
	mulq	%rsi
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movslq	%edi, %rdx
	movslq	%r13d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %edi
	movl	$0, %edx
	divq	%rdi
	imulq	$16, %rax, %rax
	subq	%rax, %rsp
	movq	%rsp, %rax
	addq	$0, %rax
	movq	%rax, -80(%rbp)
	movl	$0, -108(%rbp)
	jmp	.L41
.L49:
	movl	$0, -112(%rbp)
	jmp	.L42
.L48:
	cmpl	$0, -108(%rbp)
	je	.L43
	movl	-148(%rbp), %eax
	addl	$1, %eax
	cmpl	%eax, -108(%rbp)
	jne	.L44
.L43:
	movq	-80(%rbp), %rsi
	movl	-112(%rbp), %eax
	movslq	%eax, %rdx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movb	$0, (%rax)
	movq	-80(%rbp), %rsi
	movl	-112(%rbp), %eax
	movslq	%eax, %rdx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movb	$0, (%rax)
	movq	-80(%rbp), %rsi
	movl	-112(%rbp), %eax
	movslq	%eax, %rdx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movb	$0, (%rax)
	jmp	.L45
.L44:
	cmpl	$0, -112(%rbp)
	je	.L46
	movl	-152(%rbp), %eax
	addl	$1, %eax
	cmpl	%eax, -112(%rbp)
	jne	.L47
.L46:
	movq	-80(%rbp), %rsi
	movl	-112(%rbp), %eax
	movslq	%eax, %rdx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movb	$0, (%rax)
	movq	-80(%rbp), %rsi
	movl	-112(%rbp), %eax
	movslq	%eax, %rdx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movb	$0, (%rax)
	movq	-80(%rbp), %rsi
	movl	-112(%rbp), %eax
	movslq	%eax, %rdx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movb	$0, (%rax)
	jmp	.L45
.L47:
	movl	-108(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-160(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-112(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	movzbl	(%rax), %edx
	movq	-80(%rbp), %rdi
	movl	-112(%rbp), %eax
	movslq	%eax, %rcx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	movb	%dl, (%rax)
	movl	-108(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-160(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-112(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movzbl	(%rax), %edx
	movq	-80(%rbp), %rdi
	movl	-112(%rbp), %eax
	movslq	%eax, %rcx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	addq	$1, %rax
	movb	%dl, (%rax)
	movl	-108(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-160(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-112(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movzbl	(%rax), %edx
	movq	-80(%rbp), %rdi
	movl	-112(%rbp), %eax
	movslq	%eax, %rcx
	movl	-108(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	addq	$2, %rax
	movb	%dl, (%rax)
.L45:
	addl	$1, -112(%rbp)
.L42:
	movl	-152(%rbp), %eax
	addl	$1, %eax
	cmpl	%eax, -112(%rbp)
	jle	.L48
	addl	$1, -108(%rbp)
.L41:
	movl	-148(%rbp), %eax
	addl	$1, %eax
	cmpl	%eax, -108(%rbp)
	jle	.L49
	movl	$1, -116(%rbp)
	jmp	.L50
.L69:
	movl	$1, -120(%rbp)
	jmp	.L51
.L68:
	movl	$0, -60(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-64(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	$-1, -124(%rbp)
	jmp	.L52
.L55:
	movl	$-1, -128(%rbp)
	jmp	.L53
.L54:
	movl	-68(%rbp), %ecx
	movl	-116(%rbp), %edx
	movl	-124(%rbp), %eax
	addl	%edx, %eax
	movl	-120(%rbp), %esi
	movl	-128(%rbp), %edx
	addl	%esi, %edx
	movq	-80(%rbp), %rdi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addl	%ecx, %eax
	movl	%eax, -68(%rbp)
	movl	-64(%rbp), %ecx
	movl	-116(%rbp), %edx
	movl	-124(%rbp), %eax
	addl	%edx, %eax
	movl	-120(%rbp), %esi
	movl	-128(%rbp), %edx
	addl	%esi, %edx
	movq	-80(%rbp), %rdi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addl	%ecx, %eax
	movl	%eax, -64(%rbp)
	movl	-60(%rbp), %ecx
	movl	-116(%rbp), %edx
	movl	-124(%rbp), %eax
	addl	%edx, %eax
	movl	-120(%rbp), %esi
	movl	-128(%rbp), %edx
	addl	%esi, %edx
	movq	-80(%rbp), %rdi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addl	%ecx, %eax
	movl	%eax, -60(%rbp)
	addl	$1, -128(%rbp)
.L53:
	cmpl	$1, -128(%rbp)
	jle	.L54
	addl	$1, -124(%rbp)
.L52:
	cmpl	$1, -124(%rbp)
	jle	.L55
	movl	-120(%rbp), %eax
	leal	-1(%rax), %esi
	movl	-116(%rbp), %eax
	leal	-1(%rax), %edi
	movl	-152(%rbp), %edx
	movl	-148(%rbp), %eax
	movl	%edx, %ecx
	movl	%eax, %edx
	call	is_border
	cmpl	$1, %eax
	jne	.L56
	movl	-120(%rbp), %eax
	leal	-1(%rax), %esi
	movl	-116(%rbp), %eax
	leal	-1(%rax), %edi
	movl	-152(%rbp), %edx
	movl	-148(%rbp), %eax
	movl	%edx, %ecx
	movl	%eax, %edx
	call	is_corner
	testl	%eax, %eax
	je	.L57
	movl	$0, -132(%rbp)
	jmp	.L58
.L60:
	movl	-132(%rbp), %eax
	cltq
	movl	-68(%rbp,%rax,4), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	.LC10(%rip), %xmm1
	divss	%xmm1, %xmm0
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movq	%xmm2, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %edx
	movl	-132(%rbp), %eax
	cltq
	movl	%edx, -68(%rbp,%rax,4)
	movl	-132(%rbp), %eax
	cltq
	movl	-68(%rbp,%rax,4), %eax
	cmpl	$255, %eax
	jle	.L59
	movl	-132(%rbp), %eax
	cltq
	movl	$255, -68(%rbp,%rax,4)
.L59:
	addl	$1, -132(%rbp)
.L58:
	cmpl	$2, -132(%rbp)
	jle	.L60
	jmp	.L61
.L57:
	movl	$0, -136(%rbp)
	jmp	.L62
.L64:
	movl	-136(%rbp), %eax
	cltq
	movl	-68(%rbp,%rax,4), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	.LC11(%rip), %xmm1
	divss	%xmm1, %xmm0
	pxor	%xmm3, %xmm3
	cvtss2sd	%xmm0, %xmm3
	movq	%xmm3, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %edx
	movl	-136(%rbp), %eax
	cltq
	movl	%edx, -68(%rbp,%rax,4)
	movl	-136(%rbp), %eax
	cltq
	movl	-68(%rbp,%rax,4), %eax
	cmpl	$255, %eax
	jle	.L63
	movl	-136(%rbp), %eax
	cltq
	movl	$255, -68(%rbp,%rax,4)
.L63:
	addl	$1, -136(%rbp)
.L62:
	cmpl	$2, -136(%rbp)
	jle	.L64
	jmp	.L61
.L56:
	movl	$0, -140(%rbp)
	jmp	.L65
.L67:
	movl	-140(%rbp), %eax
	cltq
	movl	-68(%rbp,%rax,4), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	.LC12(%rip), %xmm1
	divss	%xmm1, %xmm0
	pxor	%xmm4, %xmm4
	cvtss2sd	%xmm0, %xmm4
	movq	%xmm4, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %edx
	movl	-140(%rbp), %eax
	cltq
	movl	%edx, -68(%rbp,%rax,4)
	movl	-140(%rbp), %eax
	cltq
	movl	-68(%rbp,%rax,4), %eax
	cmpl	$255, %eax
	jle	.L66
	movl	-140(%rbp), %eax
	cltq
	movl	$255, -68(%rbp,%rax,4)
.L66:
	addl	$1, -140(%rbp)
.L65:
	cmpl	$2, -140(%rbp)
	jle	.L67
.L61:
	movl	-68(%rbp), %ecx
	movl	-116(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-160(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-120(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	movb	%cl, (%rax)
	movl	-64(%rbp), %ecx
	movl	-116(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-160(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-120(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$1, %rax
	movb	%cl, (%rax)
	movl	-60(%rbp), %ecx
	movl	-116(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-160(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-120(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$2, %rax
	movb	%cl, (%rax)
	addl	$1, -120(%rbp)
.L51:
	movl	-152(%rbp), %eax
	cmpl	-120(%rbp), %eax
	jge	.L68
	addl	$1, -116(%rbp)
.L50:
	movl	-148(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jge	.L69
	nop
	movq	-200(%rbp), %rsp
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	je	.L71
	call	__stack_chk_fail@PLT
.L71:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	blur, .-blur
	.globl	edges
	.type	edges, @function
edges:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$280, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, -260(%rbp)
	movl	%esi, -264(%rbp)
	movq	%rdx, -272(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	movl	-264(%rbp), %r12d
	movslq	%r12d, %rax
	subq	$1, %rax
	movq	%rax, -192(%rbp)
	movslq	%r12d, %rax
	movq	%rax, %rcx
	movl	$0, %ebx
	imulq	$24, %rbx, %rdx
	imulq	$0, %rcx, %rax
	leaq	(%rdx,%rax), %rsi
	movl	$24, %eax
	mulq	%rcx
	leaq	(%rsi,%rdx), %rcx
	movq	%rcx, %rdx
	movq	%rsp, %rax
	movq	%rax, -312(%rbp)
	movl	-264(%rbp), %eax
	leal	2(%rax), %edi
	movl	-260(%rbp), %eax
	leal	2(%rax), %r13d
	movslq	%edi, %rax
	subq	$1, %rax
	movq	%rax, -184(%rbp)
	movslq	%edi, %rax
	movq	%rax, %r8
	movl	$0, %r9d
	imulq	$24, %r9, %rdx
	imulq	$0, %r8, %rax
	leaq	(%rdx,%rax), %rcx
	movl	$24, %eax
	mulq	%r8
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movslq	%edi, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	leaq	(%rax,%rdx), %rbx
	movslq	%r13d, %rax
	subq	$1, %rax
	movq	%rax, -176(%rbp)
	movslq	%edi, %rax
	movq	%rax, -304(%rbp)
	movq	$0, -296(%rbp)
	movslq	%r13d, %rax
	movq	%rax, -288(%rbp)
	movq	$0, -280(%rbp)
	movq	-304(%rbp), %r8
	movq	-296(%rbp), %r9
	movq	%r9, %rdx
	imulq	-288(%rbp), %rdx
	movq	-280(%rbp), %rax
	imulq	%r8, %rax
	leaq	(%rdx,%rax), %rcx
	movq	%r8, %rax
	mulq	-288(%rbp)
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	imulq	$24, %rdx, %rsi
	imulq	$0, %rax, %rcx
	addq	%rsi, %rcx
	movl	$24, %esi
	mulq	%rsi
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movslq	%edi, %rax
	movq	%rax, %r14
	movl	$0, %r15d
	movslq	%r13d, %rax
	movq	%rax, %r10
	movl	$0, %r11d
	movq	%r15, %rdx
	imulq	%r10, %rdx
	movq	%r11, %rax
	imulq	%r14, %rax
	leaq	(%rdx,%rax), %rcx
	movq	%r14, %rax
	mulq	%r10
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	imulq	$24, %rdx, %rsi
	imulq	$0, %rax, %rcx
	addq	%rsi, %rcx
	movl	$24, %esi
	mulq	%rsi
	addq	%rdx, %rcx
	movq	%rcx, %rdx
	movslq	%edi, %rdx
	movslq	%r13d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %edi
	movl	$0, %edx
	divq	%rdi
	imulq	$16, %rax, %rax
	subq	%rax, %rsp
	movq	%rsp, %rax
	addq	$0, %rax
	movq	%rax, -168(%rbp)
	movl	$0, -220(%rbp)
	jmp	.L73
.L81:
	movl	$0, -224(%rbp)
	jmp	.L74
.L80:
	cmpl	$0, -220(%rbp)
	je	.L75
	movl	-260(%rbp), %eax
	addl	$1, %eax
	cmpl	%eax, -220(%rbp)
	jne	.L76
.L75:
	movq	-168(%rbp), %rsi
	movl	-224(%rbp), %eax
	movslq	%eax, %rdx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movb	$0, (%rax)
	movq	-168(%rbp), %rsi
	movl	-224(%rbp), %eax
	movslq	%eax, %rdx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movb	$0, (%rax)
	movq	-168(%rbp), %rsi
	movl	-224(%rbp), %eax
	movslq	%eax, %rdx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movb	$0, (%rax)
	jmp	.L77
.L76:
	cmpl	$0, -224(%rbp)
	je	.L78
	movl	-264(%rbp), %eax
	addl	$1, %eax
	cmpl	%eax, -224(%rbp)
	jne	.L79
.L78:
	movq	-168(%rbp), %rsi
	movl	-224(%rbp), %eax
	movslq	%eax, %rdx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movb	$0, (%rax)
	movq	-168(%rbp), %rsi
	movl	-224(%rbp), %eax
	movslq	%eax, %rdx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movb	$0, (%rax)
	movq	-168(%rbp), %rsi
	movl	-224(%rbp), %eax
	movslq	%eax, %rdx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movb	$0, (%rax)
	jmp	.L77
.L79:
	movl	-220(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-272(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-224(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	movzbl	(%rax), %edx
	movq	-168(%rbp), %rdi
	movl	-224(%rbp), %eax
	movslq	%eax, %rcx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	movb	%dl, (%rax)
	movl	-220(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-272(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-224(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movzbl	(%rax), %edx
	movq	-168(%rbp), %rdi
	movl	-224(%rbp), %eax
	movslq	%eax, %rcx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	addq	$1, %rax
	movb	%dl, (%rax)
	movl	-220(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-272(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-224(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movzbl	(%rax), %edx
	movq	-168(%rbp), %rdi
	movl	-224(%rbp), %eax
	movslq	%eax, %rcx
	movl	-220(%rbp), %eax
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rsi
	movq	%rcx, %rax
	addq	%rax, %rax
	addq	%rcx, %rax
	addq	%rdi, %rax
	addq	%rsi, %rax
	addq	$2, %rax
	movb	%dl, (%rax)
.L77:
	addl	$1, -224(%rbp)
.L74:
	movl	-264(%rbp), %eax
	addl	$1, %eax
	cmpl	%eax, -224(%rbp)
	jle	.L80
	addl	$1, -220(%rbp)
.L73:
	movl	-260(%rbp), %eax
	addl	$1, %eax
	cmpl	%eax, -220(%rbp)
	jle	.L81
	movl	$1, -228(%rbp)
	jmp	.L82
.L92:
	movl	$1, -232(%rbp)
	jmp	.L83
.L91:
	pxor	%xmm0, %xmm0
	movss	%xmm0, -248(%rbp)
	movss	-248(%rbp), %xmm0
	movss	%xmm0, -212(%rbp)
	movss	-212(%rbp), %xmm0
	movss	%xmm0, -216(%rbp)
	movss	-216(%rbp), %xmm0
	movss	%xmm0, -236(%rbp)
	movss	-236(%rbp), %xmm0
	movss	%xmm0, -244(%rbp)
	movss	-244(%rbp), %xmm0
	movss	%xmm0, -240(%rbp)
	movl	$0, -208(%rbp)
	movss	.LC14(%rip), %xmm0
	movss	%xmm0, -144(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -140(%rbp)
	movss	.LC15(%rip), %xmm0
	movss	%xmm0, -136(%rbp)
	movss	.LC16(%rip), %xmm0
	movss	%xmm0, -132(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -128(%rbp)
	movss	.LC17(%rip), %xmm0
	movss	%xmm0, -124(%rbp)
	movss	.LC14(%rip), %xmm0
	movss	%xmm0, -120(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -116(%rbp)
	movss	.LC15(%rip), %xmm0
	movss	%xmm0, -112(%rbp)
	movss	.LC14(%rip), %xmm0
	movss	%xmm0, -96(%rbp)
	movss	.LC16(%rip), %xmm0
	movss	%xmm0, -92(%rbp)
	movss	.LC14(%rip), %xmm0
	movss	%xmm0, -88(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -84(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -80(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -76(%rbp)
	movss	.LC15(%rip), %xmm0
	movss	%xmm0, -72(%rbp)
	movss	.LC17(%rip), %xmm0
	movss	%xmm0, -68(%rbp)
	movss	.LC15(%rip), %xmm0
	movss	%xmm0, -64(%rbp)
	movl	$1, -204(%rbp)
	jmp	.L84
.L87:
	movl	$1, -200(%rbp)
	jmp	.L85
.L86:
	movl	-228(%rbp), %edx
	movl	-204(%rbp), %eax
	addl	%edx, %eax
	movl	-232(%rbp), %ecx
	movl	-200(%rbp), %edx
	addl	%ecx, %edx
	movq	-168(%rbp), %rsi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movl	-208(%rbp), %eax
	cltq
	movss	-144(%rbp,%rax,4), %xmm0
	mulss	%xmm1, %xmm0
	movss	-240(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -240(%rbp)
	movl	-228(%rbp), %edx
	movl	-204(%rbp), %eax
	addl	%edx, %eax
	movl	-232(%rbp), %ecx
	movl	-200(%rbp), %edx
	addl	%ecx, %edx
	movq	-168(%rbp), %rsi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movl	-208(%rbp), %eax
	cltq
	movss	-144(%rbp,%rax,4), %xmm0
	mulss	%xmm1, %xmm0
	movss	-244(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -244(%rbp)
	movl	-228(%rbp), %edx
	movl	-204(%rbp), %eax
	addl	%edx, %eax
	movl	-232(%rbp), %ecx
	movl	-200(%rbp), %edx
	addl	%ecx, %edx
	movq	-168(%rbp), %rsi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movl	-208(%rbp), %eax
	cltq
	movss	-144(%rbp,%rax,4), %xmm0
	mulss	%xmm1, %xmm0
	movss	-236(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -236(%rbp)
	movl	-228(%rbp), %edx
	movl	-204(%rbp), %eax
	addl	%edx, %eax
	movl	-232(%rbp), %ecx
	movl	-200(%rbp), %edx
	addl	%ecx, %edx
	movq	-168(%rbp), %rsi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movl	-208(%rbp), %eax
	cltq
	movss	-96(%rbp,%rax,4), %xmm0
	mulss	%xmm1, %xmm0
	movss	-216(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -216(%rbp)
	movl	-228(%rbp), %edx
	movl	-204(%rbp), %eax
	addl	%edx, %eax
	movl	-232(%rbp), %ecx
	movl	-200(%rbp), %edx
	addl	%ecx, %edx
	movq	-168(%rbp), %rsi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movl	-208(%rbp), %eax
	cltq
	movss	-96(%rbp,%rax,4), %xmm0
	mulss	%xmm1, %xmm0
	movss	-212(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -212(%rbp)
	movl	-228(%rbp), %edx
	movl	-204(%rbp), %eax
	addl	%edx, %eax
	movl	-232(%rbp), %ecx
	movl	-200(%rbp), %edx
	addl	%ecx, %edx
	movq	-168(%rbp), %rsi
	movslq	%edx, %rdx
	cltq
	imulq	%rbx, %rax
	movq	%rax, %rcx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movl	-208(%rbp), %eax
	cltq
	movss	-96(%rbp,%rax,4), %xmm0
	mulss	%xmm1, %xmm0
	movss	-248(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -248(%rbp)
	addl	$1, -208(%rbp)
	subl	$1, -200(%rbp)
.L85:
	cmpl	$-1, -200(%rbp)
	jge	.L86
	subl	$1, -204(%rbp)
.L84:
	cmpl	$-1, -204(%rbp)
	jge	.L87
	pxor	%xmm5, %xmm5
	cvtss2sd	-240(%rbp), %xmm5
	movq	%xmm5, %rax
	movsd	.LC18(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movsd	%xmm0, -288(%rbp)
	pxor	%xmm6, %xmm6
	cvtss2sd	-216(%rbp), %xmm6
	movq	%xmm6, %rax
	movsd	.LC18(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movapd	%xmm0, %xmm2
	addsd	-288(%rbp), %xmm2
	movq	%xmm2, %rax
	movsd	.LC19(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %eax
	movl	%eax, -156(%rbp)
	pxor	%xmm5, %xmm5
	cvtss2sd	-244(%rbp), %xmm5
	movq	%xmm5, %rax
	movsd	.LC18(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movsd	%xmm0, -288(%rbp)
	pxor	%xmm6, %xmm6
	cvtss2sd	-212(%rbp), %xmm6
	movq	%xmm6, %rax
	movsd	.LC18(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movapd	%xmm0, %xmm3
	addsd	-288(%rbp), %xmm3
	movq	%xmm3, %rax
	movsd	.LC19(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %eax
	movl	%eax, -152(%rbp)
	pxor	%xmm2, %xmm2
	cvtss2sd	-236(%rbp), %xmm2
	movq	%xmm2, %rax
	movsd	.LC18(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movsd	%xmm0, -288(%rbp)
	pxor	%xmm3, %xmm3
	cvtss2sd	-248(%rbp), %xmm3
	movq	%xmm3, %rax
	movsd	.LC18(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movapd	%xmm0, %xmm4
	addsd	-288(%rbp), %xmm4
	movq	%xmm4, %rax
	movsd	.LC19(%rip), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	call	round@PLT
	cvttsd2sil	%xmm0, %eax
	movl	%eax, -148(%rbp)
	movl	$0, -196(%rbp)
	jmp	.L88
.L90:
	movl	-196(%rbp), %eax
	cltq
	movl	-156(%rbp,%rax,4), %eax
	cmpl	$255, %eax
	jle	.L89
	movl	-196(%rbp), %eax
	cltq
	movl	$255, -156(%rbp,%rax,4)
.L89:
	addl	$1, -196(%rbp)
.L88:
	cmpl	$2, -196(%rbp)
	jle	.L90
	movl	-156(%rbp), %ecx
	movl	-228(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-272(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-232(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	movb	%cl, (%rax)
	movl	-152(%rbp), %ecx
	movl	-228(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-272(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-232(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$1, %rax
	movb	%cl, (%rax)
	movl	-148(%rbp), %ecx
	movl	-228(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movslq	%r12d, %rax
	imulq	%rax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rax, %rdx
	movq	-272(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-232(%rbp), %eax
	subl	$1, %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	$2, %rax
	movb	%cl, (%rax)
	addl	$1, -232(%rbp)
.L83:
	movl	-264(%rbp), %eax
	cmpl	-232(%rbp), %eax
	jge	.L91
	addl	$1, -228(%rbp)
.L82:
	movl	-260(%rbp), %eax
	cmpl	-228(%rbp), %eax
	jge	.L92
	nop
	movq	-312(%rbp), %rsp
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	je	.L94
	call	__stack_chk_fail@PLT
.L94:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	edges, .-edges
	.section	.rodata
	.align 4
.LC0:
	.long	1077936128
	.align 8
.LC1:
	.long	-1340029796
	.long	1070688370
	.align 8
.LC2:
	.long	721554506
	.long	1071715975
	.align 8
.LC3:
	.long	-1511828488
	.long	1069597851
	.align 8
.LC4:
	.long	412316860
	.long	1071011332
	.align 8
.LC5:
	.long	1168231105
	.long	1072034742
	.align 8
.LC6:
	.long	618475291
	.long	1069908230
	.align 8
.LC7:
	.long	2027224564
	.long	1071195881
	.align 8
.LC8:
	.long	-481036337
	.long	1072208805
	.align 8
.LC9:
	.long	-377957122
	.long	1070084390
	.align 4
.LC10:
	.long	1082130432
	.align 4
.LC11:
	.long	1086324736
	.align 4
.LC12:
	.long	1091567616
	.align 4
.LC14:
	.long	-1082130432
	.align 4
.LC15:
	.long	1065353216
	.align 4
.LC16:
	.long	-1073741824
	.align 4
.LC17:
	.long	1073741824
	.align 8
.LC18:
	.long	0
	.long	1073741824
	.align 8
.LC19:
	.long	0
	.long	1071644672
	.ident	"GCC: (GNU) 10.1.0"
	.section	.note.GNU-stack,"",@progbits
