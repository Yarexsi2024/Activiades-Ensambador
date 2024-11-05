// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que verifica si un número es primo

// Este programa utiliza bucles y saltos condicionales para determinar si un número dado es primo.
// Si el número es primo, muestra el mensaje "Es primo"; si no, muestra "No es primo".

.section .data
is_prime_msg:   .asciz "El número %d es primo.\n"
not_prime_msg:  .asciz "El número %d no es primo.\n"

.section .text
.global _start

_start:
    // Entrada: Definir el número a verificar
    mov w0, #29                // Número a verificar (en este ejemplo, 29)
    
    // Verificar si el número es menor o igual a 1
    cmp w0, #1
    ble not_prime              // Si el número es <= 1, no es primo

    // Verificar si el número es 2 o 3 (primos por definición)
    cmp w0, #2
    beq is_prime               // Si el número es 2, es primo
    cmp w0, #3
    beq is_prime               // Si el número es 3, es primo

    // Inicializar divisor y límite para el bucle de prueba de divisibilidad
    mov w1, #2                 // Divisor inicial: 2
    sqrt_loop:
        // Calcular límite (aproximación de raíz cuadrada)
        mul w2, w1, w1         // w2 = divisor * divisor
        cmp w2, w0
        bgt end_check          // Si divisor^2 > número, salir del bucle

        // Comprobar divisibilidad
        udiv w3, w0, w1        // w3 = número / divisor
        msub w4, w3, w1, w0    // w4 = número - (w3 * divisor)
        cbz w4, not_prime      // Si w4 == 0, el número es divisible y no es primo

        // Incrementar divisor
        add w1, w1, #1         // divisor++
        b sqrt_loop            // Repetir el bucle con el siguiente divisor

is_prime:
    // Mostrar mensaje: es primo
    mov x0, w0                 // Pasar el número como argumento
    ldr x1, =is_prime_msg      // Dirección del mensaje
    bl printf                  // Imprimir el mensaje
    b end_program              // Saltar al final del programa

not_prime:
    // Mostrar mensaje: no es primo
    mov x0, w0                 // Pasar el número como argumento
    ldr x1, =not_prime_msg     // Dirección del mensaje
    bl printf                  // Imprimir el mensaje

end_program:
    // Finalizar el programa
    mov x8, #93                // Llamada al sistema 'exit'
    mov x0, #0                 // Código de salida 0
    svc #0                     // Ejecutar llamada al sistema
