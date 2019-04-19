.align 32

.data

arg1: .8byte 0x10d00f0000000000 ,0xf00a0a00a0900000 
arg2: .8byte 0x10000daaa0005000 ,0xe0ccccccccccc000 	
wynik:.8byte 0x0000000000000000 ,0x0000000000000000

.text

.global main
main:
	
ODEJMOWANIE:
				# Obliczenie młodszej części wyniku [arg2 - arg1]
	
	movq $arg1+8,%rax	# umieszczenie adresu młodszej części 
				# argumentu 1 w rejestrze rax		

	movq $arg2+8,%rbx	# umieszczenie adresu młodszej części 
				# argumentu 2 w rejestrze rbx
	
	movq (%rbx),%rcx	# umieszczenie wartości wskazywanej 
				# przez rbx w rcx 

	subq (%rax),%rcx	# odejmowanie od rejestru rcx wartości 
				# wskazywanej przez rax 
	
	movq $wynik+8,%rax	# umieszczenie młodszej części wyniku 
	movq %rcx,(%rax)	# dodawania w pamięci
		
	movq arg2,%rax		# Obliczenie starszej części wyniku
	sbbq arg1,%rax		# odejmowanie z uwzględnieniem pożyczki
	
	movq %rax,wynik		# umieszczenie starszej części wyniku w pamięci

SPR_OD:
	
	movq $wynik+8,%rcx	# Sprawdzenie poprawności działania 
	movq (%rcx),%rbx	# umieszczenie młodszej części w rbx
				# starsza część w rax



	
	







