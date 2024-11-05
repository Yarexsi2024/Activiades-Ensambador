// Autor: Yarexsi Santiago
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que calcula la serie de Fibonacci hasta el enésimo término.

// Este programa utiliza un bucle para calcular la serie de Fibonacci hasta un término dado N.
// Los valores de la serie se almacenan en memoria y se muestran en la salida estándar.

.section .data
output_msg:   .asciz "Fibonacci[%d] = %d\n"    // Mensaje de formato para imprimir cada término
n_value:      .word 10                         // Número de términos a calcular en la serie (N = 10)

.section .bss
fib_series:   .space 40                        // Espacio en memoria para almacenar 10 términos (4 bytes cada uno)

.section .text
.global _start

_start:
    // Leer el valor de N desde la memoria (n_value)
    ldr w0, =n_value           // Cargar la dirección de n_value en w0
    ldr w1, [w0]               // Cargar el valor de N en w1

    // Verificar que N sea mayor que 1 para realizar la serie
    cmp w1, #1
    ble end_program            // Si N <= 1, terminar el programa

    // Inicializar los primeros dos valores de la serie de Fibonacci
    mov w2, #0                 // Fibonacci[0] = 0
    mov w3, #1                 // Fibonacci[1] = 1

    // Almacenar los primeros dos términos en la serie
    ldr x0, =fib_series        // Cargar la dirección base de fib_series
    str w2, [x0], #4           // Almacenar Fibonacci[0] y avanzar el puntero 4 bytes
    str w3, [x0], #4           // Almacenar Fibonacci[1] y avanzar el puntero 4 bytes

    // Configurar el bucle para calcular el resto de los términos
    sub w1, w1, #2             // Reducir N en 2 (ya que los dos primeros términos están definidos)

loop:
    // Calcular el siguiente término de Fibonacci
    add w4, w2, w3             // w4 = Fibonacci[n-2] + Fibonacci[n-1]

    // Actualizar los términos para la siguiente iteración
    mov w2, w3                 // w2 = Fibonacci[n-1]
    mov w3, w4                 // w3 = Fibonacci[n]

    // Almacenar el término actual en la serie
    str w4, [x0], #4           // Guardar Fibonacci[n] en la memoria y avanzar el puntero

    // Decrementar el contador y verificar si se ha llegado a N términos
    sub w1, w1, #1
    cbnz w1, loop              // Si w1 no es cero, repetir el bucle

    // Imprimir los términos de la serie desde la memoria
    ldr x0, =fib_series        // Reiniciar el puntero al inicio de fib_series
    ldr w1, =n_value           // Cargar el número de términos N
    ldr w1, [w1]               // Leer el valor de N

print_loop:
    // Cargar el valor del término actual
    ldr w2, [x0], #4           // Leer Fibonacci[i] y avanzar el puntero
    sub w3, w1, w1             // Calcular el índice actual (N - w1)

    // Preparar y realizar la llamada a printf para mostrar el término actual
    mov x0, w3                 // Pasar el índice como argumento
    mov x1, w2                 // Pasar el valor Fibonacci[i] como argumento
    ldr x2, =output_msg        // Dirección del mensaje de formato
    bl printf                  // Imprimir el término actual

    // Decrementar el contador y verificar si se han mostrado todos los términos
    sub w1, w1, #1
    cbnz w1, print_loop        // Si w1 no es cero, repetir para el siguiente término

end_program:
    // Finalizar el programa
    mov x8, #93               // Llamada al sistema 'exit'
    mov x0, #0                // Código de salida 0
    svc #0                    // Ejecutar llamada al sistema
