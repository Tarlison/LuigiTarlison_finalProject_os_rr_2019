	.include "cMIPS.s"
	# .set UART_rx_irq,0x08
	# .set UART_tx_irq,0x10
	.set UART_tx_bfr_empty,0x40

	# save registers
	.global Ud, tx_has_started
	.equ Q_SZ, (1<<4) # 16, MUST be a power of two

Ud:
rx_hd:	.space 4	# reception queue head index
rx_tl:	.space 4	# tail index
rx_q:	.space Q_SZ # reception queue
tx_hd:	.space 4	# transmission queue head index
tx_tl:	.space 4	# tail index
tx_q:	.space Q_SZ	# transmission queue
nrx:	.space 4	# characters in RX_queue
ntx:	.space 4	# spaces left in TX_queue

tx_has_started:	.space 4 # synchronizes transmission with Putc()	

	# replace $xx for the apropriate registers

	lui   $15, %hi(HW_uart_addr)  # get device's address
	ori   $15, $15, %lo(HW_uart_addr)
	
	#---------------------------------------------------
	# handle transmission
UARTtra:
	lw    $15, $zero(x_IO_BASE_ADDR+0x10)
	la 	  $14, $zero(tx_q)	# salva o tamanho do vetor
	lw    $13, $zero(ntx)	# salva a quantidade espaços vazios
	la    $12, $zero(ntx)	# salva o endereço para poder zerar esse espaço
	li    $9, 16			# salva o valor que será o novo número de casas disponíveis
	sw    $9, $zero($12)	# zera o ntx
	beq   $13, 16, HEXA_EXIT# caso o valor seja 16 ele está vazio e sai
	addi  $13, $13, -15		# subtrai para encontrar o topo do vetor
	move  $8, $zero			# zera o valor para receber o resultado
HEXA:
	lw   $10, $13($14)		# pega o valor do vetor
	slti  $9, $10, 60       # se for menor que 60 está no intervalo 0-9, senão A-F
	beq   $9, $zero, COMP1	# se for igual a zero, está no intervalo A-F
	addi  $10, $10, -48     # decrementa para ter o valor
	j COMP2
COMP1:
	addi  $10, $10, -65     # decrementa para ter o valor
	addi  $10, $10, 10		# soma mais 10 porque o A representa 10
COMP2:
	add   $8, $8, $10		# soma com o resultado
	sll   $8, $8, 4			# dá o shift como se estivesse multiplicando por 16
	addi  $13, $13, -1		# subtrai o valor para o vetor
	slti  $9, $13, 0		# se for menor que 0, não está mais no vetor
	beq   $9, $zero, HEXA	# o calculo não terminou
HEXA_EXIT:
	srl   $8, $8, 4			# cancela o ultimo shift que é desnecessário
	move  $7, $zero			# zera o valor para receber o resultado
	beq   $8, $zero, EXIT	# caso seja 0 ele sai e registra como zero
	lui	  $9, 1
	lui   $7, 1				# caso seja 1, o resultado também é 1
	beq   $8, $9, EXIT		# caso seja 1, ele sai do loop
	lui   $5, 0				# carrega o auxiliar com o primeiro valor do fibonnacci
	lui   $6, 1				# carrega o auxiliar com o segundo valor do fibonnacci
FIB:add   $7, $6, $5		# troca os valores anteriores
	move  $5, $6			# troca os valores
	move  $6, $7			# troca os valores
	addi  $8, $8, -1		# decrementa o contador
	slti  $9, $8, 2			# se ele for menor então
	beq   $9, $zero, FIB	# continua somando até ser menor que dois
EXIT:
	#sw    $xx, UDATA($xx)	# Read data from device



	#---------------------------------------------------
	# handle reception
UARTrec:
	la 	  $14, $zero(tx_q)	# salva o tamanho do vetor
	la    $13, $zero(nrx)	# carrega o endereço para zerar o valor
	li    $9, 16			# salva o valor que será o novo número de casas disponíveis
	sw    $9, $zero($13)	# atribui 16 ao ntx como se todos os espaços estivessem disponíveis
	mov   $5, $zero			# receberá o novo indice

DIV:
	div	  $9, $5			# faz a divisao
	mfhi  $6				# pega o resto da divisão
	sw    $6, $5($14)		# salva o valor no vetor
	addi  $5, $5, 1			# incrementa
	srl   $9, $9, 4			# divide por 2 elevado a 16
	bne   $9, $zero, DIV	# continua a divisao se nao for igual a zero



	#---------------------------------------------------
	# return	
	
_return:

	# restore registers


	eret			    # Return from interrupt

