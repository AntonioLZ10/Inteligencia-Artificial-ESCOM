#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <fcntl.h>
#include <pthread.h>
#include <time.h>
#define MAX_BUFFER 8
#define DATOS_A_PRODUCIR 100

sem_t elementos;
sem_t huecos;
int buffer[MAX_BUFFER];
void *Productor(void *);
void *Consumidor(void *);
pthread_mutex_t mutex=PTHREAD_MUTEX_INITIALIZER;
int dato, i,  pos=0;


void main(void){
srand(time(NULL));
pthread_t th1, th2, th3, th4, th5, th6;

/* Inicializar los semáforos*/
sem_init(&elementos, 0, 0);
sem_init(&huecos, 0, MAX_BUFFER);

/* Crear los procesos ligeros*/

pthread_create(&th1, NULL, Productor, NULL); 
pthread_create(&th2, NULL, Consumidor, NULL); 
pthread_create(&th3, NULL, Productor, NULL); 
pthread_create(&th4, NULL, Consumidor, NULL); 
pthread_create(&th5, NULL, Productor, NULL); 
pthread_create(&th6, NULL, Consumidor, NULL); 

/*esperar su finalización*/
pthread_join(th1, NULL);
pthread_join(th2, NULL);
pthread_join(th3, NULL);
pthread_join(th4, NULL);
pthread_join(th5, NULL);
pthread_join(th6, NULL);

sem_destroy(&huecos);
sem_destroy(&elementos);
exit(0);
}

void *Productor(void *p){
for(i=0; i<DATOS_A_PRODUCIR; i++){ 
dato=i;
sem_wait(&huecos);
pthread_mutex_lock(&mutex);
buffer[pos]=i;
pos=pos%MAX_BUFFER; 
sem_post(&elementos);
printf("\n pid del Productor: %li \t Valor del dato:%i \t Posicion:%i\n", pthread_self(), dato, pos);
pthread_mutex_unlock(&mutex);
pos=pos+1;}
pthread_exit(0);}

void *Consumidor(void *c){
for(i=0; i<DATOS_A_PRODUCIR; i++){ 
sem_wait(&elementos);
pthread_mutex_lock(&mutex);
dato=buffer[pos];
pos=pos%MAX_BUFFER;
sem_post(&huecos);
printf("\n pid del Consumidor: %li \t Valor del dato:%i \t Posicion:%i\n", pthread_self(), dato, pos);
pos=pos+1;
pthread_mutex_unlock(&mutex);}
pthread_exit(0);}