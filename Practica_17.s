// Fecha:11/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que ordena un arreglo usando el algoritmo de ordenamiento burbuja.


// Equivalente en C#:
/*
using System;

class Program {
    static void OrdenamientoBurbuja(int[] arreglo) {
        int n = arreglo.Length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arreglo[j] > arreglo[j + 1]) {
                    // Intercambiar arreglo[j] y arreglo[j + 1]
                    int temp = arreglo[j];
                    arreglo[j] = arreglo[j + 1];
                    arreglo[j + 1] = temp;
                }
            }
        }
    }

    static void Main() {
        int[] arreglo = {5, 2, 9, 1, 5, 6};
        OrdenamientoBurbuja(arreglo);
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
    sub w3, w1, w2               // w3 = n - i
    cmp w3, 1                    // Si w3 <= 1, fin del ciclo externo
    ble imprimir_arreglo

    // Ciclo interno: for (int j = 0; j < n - i - 1; j++)
    mov w4, 0                    // j = 0

ciclo_interno:
    sub w5, w3, 1                // w5 = n - i - 1
    cmp w4, w5                   // Comparar j con n - i - 1
    bge fin_ciclo_interno        // Si j >= n - i - 1, salir del ciclo interno

    // Comparar arreglo[j] y arreglo[j + 1]
    ldr w6, [x0, w4, LSL #2]     // Cargar arreglo[j] en w6
    ldr w7, [x0, w4, LSL #2 + 4] // Cargar arreglo[j + 1] en w7
    cmp w6, w7                   // Comparar arreglo[j] con arreglo[j + 1]
    ble no_intercambiar          // Si arreglo[j] <= arreglo[j + 1], no intercambiar

    // Intercambiar arreglo[j] y arreglo[j + 1]
    str w7, [x0, w4, LSL #2]     // Guardar arreglo[j + 1] en arreglo[j]
    str w6, [x0, w4, LSL #2 + 4] // Guardar arreglo[j] en arreglo[j + 1]

no_intercambiar:
    add w4, w4, 1                // j++
    b ciclo_interno              // Repetir el ciclo interno

fin_ciclo_interno:
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
