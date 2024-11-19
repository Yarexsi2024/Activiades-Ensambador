// Fecha: 12/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que manipula bits específicos de un número: establecer, borrar y alternar bits.

// Equivalente en C#:
/*
using System;

class Program {
    static void ManipularBits(int num, int posicion) {
        // Establecer el bit en la posición (bitwise OR)
        int establecer = num | (1 << posicion);
        // Borrar el bit en la posición (bitwise AND con NOT)
        int borrar = num & ~(1 << posicion);
        // Alternar el bit en la posición (bitwise XOR)
        int alternar = num ^ (1 << posicion);

        Console.WriteLine("Establecer bit: " + establecer);
        Console.WriteLine("Borrar bit: " + borrar);
        Console.WriteLine("Alternar bit: " + alternar);
    }

    static void Main() {
        int num = 12;  // 1100 en binario
        int posicion = 1;
        ManipularBits(num, posicion);
    }
}
*/

.section .data
num: .word 12                       // Número base (1100 en binario)
posicion: .word 1                   // Posición del bit a manipular
msg_establecer: .asciz "Establecer bit: %d\n"
msg_borrar: .asciz "Borrar bit: %d\n"
msg_alternar: .asciz "Alternar bit: %d\n"

.section .text
.global _start

_start:
    // Cargar el número y la posición
    ldr w1, num                     // Cargar el número en w1
    ldr w2, posicion                // Cargar la posición en w2

    // Establecer el bit (OR)
    mov w3, 1                       // Preparar 1
    lsl w3, w3, w2                  // Desplazar 1 a la izquierda por 'posicion' bits
    orr w4, w1, w3                  // w4 = w1 | (1 << posicion) - Establecer el bit
    mov x0, w4                      // Pasar el resultado a x0 para printf
    ldr x1, =msg_establecer         // Cargar el mensaje de establecer en x1
    bl printf                       // Imprimir el resultado de establecer

    // Borrar el bit (AND con NOT)
    mvn w3, w3                      // Negar el valor (NOT)
    and w5, w1, w3                  // w5 = w1 & ~(1 << posicion) - Borrar el bit
    mov x0, w5                      // Pasar el resultado a x0 para printf
    ldr x1, =msg_borrar             // Cargar el mensaje de borrar en x1
    bl printf                       // Imprimir el resultado de borrar

    // Alternar el bit (XOR)
    eor w6, w1, w3                  // w6 = w1 ^ (1 << posicion) - Alternar el bit
    mov x0, w6                      // Pasar el resultado a x0 para printf
    ldr x1, =msg_alternar           // Cargar el mensaje de alternar en x1
    bl printf                       // Imprimir el resultado de alternar

    // Salir del programa
    mov x8, 93                      // Código de syscall para exit
    mov x0, 0                       // Estado de salida
    svc 0                           // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
