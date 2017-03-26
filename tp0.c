#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <stdbool.h>

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

FILE* fileOpen(char* nombre){
	FILE* fp = fopen(nombre, "rb");
	if(fp == NULL){
		fputs ("El archivo no existe o no puede ser abierto.\n", stderr);
		exit(1);
	}
	return fp;
}


void fileClose(FILE* fp){
	fclose(fp);
}

int fileGetSize(char* nombre){
	FILE* fp = fileOpen(nombre);
	fseek(fp, 0L, SEEK_END);
	int size = ftell(fp);
	fseek(fp, 0L, SEEK_SET);
	fileClose(fp);
	return size;
}

void fileRead(FILE* fp,char* buffer){
	char caracter;
	int pos = 0;
	while((caracter = fgetc(fp)) != EOF){
		buffer[pos] = caracter;
		pos++;
	}
}

void fileProcessing(char* nombre, char* buffer){
	FILE* fp = fileOpen(nombre);
	if (fp != NULL){
		fileRead(fp, buffer);
		fileClose(fp);
	}
}

char* bufferOpen(int size){
	char* auxBf = malloc(sizeof(char)*size +1);
	if (auxBf != NULL)
		return auxBf;
	fputs ("No se pudo obtener buffer.\n", stderr);
	return NULL;
}

void bufferClose(char* bf){
	free(bf);
}


void PosicionToBinary(int posicion, char *CadenaBit) {
	char cadenaAuxiliar[8] = "";
	int j=0;
    for (int i = 7; i >= 0; --i)
    {
    	//Las cadenas en base64 son de 6 bits, los dos primeros ceros no me interesan
    	if((j != 0) && (j != 1)) {
    		cadenaAuxiliar[j-2] = ((posicion & (1 << i)) ? '1' : '0' );
    	}
    	j++;
    }
    strcat(CadenaBit, cadenaAuxiliar);
}

