// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que calcula la suma de los N primeros números naturales.

// Este programa utiliza un bucle para sumar los primeros N números naturales.
// Los registros x0 y x1 almacenan el contador y el límite N, respectivamente, y x2 acumula la suma.
// El programa imprime el resultado final en la salida estándar.

.section .data
output_msg:   .asciz "La suma de los primeros N números naturales es: %d\n"

.section .text
.global _start

_start:
    // Inicialización de valores
    mov x1, #10               // N: límite hasta el cual se sumarán los números (en este caso, 10)
    mov x0, #1                // Contador: comienza en 1
    mov x2, #0                // Acumulador de suma: comienza en 0

loop:
    // Sumar el contador actual al acumulador
    add x2, x2, x0            // x2 = x2 + x0 (acumulador += contador)

    // Incrementar el contador
    add x0, x0, #1            // x0 = x0 + 1 (contador++)

    // Verificar si el contador alcanzó el valor de N
    cmp x0, x1                // Comparar contador con N
    ble loop                  // Si contador <= N, repetir el bucle

    // Preparar la llamada al sistema para imprimir el resultado
    mov x0, x2                // Pasar el resultado de la suma en x0 para mostrar
    ldr x1, =output_msg       // Dirección del mensaje de formato
    mov x2, #0                // Indicador de tipo de formato (0 para %d)

    // Llamada al sistema de impresión (en Linux)
    bl printf                 // Imprimir resultado

    // Finalizar el programa
    mov x8, #93               // Llamada al sistema 'exit'
    mov x0, #0                // Código de salida 0
    svc #0                    // Ejecutar llamada al sistema
