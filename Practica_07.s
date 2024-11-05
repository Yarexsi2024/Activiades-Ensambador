// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que calcula el factorial de un número N.

// Este programa calcula el factorial de un número dado (N) utilizando un bucle.
// Los registros x0 y x1 almacenan el contador y el valor de N, respectivamente, mientras que x2
// almacena el resultado acumulado del factorial. El programa imprime el resultado final en la salida estándar.

.section .data
output_msg:   .asciz "El factorial de %d es: %d\n"

.section .text
.global _start

_start:
    // Inicialización de valores
    mov x1, #5                // Número N cuyo factorial se desea calcular (en este caso, N = 5)
    mov x0, x1                // Copiar N en x0 para imprimir al final
    mov x2, #1                // Inicializar el resultado del factorial en 1
    mov x3, #1                // Contador inicializado en 1

factorial_loop:
    // Multiplicar el resultado acumulado por el contador
    mul x2, x2, x3            // x2 = x2 * x3

    // Incrementar el contador
    add x3, x3, #1            // x3 = x3 + 1

    // Verificar si el contador alcanzó el valor de N
    cmp x3, x1                // Comparar contador con N
    ble factorial_loop        // Si contador <= N, repetir el bucle

    // Preparar la llamada al sistema para imprimir el resultado
    mov x0, x1                // Pasar N a x0 para mostrar
    mov x1, x2                // Pasar el resultado del factorial a x1 para mostrar
    ldr x2, =output_msg       // Dirección del mensaje de formato

    // Llamada al sistema de impresión (en Linux)
    bl printf                 // Imprimir resultado

    // Finalizar el programa
    mov x8, #93               // Llamada al sistema 'exit'
    mov x0, #0                // Código de salida 0
    svc #0                    // Ejecutar llamada al sistema
