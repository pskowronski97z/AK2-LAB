.align 32

.data

arg1: .8byte 0x10d00f0000000000 ,0xf0000a0000000000 
arg2: .8byte 0x10000daaa0005000 ,0xe0ccc00000009000 	
wynik:.8byte 0x0000000000000000 ,0x0000000000000000

.text

.global main
main:
	
DODAWANIE:
				# Obliczenie młodszej części wyniku
	
	movq $arg1+8,%rax	# umieszczenie adresu młodszej części 
				# argumentu 1 w rejestrze rax		

	movq $arg2+8,%rbx	# umieszczenie adresu młodszej części 
				# argumentu 2 w rejestrze rbx
	
	movq (%rax),%rcx	# umieszczenie wartości wskazywanej 
				# przez rax w rcx 

	addq (%rbx),%rcx	# dodawanie do rejestru rcx wartości 
				# wskazywanej przez rbx 
	
	movq $wynik+8,%rax	# umieszczenie młodszej części wyniku 
	movq %rcx,(%rax)	# dodawania w pamięci
		
	movq arg1,%rax		# Obliczenie starszej części wyniku
	adc arg2,%rax		# dodawanie z uwzględnieniem przeniesienia
	
	movq %rax,wynik		# umieszczenie starszej części wyniku w pamięci

SPR_DOD:
	
	movq $wynik+8,%rcx	# Sprawdzenie poprawności działania 
	movq (%rcx),%rbx	# umieszczenie młodszej części w rbx
				# starsza część w rax

ODEJMOWANIE:

	
	







