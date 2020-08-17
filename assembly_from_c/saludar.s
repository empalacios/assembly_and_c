.section .data
  fin_linea:
    .ascii "\n"
  saludo:
    .ascii "Hola "
  saludo_end:

  .equ saludo_len, saludo_end - saludo

.section .text
  .globl saludar

  saludar:
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp

    # Imprimir el saludo
    movl $4, %eax           # Enviar la solicitud de escritura
    movl $1, %ebx           # Enviar el id del archivo (stdout)
    movl $saludo, %ecx      # Enviar el inicio de la cadena (Hola )
    movl $saludo_len, %edx  # Enviar la longitud de la cadena
    int $0x80               # Ejecutar la accion

    # Imprimir el nombre
    movl $4, %eax           # Enviar la solicitud de escritura
    movl $1, %ebx           # Enviar el id de archivo (stdout)
    movl 8(%ebp), %ecx      # Enviar el inicio de la cadena (parametro nombre)
    movl 12(%ebp), %edx     # Enviar la longitud de la cadena (parametro longitud)
    int $0x80               # Ejecutar la accion

    movl $4, %eax           # Enviar la solicitud de escritura
    movl $1, %ebx           # Enviar el id de archivo (stdout)
    movl $fin_linea, %ecx   # Enviar el inicio de la cadena (fin de linea)
    movl $1, %edx           # Enviar la longitud de la cadena (1 caracter)
    int $0x80               # Ejecutar la accion

    movl $0, %eax           # Indicar 0 como resultado de la operacion
    movl %ebp, %esp
    popl %ebp
    ret
