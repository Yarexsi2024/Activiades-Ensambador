// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Programa que calcula el Mínimo Común Múltiplo (MCM) de dos números
// usando el MCD a través del algoritmo de Euclides.

// Equivalente en C#:
// /*
// using System;
// class Program {
//     static int CalcularMCD(int a, int b) {
//         while (b != 0) {
//             int temp = b;
//             b = a % b;
//             a = temp;
//         }
//         return a;
//     }
// 
//     static int CalcularMCM(int a, int b) {
//         return (a * b) / CalcularMCD(a, b);
//     }
// 
//     static void Main() {
//         int a = 56;
//         int b = 98;
//         int resultado = CalcularMCM(a, b);
//         Console.WriteLine("El MCM es: " + resultado);
//     }
// }
// */

.section .data
a: .word 56                       // Primer número
b: .word 98                       // Segundo número
msg_resultado: .asciz "El MCM es: %d\n"

.section .text
.global _start

_start:
    // Cargar los valores iniciales de a y b
    ldr w1, a                     // Cargar a en w1
    ldr w2, b                     // Cargar b en w2

    // Guardar a y b para usarlos más tarde en el cálculo del MCM
    mov w3, w1                    // w3 = a
    mov w4, w2                    // w4 = b

calcular_mcd:
    cmp w2, 0                     // Comprobar si b == 0
    beq calcular_mcm              // Si b es 0, el MCD está en w1

    udiv w5, w1, w2               // Cociente de a / b (ilustrativo, no se usa aquí)
    msub w6, w5, w2, w1           // Calcular a % b y almacenar en w6: w6 = a - (b * (a / b))
    mov w1, w2                    // a = b
    mov w2, w6                    // b = a % b

    b calcular_mcd                // Repetir hasta que b sea 0

calcular_mcm:
    // Cálculo del MCM: (a_original * b_original) / MCD(a, b)
    mul w7, w3, w4                // Multiplicar a * b
    udiv w0, w7, w1               // (a * b) / MCD, resultado en w0

    // Imprimir el resultado
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión
    bl printf                     // Imprimir el resultado

    // Salir del programa
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall
