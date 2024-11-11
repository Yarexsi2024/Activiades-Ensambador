

// Autor: Yarexsi Santiago De La Cruz
// Fecha: 11/11/2024
// Descripción: Programa que verifica si una cadena es un palíndromo.


// Equivalente en C#:
/*
using System;

class Program {
    static bool EsPalindromo(string cadena) {
        int longitud = cadena.Length;
        for (int i = 0; i < longitud / 2; i++) {
            if (cadena[i] != cadena[longitud - i - 1]) {
                return false; // No es palíndromo
            }
        }
        return true; // Es palíndromo
    }

    static void Main() {
        string cadena = "radar";
        if (EsPalindromo(cadena)) {
            Console.WriteLine("Es un palíndromo.");
        } else {
            Console.WriteLine("No es un palíndromo.");
        }
    }
}
*/


.section .data
cadena: .asciz "radar"        // Cadena de ejemplo
msg_palindromo: .asciz "Es un palíndromo.\n"
msg_no_palindromo: .asciz "No es un palíndromo.\n"
longitud: .word 0             // Almacena la longitud de la cadena

.section .text
.global _start

_start:
    // Calcular la longitud de la cadena (strlen)
    ldr x0, =cadena           // Cargar la dirección de la cadena en x0
    bl strlen                 // Llamada a la función strlen, devuelve en x0
    str w0, longitud          // Guardar la longitud en memoria

    // Comprobación de palíndromo
    mov w1, 0                 // Índice i = 0
    ldr w2, longitud          // Cargar la longitud en w2
    asr w2, w2, 1             // Dividir longitud entre 2 (mitad)

verificar:
    cmp w1, w2                // Comparar i con longitud/2
    bge es_palindromo         // Si i >= longitud/2, es palíndromo

    // Comparar caracteres
    ldrb w3, [x0, w1]         // Cargar caracter en la posición i
    ldr w4, longitud          // Cargar longitud
    sub w4, w4, w1            // longitud - i - 1
    sub w4, w4, 1
    ldrb w5, [x0, w4]         // Cargar caracter en longitud - i - 1

    cmp w3, w5                // Comparar los caracteres
    bne no_palindromo         // Si no son iguales, no es palíndromo

    add w1, w1, 1             // Incrementar i
    b verificar               // Repetir el ciclo

es_palindromo:
    // Imprimir "Es un palíndromo"
    ldr x0, =msg_palindromo
    bl printf
    b fin

no_palindromo:
    // Imprimir "No es un palíndromo"
    ldr x0, =msg_no_palindromo
    bl printf

fin:
    // Salir del programa
    mov x8, 93                // Código de syscall para exit
    mov x0, 0                 // Estado de salida
    svc 0                     // Invocar syscall

// Funciones auxiliares (como strlen y printf) se deben agregar o importar
