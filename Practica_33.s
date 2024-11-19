// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Programa que suma los elementos de un arreglo.

// Equivalente en C#:
// /*
// using System;
// class Program {
//     static int SumarArreglo(int[] arr) {
//         int suma = 0;
//         for (int i = 0; i < arr.Length; i++) {
//             suma += arr[i];
//         }
//         return suma;
//     }
// 
//     static void Main() {
//         int[] arr = {1, 2, 3, 4, 5};
//         int resultado = SumarArreglo(arr);
//         Console.WriteLine("La suma es: " + resultado);
//     }
// }
// */

.section .data
arreglo: .word 1, 2, 3, 4, 5      // Definir el arreglo de 5 elementos
longitud: .word 5                 // Tamaño del arreglo
msg_resultado: .asciz "La suma de los elementos es: %d\n"

.section .text
.global _start

_start:
    // Cargar la longitud del arreglo en w1
    ldr w1, longitud              // w1 = longitud del arreglo
    mov w2, 0                     // Inicializar índice (i) en w2
    mov w3, 0                     // Inicializar suma en w3

sumar_elementos:
    cmp w2, w1                    // Comparar índice con la longitud
    bge imprimir_resultado        // Si índice >= longitud, ir a imprimir resultado

    ldr w4, [x0, w2, lsl #2]      // Cargar elemento del arreglo en w4 (x0 es la base)
    add w3, w3, w4                // Sumar el elemento a w3 (suma acumulada)
    add w2, w2, 1                 // Incrementar índice

    b sumar_elementos             // Repetir hasta recorrer todo el arreglo

imprimir_resultado:
    mov x0, w3                    // Pasar la suma a x0 para printf
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión en x1
    bl printf                     // Imprimir la suma

    // Salir del programa
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall
