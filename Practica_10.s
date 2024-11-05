// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que invierte una cadena de caracteres

// Este programa utiliza punteros y manipulación de memoria para invertir una cadena de caracteres.
// Los caracteres se intercambian desde los extremos hacia el centro.

.section .data
input_str:    .asciz "Hola, ARM64!"      // Cadena a invertir
output_msg:   .asciz "Cadena invertida: %s\n"

.section .bss
buffer:       .space 100                  // Espacio para copiar la cadena original

.section .text
.global _start

_start:
    // Cargar la dirección de la cadena de entrada
    ldr x0, =input_str                    // Dirección de la cadena original
    ldr x1, =buffer                       // Dirección del buffer donde se copiará la cadena

    // Copiar la cadena original al buffer
copy_loop:
    ldrb w2, [x0], #1                     // Cargar un byte de input_str y avanzar puntero
    strb w2, [x1], #1                     // Almacenar el byte en buffer y avanzar puntero
    cbnz w2, copy_loop                    // Si el byte no es nulo, repetir el bucle

    // Invertir la cadena en el buffer
    ldr x0, =buffer                       // Puntero al inicio de la cadena en buffer
    mov x1, x0                            // Guardar puntero de inicio en x1 para el final

    // Calcular la longitud de la cadena
find_end:
    ldrb w2, [x1], #1                     // Cargar un byte y avanzar el puntero
    cbz w2, reverse_loop                  // Si encontramos el byte nulo, saltar a invertir
    sub x1, x1, #1                        // Retroceder para ajustar al último carácter
    b find_end                            // Repetir hasta encontrar el final

reverse_loop:
    // Intercambiar caracteres desde los extremos hacia el centro
    cmp x0, x1                            // Comparar inicio con fin
    bge print_result                      // Si se encuentran o cruzan, terminar

    ldrb w2, [x0]                         // Cargar byte desde el inicio
    ldrb w3, [x1]                         // Cargar byte desde el fin
    strb w3, [x0]                         // Almacenar el byte del fin en el inicio
    strb w2, [x1]                         // Almacenar el byte del inicio en el fin

    add x0, x0, #1                        // Mover inicio hacia adelante
    sub x1, x1, #1                        // Mover fin hacia atrás
    b reverse_loop                        // Repetir el intercambio

print_result:
    // Mostrar la cadena invertida
    ldr x0, =buffer                       // Pasar el buffer invertido como argumento
    ldr x1, =output_msg                   // Dirección del mensaje de formato
    bl printf                             // Imprimir el mensaje y la cadena invertida

    // Finalizar el programa
    mov x8, #93                           // Llamada al sistema 'exit'
    mov x0, #0                            // Código de salida 0
    svc #0                                // Ejecutar llamada al sistema
