// Fecha: 11/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que realiza una búsqueda binaria recursiva en un arreglo ordenado.


// Equivalente en C#:
/*
using System;

class Program {
    static int BusquedaBinaria(int[] arreglo, int elemento, int inicio, int fin) {
        if (inicio > fin) {
            return -1; // Elemento no encontrado
        }
        int medio = inicio + (fin - inicio) / 2;
        if (arreglo[medio] == elemento) {
            return medio; // Elemento encontrado
        } else if (arreglo[medio] > elemento) {
            return BusquedaBinaria(arreglo, elemento, inicio, medio - 1);
        } else {
            return BusquedaBinaria(arreglo, elemento, medio + 1, fin);
        }
    }

    static void Main() {
        int[] arreglo = {2, 3, 5, 7, 8}; // Arreglo ordenado
        int elemento = 7;
        int indice = BusquedaBinaria(arreglo, elemento, 0, arreglo.Length - 1);
        if (indice != -1) {
            Console.WriteLine("Elemento encontrado en el índice: " + indice);
        } else {
            Console.WriteLine("Elemento no encontrado.");
        }
    }
}
*/


.section .data
arreglo: .word 2, 3, 5, 7, 8  // Arreglo de ejemplo (ordenado)
n_elementos: .word 5          // Número de elementos en el arreglo
elemento_buscar: .word 7      // Elemento a buscar
msg_encontrado: .asciz "Elemento encontrado en el índice: %d\n"
msg_no_encontrado: .asciz "Elemento no encontrado.\n"

.section .text
.global _start

_start:
    ldr w1, n_elementos        // Cargar el número de elementos en w1
    sub w1, w1, 1              // Calcular el índice máximo (n_elementos - 1)
    ldr x0, =arreglo           // Cargar la dirección del arreglo en x0
    ldr w2, elemento_buscar    // Cargar el elemento a buscar en w2
    mov w3, 0                  // Inicializar índice de inicio (w3 = 0)

    bl busqueda_binaria        // Llamar a la función de búsqueda binaria

    // Comprobar resultado
    cmp w0, -1                 // Si el resultado es -1, no se encontró el elemento
    beq no_encontrado

    // Imprimir índice del elemento encontrado
    ldr x1, =msg_encontrado    // Cargar el mensaje en x1
    bl printf
    b fin

no_encontrado:
    // Imprimir "Elemento no encontrado"
    ldr x0, =msg_no_encontrado
    bl printf

fin:
    // Salir del programa
    mov x8, 93                 // Código de syscall para exit
    mov x0, 0                  // Estado de salida
    svc 0                      // Invocar syscall

// Función de búsqueda binaria recursiva
// Parámetros: x0 = dirección del arreglo, w2 = elemento a buscar, w3 = inicio, w1 = fin
busqueda_binaria:
    cmp w3, w1                 // Comprobar si inicio > fin
    bgt no_encontrado_recursivo // Si inicio > fin, elemento no encontrado

    // Calcular índice medio: medio = inicio + (fin - inicio) / 2
    sub w4, w1, w3             // w4 = fin - inicio
    lsr w4, w4, 1              // w4 = (fin - inicio) / 2
    add w4, w4, w3             // w4 = inicio + (fin - inicio) / 2 (índice medio)

    // Comparar elemento en la posición medio con el elemento a buscar
    ldr w5, [x0, w4, LSL #2]   // Cargar arreglo[medio] en w5
    cmp w5, w2                 // Comparar arreglo[medio] con el elemento a buscar
    beq encontrado             // Si son iguales, ir a encontrado

    // Si arreglo[medio] > elemento, buscar en la mitad izquierda
    bgt buscar_izquierda

    // Si arreglo[medio] < elemento, buscar en la mitad derecha
    add w3, w4, 1              // inicio = medio + 1
    b busqueda_binaria         // Llamada recursiva

buscar_izquierda:
    sub w1, w4, 1              // fin = medio - 1
    b busqueda_binaria         // Llamada recursiva

encontrado:
    mov w0, w4                 // Retornar índice encontrado
    ret

no_encontrado_recursivo:
    mov w0, -1                 // Retornar -1 (no encontrado)
    ret
