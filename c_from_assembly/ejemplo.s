.section .data
  nombre:
    .ascii "Juan Perez\0"

.section .text
  .globl _start

   _start:
    pushl $nombre     # se envia el parametro nombre a la pila
    call  saludar     # llamada a la funcion say_hi

    movl  $0, %ebx    # se envia el codigo 0 como resultado de ejecucion
    movl  $1, %eax    # se envia la llamada de salida
    int   $0x80       # se solicita la ejecucion de la llamada al sistema operativo
