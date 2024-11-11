// Autor: Yarexsi Santiago
// Fecha: 11/11/24
// Descripción: Programa que recorre un arreglo y encuentra el valor máximo.

// Equivalente en C#:
/*
using System;

class Program {
    static int EncontrarMaximo(int[] arreglo) {
        int maximo = arreglo[0];
        for (int i = 1; i < arreglo.Length; i++) {
            if (arreglo[i] > maximo) {
                maximo = arreglo[i];
            }
        }
        return maximo;
    }

    static void Main() {
        int[] arreglo = {3, 5, 7, 2, 8};
        int maximo = EncontrarMaximo(arreglo);
        Console.WriteLine("El máximo es: " + maximo);
    }
}
*/

.section .data
arreglo: .word 3, 5, 7, 2, 8  // Arreglo de ejemplo
n_elementos: .word 5          // Número de elementos en el arreglo
msg_maximo: .asciz "El máximo es: %d\n"

.section .text
.global _start

_start:
    ldr w1, n_elementos       // Cargar el número de elementos en w1
    ldr x0, =arreglo          // Cargar la dirección del arreglo en x0

    // Inicializar el máximo con el primer elemento del arreglo
    ldr w2, [x0], #4          // Cargar el primer elemento en w2 y avanzar el puntero (x0 += 4)
    sub w1, w1, 1             // Decrementar el número de elementos restantes

recorrer_arreglo:
    cbz w1, imprimir_maximo   // Si no quedan más elementos, ir a imprimir el máximo

    ldr w3, [x0], #4          // Cargar el siguiente elemento en w3 y avanzar el puntero
    cmp w3, w2                // Comparar el elemento actual con el máximo actual
    ble continuar             // Si w3 <= w2, continuar sin cambios
    mov w2, w3                // Si w3 > w2, actualizar el máximo

continuar:
    sub w1, w1, 1             // Decrementar el número de elementos restantes
    b recorrer_arreglo        // Repetir el ciclo

imprimir_maximo:
    // Imprimir el máximo encontrado
    mov x0, x2                // Pasar el valor máximo a x0 para printf
    ldr x1, =msg_maximo       // Cargar el mensaje en x1
    bl printf

    // Salir del programa
    mov x8, 93                // Código de syscall para exit
    mov x0, 0                 // Estado de salida
    svc 0                     // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
