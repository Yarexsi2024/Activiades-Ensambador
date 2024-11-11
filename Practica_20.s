// Fecha: 11/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que realiza la multiplicación de dos matrices 3x3.

// Equivalente en C#:
/*
using System;

class Program {
    static void MultiplicarMatrices(int[,] matrizA, int[,] matrizB, int[,] resultado) {
        int filas = matrizA.GetLength(0);
        int columnas = matrizB.GetLength(1);
        int n = matrizA.GetLength(1);

        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < columnas; j++) {
                resultado[i, j] = 0;
                for (int k = 0; k < n; k++) {
                    resultado[i, j] += matrizA[i, k] * matrizB[k, j];
                }
            }
        }
    }

    static void Main() {
        int[,] matrizA = { {1, 2, 3}, {4, 5, 6}, {7, 8, 9} };
        int[,] matrizB = { {9, 8, 7}, {6, 5, 4}, {3, 2, 1} };
        int[,] resultado = new int[3, 3];
        
        MultiplicarMatrices(matrizA, matrizB, resultado);
        
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
filas: .word 3                                   // Número de filas en A
columnas: .word 3                                // Número de columnas en B
n_comun: .word 3                                 // Dimensión común para la multiplicación
msg_resultado: .asciz "Matriz Resultado:\n"

.section .text
.global _start

_start:
    ldr w3, =filas                               // Cargar número de filas en w3
    ldr w4, =columnas                            // Cargar número de columnas en w4
    ldr w5, =n_comun                             // Cargar dimensión común en w5
    ldr x0, =matrizA                             // Dirección de matrizA en x0
    ldr x1, =matrizB                             // Dirección de matrizB en x1
    ldr x2, =resultado                           // Dirección de matriz resultado en x2

    mov w6, 0                                    // i = 0, contador de filas de A

ciclo_filas:
    cmp w6, w3                                   // Comparar i con el número de filas
    bge imprimir_matriz                          // Si i >= filas, pasar a imprimir la matriz resultado

    mov w7, 0                                    // j = 0, contador de columnas de B

ciclo_columnas:
    cmp w7, w4                                   // Comparar j con el número de columnas
    bge fin_columna                              // Si j >= columnas, salir del ciclo de columnas

    // Inicializar resultado[i][j] = 0
    mul w8, w6, w4                               // índice_fila = i * columnas
    add w8, w8, w7                               // índice_total = índice_fila + j
    str wzr, [x2, w8, LSL #2]                    // resultado[i][j] = 0

    mov w9, 0                                    // k = 0, contador para la dimensión común

ciclo_interno:
    cmp w9, w5                                   // Comparar k con la dimensión común
    bge fin_interno                              // Si k >= n, fin del ciclo interno

    // Cargar elementos de matrizA y matrizB
    mul w10, w6, w5                              // índice_A = i * n_comun
    add w10, w10, w9                             // índice_total_A = índice_A + k
    ldr w11, [x0, w10, LSL #2]                   // w11 = matrizA[i][k]

    mul w12, w9, w4                              // índice_B = k * columnas
    add w12, w12, w7                             // índice_total_B = índice_B + j
    ldr w13, [x1, w12, LSL #2]                   // w13 = matrizB[k][j]

    // Multiplicar y acumular en resultado[i][j]
    mul w14, w11, w13                            // w14 = matrizA[i][k] * matrizB[k][j]
    ldr w15, [x2, w8, LSL #2]                    // Cargar resultado[i][j]
    add w15, w15, w14                            // resultado[i][j] += w14
    str w15, [x2, w8, LSL #2]                    // Guardar nuevo resultado[i][j]

    // Incrementar k
    add w9, w9, 1                                // k++
    b ciclo_interno                              // Repetir ciclo interno

fin_interno:
    add w7, w7, 1                                // j++
    b ciclo_columnas                             // Repetir ciclo de columnas

fin_columna:
    add w6, w6, 1                                // i++
    b ciclo_filas                                // Repetir ciclo de filas

imprimir_matriz:
    ldr x0, =msg_resultado                       // Mensaje de inicio de impresión
    bl printf                                    // Imprimir mensaje

    mov w6, 0                                    // Reiniciar i = 0 para impresión

imprimir_filas:
    cmp w6, w3                                   // Verificar si i < filas
    bge fin                                      // Si i >= filas, terminar el programa

    mov w7, 0                                    // Reiniciar j = 0 para impresión de columnas

imprimir_columnas:
    cmp w7, w4                                   // Verificar si j < columnas
    bge fin_fila                                 // Si j >= columnas, ir a la siguiente fila

    // Obtener elemento de resultado
    mul w8, w6, w4                               // índice_fila = i * columnas
    add w8, w8, w7                               // índice_total = índice_fila + j
    ldr w9, [x2, w8, LSL #2]                     // Cargar resultado[i][j] en w9
    mov x0, w9                                   // Pasar valor a x0 para impresión
    bl printf                                    // Imprimir elemento
    
    add w7, w7, 1                                // j++
    b imprimir_columnas                          // Repetir ciclo de columnas

fin_fila:
    bl printf                                    // Imprimir salto de línea
    add w6, w6, 1                                // i++
    b imprimir_filas                             // Repetir ciclo de filas

fin:
    mov x8, 93                                   // Syscall para salir
    mov x0, 0                                    // Estado de salida
    svc 0
