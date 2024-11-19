// Fecha: 18/11/2024
// Autor: Yarexsi Santiago
// Descripción: Implementación de una cola (queue) usando un arreglo en ARM64 Assembly.

// Equivalente en C#:
// /*
// using System;
// class Cola {
//     private int[] queue;
//     private int front, rear, size, capacity;
// 
//     public Cola(int capacity) {
//         this.capacity = capacity;
//         queue = new int[capacity];
//         front = 0;
//         rear = -1;
//         size = 0;
//     }
// 
//     public void Enqueue(int value) {
//         if (size == capacity) {
//             Console.WriteLine("Cola llena");
//             return;
//         }
//         rear = (rear + 1) % capacity;
//         queue[rear] = value;
//         size++;
//     }
// 
//     public int Dequeue() {
//         if (size == 0) {
//             Console.WriteLine("Cola vacía");
//             return -1; // Indica error
//         }
//         int value = queue[front];
//         front = (front + 1) % capacity;
//         size--;
//         return value;
//     }
// 
//     public static void Main() {
//         Cola cola = new Cola(5);
//         cola.Enqueue(10);
//         cola.Enqueue(20);
//         Console.WriteLine("Elemento sacado: " + cola.Dequeue());
//     }
// }
// */

.section .data
cola: .space 20                   // Espacio para un arreglo de 5 elementos (4 bytes cada uno)
front: .word 0                    // Índice del frente de la cola
rear: .word -1                    // Índice de la parte trasera de la cola (inicialmente -1)
size: .word 0                     // Tamaño actual de la cola
capacidad: .word 5                // Capacidad máxima de la cola
msg_cola_llena: .asciz "Cola llena\n"
msg_cola_vacia: .asciz "Cola vacía\n"
msg_dequeue: .asciz "Elemento sacado: %d\n"

.section .text
.global _start

_start:
    // Enqueue de elementos en la cola
    mov w1, 10                    // Elemento a insertar
    bl enqueue                    // Llamar a la función enqueue
    mov w1, 20                    // Otro elemento a insertar
    bl enqueue                    // Llamar a la función enqueue

    // Dequeue de un elemento de la cola
    bl dequeue                    // Llamar a la función dequeue
    cmp w0, -1                    // Comprobar si el valor de retorno es -1 (cola vacía)
    beq salir                     // Si es -1, salir
    mov x0, w0                    // Pasar el valor sacado a x0 para printf
    ldr x1, =msg_dequeue          // Cargar el mensaje de impresión en x1
    bl printf                     // Imprimir el valor sacado

    // Salir del programa
salir:
    mov x8, 93                    // Código de syscall para exit
    mov x0, 0                     // Estado de salida
    svc 0                         // Invocar syscall

// Función enqueue: inserta un valor en la cola
// Entrada: w1 = valor a insertar
// Salida: nada
enqueue:
    ldr w2, size                  // Cargar el tamaño actual de la cola
    ldr w3, capacidad             // Cargar la capacidad máxima de la cola
    cmp w2, w3                    // Comprobar si la cola está llena
    bge cola_llena                // Si está llena, mostrar mensaje y salir

    ldr w4, rear                  // Cargar el índice de la parte trasera
    add w4, w4, 1                 // Incrementar rear
    and w4, w4, w3                // rear = (rear + 1) % capacidad
    str w4, rear                  // Actualizar rear

    str w1, [x0, w4, lsl #2]      // Insertar el valor en la cola
    add w2, w2, 1                 // Incrementar tamaño
    str w2, size                  // Actualizar size

    ret                           // Retornar de la función

cola_llena:
    ldr x1, =msg_cola_llena       // Cargar el mensaje de cola llena en x1
    bl printf                     // Imprimir el mensaje
    ret                           // Retornar de la función

// Función dequeue: saca un valor de la cola
// Entrada: nada
// Salida: w0 = valor sacado o -1 si la cola está vacía
dequeue:
    ldr w2, size                  // Cargar el tamaño actual de la cola
    cmp w2, 0                     // Comprobar si la cola está vacía
    beq cola_vacia                // Si size == 0, la cola está vacía

    ldr w3, front                 // Cargar el índice del frente
    ldr w0, [x0, w3, lsl #2]      // Sacar el valor de la cola en w0
    add w3, w3, 1                 // Incrementar front
    ldr w4, capacidad             // Cargar la capacidad
    and w3, w3, w4                // front = (front + 1) % capacidad
    str w3, front                 // Actualizar front

    sub w2, w2, 1                 // Decrementar tamaño
    str w2, size                  // Actualizar size

    ret                           // Retornar de la función

cola_vacia:
    ldr x1, =msg_cola_vacia       // Cargar el mensaje de cola vacía en x1
    bl printf                     // Imprimir el mensaje
    mov w0, -1                    // Retornar -1 para indicar error
    ret                           // Retornar de la función
