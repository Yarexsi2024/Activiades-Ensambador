// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Programa que convierte un número decimal a binario y muestra el resultado.

// Equivalente en C#:
// /*
// using System;
// class Program {
//     static void DecimalABinario(int num) {
//         if (num == 0) {
//             Console.WriteLine("0");
//             return;
//         }
//         string binario = "";
//         while (num > 0) {
//             binario = (num % 2) + binario;
//             num /= 2;
//         }
//         Console.WriteLine(binario);
//     }
// 
//     static void Main() {
//         int num = 23;
//         DecimalABinario(num);
//     }
// }
// */

.section .data
numero: .word 23                 // Número a convertir a binario
msg_resultado: .asciz "El número en binario es: "
buffer: .space 32                // Espacio para almacenar la representación binaria (máx 32 bits)

.section .text
.global _start

_start:
    ldr w1, numero               // Cargar el número decimal en w1
    cmp w1, 0                    // Comprobar si el número es 0
    bne convertir_a_binario      // Si no es 0, proceder con la conversión

    // Imprimir "0" si el número es 0
    mov x0, '0'                  // Carácter '0'
    bl putchar                   // Imprimir '0'
    b salir                      // Ir a la salida

convertir_a_binario:
    mov w2, 0                    // Índice para el buffer, comenzando desde 0

conversion_loop:
    udiv w3, w1, 2               // Dividir el número por 2 (cociente)
    msub w4, w3, 2, w1           // Calcular el resto (w4 = w1 % 2)
    add w4, w4, '0'              // Convertir el resto a carácter ('0' o '1')

    strb w4, [x0, w2]            // Almacenar el carácter en el buffer
    add w2, w2, 1                // Incrementar el índice del buffer

    mov w1, w3                   // Actualizar w1 con el cociente
    cmp w1, 0                    // Comprobar si el cociente es 0
    bne conversion_loop          // Si no es 0, repetir

    // Imprimir el mensaje
    ldr x1, =msg_resultado       // Cargar el mensaje de impresión en x1
    bl printf                    // Imprimir el mensaje

imprimir_binario:
    sub w2, w2, 1                // Ajustar índice para imprimir desde el último carácter

print_loop:
    ldrb w3, [x0, w2]            // Cargar el carácter desde el buffer
    mov x0, w3                   // Pasar el carácter a x0 para putchar
    bl putchar                   // Imprimir el carácter

    subs w2, w2, 1               // Decrementar el índice
    bge print_loop               // Repetir hasta llegar al primer carácter

salir:
    mov x8, 93                   // Código de syscall para exit
    mov x0, 0                    // Estado de salida
    svc 0                        // Invocar syscall

// Función putchar: imprime un carácter (implementación simplificada)
putchar:
    // Implementación de impresión de un solo carácter usando syscall u otro método
    ret
