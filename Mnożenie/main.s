.align 32

.data

	arg1: .byte 0x1A,0x2E
	arg2: .byte 0xC5,0x3D
	iloczyn1: .2byte 0x0000
	iloczyn2: .4byte 0x00000000

.text

CLEAR_REG:
	
	xor %rcx,%rcx
	xor %rbx,%rbx
	xor %rax,%rax
	ret


.global main
main:

	call CLEAR_REG			# Zerowanie rejestrów	

	movq $arg2+1,%rcx		# ustawnienie rcx na wskazanie 
					# młodszą część mnożnika
	movq $arg1+1,%rbx		# 

	movb (%rcx),%al
	mulb (%rbx)

	movw %ax,iloczyn1
	
	call CLEAR_REG
	
	movq $arg2+1,%rcx
	movb (%rcx),%al
	movb arg1,%bl

	mulb %bl

	movw %ax,iloczyn2

	shll $8,iloczyn2
	
	

	call CLEAR_REG

	movw iloczyn1,%ax

	addl iloczyn2,%eax

	movl $0x0,iloczyn2
	movl %eax,iloczyn2;
	
	int $0x80
	



	







	
