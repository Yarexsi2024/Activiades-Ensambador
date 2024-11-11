// Fecha: 11/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que ordena un arreglo usando el algoritmo de ordenamiento por selección.

// Equivalente en C#:
/*
using System;

class Program {
    static void OrdenamientoSeleccion(int[] arreglo) {
        int n = arreglo.Length;
        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (arreglo[j] < arreglo[minIndex]) {
                    minIndex = j;
                }
            }
            // Intercambiar arreglo[i] y arreglo[minIndex]
            int temp = arreglo[i];
            arreglo[i] = arreglo[minIndex];
            arreglo[minIndex] = temp;
        }
    }

    static void Main() {
        int[] arreglo = {5, 2, 9, 1, 5, 6};
        OrdenamientoSeleccion(arreglo);
        Console.WriteLine("Arreglo ordenado: " + string.Join(", ", arreglo));
    }
}
*/

.section .data
arreglo: .word 5, 2, 9, 1, 5, 6  // Arreglo de ejemplo
n_elementos: .word 6             // Número de elementos en el arreglo
msg_ordenado: .asciz "Arreglo ordenado: "

.section .text
.global _start

_start:
    ldr w1, n_elementos          // Cargar el número de elementos en w1
    ldr x0, =arreglo             // Cargar la dirección del arreglo en x0

    // Ciclo externo: for (int i = 0; i < n - 1; i++)
    mov w2, 0                    // i = 0

ciclo_externo:
    sub w3, w1, 1                // w3 = n - 1
    cmp w2, w3                   // Comparar i con n - 1
    bge imprimir_arreglo         // Si i >= n - 1, fin del ciclo externo

    mov w4, w2                   // minIndex = i

    // Ciclo interno: for (int j = i + 1; j < n; j++)
    add w5, w2, 1                // j = i + 1

ciclo_interno:
    cmp w5, w1                   // Comparar j con n
    bge fin_ciclo_interno        // Si j >= n, salir del ciclo interno

    ldr w6, [x0, w4, LSL #2]     // Cargar arreglo[minIndex] en w6
    ldr w7, [x0, w5, LSL #2]     // Cargar arreglo[j] en w7
    cmp w7, w6                   // Comparar arreglo[j] con arreglo[minIndex]
    bge no_actualizar_min        // Si arreglo[j] >= arreglo[minIndex], no actualizar

    mov w4, w5                   // minIndex = j

no_actualizar_min:
    add w5, w5, 1                // j++
    b ciclo_interno              // Repetir el ciclo interno

fin_ciclo_interno:
    // Intercambiar arreglo[i] y arreglo[minIndex] si es necesario
    cmp w2, w4                   // Comparar i con minIndex
    beq no_intercambiar          // Si i == minIndex, no intercambiar

    ldr w6, [x0, w2, LSL #2]     // Cargar arreglo[i] en w6 (temp)
    ldr w7, [x0, w4, LSL #2]     // Cargar arreglo[minIndex] en w7
    str w7, [x0, w2, LSL #2]     // Guardar arreglo[minIndex] en arreglo[i]
    str w6, [x0, w4, LSL #2]     // Guardar arreglo[i] en arreglo[minIndex]

no_intercambiar:
    add w2, w2, 1                // i++
    b ciclo_externo              // Repetir el ciclo externo

imprimir_arreglo:
    // Imprimir el arreglo ordenado
    ldr x1, =msg_ordenado        // Cargar el mensaje de inicio
    bl printf

    // Imprimir cada elemento
    mov w2, 0                    // i = 0
imprimir_elemento:
    cmp w2, w1                   // Comprobar si i < n
    beq fin                      // Si i == n, fin de impresión
    ldr w3, [x0, w2, LSL #2]     // Cargar elemento en w3
    mov x0, w3                   // Pasar el valor a x0
    bl printf                    // Imprimir el elemento
    add w2, w2, 1                // i++
    b imprimir_elemento          // Repetir

fin:
    // Salir del programa
    mov x8, 93                   // Código de syscall para exit
    mov x0, 0                    // Estado de salida
    svc 0                        // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
