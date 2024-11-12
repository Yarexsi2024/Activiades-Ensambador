// Fecha: 12/11/25
// Autor: Tu Nombre
// Descripción: Programa que convierte una cadena de caracteres en formato ASCII a un número entero.

// Equivalente en C#:
/*
using System;

class Program {
    static int ConvertirAsciiAEntero(string numeroAscii) {
        int resultado = 0;
        for (int i = 0; i < numeroAscii.Length; i++) {
            resultado = resultado * 10 + (numeroAscii[i] - '0');
        }
        return resultado;
    }

    static void Main() {
        string numero = "12345";
        int resultado = ConvertirAsciiAEntero(numero);
        Console.WriteLine("El número convertido es: " + resultado);
    }
}
*/

.section .data
cadena: .asciz "12345"            // Cadena de ejemplo en formato ASCII
msg_resultado: .asciz "El número convertido es: %d\n"

.section .bss
resultado: .word 0                // Variable para almacenar el resultado

.section .text
.global _start

_start:
    ldr x0, =cadena               // Cargar la dirección de la cadena en x0
    mov w1, 0                     // Inicializar el resultado a 0

convertir:
    ldrb w2, [x0], #1             // Cargar el siguiente carácter en w2 y avanzar el puntero (x0 += 1)
    cmp w2, #0                    // Comprobar si el carácter es nulo (fin de cadena)
    beq imprimir_resultado        // Si es nulo, saltar a imprimir el resultado

    sub w2, w2, '0'               // Convertir carácter ASCII a valor numérico ('0' = 48)
    mul w1, w1, 10                // Multiplicar el resultado actual por 10
    add w1, w1, w2                // Sumar el dígito convertido al resultado

    b convertir                   // Repetir el ciclo para el siguiente carácter

imprimir_resultado:
    mov x0, w1                    // Pasar el resultado a x0 para printf
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión en x1
    bl printf                     // Imprimir el resultado

    // Salir del programa
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
