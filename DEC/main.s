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

.global main
main: 
	movq $SYSREAD, %rax	# wczytanie liczby jako 
	movq $STDIN, %rbx	# łańcucha znaków ze
	movq $liczba, %rcx	# standardowego wejścia
	movq $16, %rdx

	int $0x80

	xor %rax, %rax		# zerowanie rejestrów
	xor %rbx, %rbx	
	xor %rcx, %rcx	
	movq $liczba, %rbx	# ustawienie wskazania
				# rbx na pierwszy znak 
PTR:
	movb (%rbx), %cl	# spawdzenie czy koniec 
	cmp $0,%cl		# łańcucha
	je END			# jeśli tak to przerwij

	movq $0xA, %rcx		# mnożenie wyniku przez 10
	mulq %rcx

	movb (%rbx), %cl	# uzyskanie wartości znaku
	subb $48, %cl
	movb %cl, bufor	

	addq bufor, %rax	# dodanie wartości odczytanego 
				# znaku do wyniku
	incq %rbx		# zwiększenie wskazania
	
	jmp PTR			# powtarzaj dopóki kod znaku 
				# jest różny od 0
			
END:

	movq %rax,wynik		# umieszczenie wyniku w pamięci

	movq $SYSEXIT, %rax 
	movq $EXIT_SUCCESS, %rbx
	
		
