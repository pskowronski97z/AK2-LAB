.align 32


.data

	mnozna_h: .8byte 0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF
	mnoznik_h: .8byte 0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF		
	il1: .8byte 0x0,0x0
	il2: .8byte 0x0,0x0
	il3: .8byte 0x0,0x0
	il4: .8byte 0x0,0x0
	wynik: .8byte 	0x0,0x0,0x0,0x0
	
.text

CZYSC:					# zerowanie rejestrów

	xor %rax, %rax
	xor %rbx, %rbx
	xor %rcx, %rcx
	xor %rdx, %rdx
	ret


.global main
main:
					
	call CZYSC
					# pierwszy iloczyn częściowy
	movq $mnoznik_h+8, %rbx
	movq (%rbx),%rax	
	movq $mnozna_h+8, %rbx
	mulq (%rbx)
					# transfer iloczynu do pamięci
	movq %rdx, il1			
	movq $il1+8, %rbx
	movq %rax, (%rbx) 		

IL1:


					# drugi iloczyn częściowy	
	movq $mnoznik_h+8, %rbx
	movq (%rbx), %rax
	movq mnozna_h, %rbx
	mulq %rbx
					# transfer iloczynu do pamięci
	movq %rdx, il2			
	movq $il2+8, %rbx
	movq %rax, (%rbx)


IL2:

					# trzeci iloczyn częściowy
	movq $mnozna_h+8, %rbx
	movq (%rbx), %rax
	movq mnoznik_h, %rbx	
	mulq %rbx
					# transfer iloczynu do pamięci
	movq %rdx, il3
	movq $il3+8, %rbx
	movq %rax, (%rbx)

IL3:


					# czwarty iloczyn częściowy
	movq mnoznik_h, %rbx
	movq mnozna_h, %rax
	mulq %rbx

					# transfer iloczynu do pamięci
	movq %rdx, il4
	movq $il4+8, %rbx
	movq %rax, (%rbx)

IL4:


					# sumowanie iloczynów częściowych
	movq $il1+8, %rbx		# oraz transfer wyniku mnożenia do pamięci
	movq (%rbx), %rcx
	movq $wynik+24, %rax
	movq %rcx, (%rax)

					
	
	movq il1, %rax
	movq $il2+8, %rbx
	addq (%rbx), %rax
	
	movq $wynik+16, %rbx		
	movq %rax, (%rbx)


	movq il2, %rax
	adcq il3, %rax
	
	movq $wynik+8, %rbx
	movq %rax, (%rbx)

	adcq $0, wynik			# zachowanie przeniesienia
	
	clc				# czyszczenie flagi cf
		
	movq $wynik+16, %rbx
	movq $il3+8, %rcx
	movq (%rcx), %rax
	
	addq %rax, (%rbx)

	movq $wynik+8, %rbx
	movq $il4+8, %rcx
	movq (%rcx), %rax
	
	adcq %rax, (%rbx)

	adcq $0, wynik
	 
	movq il4, %rax
	adcq %rax, wynik	
	
	call CZYSC			# podgląd wyniku w rejestrach

	movq $wynik+8, %rcx
	movq (%rcx), %rbx

	movq $wynik+16, %rax
	movq (%rax), %rcx
	
	movq $wynik+24, %rax
	movq (%rax), %rdx

	movq wynik, %rax
		
KONIEC:
	int $0x80
