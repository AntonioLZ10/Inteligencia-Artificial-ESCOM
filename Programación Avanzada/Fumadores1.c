#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <pthread.h>
#include <semaphore.h>
#include <time.h>

sem_t sem_agente;
sem_t sem_tabaco1;
sem_t sem_cerillo1;
sem_t sem_papel1;

void* fumador1(void* argumento);
void* fumador2(void* argumento);
void* fumador3(void* argumento);
void* Agente(void* argumento);

int cerillo=0, papel=1, tabaco=2;

void main(void){
pthread_t agente, tabaco1, cerillo1, papel1;
sem_init(&sem_agente, 0,1);
sem_init(&sem_tabaco1, 0,0);
sem_init(&sem_cerillo1, 0,0);
sem_init(&sem_papel1, 0,0);


if(pthread_create(&agente, NULL, (void*)Agente, NULL)){
printf("Problema en la creación del Hilo\n");
exit(EXIT_FAILURE);}

if(pthread_create(&tabaco1, NULL, (void*)fumador1, NULL)){
printf("Problema en la creación del Hilo\n");
exit(EXIT_FAILURE);}

if(pthread_create(&cerillo1, NULL, (void*)fumador3, NULL)){
printf("Problema en la creación del Hilo\n");
exit(EXIT_FAILURE);}

if(pthread_create(&papel1, NULL, (void*)fumador3, NULL)){
printf("Problema en la creación del Hilo\n");
exit(EXIT_FAILURE);}


pthread_join(agente,NULL);
pthread_join(tabaco1,NULL);
pthread_join(cerillo1,NULL);
pthread_join(papel1,NULL);

sem_destroy(&sem_agente);
sem_destroy(&sem_papel1);
sem_destroy(&sem_cerillo1);
sem_destroy(&sem_tabaco1);
exit(0);
}

void * Agente(void *x)
{
	while(1)
	{
		sem_wait(&sem_agente);
		int ing1=0, ing2=0;
		printf("pid del proceso Agente: %li\n",pthread_self());
		do
		{
			ing1 = rand()%3;
			ing2 = rand()%3;
			
		}while(ing1 == ing2);

		printf("Ingrediente 1:%d\n",ing1);
		printf("Ingrediente 2:%d\n",ing2);

		if((ing1==0 && ing2 == 1) || (ing1==1 && ing2 == 0) )
		{
			//Tabaco y Cerillos
			sem_post(&sem_tabaco1);	
		}


		else if((ing1==1 && ing2 == 2) || (ing1==2 && ing2 == 1))
		{
			//Cerillo y Papel
			sem_post(&sem_cerillo1);	
		}
		
		
		else if((ing1==1 && ing2 == 2) || (ing1==2 && ing2 == 1))
		{
			//Cerillo y Papel
			sem_post(&sem_papel1);	
		}
		
	}
}  

void* fumador1(void * argumento)
{
	while(1)
	{
		sem_wait(&sem_papel1);
		printf("Fumador que tiene el papel: %li\n\n",pthread_self());
		sleep(1);
		sem_post(&sem_agente);
	}
}

void* fumador2(void * argumento)
{
	while(1)
	{
		sem_wait(&sem_cerillo1);
		printf("Fumador que tiene el tabaco: %li\n\n",pthread_self());
		sleep(2);
		sem_post(&sem_agente);
	}
}
void *fumador3(void * argumento)
{
	while(1)
	{
		sem_wait(&sem_tabaco1);
		printf("Fumador que tiene el cerillo: %li\n\n",pthread_self());
		sleep(3);
		sem_post(&sem_agente);
	}
}
