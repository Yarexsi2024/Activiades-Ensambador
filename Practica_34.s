// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Programa que invierte los elementos de un arreglo.

// Equivalente en C#:
// /*
// using System;
// class Program {
//     static void InvertirArreglo(int[] arr) {
//         int temp;
//         for (int i = 0, j = arr.Length - 1; i < j; i++, j--) {
//             temp = arr[i];
//             arr[i] = arr[j];
//             arr[j] = temp;
//         }
//     }
// 
//     static void Main() {
//         int[] arr = {1, 2, 3, 4, 5};
//         InvertirArreglo(arr);
//         Console.WriteLine("Arreglo invertido: " + string.Join(", ", arr));
//     }
// }
// */

.section .data
arreglo: .word 1, 2, 3, 4, 5      // Definir el arreglo de 5 elementos
longitud: .word 5                 // Tamaño del arreglo
msg_resultado: .asciz "Arreglo invertido: "

.section .text
.global _start

_start:
    // Cargar la longitud del arreglo en w1
    ldr w1, longitud              // w1 = longitud del arreglo
    sub w1, w1, 1                 // w1 = longitud - 1 (índice máximo)
    mov w2, 0                     // Inicializar índice i en w2 (comienza en 0)

invertir_arreglo:
    cmp w2, w1                    // Comparar i con j
    bge imprimir_arreglo          // Si i >= j, fin del intercambio

    // Intercambiar arr[i] y arr[j]
    ldr w3, [x0, w2, lsl #2]      // Cargar arr[i] en w3
    ldr w4, [x0, w1, lsl #2]      // Cargar arr[j] en w4
    str w4, [x0, w2, lsl #2]      // Guardar arr[j] en arr[i]
    str w3, [x0, w1, lsl #2]      // Guardar arr[i] en arr[j]

    add w2, w2, 1                 // Incrementar i
    sub w1, w1, 1                 // Decrementar j

    b invertir_arreglo            // Repetir hasta que i >= j

imprimir_arreglo:
    // Código para imprimir los elementos del arreglo
    ldr w1, longitud              // Recargar longitud
    mov w2, 0                     // Reiniciar índice a 0
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión
    bl printf                     // Imprimir el mensaje

    print_elemento:
        cmp w2, w1                // Comparar índice con la longitud
        bge salir                 // Si índice >= longitud, terminar

        ldr w3, [x0, w2, lsl #2]  // Cargar elemento del arreglo en w3
        mov x0, w3                // Pasar el elemento a x0 para printf
        bl printf_elemento        // Imprimir elemento (implementa printf)

        add w2, w2, 1             // Incrementar índice
        b print_elemento          // Repetir para el siguiente elemento

salir:
    // Salir del programa
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall

// Subrutina o macro que imprime un elemento (ejemplo simplificado)
printf_elemento:
    // Implementa impresión del elemento y formato (agregar soporte si es necesario)
    ret
