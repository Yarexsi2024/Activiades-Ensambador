// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que realiza la suma de dos números
// link asciinema https://asciinema.org/a/687650

// Programa equivalente en C#:
/*
using System;

class Program
{
    static void Main()
    {
        int numero1 = 7;  // Primer número a sumar
        int numero2 = 3;  // Segundo número a sumar
        int resultado = numero1 + numero2;  // Realiza la suma

        Console.WriteLine($"Resultado de la suma: {resultado}");
    }
}
*/

// Programa equivalente en Python:
/*
numero1 = 7  # Primer número
numero2 = 3  # Segundo número
resultado = numero1 + numero2  # Realiza la suma
print(f"Resultado de la suma: {resultado}")
*/

.section .data
output_msg:   .asciz "Resultado de la suma: %d\n"

.section .text
.global _start

_start:
    // Entrada de datos - Asignación de valores a los registros x0 y x1
    // En esta implementación, los valores se asignan directamente.
    mov x0, #7                // Primer número: 7
    mov x1, #3                // Segundo número: 3

    // Realizar la suma
    add x2, x0, x1            // Almacena el resultado de x0 + x1 en x2

    // Llamada al sistema para imprimir el resultado
    mov x0, x2                // Mueve el resultado al registro x0 (argumento de printf)
    adr x1, output_msg        // Dirección del mensaje en x1
    bl printf                 // Llamada a printf para mostrar el resultado

    // Salida del programa
    mov x8, #93               // Código de salida en Linux
    mov x0, #0                // Estado de salida (0 = éxito)
    svc #0                    // Llamada al sistema
