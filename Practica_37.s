// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Implementación de una pila usando un arreglo en ARM64 Assembly.

// Equivalente en C#:
// /*
// using System;
// class Pila {
//     private int[] stack;
//     private int top;
// 
//     public Pila(int size) {
//         stack = new int[size];
//         top = -1;
//     }
// 
//     public void Push(int value) {
//         if (top >= stack.Length - 1) {
//             Console.WriteLine("Pila llena");
//             return;
//         }
//         stack[++top] = value;
//     }
// 
//     public int Pop() {
//         if (top < 0) {
//             Console.WriteLine("Pila vacía");
//             return -1; // Indica error
//         }
//         return stack[top--];
//     }
// 
//     public static void Main() {
//         Pila pila = new Pila(5);
//         pila.Push(10);
//         pila.Push(20);
//         Console.WriteLine("Elemento sacado: " + pila.Pop());
//     }
// }
// */

.section .data
pila: .space 20                   // Espacio para un arreglo de 5 elementos (4 bytes cada uno)
top: .word -1                     // Índice de la parte superior de la pila (inicialmente -1)
tamano_pila: .word 5              // Tamaño máximo de la pila
msg_pila_llena: .asciz "Pila llena\n"
msg_pila_vacia: .asciz "Pila vacía\n"
msg_pop: .asciz "Elemento sacado: %d\n"

.section .text
.global _start

_start:
    // Push de elementos en la pila
    mov w1, 10                    // Elemento a empujar
    bl push                       // Llamar a la función push
    mov w1, 20                    // Otro elemento a empujar
    bl push                       // Llamar a la función push

    // Pop de un elemento de la pila
    bl pop                        // Llamar a la función pop
    cmp w0, -1                    // Comprobar si el valor de retorno es -1 (pila vacía)
    beq salir                     // Si es -1, salir
    mov x0, w0                    // Pasar el valor sacado a x0 para printf
    ldr x1, =msg_pop              // Cargar el mensaje de impresión en x1
    bl printf                     // Imprimir el valor sacado

    // Salir del programa
salir:
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall

// Función push: empuja un valor a la pila
// Entrada: w1 = valor a empujar
// Salida: nada
push:
    ldr w2, top                   // Cargar el índice superior de la pila
    ldr w3, tamano_pila           // Cargar el tamaño máximo de la pila
    cmp w2, w3                    // Comprobar si top >= tamano_pila - 1
    bge pila_llena                // Si la pila está llena, mostrar mensaje y salir

    add w2, w2, 1                 // Incrementar el índice superior (top++)
    str w2, top                   // Actualizar top
    str w1, [x0, w2, lsl #2]      // Guardar el valor en la pila

    ret                           // Retornar de la función

pila_llena:
    ldr x1, =msg_pila_llena       // Cargar el mensaje de pila llena en x1
    bl printf                     // Imprimir el mensaje
    ret                           // Retornar de la función

// Función pop: saca un valor de la pila
// Entrada: nada
// Salida: w0 = valor sacado o -1 si la pila está vacía
pop:
    ldr w2, top                   // Cargar el índice superior de la pila
    cmp w2, -1                    // Comprobar si la pila está vacía
    blt pila_vacia                // Si top < 0, la pila está vacía

    ldr w0, [x0, w2, lsl #2]      // Cargar el valor de la pila en w0
    sub w2, w2, 1                 // Decrementar el índice superior (top--)
    str w2, top                   // Actualizar top

    ret                           // Retornar de la función

pila_vacia:
    ldr x1, =msg_pila_vacia       // Cargar el mensaje de pila vacía en x1
    bl printf                     // Imprimir el mensaje
    mov w0, -1                    // Retornar -1 para indicar error
    ret                           // Retornar de la función
