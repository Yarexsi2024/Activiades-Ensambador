// Fecha: 12/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que realiza operaciones AND, OR y XOR a nivel de bits.

// Equivalente en C#:
/*
using System;

class Program {
    static void OperacionesBitwise(int a, int b) {
        int resultadoAND = a & b;
        int resultadoOR = a | b;
        int resultadoXOR = a ^ b;

        Console.WriteLine("AND: " + resultadoAND);
        Console.WriteLine("OR: " + resultadoOR);
        Console.WriteLine("XOR: " + resultadoXOR);
    }

    static void Main() {
        int a = 12;  // 1100 en binario
        int b = 5;   // 0101 en binario
        OperacionesBitwise(a, b);
    }
}
*/

.section .data
a: .word 12                          // Primer operando (1100 en binario)
b: .word 5                           // Segundo operando (0101 en binario)
msg_and: .asciz "AND: %d\n"
msg_or: .asciz "OR: %d\n"
msg_xor: .asciz "XOR: %d\n"

.section .text
.global _start

_start:
    // Cargar los operandos
    ldr w1, a                        // Cargar el valor de 'a' en w1
    ldr w2, b                        // Cargar el valor de 'b' en w2

    // Operación AND
    and w3, w1, w2                   // w3 = w1 AND w2
    mov x0, w3                       // Pasar el resultado a x0 para printf
    ldr x1, =msg_and                 // Cargar el mensaje de AND en x1
    bl printf                        // Imprimir el resultado de AND

    // Operación OR
    orr w4, w1, w2                   // w4 = w1 OR w2
    mov x0, w4                       // Pasar el resultado a x0 para printf
    ldr x1, =msg_or                  // Cargar el mensaje de OR en x1
    bl printf                        // Imprimir el resultado de OR

    // Operación XOR
    eor w5, w1, w2                   // w5 = w1 XOR w2
    mov x0, w5                       // Pasar el resultado a x0 para printf
    ldr x1, =msg_xor                 // Cargar el mensaje de XOR en x1
    bl printf                        // Imprimir el resultado de XOR

    // Salir del programa
    mov x8, 93                       // Código de syscall para exit
    mov x0, 0                        // Estado de salida
    svc 0                            // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
