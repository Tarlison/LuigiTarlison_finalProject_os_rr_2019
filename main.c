#include <stdio.h>
#include <stdlib.h>
#include "cMIPS.h"

typedef  struct UARTdriver{
    int  rx_hd;//  reception  queue  head  index
    int  rx_tl;//  reception  queue  tail  index
    char rx_q [16];//  reception  queue
    int  tx_hd;//  transmission  queue  head  index
    int  tx_tl;//  transmission  queue  tail  index
    char tx_q [16];//  transmission  queue
    int  nrx;//  number  of  characters  in  rx_queue
    int  ntx;//  number  of  spaces  in  tx_queue

}UARTdriver;

UARTdriver  Ud;
/*extern  int         _counter_val;
extern  int         _counter_saves;
extern  int         tx_has_started;
extern  int         _uart_buff;
extern  int         _dma_status;
extern  int         _dma_saves;*/

int proberx(void); //ja
int probetx(void); //ja
Tstatus iostat(void); //asdfsdfgsadg
void ioctl(Tcontrol); //sdfsdgfsdfg
char Getc(void); //ja
int Putc(char c); //ja

extern void to_stdout(char c);

int main(){
	Ud.nrx = 0;
	Ud.ntx = 16;
	char saida[256];
	int soma = 0;

	enableInterr();
	Putc('0');
	Putc('F');
	disableInterr();

	enableInterr();
	int tamanho = proberx();
	while(proberx() > 0){
		int aux = proberx() - 1;
		saida[aux++] = Getc();
	}
	disableInterr();

	for(int c = 0; c >= tamanho-1; c--){
		soma += saida[c];
		/*switch(saida[c]){
			case '0': soma +=  0;
			case '1': soma +=  1;
			case '2': soma +=  2;
			case '3': soma +=  3;
			case '4': soma +=  4;
			case '5': soma +=  5;
			case '6': soma +=  6;
			case '7': soma +=  7;
			case '8': soma +=  8;
			case '9': soma +=  9;
			case 'A': soma += 10;
			case 'B': soma += 11;
			case 'C': soma += 12;
			case 'D': soma += 13;
			case 'E': soma += 14;
			case 'F': soma += 15;
		}*/
		soma *= 16;
	}
	soma /= 16; //cancela a ultima multiplicacao
	printf("%d\n", soma);

	/*chamar o rx em uma variavel e pegar char por char e colocar
	numa fucking fila*/

    // o  que eu faço pelo amor de deus socorro tenha piedade da minha alma meu dia so tem 24hrs e eu tenho 923748r6234 trabalhos pra entregar
}

char Getc(void){
    if(Ud.nrx == 0){
        return EOF;
    }
    else{
        Ud.nrx = Ud.nrx - 1;
        return from_stdin();
    }
}
int proberx(void){
    return Ud.nrx;
}
int probetx(void){    
    return Ud.ntx;
}
int Putc(char c){
    if(Ud.ntx > 0){
       tx_q[15-Ud.ntx] = c;
       Ud.ntx = Ud.ntx - 1;
       to_stdout(tx_q[15 - Ud.ntx]);
       return 0;
    }
    else{
        return -1;
    }
}