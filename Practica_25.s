// Fecha: 12/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que cuenta las vocales y consonantes en una cadena.

// Equivalente en C#:
/*
using System;

class Program {
    static (int, int) ContarVocalesYConsonantes(string cadena) {
        int vocales = 0, consonantes = 0;
        foreach (char c in cadena.ToLower()) {
            if (c >= 'a' && c <= 'z') {
                if ("aeiou".Contains(c)) {
                    vocales++;
                } else {
                    consonantes++;
                }
            }
        }
        return (vocales, consonantes);
    }

    static void Main() {
        string cadena = "Hola, ARM64!";
        (int vocales, int consonantes) = ContarVocalesYConsonantes(cadena);
        Console.WriteLine("Vocales: " + vocales);
        Console.WriteLine("Consonantes: " + consonantes);
    }
}
*/

.section .data
cadena: .asciz "Hola, ARM64!"          // Cadena de ejemplo
msg_vocales: .asciz "Vocales: %d\n"
msg_consonantes: .asciz "Consonantes: %d\n"
vocales: .asciz "aeiouAEIOU"            // Lista de vocales

.section .bss
contador_vocales: .word 0               // Espacio para contar vocales
contador_consonantes: .word 0           // Espacio para contar consonantes

.section .text
.global _start

_start:
    ldr x0, =cadena                     // Cargar la dirección de la cadena en x0
    mov w1, 0                           // Inicializar contador de vocales
    mov w2, 0                           // Inicializar contador de consonantes

contar_caracteres:
    ldrb w3, [x0], #1                   // Cargar el siguiente carácter en w3 y avanzar el puntero (x0 += 1)
    cmp w3, #0                          // Comprobar si el carácter es nulo (fin de cadena)
    beq imprimir_resultados             // Si es nulo, saltar a imprimir los resultados

    // Comprobar si es letra (a-z, A-Z)
    cmp w3, 'a'
    bge comprobar_vocal                 // Si w3 >= 'a', puede ser vocal o consonante
    cmp w3, 'A'
    blt contar_caracteres               // Si w3 < 'A', no es letra, seguir al siguiente carácter

comprobar_vocal:
    cmp w3, 'z'
    ble verificar_vocal
    cmp w3, 'Z'
    bgt contar_caracteres               // Si w3 > 'Z', seguir al siguiente carácter

verificar_vocal:
    ldr x4, =vocales                    // Cargar la dirección de la lista de vocales en x4
    mov w5, 0                           // Inicializar índice para la lista de vocales

comparar_vocal:
    ldrb w6, [x4, w5]                   // Cargar la vocal actual en w6
    cmp w6, #0                          // Comprobar si es el final de la lista de vocales
    beq contar_consonante               // Si es el final, no es vocal, contar como consonante
    cmp w3, w6                          // Comparar el carácter con la vocal actual
    beq incrementar_vocal               // Si es igual, incrementar contador de vocales
    add w5, w5, 1                       // Incrementar índice de la lista de vocales
    b comparar_vocal                    // Repetir la comparación

incrementar_vocal:
    add w1, w1, 1                       // Incrementar el contador de vocales
    b contar_caracteres                 // Volver al ciclo principal

contar_consonante:
    add w2, w2, 1                       // Incrementar el contador de consonantes
    b contar_caracteres                 // Volver al ciclo principal

imprimir_resultados:
    mov x0, w1                          // Pasar el contador de vocales a x0 para printf
    ldr x1, =msg_vocales                // Cargar el mensaje de vocales en x1
    bl printf                           // Imprimir el número de vocales

    mov x0, w2                          // Pasar el contador de consonantes a x0 para printf
    ldr x1, =msg_consonantes            // Cargar el mensaje de consonantes en x1
    bl printf                           // Imprimir el número de consonantes

    // Salir del programa
    mov x8, 93                          // Código de syscall para exit
    mov x0, 0                           // Estado de salida
    svc 0                               // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