int decodeBase64(char caracter) {
	//REVISAR CASO DEL IGUAL, HACER CASO DE BORDE
	char code[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	for(unsigned int i=0; i<strlen(code); i++) {
		if(caracter == code[i]) {
			return i;
			break;
		}
	}
}

void decode(char *cadenaBase64, char *CadenaDecodificada) {
	char *CadenaBits;
	//Reservo memoria para almacenar la cadena binaria
	CadenaBits = malloc(strlen(cadenaBase64)*sizeof(char)*6+1);

	//Traduzco cada caracter base64 a binario
	for(unsigned int i=0; i<strlen(cadenaBase64); i++) {
		char cadenaAuxiliar[6] = "";
		PosicionToBinary(decodeBase64(cadenaBase64[i]), cadenaAuxiliar);
		strcat(CadenaBits, cadenaAuxiliar);
	}

	//Traduzco la cadena binaria a texto
	char cadenaAuxiliar[8] = "";
	int i = 0;
	int k = 0;
	while(i < strlen(CadenaBits)) {
		for(unsigned int j=0; j<8; j++) {
			cadenaAuxiliar[j] = CadenaBits[i];
			i++;
		}
		char c = strtol(cadenaAuxiliar, 0, 2);
		if(strlen(&c) != 0) {
			CadenaDecodificada[k] = c;
			k++;
		}
	}
}

void grabarArchivo(char *nombreArchivo, char* cadena) {
	FILE *fp;
	fp = fopen(nombreArchivo, "w+");
	if (fp == NULL) {
		fputs ("Error abriendo el archivo.",stderr);
		exit(1);
	}
 	fputs(cadena, fp);
	fclose (fp);
}

void setStdinBuffer(char* buffer2) {
    char *buffer = NULL;
    int read;
    long unsigned int len;
    read = getline(&buffer, &len, stdin);
    if (-1 != read) {
    	buffer2 = calloc(1, strlen(buffer));
    	strcpy(buffer2, buffer);
        puts(buffer);
    }
    else
        printf("No line read...\n");

    printf("Size read: %d\n Len: %d\n", read, (int)len);
}

void leerArchivo(char* nombreArchivo, char** bf) {
	//Dado que tengo un archivo, obtengo la cadena de caracteres
	int size = fileGetSize(nombreArchivo);
	*bf = bufferOpen(size);
	bf[size] = '\0';
	fileProcessing(nombreArchivo, *bf);
}

void setParametrosActivos(int argc, char *argv[], bool *oflag) {
	//Seteo los parametros que estan activos
	for (size_t i = 0; i < argc; i++){
		if((strcmp(argv[i], "-o") == 0) || strcmp(argv[i], "--output") == 0) {
			*oflag = true;
		}
	}
}

int main (int argc, char *argv[]) {
	/*char ejemplo[2] = "Ma";
	char CadenaBit[24] = "";
	for(unsigned int i=0; i<2; i++) {
		CharToBinary(ejemplo[i], CadenaBit);
	}

	printf("El largo de CadenaBit es:%d\n", (int)strlen(CadenaBit));*/

	/**
	NOTA CRISTIAN: TE COMENTO LO TUYO PARA PODER PROBAR
	LOS ARGUMENTOS REALES**/

	/**
	for (size_t i = 0; i < argc; i++){
		printf("Argumentos[%d] :%s\n",(int)i,argv[i]);
	}

	//dado que tengo un archivo, obtengo la cadena de caracteres
	int size = fileGetSize(argv[4]);
	char* bf = bufferOpen(size);
	//char* bf[size+1] = ""
	bf[size] = '\0';
	fileProcessing(argv[4],bf);
	printf("El buffer es:%s\n",bf); //valgrind me tira lectura invalida aca
	printf("Tamanio del buffer:%d\n",(int)strlen(bf));
	//BinaryToDecimal(bf);
	bufferClose(bf);
	//BinaryToDecimal(&(CadenaBit[0]));

	**/
	//Cargo el buffer con posibles caracteres ingresados por Stdin
	//char *buffer = NULL;
	//setStdinBuffer(buffer);

	//printf("A ver: %s", buffer);

	char **bufferArchivoEntrada;
	*bufferArchivoEntrada = NULL;
	char *CadenaDecodificada = NULL;
	bool oflag = false;
	int c;
	while (1) {
		static struct option long_options[] = {
				{"version", no_argument, 0, 'V'},
				{"help", no_argument, 0, 'h'},
				{"input", required_argument, 0, 'i'},
				{"output", required_argument, 0, 'o'},
				{"action", optional_argument, 0, 'a'},
				{0, 0, 0, 0}
		};
		int option_index = 0;
 		c = getopt_long (argc, argv, "Vhi:o:a:",
 	   	long_options, &option_index);
		if (c == -1)
		break;

		setParametrosActivos(argc, argv, &oflag);
		switch (c) {
			case 'V':
				version();
				break;
			case 'h':
				help();
				break;
			case 'i':
				leerArchivo(optarg, bufferArchivoEntrada);
				break;
			case 'o':
        		if(CadenaDecodificada != NULL) {
					grabarArchivo(optarg, CadenaDecodificada);
				}
				//FALTA IMPLEMENTAR -i
				//else if(CadenaCodificada != 0) {
				//	grabarArchivo(optarg, CadenaCodificada);
				//}
				else {
					printf("No hay informacion para persistir.\n");
				}
				break;
			case 'a':
				if(optarg != 0) {
					if(strcmp(optarg, "decode") == 0) {
						//Se ingreso la informacion a ser procesada por medio de un archivo
						if(*bufferArchivoEntrada != NULL) {
							CadenaDecodificada = malloc(((strlen(*bufferArchivoEntrada)*sizeof(char)*6)/8)+1);
							decode(*bufferArchivoEntrada, CadenaDecodificada);

							//Si no se especifica un archivo de salida, entonces se muestra por stdout
							if(!oflag) {
								fputs(CadenaDecodificada, stdout);
							}
						}
					} else if(strcmp(optarg, "encode") == 0) {
						printf("Hay que codificar");
					} else {
						fputs ("No se reconoce el comando, por favor lea la ayuda.\n", stderr);
					}
				} else if (optarg == 0) {
					//Por defecto codifica
					printf("Hay que codificar");
				}
        		break;
			case '?':
				break;
			default:
				abort();
		}
	}

	//Libero recursos
	if (*bufferArchivoEntrada != NULL) {
		bufferClose(*bufferArchivoEntrada);
	}

	return 0;
}
