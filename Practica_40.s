// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Programa que convierte un número binario a decimal.

// Equivalente en C#:
// /*
// using System;
// class Program {
//     static int BinarioADecimal(string binario) {
//         int resultado = 0;
//         for (int i = 0; i < binario.Length; i++) {
//             resultado = resultado * 2 + (binario[i] - '0');
//         }
//         return resultado;
//     }
// 
//     static void Main() {
//         string binario = "10111";
//         int resultado = BinarioADecimal(binario);
//         Console.WriteLine("El número decimal es: " + resultado);
//     }
// }
// */

.section .data
binario: .asciz "10111"           // Cadena de bits representando el número binario
longitud: .word 5                 // Longitud de la cadena binaria
msg_resultado: .asciz "El número decimal es: %d\n"

.section .text
.global _start

_start:
    ldr x0, =binario              // Cargar la dirección de la cadena binaria en x0
    ldr w1, longitud              // Cargar la longitud de la cadena en w1
    mov w2, 0                     // Inicializar resultado a 0
    mov w3, 0                     // Inicializar índice a 0

conversion_loop:
    cmp w3, w1                    // Comparar índice con la longitud
    bge imprimir_resultado        // Si índice >= longitud, ir a imprimir resultado

    ldrb w4, [x0, w3]             // Cargar el carácter actual en w4
    sub w4, w4, '0'               // Convertir carácter a número (0 o 1)
    lsl w2, w2, 1                 // Desplazar el resultado a la izquierda (multiplicar por 2)
    add w2, w2, w4                // Sumar el bit actual al resultado

    add w3, w3, 1                 // Incrementar el índice
    b conversion_loop             // Repetir para el siguiente bit

imprimir_resultado:
    mov x0, w2                    // Pasar el resultado a x0 para printf
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión en x1
    bl printf                     // Imprimir el resultado

    // Salir del programa
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall
