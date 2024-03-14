#include<sys/types.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<sys/ipc.h>
#include<unistd.h>

#define MAX 256

int main(){
int pid, pipe1[2], pipe2[2];
char mensaje[MAX];

if (pipe(pipe1)==-1){
printf("\nError en la creacion de la tuberia 1\n");
exit(-1);
}

if (pipe(pipe2)==-1){
printf("\nError en la creacion de la tuberia 2\n");
exit(-1);
}

if ((pid=fork())==0){
while(strcmp(mensaje,"fin")!=0){ 
read(pipe1[0], mensaje, MAX);
printf("\nSoy %i y recibi: %s\n",getpid(), mensaje);
printf("\nSoy el proceso: %i y escribo: ",getpid());
scanf("%s\n", mensaje);
write(pipe2[1], mensaje,strlen(mensaje)+1);	
}
close(pipe1[0]);
close(pipe2[1]);
exit(0);
}

else{
while(strcmp(mensaje,"fin")!=0){
scanf("%s", mensaje);
printf("\nSoy el proceso: %i y escribi \n", getpid());
write(pipe1[1],mensaje,strlen(mensaje)+1);
if(strcmp(mensaje,"fin")!=0){
read(pipe2[0], mensaje, MAX);
printf("\nSoy el proceso: %i y lei: %s\n", getpid(),mensaje);}
}
close(pipe1[1]);
close(pipe2[0]);
exit(0);