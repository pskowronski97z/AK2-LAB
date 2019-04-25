SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
.align 32

.data


bufor: .byte 0x0
wynik: .8byte 0x0
liczba: .string ""

.text

A_DIG:
	xor %cl, %cl		# umieszczenie w cl wartości cyfry A
	movb $10, %cl
	jmp CONT

B_DIG:
	xor %cl, %cl		# umieszczenie w cl wartości cyfry B
	movb $11, %cl	
	jmp CONT

C_DIG:
	xor %cl, %cl		# umieszczenie w cl wartości cyfry C
	movb $12, %cl
	jmp CONT

D_DIG:
	xor %cl, %cl		# umieszczenie w cl wartości cyfry D
	movb $13, %cl
	jmp CONT

E_DIG:				# umieszczenie w cl wartości cyfry E
	xor %cl, %cl
	movb $14, %cl
	jmp CONT

F_DIG:				# umieszczenie w cl wartości cyfry F
	xor %cl, %cl
	movb $15, %cl
	jmp CONT



.global main
main: 
	movl $SYSREAD, %eax	# wczytywanie liczby jako ciągu
	movl $STDIN, %ebx	# znaków ze standardowego wejścia
	movl $liczba, %ecx
	movl $16, %edx

	int $0x80

	xor %rax, %rax		# zerowanie rejestrów
	xor %rbx, %rbx		# zerowanie rejestrów
	xor %rcx, %rcx		# zerowanie rejestrów
	xor %rdx, %rdx
	movq $liczba, %rbx	# ustawienie wskazania rbx 
				# na pierwszy znak

PTR:
	movb (%rbx), %cl	# spawdzenie czy koniec łańcucha
	cmp $0,%cl		# jeśli tak to koniec
	je END

	cmp $65, %cl		# sprawdzenie czy znak jest cyfrą
	je A_DIG
	
	cmp $66, %cl
	je B_DIG
		
	cmp $67, %cl
	je C_DIG

	cmp $68, %cl
	je D_DIG

	cmp $69, %cl
	je E_DIG

	cmp $70, %cl
	je F_DIG

			
	subb $48, %cl		# uzyskanie wartości znaku
CONT:
	movb %cl, bufor	
	
	xor %rcx, %rcx	
	
	movq $16, %rcx		# mnożenie wyniku przez 16
	mulq %rcx

	addq bufor, %rax	# dodanie wartości odczytanego znaku do wyniku
	
	incq %rbx		# zwiększenie wskazania
	jmp PTR			# powtarzaj dopóki kod znaku jest różny od 0
			
END:

	movq %rax, wynik	# umieszczenie wyniku w pamięci

	movq $SYSEXIT, %rax
	movq $EXIT_SUCCESS, %rbx

	
