// Fecha: 12/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que transpone una matriz de tamaño fijo y la imprime.

// Equivalente en C#:
/*
using System;

class Program {
    static void TransponerMatriz(int[,] matriz, int filas, int columnas) {
        int[,] transpuesta = new int[columnas, filas];
        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < columnas; j++) {
                transpuesta[j, i] = matriz[i, j];
            }
        }
        // Imprimir la matriz transpuesta
        for (int i = 0; i < columnas; i++) {
            for (int j = 0; j < filas; j++) {
                Console.Write(transpuesta[i, j] + " ");
            }
            Console.WriteLine();
        }
    }

    static void Main() {
        int[,] matriz = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        TransponerMatriz(matriz, 3, 3);
    }
}
*/

.section .data
matriz: .word 1, 2, 3, 4, 5, 6, 7, 8, 9  // Matriz de 3x3 almacenada en forma lineal
filas: .word 3                          // Número de filas
columnas: .word 3                       // Número de columnas
msg_elemento: .asciz "%d "
msg_nueva_linea: .asciz "\n"

.section .bss
transpuesta: .space 36                  // Espacio para la matriz transpuesta (3x3 = 9 elementos de 4 bytes cada uno)

.section .text
.global _start

_start:
    ldr w1, filas                       // Cargar el número de filas en w1
    ldr w2, columnas                    // Cargar el número de columnas en w2
    ldr x0, =matriz                     // Cargar la dirección de la matriz original en x0
    ldr x3, =transpuesta                // Cargar la dirección de la matriz transpuesta en x3

    // Ciclo externo: for (int i = 0; i < filas; i++)
    mov w4, 0                           // i = 0

ciclo_externo:
    cmp w4, w1                          // Comparar i con filas
    bge imprimir_matriz                 // Si i >= filas, fin del ciclo externo

    // Ciclo interno: for (int j = 0; j < columnas; j++)
    mov w5, 0                           // j = 0

ciclo_interno:
    cmp w5, w2                          // Comparar j con columnas
    bge fin_ciclo_interno               // Si j >= columnas, salir del ciclo interno

    // transpuesta[j, i] = matriz[i, j]
    mul w6, w5, w1                      // Calcular el índice de transpuesta[j, i] => j * filas
    add w6, w6, w4                      // Índice completo para transpuesta[j, i] => j * filas + i
    ldr w7, [x0, w4, LSL #2]            // Cargar matriz[i, j] en w7
    str w7, [x3, w6, LSL #2]            // Guardar en transpuesta[j, i]

    add w5, w5, 1                       // j++
    b ciclo_interno                     // Repetir el ciclo interno

fin_ciclo_interno:
    add w4, w4, 1                       // i++
    b ciclo_externo                     // Repetir el ciclo externo

imprimir_matriz:
    // Imprimir la matriz transpuesta
    mov w4, 0                           // i = 0

imprimir_fila:
    cmp w4, w2                          // Comparar i con columnas
    bge fin                             // Si i >= columnas, fin de impresión

    mov w5, 0                           // j = 0
imprimir_columna:
    cmp w5, w1                          // Comparar j con filas
    bge nueva_linea                     // Si j >= filas, imprimir nueva línea

    mul w6, w4, w1                      // Calcular índice de transpuesta[i, j] => i * filas
    add w6, w6, w5                      // Índice completo => i * filas + j
    ldr w7, [x3, w6, LSL #2]            // Cargar transpuesta[i, j] en w7
    mov x0, w7                          // Pasar el valor a x0 para printf
    ldr x1, =msg_elemento               // Cargar el formato de impresión en x1
    bl printf                           // Imprimir el elemento

    add w5, w5, 1                       // j++
    b imprimir_columna                  // Repetir la impresión de la columna

nueva_linea:
    ldr x0, =msg_nueva_linea            // Cargar el mensaje de nueva línea en x0
    bl printf                           // Imprimir nueva línea
    add w4, w4, 1                       // i++
    b imprimir_fila                     // Repetir la impresión de la fila

fin:
    // Salir del programa
    mov x8, 93                          // Código de syscall para exit
    mov x0, 0                           // Estado de salida
    svc 0                               // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
