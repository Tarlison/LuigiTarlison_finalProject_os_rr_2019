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
	
	# your code goes here
	
	#---------------------------------------------------
	# handle reception
UARTrec:
	

	# your code goes here
	rx = caracteres
	j     _return
	nop

	
	
	#---------------------------------------------------
	# handle transmission
UARTtra:	
	
	# your code goes here

	lw    $15, (x_IO_BASE_ADDR+0x10)
	la 	  $14, (tx_q)		# salva o tamanho do vetor
	lw    $13, (ntx)		# salva a quantidade espaços vazios
	beq   $13, 16, EXIT     # caso o valor seja 16 ele está vazio e sai
	addi  $13, $13, -15		# subtrai para encontrar o topo do vetor
	move  $8, $zero			# zera o valor para receber o resultado
FIB:lw    $10, $13($14)     # pega o valor do vetor
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
	beq $9, $zero, FIB		# o calculo não terminou
EXIT:

	sw    $xx, UDATA($xx)	# Read data from device


	#---------------------------------------------------
	# return	
	
_return:

	# restore registers


	eret			    # Return from interrupt

