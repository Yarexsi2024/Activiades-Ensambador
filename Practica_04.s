// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que realiza la multiplicación de dos números

// Este programa utiliza los registros x0 y x1 para almacenar los valores de entrada
// (números a multiplicar) y x2 para almacenar el resultado de la multiplicación. 
// El programa imprime el resultado en la salida estándar.

.section .data
output_msg:   .asciz "Resultado de la multiplicación: %d\n"

.section .text
.global _start

_start:
    // Entrada de datos - Asignación de valores a los registros x0 y x1
    // En esta implementación, los valores se asignan directamente.
    mov x0, #8                // Primer número: 8
    mov x1, #6                // Segundo número: 6

    // Realizar la operación de multiplicación
    mul x2, x0, x1            // x2 = x0 * x1 (Multiplicación: 8 * 6 = 48)

    // Preparar la llamada al sistema para imprimir el resultado
    mov x0, x2                // Pasar el resultado de la multiplicación en x0 para mostrar
    ldr x1, =output_msg       // Dirección del mensaje de formato
    mov x2, #0                // Indicador de tipo de formato (0 para %d)

    // Llamada al sistema de impresión (en Linux)
    bl printf                 // Imprimir resultado

    // Finalizar el programa
    mov x8, #93               // Llamada al sistema 'exit'
    mov x0, #0                // Código de salida 0
    svc #0                    // Ejecutar llamada al sistema
