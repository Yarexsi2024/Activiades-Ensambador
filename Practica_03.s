// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que realiza la resta de dos números
// asciinema https://asciinema.org/a/687664
//DEBUG https://asciinema.org/a/687671

// Equivalente en C#:
/*
using System;

class Program
{
    static void Main()
    {
        int numero1 = 10;           // Primer número
        int numero2 = 3;            // Segundo número
        int resultado = numero1 - numero2;   // Realizar la resta

        Console.WriteLine($"Resultado de la resta: {resultado}");
    }
}
*/

.section .data
output_msg:   .asciz "Resultado de la resta: %d\n"

.section .text
.global _start

_start:
    // Entrada de datos - Asignamos valores directamente a los registros x0 y x1
    mov x0, #10                // Primer número: 10
    mov x1, #3                 // Segundo número: 3

    // Realizar la operación de resta
    sub x2, x0, x1             // x2 = x0 - x1 (Resta: 10 - 3 = 7)

    // Preparar la llamada a printf para mostrar el resultado en consola
    adr x0, output_msg         // En x0, la dirección del mensaje de formato
    mov x1, x2                 // En x1, el resultado de la resta para mostrar

    // Llamada a printf para imprimir el resultado
    bl printf

    // Finalizar el programa
    mov x8, #93                // Código de salida para Linux
    mov x0, #0                 // Estado de salida (0 = éxito)
    svc #0                     // Llamada al sistema para salir

