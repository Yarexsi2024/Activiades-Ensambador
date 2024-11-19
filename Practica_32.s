// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Programa que calcula la potencia x^n de forma recursiva.

// Equivalente en C#:
// /*
// using System;
// class Program {
//     static int Potencia(int x, int n) {
//         if (n == 0) return 1;
//         if (n == 1) return x;
//         return x * Potencia(x, n - 1);
//     }
// 
//     static void Main() {
//         int x = 2;
//         int n = 5;
//         int resultado = Potencia(x, n);
//         Console.WriteLine("El resultado es: " + resultado);
//     }
// }
// */

.section .data
x: .word 2                        // Base de la potencia
n: .word 5                        // Exponente de la potencia
msg_resultado: .asciz "El resultado de x^n es: %d\n"

.section .text
.global _start

_start:
    // Cargar los valores de x y n
    ldr w1, x                     // Cargar x en w1 (base)
    ldr w2, n                     // Cargar n en w2 (exponente)

    // Llamar a la función de potencia
    bl potencia

    // Imprimir el resultado
    mov x0, w0                    // Pasar el resultado a x0 para printf
    ldr x1, =msg_resultado        // Cargar el mensaje de impresión en x1
    bl printf                     // Imprimir el resultado

    // Salir del programa
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall

// Función potencia: calcula x^n
// Entrada: w1 = x, w2 = n
// Salida: w0 = resultado de x^n
potencia:
    cmp w2, 0                     // Comparar n con 0
    beq caso_base_1               // Si n == 0, resultado es 1

    cmp w2, 1                     // Comparar n con 1
    beq caso_base_x               // Si n == 1, resultado es x

    // Caso recursivo: x * potencia(x, n-1)
    sub w2, w2, 1                 // n = n - 1
    mov w3, w1                    // Guardar x en w3 para la multiplicación
    bl potencia                   // Llamar recursivamente a potencia(x, n-1)

    mul w0, w0, w3                // Multiplicar resultado por x (w0 = w0 * x)
    ret                           // Retornar a la llamada anterior

caso_base_1:
    mov w0, 1                     // Retornar 1 cuando n == 0
    ret

caso_base_x:
    mov w0, w1                    // Retornar x cuando n == 1
    ret
