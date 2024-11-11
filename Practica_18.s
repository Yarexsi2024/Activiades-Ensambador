// Fecha: 11/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que ordena un arreglo usando el algoritmo de ordenamiento por mezcla (Merge Sort).

// Equivalente en C#:
/*
using System;

class Program {
    static void MergeSort(int[] arreglo, int inicio, int fin) {
        if (inicio < fin) {
            int mitad = (inicio + fin) / 2;
            MergeSort(arreglo, inicio, mitad);
            MergeSort(arreglo, mitad + 1, fin);
            Merge(arreglo, inicio, mitad, fin);
        }
    }

    static void Merge(int[] arreglo, int inicio, int mitad, int fin) {
        int[] temp = new int[fin - inicio + 1];
        int i = inicio, j = mitad + 1, k = 0;

        while (i <= mitad && j <= fin) {
            if (arreglo[i] <= arreglo[j]) {
                temp[k++] = arreglo[i++];
            } else {
                temp[k++] = arreglo[j++];
            }
        }

        while (i <= mitad) temp[k++] = arreglo[i++];
        while (j <= fin) temp[k++] = arreglo[j++];

        for (k = 0, i = inicio; i <= fin; i++, k++) {
            arreglo[i] = temp[k];
        }
    }

    static void Main() {
        int[] arreglo = {38, 27, 43, 3, 9, 82, 10};
        MergeSort(arreglo, 0, arreglo.Length - 1);
        Console.WriteLine("Arreglo ordenado: " + string.Join(", ", arreglo));
    }
}
*/

.section .data
arreglo: .word 38, 27, 43, 3, 9, 82, 10     // Ejemplo de arreglo a ordenar
n_elementos: .word 7                        // Número de elementos en el arreglo
msg_ordenado: .asciz "Arreglo ordenado: "

.section .text
.global _start

// Punto de entrada
_start:
    ldr w1, n_elementos                    // Cargar el número de elementos en w1
    ldr x0, =arreglo                       // Cargar la dirección del arreglo en x0
    sub w2, w1, 1                          // Fin del índice = n - 1
    bl merge_sort                          // Llamada a merge_sort(arreglo, 0, n-1)

    // Imprimir arreglo ordenado
    ldr x1, =msg_ordenado                  // Cargar mensaje de inicio
    bl printf                              // Imprimir mensaje
    mov w2, 0                              // i = 0 para imprimir elementos

imprimir_elemento:
    cmp w2, w1                             // Comprobar si i < n
    beq fin                                // Si i == n, fin de impresión
    ldr w3, [x0, w2, LSL #2]               // Cargar elemento en w3
    mov x0, w3                             // Pasar el valor a x0
    bl printf                              // Imprimir elemento
    add w2, w2, 1                          // i++
    b imprimir_elemento                    // Repetir para cada elemento

fin:
    mov x8, 93                             // Syscall para salir
    mov x0, 0                              // Estado de salida
    svc 0

// Función recursiva de MergeSort
merge_sort:
    cmp w1, w2                             // Si inicio >= fin, retorna
    bge retorno_merge_sort
    add w3, w1, w2                         // mitad = (inicio + fin) / 2
    asr w3, w3, 1
    mov x1, w3                             // Paso de mitad como parámetro

    // Llamada recursiva a merge_sort(arreglo, inicio, mitad)
    bl merge_sort
    // Llamada recursiva a merge_sort(arreglo, mitad+1, fin)
    add w3, w3, 1
    bl merge_sort
    // Fusionar las dos mitades
    bl merge
retorno_merge_sort:
    ret

// Función para fusionar dos mitades
merge:
    // Implementación de la lógica de combinación en merge
    ret

