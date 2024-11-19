// Fecha: 11/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que convierte una temperatura de Celsius a Fahrenheit.
// Asciinema: https://asciinema.org/a/5yobWkUUZchMEcDPNW4QAX6oZ

// Equivalente en C#:
/*
using System;

class Program {
    static double ConvertirCelsiusAFahrenheit(double celsius) {
        return (celsius * 9.0 / 5.0) + 32;
    }

    static void Main() {
        Console.Write("Ingrese la temperatura en Celsius: ");
        double celsius = Convert.ToDouble(Console.ReadLine());
        double fahrenheit = ConvertirCelsiusAFahrenheit(celsius);
        Console.WriteLine("Temperatura en Fahrenheit: " + fahrenheit);
    }
}
*/

.section .data
msg_entrada:      .asciz "Ingrese la temperatura en Celsius: "
msg_salida:       .asciz "Temperatura en Fahrenheit: %f\n"
temp_celsius:     .float 0.0          // Valor inicial vacío
temp_fahrenheit:  .float 0.0

.section .text
.global _start

_start:
    // Inicializar el puntero de pila
    mov x29, sp
    sub sp, sp, #16

    // Mostrar mensaje de entrada
    ldr x0, =msg_entrada      // Cargar dirección del mensaje de entrada en x0
    bl printf                 // Imprimir mensaje

    // Leer valor en Celsius desde la entrada
    ldr x0, =temp_celsius     // Cargar dirección donde almacenar temp_celsius
    bl scanf                  // Leer entrada del usuario y guardarla en temp_celsius

    // Cargar el valor ingresado en temp_celsius
    ldr x1, =temp_celsius     // Cargar la dirección de temp_celsius en x1
    ldr s0, [x1]              // Cargar el valor de temp_celsius desde la dirección

    // Conversión: Fahrenheit = (Celsius * 9/5) + 32
    mov w1, #9
    mov w2, #5
    ucvtf s1, w1              // Convertir 9 a punto flotante en s1
    ucvtf s2, w2              // Convertir 5 a punto flotante en s2
    fdiv s1, s1, s2           // s1 = 9/5

    fmul s0, s0, s1           // s0 = Celsius * 9/5

    mov w3, #32
    ucvtf s3, w3              // Convertir 32 a punto flotante en s3
    fadd s0, s0, s3           // s0 = (Celsius * 9/5) + 32 (Fahrenheit)

    // Guardar resultado en temp_fahrenheit
    ldr x1, =temp_fahrenheit  // Cargar la dirección de temp_fahrenheit en x1
    str s0, [x1]              // Almacenar el resultado en temp_fahrenheit

    // Mostrar mensaje de salida
    ldr x0, =msg_salida       // Cargar el mensaje de salida en x0
    ldr x1, =temp_fahrenheit  // Cargar la dirección de temp_fahrenheit
    ldr s0, [x1]              // Cargar temp_fahrenheit desde la dirección
    fcvt d0, s0               // Convertir s0 (32 bits) a d0 (64 bits, doble precisión)
    bl printf                 // Imprimir temperatura en Fahrenheit

    // Terminar programa
    mov x8, 93                // Código de syscall para salir
    mov x0, 0                 // Estado de salida
    svc 0


