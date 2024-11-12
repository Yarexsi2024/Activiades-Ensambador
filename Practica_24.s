// 12/11/25
// Autor: Tu Nombre
// Descripción: Programa que calcula la longitud de una cadena de caracteres.

// Equivalente en C#:
/*
using System;

class Program {
    static int CalcularLongitud(string cadena) {
        int longitud = 0;
        while (longitud < cadena.Length && cadena[longitud] != '\0') {
            longitud++;
        }
        return longitud;
    }

    static void Main() {
        string cadena = "Hola, ARM64!";
        int longitud = CalcularLongitud(cadena);
        Console.WriteLine("La longitud de la cadena es: " + longitud);
    }
}
*/

.section .data
cadena: .asciz "Hola, ARM64!"      // Cadena de ejemplo
msg_resultado: .asciz "La longitud de la cadena es: %d\n"

.section .text
.global _start

_start:
    ldr x0, =cadena                // Cargar la dirección de la cadena en x0
    mov w1, 0                      // Inicializar el contador de longitud en 0

calcular_longitud:
    ldrb w2, [x0], #1              // Cargar el siguiente carácter en w2 y avanzar el puntero (x0 += 1)
    cmp w2, #0                     // Comprobar si el carácter es nulo (fin de cadena)
    beq imprimir_resultado         // Si es nulo, saltar a imprimir el resultado
    add w1, w1, 1                  // Incrementar el contador de longitud
    b calcular_longitud            // Repetir el ciclo

imprimir_resultado:
    mov x0, w1                     // Pasar la longitud a x0 para printf
    ldr x1, =msg_resultado         // Cargar el mensaje de impresión en x1
    bl printf                      // Imprimir el resultado

    // Salir del programa
    mov x8, 93                     // Código de syscall para exit
    mov x0, 0                      // Estado de salida
    svc 0                          // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
