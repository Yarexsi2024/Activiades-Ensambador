// Fecha: 11/11/25
// Autor: Yarexsi Santiago
// Descripción: Programa que convierte una temperatura de Celsius a Fahrenheit.

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
msg_entrada: .asciz "Ingrese la temperatura en Celsius: "
msg_salida: .asciz "Temperatura en Fahrenheit: %f\n"
temp_celsius: .float 0.0
temp_fahrenheit: .float 0.0

.section .text
.global _start

_start:
    // Mostrar mensaje de entrada
    ldr x0, =msg_entrada      // Cargar dirección del mensaje de entrada en x0
    bl printf                 // Imprimir mensaje

    // Leer valor en Celsius (por simplicidad se asume entrada directa)
    // Aquí podríamos usar `scanf` o `read`, para fines prácticos se considera una entrada en `temp_celsius`

    // Cargar el valor de Celsius
    ldr s0, temp_celsius       // Cargar temp_celsius en el registro s0 (Celsius)

    // Conversión: Fahrenheit = (Celsius * 9/5) + 32
    // Multiplicación por 9/5
    mov w1, #9
    mov w2, #5
    ucvtf s1, w1              // Convertir 9 a punto flotante en s1
    ucvtf s2, w2              // Convertir 5 a punto flotante en s2
    fdiv s1, s1, s2           // s1 = 9/5

    fmul s0, s0, s1           // s0 = Celsius * 9/5

    // Sumar 32 para completar la conversión
    mov w3, #32
    ucvtf s3, w3              // Convertir 32 a punto flotante en s3
    fadd s0, s0, s3           // s0 = (Celsius * 9/5) + 32 (Fahrenheit)

    // Guardar resultado en temp_fahrenheit
    str s0, temp_fahrenheit

    // Mostrar mensaje de salida
    ldr x0, =msg_salida       // Cargar el mensaje de salida en x0
    ldr s1, temp_fahrenheit   // Cargar temp_fahrenheit en s1
    fmov d0, s1               // Mover el resultado a d0 para impresión
    bl printf                 // Imprimir temperatura en Fahrenheit

    // Terminar programa
    mov x8, 93               // Código de syscall para salir
    mov x0, 0                // Estado de salida
    svc 0

