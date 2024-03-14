#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

pthread_mutex_t mutex=PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t lleno=PTHREAD_COND_INITIALIZER;
pthread_cond_t vacio=PTHREAD_COND_INITIALIZER;

void *productor(void *arg);
void *consumidor(void *arg);

int buffer[10];
int n_elementos=0;
int TamanioBuff=10;

int pos_productor=0;
int dato_productor=0;
int pos_consumidor=0;

int consumido=0;
int producido=0;

int main(){

	pthread_t hilop1;
	pthread_t hilop2;
	pthread_t hilop3;
	pthread_t hiloc1;
	pthread_t hiloc2;
	pthread_t hiloc3;
	pthread_t hiloc4;

	void *valor_retorno;

	if(pthread_create(&hilop1,NULL,productor,NULL)){
		printf("Problema en la creación del hilo productor 1\n");
		exit(EXIT_FAILURE);
	}

	if(pthread_create(&hilop2,NULL,productor,NULL)){
		printf("Problema en la creación del hilo productor 2\n");
		exit(EXIT_FAILURE);
	}

	if(pthread_create(&hilop3,NULL,productor,NULL)){
		printf("Problema en la creación del hilo productor 3\n");
		exit(EXIT_FAILURE);
	}

	if(pthread_create(&hiloc1,NULL,consumidor,NULL)){
		printf("Problema en la creación del hilo consumidor 1\n");
		exit(EXIT_FAILURE);
	}

	if(pthread_create(&hiloc2,NULL,consumidor,NULL)){
		printf("Problema en la creación del hilo consumidor 2\n");
		exit(EXIT_FAILURE);
	}

	if(pthread_create(&hiloc3,NULL,consumidor,NULL)){
		printf("Problema en la creación del hilo consumidor 3\n");
		exit(EXIT_FAILURE);
	}

	if(pthread_create(&hiloc4,NULL,consumidor,NULL)){
		printf("Problema en la creación del hilo consumidor 4\n");
		exit(EXIT_FAILURE);
	}

	

	if(pthread_join(hilop1,&valor_retorno)){
		printf("Problema al enlazar con hilo productor 1\n");
		exit(EXIT_FAILURE);
	}else{
		printf("%s",(char *)valor_retorno);
	}

	if(pthread_join(hilop2,&valor_retorno)){
		printf("Problema al enlazar con hilo productor 2\n");
		exit(EXIT_FAILURE);
	}else{
		printf("%s",(char *)valor_retorno);
	}

	if(pthread_join(hilop3,&valor_retorno)){
		printf("Problema al enlazar con hilo productor 3\n");
		exit(EXIT_FAILURE);
	}else{
		printf("%s",(char *)valor_retorno);
	}

	if(pthread_join(hiloc1,&valor_retorno)){
		printf("Problema al enlazar con hilo consumidor 1\n");
		exit(EXIT_FAILURE);
	}else{
		printf("%s",(char *)valor_retorno);
	}

	if(pthread_join(hiloc2,&valor_retorno)){
		printf("Problema al enlazar con hilo consumidor 2\n");
		exit(EXIT_FAILURE);
	}else{
		printf("%s",(char *)valor_retorno);
	}

	if(pthread_join(hiloc3,&valor_retorno)){
		printf("Problema al enlazar con hilo consumidor 3\n");
		exit(EXIT_FAILURE);
	}else{
		printf("%s",(char *)valor_retorno);
	}

	if(pthread_join(hiloc4,&valor_retorno)){
		printf("Problema al enlazar con hilo consumidor 4\n");
		exit(EXIT_FAILURE);
	}else{
		printf("%s",(char *)valor_retorno);
	}

	exit(EXIT_SUCCESS);
}


void *productor(void *arg){

	printf("\nPid del productor: %i\n",pthread_self());
	for(;;){
	
		pthread_mutex_lock(&mutex);
		while(n_elementos==TamanioBuff)
			pthread_cond_wait(&lleno,&mutex);
		dato_productor=dato_productor+1;
		buffer[pos_productor]=dato_productor;
		printf("\nDato: %i por %i es: %i\n", pos_productor,pthread_self(), buffer[pos_productor]);
		pos_productor=(pos_productor+1)%TamanioBuff;
		n_elementos++;
		producido++;
		if(n_elementos==1) 
			pthread_cond_signal(&vacio);
		pthread_mutex_unlock(&mutex);

		sleep(1);
	}
	

}


void *consumidor(void *arg){

	int dato=0;

	printf("\nPid consumidor: %i\n",pthread_self());

	
    for(;;){
	
		pthread_mutex_lock(&mutex);
		
		while(n_elementos==0){
			pthread_cond_wait(&vacio,&mutex);
		}
		dato=buffer[pos_consumidor];
		printf("\ndato: %i por %i: %i\n", pos_consumidor,pthread_self(), dato);
		sleep(1);
		pos_consumidor=(pos_consumidor+1)%TamanioBuff;
		n_elementos--;
		consumido++;
		if(n_elementos==(TamanioBuff))
			pthread_cond_signal(&lleno);
		pthread_mutex_unlock(&mutex);

		

	}
}