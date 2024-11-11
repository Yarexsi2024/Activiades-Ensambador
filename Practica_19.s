// Fecha: 11/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que realiza la suma de dos matrices 3x3.

// Equivalente en C#:
/*
using System;

class Program {
    static void SumaMatrices(int[,] matrizA, int[,] matrizB, int[,] resultado) {
        int filas = matrizA.GetLength(0);
        int columnas = matrizA.GetLength(1);

        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < columnas; j++) {
                resultado[i, j] = matrizA[i, j] + matrizB[i, j];
            }
        }
    }

    static void Main() {
        int[,] matrizA = { {1, 2, 3}, {4, 5, 6}, {7, 8, 9} };
        int[,] matrizB = { {9, 8, 7}, {6, 5, 4}, {3, 2, 1} };
        int[,] resultado = new int[3, 3];
        
        SumaMatrices(matrizA, matrizB, resultado);
        
        Console.WriteLine("Matriz Resultado:");
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                Console.Write(resultado[i, j] + " ");
            }
            Console.WriteLine();
        }
    }
}
*/

.section .data
matrizA: .word 1, 2, 3, 4, 5, 6, 7, 8, 9         // Matriz A de 3x3
matrizB: .word 9, 8, 7, 6, 5, 4, 3, 2, 1         // Matriz B de 3x3
resultado: .space 36                             // Espacio para la matriz resultado 3x3
filas: .word 3                                   // Número de filas
columnas: .word 3                                // Número de columnas
msg_resultado: .asciz "Matriz Resultado:\n"

.section .text
.global _start

_start:
    ldr w3, =filas                              // Cargar el número de filas en w3
    ldr w4, =columnas                           // Cargar el número de columnas en w4
    ldr x0, =matrizA                            // Dirección de matrizA en x0
    ldr x1, =matrizB                            // Dirección de matrizB en x1
    ldr x2, =resultado                          // Dirección de matriz resultado en x2

    mov w5, 0                                   // i = 0, contador de filas

ciclo_filas:
    cmp w5, w3                                  // Comparar i con el número de filas
    bge imprimir_matriz                         // Si i >= filas, pasar a imprimir la matriz resultado

    mov w6, 0                                   // j = 0, contador de columnas

ciclo_columnas:
    cmp w6, w4                                  // Comparar j con el número de columnas
    bge fin_columna                             // Si j >= columnas, fin del ciclo de columnas

    // Calcular índice de posición en el arreglo
    mul w7, w5, w4                              // índice_fila = i * columnas
    add w7, w7, w6                              // índice_total = índice_fila + j

    // Cargar elementos de matrizA y matrizB
    ldr w8, [x0, w7, LSL #2]                    // w8 = matrizA[i][j]
    ldr w9, [x1, w7, LSL #2]                    // w9 = matrizB[i][j]
    
    // Sumar elementos
    add w10, w8, w9                             // w10 = matrizA[i][j] + matrizB[i][j]
    
    // Guardar resultado en la matriz resultado
    str w10, [x2, w7, LSL #2]                   // resultado[i][j] = w10

    // Incrementar columna
    add w6, w6, 1                               // j++
    b ciclo_columnas                            // Repetir ciclo de columnas

fin_columna:
    add w5, w5, 1                               // i++
    b ciclo_filas                               // Repetir ciclo de filas

imprimir_matriz:
    ldr x0, =msg_resultado                      // Mensaje de inicio de impresión
    bl printf                                   // Imprimir mensaje

    mov w5, 0                                   // Reiniciar i = 0 para impresión

imprimir_filas:
    cmp w5, w3                                  // Verificar si i < filas
    bge fin                                     // Si i >= filas, terminar el programa

    mov w6, 0                                   // Reiniciar j = 0 para impresión de columnas

imprimir_columnas:
    cmp w6, w4                                  // Verificar si j < columnas
    bge fin_fila                                // Si j >= columnas, ir a la siguiente fila

    // Obtener elemento de resultado
    mul w7, w5, w4                              // índice_fila = i * columnas
    add w7, w7, w6                              // índice_total = índice_fila + j
    ldr w8, [x2, w7, LSL #2]                    // Cargar resultado[i][j] en w8
    mov x0, w8                                  // Pasar valor a x0 para impresión
    bl printf                                   // Imprimir elemento
    
    add w6, w6, 1                               // j++
    b imprimir_columnas                         // Repetir ciclo de columnas

fin_fila:
    bl printf                                   // Imprimir salto de línea
    add w5, w5, 1                               // i++
    b imprimir_filas                            // Repetir ciclo de filas

fin:
    mov x8, 93                                  // Syscall para salir
    mov x0, 0                                   // Estado de salida
    svc 0
