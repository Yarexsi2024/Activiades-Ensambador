// Fecha: 12/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que cuenta los bits activados (bits en 1) en un número.

// Equivalente en C#:
/*
using System;

class Program {
    static int ContarBitsActivados(int num) {
        int contador = 0;
        while (num != 0) {
            contador += num & 1;  // Incrementar contador si el bit menos significativo es 1
            num >>= 1;            // Desplazar a la derecha
        }
        return contador;
    }

    static void Main() {
        int num = 29;  // 29 en binario es 11101, tiene 4 bits activados
        int resultado = ContarBitsActivados(num);
        Console.WriteLine("Número de bits activados: " + resultado);
    }
}
*/

.section .data
num: .word 29                      // Número a analizar (11101 en binario)
msg_resultado: .asciz "Número de bits activados: %d\n"

.section .text
.global _start

_start:
    ldr w1, num                    // Cargar el número en w1
    mov w2, 0                      // Inicializar el contador de bits activados a 0

contar_bits:
    cmp w1, 0                      // Comprobar si el número es 0
    beq imprimir_resultado         // Si es 0, saltar a imprimir el resultado

    and w3, w1, 1                  // Comprobar el bit menos significativo (w1 & 1)
    add w2, w2, w3                 // Incrementar el contador si es 1
    lsr w1, w1, 1                  // Desplazar w1 a la derecha por 1 bit

    b contar_bits                  // Repetir el ciclo hasta que w1 sea 0

imprimir_resultado:
    mov x0, w2                     // Pasar el contador de bits activados a x0 para printf
    ldr x1, =msg_resultado         // Cargar el mensaje de impresión en x1
    bl printf                      // Imprimir el resultado

    // Salir del programa
    mov x8, 93                     // Código de syscall para exit
    mov x0, 0                      // Estado de salida
    svc 0                          // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
