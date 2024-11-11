// Fecha: 11/11/25
// Autor: Tu Nombre
// Descripción: Programa que realiza una búsqueda lineal en un arreglo.

// Equivalente en C#:
/*
using System;

class Program {
    static int BuscarElemento(int[] arreglo, int elemento) {
        for (int i = 0; i < arreglo.Length; i++) {
            if (arreglo[i] == elemento) {
                return i; // Retorna el índice del elemento encontrado
            }
        }
        return -1; // Retorna -1 si no se encuentra el elemento
    }

    static void Main() {
        int[] arreglo = {3, 5, 7, 2, 8};
        int elemento = 7;
        int indice = BuscarElemento(arreglo, elemento);
        if (indice != -1) {
            Console.WriteLine("Elemento encontrado en el índice: " + indice);
        } else {
            Console.WriteLine("Elemento no encontrado.");
        }
    }
}
*/

.section .data
arreglo: .word 3, 5, 7, 2, 8   // Arreglo de ejemplo
n_elementos: .word 5           // Número de elementos en el arreglo
elemento_buscar: .word 7       // Elemento a buscar
msg_encontrado: .asciz "Elemento encontrado en el índice: %d\n"
msg_no_encontrado: .asciz "Elemento no encontrado.\n"

.section .text
.global _start

_start:
    ldr w1, n_elementos        // Cargar el número de elementos en w1
    ldr x0, =arreglo           // Cargar la dirección del arreglo en x0
    ldr w3, elemento_buscar    // Cargar el elemento a buscar en w3
    mov w2, 0                  // Inicializar el índice a 0

buscar_elemento:
    cbz w1, no_encontrado      // Si no quedan más elementos, ir a no_encontrado

    ldr w4, [x0], #4           // Cargar el siguiente elemento en w4 y avanzar el puntero
    cmp w4, w3                 // Comparar el elemento actual con el elemento a buscar
    beq encontrado             // Si son iguales, ir a encontrado

    add w2, w2, 1              // Incrementar el índice
    sub w1, w1, 1              // Decrementar el número de elementos restantes
    b buscar_elemento          // Repetir el ciclo

encontrado:
    // Imprimir el índice del elemento encontrado
    mov x0, w2                 // Pasar el índice a x0 para printf
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

// Funciones auxiliares (como printf) se deben agregar o importar
