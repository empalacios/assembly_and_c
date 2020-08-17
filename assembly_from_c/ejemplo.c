#include<stdio.h>
#include<string.h>

int main(int argc, char *argv[])
{
   /*
   * Declaracion de la funcion saludar para que la podamos
   * utilizar desde aca
   */
  extern int saludar(char* nombre, int longitud);

  char* nombre = "Juan Perez";
  int longitudNombre = strlen(nombre);

  saludar(nombre, longitudNombre);
}
