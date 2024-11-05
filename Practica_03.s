// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que realiza la resta de dos números

// Para este programa se utilizan los registros x0 y x1 para almacenar los valores 
// de entrada (números a restar) y x2 para almacenar el resultado de la resta. 
// El programa imprime el resultado en la salida estándar.

.section .data
output_msg:   .asciz "Resultado de la resta: %d\n"

.section .text
.global _start

_start:
    // Entrada de datos - Asumimos que los valores están cargados en los registros x0 y x1.
    // En este ejemplo, asignaremos valores directamente para propósitos de demostración.

    mov x0, #10                // Primer número: 10
    mov x1, #3                 // Segundo número: 3

    // Realizar la operación de resta
    sub x2, x0, x1             // x2 = x0 - x1 (Resta: 10 - 3 = 7)

    // Preparar llamada al sistema para imprimir el resultado en consola
    mov x0, x2                 // Pasar el resultado de la resta en x0 para mostrar
    ldr x1, =output_msg        // Dirección del mensaje
    mov x2, #0                 // Indicador de tipo de formato (0 para %d)

    // Llamada al sistema de impresión (en Linux)
    bl printf                  // Imprimir resultado

    // Finalizar el programa
    mov x8, #93                // Llamada al sistema 'exit'
    mov x0, #0                 // Código de salida 0
    svc #0                     // Ejecutar llamada al sistema
