#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <semaphore.h>
#include <fcntl.h>
#include <pthread.h>

sem_t lector;
sem_t escritor;
pthread_mutex_t mutex=PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t read1=PTHREAD_COND_INITIALIZER;
pthread_cond_t write1=PTHREAD_COND_INITIALIZER;

int num=25;
int cont=0;
int cont2=0;
int band=0;
void *Lector(void *argumento);
void *Escritor(void *argumento);
	
int main(){

	pthread_t id_hilo;
	pthread_t id_hilo2;
	pthread_t id_hilo3;
	pthread_t id_hilo4;
	sem_init(&lector,0,1);
	sem_init(&escritor,0,1);
 	int c,i;


	void *valor_retorno,*valor2_retorno,*valor3_retorno,*valor4_retorno;


	if(pthread_create(&id_hilo,NULL,Lector,NULL)){
		printf("problema en la creacion del hilo \n");
		exit(EXIT_FAILURE);
	}
	if(pthread_create(&id_hilo3,NULL,Escritor,NULL)){
		printf("problema en la creacion del hilo \n");
		exit(EXIT_FAILURE);
	}


	
	if(pthread_create(&id_hilo2,NULL,Lector,NULL)){
		printf("problema en la creacion del hilo \n");
		exit(EXIT_FAILURE);}
	if(pthread_create(&id_hilo4,NULL,Escritor,NULL)){
		printf("problema en la creacion del hilo \n");
		exit(EXIT_FAILURE);}

	

	printf("esperando a que terminen los hijos...\n");
	printf("proceso papa: %li \n",pthread_self());
	if(pthread_join(id_hilo,&valor_retorno)){
		printf("problema al crear el enlace con otro hilo \n");
		exit(EXIT_FAILURE);
	}else{
	printf("el hilo 1 que espera papa, regreso!!! \t %s \n",(char*)valor_retorno);
	}
//dos
	if(pthread_join(id_hilo2,&valor2_retorno)){
		printf("problema al crear el enlace con otro hilo \n");
		exit(EXIT_FAILURE);
	}else{
	printf("el hilo  2 que espera papa, regreso!!! \t %s \n",(char*)valor2_retorno);
	}
	if(pthread_join(id_hilo3,&valor3_retorno)){
		printf("problema al crear el enlace con otro hilo \n");
		exit(EXIT_FAILURE);
	}else{
	printf("el hilo  3 que espera papa, regreso!!! \t %s \n",(char*)valor3_retorno);
	}
	if(pthread_join(id_hilo4,&valor4_retorno)){
		printf("problema al crear el enlace con otro hilo \n");
		exit(EXIT_FAILURE);
	}else{
	printf("el hilo  4 que espera papa, regreso!!! \t %s \n",(char*)valor4_retorno);
	}
	sem_destroy(&lector);
	sem_destroy(&escritor);
	exit(0);

}
//funciones

void *Lector(void *argumento){

	int dato;
	int i;

	while (1)
	 {
        pthread_mutex_lock(&mutex);
cont=cont+1;
        if(band==1)
        {
		
        pthread_cond_wait(&read1,&mutex);
         pthread_mutex_unlock(&mutex);
    }
		
        


        printf("contador1: %d\n",cont);
        printf("\t\tproceso: %li realizando lectura: ",pthread_self());
        printf("  del numero: %d\n",num);
		
        cont=cont-1;
        printf("contador: %d\n",cont);

		if (cont==0)
			pthread_cond_signal(&write1);


        sleep(1);
        pthread_mutex_unlock(&mutex);


	 }

	pthread_exit(NULL);

}
void *Escritor(void *argumento){

	int dato;


	while(1){
        pthread_mutex_lock(&mutex);
        band = 1;

		 while(cont>0){
            pthread_cond_wait(&write1,&mutex);
		 }

        cont2++;
		printf("\t\tel proceso: %li en ejecucion escribir\n ",pthread_self());
		 
		printf("valor antes de ser modificado: %d\n",num);
		
		num=num+5;
		printf("ahora el numero es: %d\n",num);


		sleep(1);
        band=0;
            pthread_cond_signal(&read1);
        
        pthread_mutex_unlock(&mutex);
	 }
	pthread_exit(NULL);
}