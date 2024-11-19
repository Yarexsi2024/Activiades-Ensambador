// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Programa que encuentra el segundo elemento más grande en un arreglo.

// Equivalente en C#:
// /*
// using System;
// class Program {
//     static int SegundoMasGrande(int[] arr) {
//         if (arr.Length < 2) return -1; // No hay segundo mayor si hay menos de dos elementos
//         int max1 = int.MinValue, max2 = int.MinValue;
//         for (int i = 0; i < arr.Length; i++) {
//             if (arr[i] > max1) {
//                 max2 = max1;
//                 max1 = arr[i];
//             } else if (arr[i] > max2 && arr[i] != max1) {
//                 max2 = arr[i];
//             }
//         }
//         return max2;
//     }
// 
//     static void Main() {
//         int[] arr = {1, 5, 3, 9, 7};
//         int resultado = SegundoMasGrande(arr);
//         Console.WriteLine("El segundo elemento más grande es: " + resultado);
//     }
// }
// */

.section .data
arreglo: .word 1, 5, 3, 9, 7      // Definir el arreglo
longitud: .word 5                 // Tamaño del arreglo
msg_resultado: .asciz "El segundo elemento más grande es: %d\n"
no_segundo: .asciz "No hay suficiente elementos para determinar el segundo mayor.\n"

.section .text
.global _start

_start:
    // Cargar la longitud del arreglo en w1
    ldr w1, longitud              // w1 = longitud del arreglo
    cmp w1, 1                     // Comprobar si hay al menos 2 elementos
    ble no_segundo_mostrar        // Si longitud <= 1, mostrar mensaje y salir

    // Inicializar max1 y max2
    mov w2, 0x80000000            // max1 = int.MinValue
    mov w3, 0x80000000            // max2 = int.MinValue
    mov w4, 0                     // Índice (i)

buscar_segundo_mas_grande:
    cmp w4, w1                    // Comparar i con la longitud
    bge imprimir_resultado        // Si i >= longitud, ir a imprimir resultado

    ldr w5, [x0, w4, lsl #2]      // Cargar arr[i] en w5

    cmp w5, w2                    // Comparar arr[i] con max1
    ble comprobar_max2            // Si arr[i] <= max1, comprobar max2

    // Actualizar max1 y max2
    mov w3, w2                    // max2 = max1
    mov w2, w5                    // max1 = arr[i]
    b siguiente_elemento          // Saltar al siguiente elemento

comprobar_max2:
    cmp w5, w3                    // Comparar arr[i] con max2
    ble siguiente_elemento        // Si arr[i] <= max2, continuar
    cmp w5, w2                    // Comprobar si arr[i] es igual a max1
    beq siguiente_elemento        // Si es igual a max1, continuar

    // Actualizar max2
    mov w3, w5                    // max2 = arr[i]

siguiente_elemento:
    add w4, w4, 1                 // Incrementar i
    b buscar_segundo_mas_grande   // Repetir para el siguiente elemento

imprimir_resultado:
    cmp w3, 0x80000000            // Comprobar si max2 sigue siendo int.MinValue
    beq no_segundo_mostrar        // Si es así, no hay segundo mayor

    mov x0, w3                    // Pasar max2 a x0 para printf
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión en x1
    bl printf                     // Imprimir el resultado
    b salir                       // Salir

no_segundo_mostrar:
    ldr x1, =no_segundo           // Cargar el mensaje de error en x1
    bl printf                     // Imprimir el mensaje de error

salir:
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall
