// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que realiza la multiplicación de dos números
//asciinema: https://asciinema.org/a/1o2A2LaXcYrJcPHgUwePhovyA

// Equivalente en C#:

/*
using System;

class Program
{
    static void Main()
    {
        // Entrada de datos
        int num1 = 8;  // Primer número
        int num2 = 6;  // Segundo número

        // Realizar la multiplicación
        int resultado = num1 * num2;

        // Imprimir el resultado
        Console.WriteLine("Resultado de la multiplicación: " + resultado);
    }
}
*/


// Este programa utiliza los registros x0 y x1 para almacenar los valores de entrada
// (números a multiplicar) y x2 para almacenar el resultado de la multiplicación. 
// El programa imprime el resultado en la salida estándar.

.section .data
output_msg:   .asciz "Resultado de la multiplicación: %d\n"

.section .text
.global main

main:
    // Entrada de datos - Asignación de valores a los registros x0 y x1
    mov x0, #8                // Primer número: 8
    mov x1, #6                // Segundo número: 6

    // Realizar la operación de multiplicación
    mul x2, x0, x1            // x2 = x0 * x1 (Multiplicación: 8 * 6 = 48)

    // Llamar a printf
    ldr x0, =output_msg       // Dirección del mensaje de formato
    mov x1, x2                // El resultado de la multiplicación va en x1
    bl printf                 // Llamada a printf para imprimir

    // Finalizar el programa
    mov x8, #93               // Llamada al sistema 'exit'
    mov x0, #0                // Código de salida 0
    svc #0                    // Ejecutar llamada al sistema
