#ifndef LISTA_H_INCLUDED
#define LISTA_H_INCLUDED
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct _Nodo {
    int dato;
    char nombre[10];
    struct _Nodo *siguiente;
}Nodo;

Nodo *CrearNodo(int d, char nombre[10]){
    Nodo *nuevo;
    nuevo = (Nodo *)malloc (sizeof(Nodo));
    nuevo->dato = d;
    strcpy(nuevo->nombre,nombre);
    nuevo->siguiente = NULL;
    return nuevo;
}

Nodo *InsertarAlInicio(Nodo *top, int d, char nombre[10]){
    Nodo *nuevo;
    nuevo = CrearNodo(d, nombre);
    if(top!=NULL) {
        nuevo ->siguiente = top;
    }
    return nuevo;
}

Nodo *InsertarAlFinal(Nodo *frente, int d, char nombre[10]){
    Nodo *nuevo, *aux;
    nuevo = CrearNodo(d, nombre);
    if(frente==NULL){
        return nuevo;
    }
    else{
        aux=frente;
        while(aux->siguiente!=NULL){
            aux = aux->siguiente;
        }
        aux->siguiente=nuevo;
        return frente;
    }
}

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
Nodo *InsertarEnPosicion(Nodo *top, int dato, int posicion, char nombre[10]){

    Nodo *aux, *nuevo;
    int longitud=ContarNodo(top);

    if((posicion<1) || (posicion>longitud)){
    printf("Posicion no esta dentro de la lista");
    }
    else {
        if(posicion==1){nuevo=InsertarAlInicio(top, dato, nombre); return nuevo;}
      aux=top;
      nuevo=CrearNodo(dato, nombre);

      for(int i=1; i<posicion-1; i++){
        aux=aux->siguiente;
      }
        nuevo->siguiente=aux->siguiente;
        aux->siguiente=nuevo;

    }
    return top;
}
void Show(Nodo *top){
    if(top==NULL){
        printf("La lista esta vacia\n");
    }
    else{
        while(top!=NULL){
            printf("%d ", top->dato);
            printf("%s ", top->nombre);
            top=top->siguiente;
        }
    }
}

Nodo *BorrarAlFinal(Nodo *frente){
   Nodo *aux;
    aux=frente;
    if(frente==NULL){
        printf("\nNo se pudo borrar.");
        return frente;
    }
    else{
        frente=frente->siguiente;
        free(aux);
        return frente;
    }
}


Nodo *BorrarAlInicio(Nodo *cima){

    Nodo *aux;
    aux=cima;
    if (cima!=NULL){
        cima=cima->siguiente;
        free(aux);
    }
    return cima;
}



#endif // LISTA_H_INCLUDED
