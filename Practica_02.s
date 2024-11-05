// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que realiza la suma de dos números

// Este programa utiliza los registros x0 y x1 para almacenar los valores de entrada
// (números a sumar), y x2 para almacenar el resultado de la suma. El resultado se
// imprime en la salida estándar.

.section .data
output_msg:   .asciz "Resultado de la suma: %d\n"

.section .text
.global _start

_start:
    // Entrada de datos - Asignación de valores a los registros x0 y x1
    // En esta implementación, los valores se asignan directamente.
    mov x0, #7                // Primer número: 7
    mov

