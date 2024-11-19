// Fecha: 12/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que convierte un entero en una cadena de caracteres en formato ASCII.

// Equivalente en C#:
/*
using System;

class Program {
    static string ConvertirEnteroAAscii(int numero) {
        if (numero == 0) return "0";
        string resultado = "";
        while (numero > 0) {
            int digito = numero % 10;
            resultado = (char)(digito + '0') + resultado;
            numero /= 10;
        }
        return resultado;
    }

    static void Main() {
        int numero = 12345;
        string resultado = ConvertirEnteroAAscii(numero);
        Console.WriteLine("El número convertido a ASCII es: " + resultado);
    }
}
*/

.section .data
numero: .word 12345              // Número a convertir
msg_resultado: .asciz "El número convertido a ASCII es: %s\n"
buffer: .space 12                // Espacio para almacenar la cadena resultante (suficiente para un int de 32 bits)

.section .text
.global _start

_start:
    ldr w1, numero               // Cargar el número en w1
    ldr x2, =buffer              // Cargar la dirección del buffer en x2
    add x2, x2, 11               // Mover el puntero al final del buffer (para construcción inversa)
    mov w3, 0                    // Inicializar contador de longitud de la cadena

    // Comprobar si el número es 0
    cmp w1, 0
    bne convertir                // Si no es 0, ir a convertir
    mov w4, '0'                  // Guardar el carácter '0' en w4
    strb w4, [x2, #-1]!          // Almacenar '0' en el buffer y mover el puntero
    b imprimir_resultado

convertir:
    // Ciclo de conversión: convertir el número a ASCII
convertir_ciclo:
    udiv w4, w1, 10              // w4 = número / 10
    msub w5, w4, 10, w1          // w5 = número % 10 (resto)
    add w5, w5, '0'              // Convertir el dígito a ASCII ('0' = 48)
    strb w5, [x2, #-1]!          // Almacenar el dígito en el buffer y mover el puntero
    mov w1, w4                   // Actualizar número = número / 10
    cmp w1, 0                    // Comprobar si el número es 0
    bne convertir_ciclo          // Si no, repetir el ciclo

imprimir_resultado:
    ldr x0, x2                   // Pasar la dirección de la cadena resultante a x0 para printf
    ldr x1, =msg_resultado       // Cargar el mensaje de impresión en x1
    bl printf                    // Imprimir el resultado

    // Salir del programa
    mov x8, 93                   // Código de syscall para exit
    mov x0, 0                    // Estado de salida
    svc 0                        // Invocar syscall

// Funciones auxiliares (como printf) se deben agregar o importar
