#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <stdbool.h>
#include <unistd.h>

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

void encodeBase64(int posicion,char* output,int pos) {
	char code[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	char resultado = code[posicion];
	output[pos] = resultado;
}

//Convierto la cadena parcial de bits a la posicion decimal de
//mi tabla de codigos base64
int BinaryToDecimal(char* cadenaParcial,char* output, int longitud){
	int cantBitsEncode64 = 6;
	int largoCadenaParcial = strlen(cadenaParcial);
	int cantidadCiclos = strlen(cadenaParcial)/cantBitsEncode64;
	int codASCIIZero = 48;
	int posicion;
	int pos = 0;
	for (int i = 0; i < cantidadCiclos; i++){
		posicion = 0 ;
		for(int j = 0 ; j < cantBitsEncode64 ; j++){
			//se realiza un conversion directa, con '0' devuelve 48, por  eso se resta
			int aux = cadenaParcial[j+i*cantBitsEncode64] - codASCIIZero;
			posicion = posicion << 1 | aux;
		}
		encodeBase64(posicion,output,pos);
		pos++;
	}

	//en caso de que sobre bits, recorro los bits que sobran y hago un segundo
	//loop rellenando con 0
	int bitsSobrantes = largoCadenaParcial%cantBitsEncode64;
	if (bitsSobrantes != 0){
		posicion = 0;
		for (size_t i = largoCadenaParcial- bitsSobrantes; i < largoCadenaParcial; i++){
			int aux = cadenaParcial[i] - codASCIIZero;
			posicion = posicion << 1 | aux;
		}
		int cantidadDeLoopsCompletar4Bytes = longitud - (cantidadCiclos + 1);
		for (size_t i = 0; i < cantBitsEncode64 - bitsSobrantes; i++){
			posicion = posicion << 1 | 0;
		}
		if (posicion == 0){
			posicion = 64;
		}
		encodeBase64(posicion,output,pos);
		pos++;
		posicion = 64;
		for (size_t i = 0; i < cantidadDeLoopsCompletar4Bytes; i++) {
			encodeBase64(posicion,output,pos);
			pos++;
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
	char* auxBf = malloc(sizeof(char)*size);
	if (auxBf != NULL)
		memset(auxBf,'\0',size);
		return auxBf;
	fputs ("No se pudo obtener buffer.\n", stderr);
	return NULL;
}

void bufferClose(char* bf){
	if(bf!=NULL)
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
	char code[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	int posicion = -1;
	for(unsigned int i=0; i<strlen(code); i++) {
		if(caracter == code[i]) {
			posicion = i;
		}
	}
	return posicion;
}

void decode(char *cadenaBase64, char *CadenaDecodificada){
	char *CadenaBits = NULL;
	//Reservo memoria para almacenar la cadena binaria
	CadenaBits = malloc((strlen(cadenaBase64)-1)*sizeof(char)*6+1);

	//Traduzco cada caracter base64 a binario
	for(unsigned int i=0; i<strlen(cadenaBase64)-1; i++){
		char cadenaAuxiliar[6] = "";
		int posicion = decodeBase64(cadenaBase64[i]);
		if(posicion != -1) {
			PosicionToBinary(posicion, cadenaAuxiliar);
			strcat(CadenaBits, cadenaAuxiliar);	
		}
		else {
			//Salio algo mal, devolvamos la memoria que pedimos :)
			free(CadenaBits);
			fputs ("Caracter erroneo durante la decodificacion.\n", stderr);
			exit(1);
		}
		
	}

	//Traduzco la cadena binaria a texto
	char cadenaAuxiliar[8] = "";
	int i = 0;
	int k = 0;

	while(i < (strlen(CadenaBits))) {
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
	CadenaDecodificada[strlen(CadenaDecodificada)] = '\0';
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


void leerArchivo(char* nombreArchivo, char** bf) {
	//Dado que tengo un archivo, obtengo la cadena de caracteres
	int size = fileGetSize(nombreArchivo);
	if (size == 0){
		exit(0);
	}
	*bf = bufferOpen(size+1);
	fileProcessing(nombreArchivo, *bf);
}

void readSTDIN(char* bf,int size){
	read(0, bf, size);
}


void charCopy(char** ch1,char* ch2){
	*ch1 = malloc(strlen(ch2)+1);
	(*ch1)[strlen(ch2)] = '\0';
	strcat(*ch1,ch2);
}

int calculateLen(char* input){
	int longitudBits = (strlen(input)-1)*8;
	int longitud = longitudBits/6;
	if (longitud%4 != 0){
		longitud = longitud +4;
		longitud = longitud/4;
		longitud = longitud*4;
	}
	return longitud;
}

void encode(char* input,char* output,int flag){
	int len = strlen(input);
	int longitudBits = (len-1)*8;
	char* cadenaDeBits = bufferOpen(longitudBits);
	for (size_t i = 0; i < len - flag; i++) {
			CharToBinary(input[i],cadenaDeBits);
	}
	BinaryToDecimal(cadenaDeBits,output,calculateLen(input));
}

int main (int argc, char *argv[]) {
	char* inputBuffer = NULL;
	bool encode64 = true; //Por defecto se encodifica
	bool stdinB = true;
	bool stdoutB = true;
	char* output = NULL;
	char* outputFileName = NULL;
	char* inputFileName = NULL;
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

		//Si no espefica el input, leo desde el stdin
		int option_index = 0;
 		c = getopt_long (argc, argv, "Vhi:o:a:",
 	   	long_options, &option_index);
		if (c == -1)
		break;
				switch (c) {
			case 'V':
				version();
				break;
			case 'h':
				help();
				break;
			case 'i':
				stdinB = false;
				charCopy(&inputFileName,optarg);
				break;
			case 'o':
				stdoutB = false;
				charCopy(&outputFileName,optarg);
				break;
			case 'a':
				if(strcmp(optarg,"decode") == 0){
					encode64 = false;
				}
        		break;
			case '?':
				break;
			default:
				abort();
		}
	}

	//llegado hasta aca el inputBuffer se leyo desde un archivo o desde stdin
	int flag = 0;
	if(stdinB){
		inputBuffer = bufferOpen(400);
		readSTDIN(inputBuffer,400);
		flag = 1;
	}else{
		leerArchivo(inputFileName,&inputBuffer);
	}
	if (encode64){
		int len = calculateLen(inputBuffer);
		output = bufferOpen(len+1);
		memset(output, '\0', strlen(output));
		encode(inputBuffer,output,flag);
	}else{
		output = bufferOpen(((strlen(inputBuffer)*sizeof(char)*6)/8) + 1);
		memset(output, '\0', strlen(output)+1);
		decode(inputBuffer,output);
	}
	//Definiendo la salida
	if(stdoutB){
		fputs(output, stdout);
		printf("\n");
	}else{
		grabarArchivo(outputFileName, output);
	}
	//Libero recursos
	bufferClose(inputBuffer);
	bufferClose(outputFileName);
	bufferClose(inputFileName);
	bufferClose(output);
	return 0;
}
