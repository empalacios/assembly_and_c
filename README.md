# Utilizando C y Assembly

Ejemplos de la utilización de código escrito en assembly para la plataforma de 32 bits (x86) y código escrito en C, desde un entorno de 64 bits (x86_64).

## Ambiente de ejecución
Se provee la configuración de una máquina virtual con el ambiente de ejecución necesario para compilar los ejemplos.

Para levantar la máquina virtual, ejecutar el comando:
```
vagrant up
```
Una vez finalizada la creación de la máquina virtual, ingresar a la misma con el comando:
```
vagrant ssh
```
Copiar los directorios: `c_from_assembly` y `assembly_from_c`desde `/vagrant` hacia el directorio  `/home/vagrant` con el comando:
```
cd /home/vagrant
cp -r /vagrant/{c_from_assembly,assembly_from_c} .
```

## Ejecutando Código C desde Assembly
En  el directorio c_from_assembly se tienen dos archivos:
- `saludar.c`: función *saludar* escrita en lenguaje C, la cual recibe el parámetro *nombre* de tipo texto (*char**) e imprime un saludo al nombre indicado.
- `ejemplo.s`: programa escrito en Assembly el cual manda a llamar a la función *saludar* del archivo anterior.

Para ejecutar el ejemplo, debemos seguir los siguientes pasos:
1. Generar código objeto a partir del archivo `ejemplo.s`
2. Generar código objeto a partir del archivo `saludar.c`
3. Generar el archivo ejecutable a partir de los archivos objetos anteriores

Esto lo podemos hacer con las siguientes instrucciones:
```
as --32 ejemplo.s -o ejemplo.o
gcc -m32 saludar.c -c -o saludar.o
ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 -lc saludar.o ejemplo.o -o cfromassembly
```

Lo anterior generará el archivo `cfromassembly`, el cual es un ejecutable y se puede llamar desde la consola con el siguiente comando:
```
./cfromassembly
```

## Ejecutando Código Assembly desde C
En  el directorio assembly_from_c se tienen dos archivos:
- `saludar.s`: función *saludar* escrita en lenguaje Assembly, la cual recibe dos parámetros, el primero *nombre* de tipo texto (*char**) y el segundo *longitud* el cual es la longitud del nombre enviado, e imprime un saludo al nombre indicado.
- `ejemplo.c`: programa escrito en lenguaje C el cual declara la función *saludar* del archivo anterior y sus parámetros y la manda a llamar con un nombre en específico.

Para ejecutar el ejemplo, debemos seguir los siguientes pasos:
1. Generar código objeto a partir del archivo `saludar.s`
2. Generar el archivo ejecutable a partir del archivo `ejemplo.c` y archivo objeto anterior

Esto lo podemos hacer con las siguientes instrucciones:
```
as --32 saludar.s -o saludar.o
gcc -m32 ejemplo.c saludar.o -o assemblyfromc
```

Lo anterior generará el archivo `assemblyfromc`, el cual es un ejecutable y se puede llamar desde la consola con el siguiente comando:
```
./assemblyfromc
```
## Observaciones
Debido a que la plataforma de ejecución está basada 64 bits, se debe instalar el paquete `gcc-multilib` para que la operación de generación de ejecutables (link) funcione correctamente.

Es necesario indicarle al assembler `as` (GNU Assembler en este caso) que los archivos objeto deben ser generados para la plataforma de 32 bits, esto se hace con el parámetro `--32`.

En la operación de generación de ejecutables a través del *linker*, también es necesario indicar que se emule el linker `elf_i386` con la finalidad que funcione correctamente con los archivos generados para la plataforma de 32 bits.

Al momento de compilar los archivos en lenguaje C, también es necesario indicar que genere código de 32 bits i386, esto se hace con la directiva `-m32`.

## Recursos Utilizados
Los documentos utilizados para estos ejemplos se obtuvieron de los siguientes enlaces:
- Programming from the Ground Up Book de Jonathan Bartlett: http://savannah.nongnu.org/projects/pgubook/
- How to Mix C and Assembly: https://www.devdungeon.com/content/how-mix-c-and-assembly

