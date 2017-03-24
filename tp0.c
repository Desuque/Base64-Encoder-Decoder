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

//Convierto la cadena parcial de bits a la posicion decimal de
//mi tabla de codigos base64
int BinaryToDecimal()//char* cadenaParcial)
{
    int array[6] = {0,1,0,0,1,1} ;
	int posicion = 0 ;    

	for(int i = 0 ; i < 6 ; i++)
        posicion = posicion << 1 | array[i];

    printf("Decimal: %d", posicion);
    return posicion;
}

void encodeBase64(int posicion) {
	char code[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
	char resultado = code[posicion];
	printf("Encode: %c", resultado);	
}

int main (int argc, char *argv[]) {
	/**
	char ejemplo[3] = "Man";
	char CadenaBit[24] = "";
	for(unsigned int i=0; i<3; i++) {
		printf("Caracter: %s", &ejemplo[i]);
		CharToBinary(ejemplo[i], CadenaBit);
	}
	printf("Esta es la cadena: %s", CadenaBit);

	encodeBase64(BinaryToDecimal());
	**/
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