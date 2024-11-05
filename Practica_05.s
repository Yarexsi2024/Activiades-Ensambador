// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que realiza la división de dos números

// Este programa utiliza los registros x0 y x1 para almacenar los valores de entrada
// (dividendo y divisor, respectivamente) y x2 para almacenar el resultado de la división.
// El programa imprime el resultado en la salida estándar.

.section .data
output_msg:   .asciz "Resultado de la división: %d\n"

.section .text
.global _start

_start:
    // Entrada de datos - Asignación de valores a los registros x0 y x1
    // En esta implementación, los valores se asignan directamente.
    mov x0, #50               // Dividendo: 50
    mov x1, #5                // Divisor: 5

    // Realizar la operación de división sin signo
    udiv x2, x0, x1           // x2 = x0 / x1 (División: 50 / 5 = 10)

    // Preparar la llamada al sistema para imprimir el resultado
    mov x0, x2                // Pasar el resultado de la división en x0 para mostrar
    ldr x1, =output_msg       // Dirección del
