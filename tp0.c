#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

void help() {
	printf(	"Usage:\n"
			" tp0 -h\n"
			" tp0 -V\n"
			" tp0 [options]\n"
			"Options:\n"
			" -V, --version		Print version and quit.\n"
			" -h, --help		Print this information.\n"
			" -i, --input		Location of the input file.\n"
			" -o, --output		Location of the output file.\n"
			" -a, --action		Program action: encode (default) or decode.\n"
			"Examples:\n"
			" tp0 -a encode -i ~/input -o ~/output\n"
			" tp0 -a decode\n");
}

void version() {
	printf("Encoder/Decoder Base64\n"
		"66.20 Organizacion de Computadoras FIUBA\n"
		);
}

//Convierto cada caracter que ingresa a una cadena de bits
void CharToBinary(char c, char *CadenaBit)
{
	char cadenaAuxiliar[8] = "";
	int j=0;
    for (int i = 7; i >= 0; --i)
    {
    	cadenaAuxiliar[j] = ((c & (1 << i)) ? '1' : '0' );
      j++;
    }
    strcat(CadenaBit, cadenaAuxiliar);
}


void encodeBase64(int posicion) {
	char code[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	char resultado = code[posicion];
	printf("Encode: %c\n", resultado);
}

//Convierto la cadena parcial de bits a la posicion decimal de
//mi tabla de codigos base64
int BinaryToDecimal(char* cadenaParcial)//char* cadenaParcial)
{
	int cantBitsEncode64 = 6;
  printf("Largo de la cadenaParcial:%d\n",(int)strlen(cadenaParcial));
	int largoCadenaParcial = strlen(cadenaParcial);
	int cantidadCiclos = strlen(cadenaParcial)/cantBitsEncode64;
	printf("cantidad de ciclos:%d\n", cantidadCiclos);
	int codASCIIZero = 48;
	int posicion;
	for (int i = 0; i < cantidadCiclos; i++){
		posicion = 0 ;
		for(int j = 0 ; j < cantBitsEncode64 ; j++){
			//se realiza un conversion directa, con '0' devuelve 48, por  eso se resta
			//printf("pos:%d\n",j+i*cantBitsEncode64);
			int aux = cadenaParcial[j+i*cantBitsEncode64] - codASCIIZero;
			posicion = posicion << 1 | aux;
		}
		printf("Decimal: %d\n", posicion);
		encodeBase64(posicion);
	}

	//en caso de que sobre bits, recorro los bits que sobran y hago un segundo
	//loop rellenando con 0
	int bitsSobrantes = largoCadenaParcial%cantBitsEncode64;
	printf("cantidad de bits sobrantes:%d\n", bitsSobrantes);
	if (bitsSobrantes != 0){
		posicion = 0;
		for (size_t i = largoCadenaParcial- bitsSobrantes; i < largoCadenaParcial; i++){
			int aux = cadenaParcial[i] - codASCIIZero;
			//printf("aux:%d\n",aux);
			posicion = posicion << 1 | aux;
		}
		int cantidadDeBytesPorDecode = 4;
		int cantidadDeLoopsCompletar4Bytes = cantidadDeBytesPorDecode - (cantidadCiclos + 1)%cantidadDeBytesPorDecode;
		printf("Cantidad de loop's faltantes es:%d\n",cantidadDeLoopsCompletar4Bytes);
		for (size_t i = 0; i < cantBitsEncode64 - bitsSobrantes; i++){
			//printf("aux:%d\n",0);
			posicion = posicion << 1 | 0;
		}
		if (posicion == 0){
			posicion = 64;
		}
		encodeBase64(posicion);
		posicion = 64;
		for (size_t i = 0; i < cantidadDeLoopsCompletar4Bytes; i++) {
			encodeBase64(posicion);
		}
	}
  return 0;
}

int main (int argc, char *argv[]) {
	char ejemplo[2] = "Ma";
	char CadenaBit[24] = "";
	for(unsigned int i=0; i<2; i++) {
		CharToBinary(ejemplo[i], CadenaBit);
	}

	printf("El largo de CadenaBit es:%d\n", (int)strlen(CadenaBit));

	BinaryToDecimal(&(CadenaBit[0]));

	int c;

	while (1) {
		static struct option long_options[] = {
				{"help", no_argument, 0, 'h'},
				{"version",  no_argument, 0, 'V'},
				{0, 0, 0, 0}
		};
		int option_index = 0;
		c = getopt_long (argc, argv, "hVo:",
                       long_options, &option_index);
		if (c == -1)
        break;
		switch (c) {
			case 'h':
				help();
				break;
			case 'V':
				version();
				break;
			case 'o':

				break;
			case '?':
				break;
			default:
				abort();
		}
	}
	return 0;
}
