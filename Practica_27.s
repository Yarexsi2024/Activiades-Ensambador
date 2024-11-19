// Fecha: 12/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que realiza desplazamientos a la izquierda y derecha en un número.

// Equivalente en C#:
/*
using System;

class Program {
    static void Desplazamientos(int num, int desplazamiento) {
        int resultadoIzquierda = num << desplazamiento;
        int resultadoDerecha = num >> desplazamiento;

        Console.WriteLine("Desplazamiento a la izquierda: " + resultadoIzquierda);
        Console.WriteLine("Desplazamiento a la derecha: " + resultadoDerecha);
    }

    static void Main() {
        int num = 12;  // 1100 en binario
        int desplazamiento = 2;
        Desplazamientos(num, desplazamiento);
    }
}
*/

.section .data
num: .word 12                       // Número a desplazar (1100 en binario)
desplazamiento: .word 2             // Número de posiciones de desplazamiento
msg_izquierda: .asciz "Desplazamiento a la izquierda: %d\n"
msg_derecha: .asciz "Desplazamiento a la derecha: %d\n"

.section .text
.global _start

_start:
    // Cargar el número y el desplazamiento
    ldr w1, num                     // Cargar el número en w1
    ldr w2, desplazamiento          // Cargar el desplazamiento en w2

    // Desplazamiento a la izquierda
    lsl w3, w1, w2                  // w3 = w1 << w2 (desplazamiento a la izquierda)
    mov x0, w3                      // Pasar el resultado a x0 para printf
    ldr x1, =msg_izquierda          // Cargar el mensaje de desplazamiento a la izquierda en x1
    bl printf                       // Imprimir el resultado

    // Desplazamiento a la derecha
    lsr w4, w1, w2                  // w4 = w1 >> w2 (desplazamiento a la derecha)
    mov x0, w4                      // Pasar el resultado a x0 para printf
    ldr x1, =msg_derecha            // Cargar el mensaje de desplazamiento a la derecha en x1
    bl printf                       // Imprimir el resultado

    // Salir del programa
    mov x8, 93                      // Código de syscall para exit
    mov x0, 0                       // Estado de salida
    svc 0                           // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
