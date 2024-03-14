#ifndef _PILA_H_
#define _PILA_H_
#include <stdio.h>
#include <stdlib.h>

typedef struct _Nodo {
    int dato;
    struct _Nodo *siguiente;    //Se pone struct _Nodo, porque aún no se tiene definida la estructura, se define hasta después del Nodo;
} Nodo;

//La primera funcion debe establecer el espacio de memoria y darle un valor (Crear emoria dinamica y poner el valor al espacio)

Nodo *CrearNodito(int d){
    Nodo *nuevo;
    nuevo=(Nodo *)malloc(sizeof(Nodo)); //Se puede omitir la comprobación
    nuevo->dato = d;
    nuevo->siguiente = NULL;
    return nuevo;
}

//Apliar o hacer el push de un stack

Nodo *Push(Nodo *top, int d){
    Nodo *nuevo;
    nuevo = CrearNodito(d);
    if(top!=NULL) {
        nuevo ->siguiente = top;
    }
    return nuevo;
}

//mostrar los elementos de la pila, Nodo *top referencia a la pila

void Show(Nodo *top){
    if(top==NULL){
        printf("La pila esta vacia\n");
    }
    else{
        while(top!=NULL){
            printf("El dato apilado es: %d\n", top->dato);
            top=top->siguiente;
        }
    }
}
//borrar elemento de una pila el superior
Nodo *BorrarNodo(Nodo *cima){

    Nodo *aux;
    aux=cima;
    if (cima!=NULL){
        cima=cima->siguiente;
        free(aux); //free sirve para borrar
    }
    return cima;
}

//Saber cantidad de elementos de una pila
int ContarNodo(Nodo*top){
    int elementos=0;

    if(top!=NULL){
         while(top!=NULL){
            elementos++;
            top=top->siguiente;
        }
    }

    return elementos;
}

//Leer un archivo de texto para almacenar datos en la pila

Nodo *LeerArchivo(Nodo *top){
    int num = 0;
    FILE *archivo=fopen("archivo.txt", "r");
            if(archivo==NULL){
                printf("Error al abrir el archivo");
            }
            else {
            while(!feof(archivo)){
            fscanf(archivo, "%d ", &num);
            top=Push(top,num);}
            }
            fclose(archivo);
            return top;
    }


void GuardarenArchivo(Nodo *top){

    FILE *archivo = fopen("archivo.txt", "w");
            if(archivo==NULL){
                printf("Error al abrir el archivo");
        }
            else{
            while(top!= NULL)
            {fprintf(archivo, "%d ", top->dato);
            top=top->siguiente;}
    }
}



#endif // _PILA_H_
