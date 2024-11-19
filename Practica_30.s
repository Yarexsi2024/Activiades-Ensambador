// Fecha: 12/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que calcula el Máximo Común Divisor (MCD) de dos números usando el algoritmo de Euclides.

// Equivalente en C#:
/*
using System;

class Program {
    static int CalcularMCD(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    static void Main() {
        int a = 56;
        int b = 98;
        int resultado = CalcularMCD(a, b);
        Console.WriteLine("El MCD es: " + resultado);
    }
}
*/

.section .data
a: .word 56                       // Primer número
b: .word 98                       // Segundo número
msg_resultado: .asciz "El MCD es: %d\n"

.section .text
.global _start

_start:
    // Cargar los valores iniciales de a y b
    ldr w1, a                     // Cargar a en w1
    ldr w2, b                     // Cargar b en w2

calcular_mcd:
    cmp w2, 0                     // Comprobar si b == 0
    beq imprimir_resultado        // Si b es 0, el MCD es a

    udiv w3, w1, w2               // Calcular a / b (cociente) en w3 (no necesario aquí, solo ilustrativo)
    msub w4, w3, w2, w1           // Calcular a % b y almacenarlo en w4: w4 = a - (b * (a / b))
    mov w1, w2                    // a = b
    mov w2, w4                    // b = a % b

    b calcular_mcd                // Repetir hasta que b sea 0

imprimir_resultado:
    mov x0, w1                    // Pasar el MCD a x0 para printf
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión en x1
    bl printf                     // Imprimir el resultado

    // Salir del programa
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
