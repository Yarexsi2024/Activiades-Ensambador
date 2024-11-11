// Fecha: 11/11/25
// Autor: Tu Nombre
// Descripción: Programa que recorre un arreglo y encuentra el valor mínimo.


// Equivalente en C#:
/*
using System;

class Program {
    static int EncontrarMinimo(int[] arreglo) {
        int minimo = arreglo[0];
        for (int i = 1; i < arreglo.Length; i++) {
            if (arreglo[i] < minimo) {
                minimo = arreglo[i];
            }
        }
        return minimo;
    }

    static void Main() {
        int[] arreglo = {3, 5, 7, 2, 8};
        int minimo = EncontrarMinimo(arreglo);
        Console.WriteLine("El mínimo es: " + minimo);
    }
}
*/

.section .data
arreglo: .word 3, 5, 7, 2, 8  // Arreglo de ejemplo
n_elementos: .word 5          // Número de elementos en el arreglo
msg_minimo: .asciz "El mínimo es: %d\n"

.section .text
.global _start

_start:
    ldr w1, n_elementos       // Cargar el número de elementos en w1
    ldr x0, =arreglo          // Cargar la dirección del arreglo en x0

    // Inicializar el mínimo con el primer elemento del arreglo
    ldr w2, [x0], #4          // Cargar el primer elemento en w2 y avanzar el puntero (x0 += 4)
    sub w1, w1, 1             // Decrementar el número de elementos restantes

recorrer_arreglo:
    cbz w1, imprimir_minimo   // Si no quedan más elementos, ir a imprimir el mínimo

    ldr w3, [x0], #4          // Cargar el siguiente elemento en w3 y avanzar el puntero
    cmp w3, w2                // Comparar el elemento actual con el mínimo actual
    bge continuar             // Si w3 >= w2, continuar sin cambios
    mov w2, w3                // Si w3 < w2, actualizar el mínimo

continuar:
    sub w1, w1, 1             // Decrementar el número de elementos restantes
    b recorrer_arreglo        // Repetir el ciclo

imprimir_minimo:
    // Imprimir el mínimo encontrado
    mov x0, x2                // Pasar el valor mínimo a x0 para printf
    ldr x1, =msg_minimo       // Cargar el mensaje en x1
    bl printf

    // Salir del programa
    mov x8, 93                // Código de syscall para exit
    mov x0, 0                 // Estado de salida
    svc 0                     // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
