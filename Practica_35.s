// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Programa que rota los elementos de un arreglo hacia la izquierda.

// Equivalente en C#:
// /*
// using System;
// class Program {
//     static void RotarIzquierda(int[] arr) {
//         if (arr.Length == 0) return;
//         int temp = arr[0];
//         for (int i = 0; i < arr.Length - 1; i++) {
//             arr[i] = arr[i + 1];
//         }
//         arr[arr.Length - 1] = temp;
//     }
// 
//     static void Main() {
//         int[] arr = {1, 2, 3, 4, 5};
//         RotarIzquierda(arr);
//         Console.WriteLine("Arreglo rotado: " + string.Join(", ", arr));
//     }
// }
// */

.section .data
arreglo: .word 1, 2, 3, 4, 5      // Definir el arreglo de 5 elementos
longitud: .word 5                 // Tamaño del arreglo
msg_resultado: .asciz "Arreglo rotado: "

.section .text
.global _start

_start:
    // Cargar la longitud del arreglo en w1
    ldr w1, longitud              // w1 = longitud del arreglo
    cmp w1, 0                     // Comprobar si el arreglo está vacío
    beq salir                     // Si longitud es 0, salir del programa

    ldr w2, [x0]                  // Cargar el primer elemento en w2 (temp)

    // Desplazar los elementos hacia la izquierda
    mov w3, 0                     // Inicializar índice en 0

rotar_izquierda:
    add w4, w3, 1                 // w4 = índice + 1
    cmp w4, w1                    // Comparar w4 con la longitud
    beq almacenar_ultimo          // Si es igual a la longitud, ir a almacenar el último

    ldr w5, [x0, w4, lsl #2]      // Cargar arr[i + 1] en w5
    str w5, [x0, w3, lsl #2]      // Guardar arr[i + 1] en arr[i]

    add w3, w3, 1                 // Incrementar índice
    b rotar_izquierda             // Repetir el proceso

almacenar_ultimo:
    str w2, [x0, w1, lsl #2, -4]  // Guardar el primer elemento en la última posición

    // Imprimir el arreglo rotado
    mov w2, 0                     // Reiniciar índice para impresión
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión
    bl printf                     // Imprimir el mensaje

imprimir_elemento:
    cmp w2, w1                    // Comparar índice con la longitud
    bge salir                     // Si índice >= longitud, terminar

    ldr w3, [x0, w2, lsl #2]      // Cargar elemento del arreglo en w3
    mov x0, w3                    // Pasar el elemento a x0 para printf
    bl printf_elemento            // Imprimir elemento (implementar printf)

    add w2, w2, 1                 // Incrementar índice
    b imprimir_elemento           // Repetir para el siguiente elemento

salir:
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall

// Subrutina o macro que imprime un elemento (ejemplo simplificado)
printf_elemento:
    // Implementa impresión de elemento y formato (agregar soporte si es necesario)
    ret
