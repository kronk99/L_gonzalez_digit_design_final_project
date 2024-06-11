@ Definiciones de las direcciones de memoria y registros
WORD_START: .word 0x0001  @ Dirección de inicio de la palabra
VGA_ADDR: .word 0x0237   @ Dirección de inicio para la VGA(565 en decimal)
CHECK_ADDR: .word 0x0232  @ Dirección de memoria para verificación (562 en decimal)
MEM_ADDR_566: .word 0x0236  @ Dirección de memoria para almacenamiento (566 en decimal)
MEM_ADDR_565: .word 0x0235 @ Dirección de memoria para 565
SECOND_ENABLE: .word 0x233 @ Enable de la segunda parte
END_MEMORY: .word 0x467 @Final de la memoria
FIRST_VGA: .word 0x237 @Primer espacio de la VGA

@ Registros
R0 = 0            @ Registro cero (siempre cero)
R1 = WORD_START   @ Dirección de inicio de la palabra
R2 = VGA_ADDR     @ Dirección de la VGA
R3 = 0            @ Contador de caracteres
R4 = 0            @ Registro temporal
R5 = 0            @ Registro temporal
R6 = CHECK_ADDR   @ Dirección de memoria para verificación
R7 = MEM_ADDR_566 @ Dirección de memoria para almacenamiento
R8 = MEM_ADDR_565 @ Dirección de memoria para 563
R9 = 0            @ Registro temporal para cargar memoria
R10 = SECOND_ENABLE @ Registro que almacena el caracter
R11 = END_MEMORY 
R12 = FIRST_VGA

@ Verificación inicial
CHECK_LOOP:
    @ Cargar el contenido de la dirección en CHECK_ADDR (560 en decimal)
    LDR R5, [R6, #0]
    
    @ Verificar si el contenido es 0
    CMP R5, R0
    BEQ CHECK_LOOP  @ Si es 0, repetir verificación

    @ Si es diferente de 0, continuar al bucle principal
    B MAIN_LOOP
@ Bucle principal
MAIN_LOOP: 
    
    @Finalizar esta etapa 
    CMP R1, R6 @//esto hay que arreglarlo, cambiar 559 a hexadecimal
    BEQ CHECK_INSERT_CHARACTER
    @ Cargar el contenido de la dirección en R1
    LDR R4, [R1, #0]
    @ Verificar si el contenido es un espacio (código ASCII 32)
    CMP R4, #32
    BEQ SPACE_FOUND  @ Si es un espacio, realizar verificación

    @ Comparar con 'a'
    CMP R4, #97
    BEQ INCREMENT_COUNTER

    @ Comparar con 'e'
    CMP R4, #101
    BEQ INCREMENT_COUNTER

    @ Comparar con 'i'
    CMP R4, #105
    BEQ INCREMENT_COUNTER

    @ Comparar con 'o'
    CMP R4, #111
    BEQ INCREMENT_COUNTER

    @ Comparar con 'u'
    CMP R4, #117
    BEQ INCREMENT_COUNTER

    @ No es vocal, saltar a incrementar dirección
    B INCREMENT_ADDRESS

@ Incrementar contador
INCREMENT_COUNTER:
    ADD R3, R3, #1  @ Incrementar contador de caracteres coincidentes
    B INCREMENT_ADDRESS  @ Incrementar dirección después de contar

@ Verificación si se encuentra un espacio
SPACE_FOUND:
    @ Cargar el contenido de la dirección en CHECK_ADDR (560 en decimal)
    LDR R5, [R6, #0]
	 
    STR R1, [R7, #0] 
    MOV R1,R8
    @ Comparar el contenido con el valor en R3
    CMP R5, R3
    BNE NOT_UPPERCASE  @ Si no son iguales, añade la letra en minúscula 
    
    @ Si son iguales, almacenar la dirección en MEM_ADDR_564 (564 en decimal)
    @//STORE R1, 0(R7)

    @ Actualizar WORD_START
    MOV R1, R8 
NOT_LOWERCASE:
    @ Cargar el contenido en la dirección de WORD_START
    ADD R1, R1, #1
    ADD R2, R2, #1
    LDR R5, [R1, #0]
    @ Convertir a mayúscula restando 32
    @ Cargar el contenido de la dirección en R4
    @ Cargar el valor de la dirección de memoria apuntada por R4 en R5
    @ Restar 32 al valor en R5
    SUB R5, R5, #32      @ Restar 32 al valor en R5
    @ Almacenar el resultado de vuelta en la dirección de memoria apuntada por R4
    STR R5, [R2, #0]
    
    @ Incrementar WORD_START y VGA_ADDR
    ADD R1, R1, #1
    ADD R2, R2, #1
    
    @ Verificar si WORD_START ha alcanzado la dirección 564
    CMP R1, R7
    BEQ INSERT_SPACE

    @ Repetir el proceso de conversión
    B NOT_LOWERCASE

@Cambiar de registro para añadir a VGA
NOT_UPPERCASE:
    @ Almacenar el carácter en la dirección VGA_ADDR
    ADD R1, R1, #1  
    ADD R2, R2, #1

    LDR R9, [R1, #0] 
    STR R9, [R2, #0]             
    
    CMP R1, R7 @//esta comparando la direccion de memoria con el 32.
    BEQ INSERT_SPACE

    @ Repetir el proceso de conversión
    B NOT_UPPERCASE

INSERT_SPACE:
    @//quitar LOAD R9, 0(R1)
    @//quitar STORE R9, 0(R2)
    MOV R3,#0
    MOV R8, R7

@ Incrementar dirección
INCREMENT_ADDRESS:
    ADD R1, R1, #1  @ Incrementar dirección de la palabra
    B MAIN_LOOP  @ Volver al inicio del bucle
@ Finalizar programa


CHECK_INSERT_CHARACTER:
    @ Cargar el contenido de la dirección en del caracter
    LDR R5, [R10, #0]
    
    @ Verificar si el contenido es 0
    CMP R5, R0
    BEQ CHECK_INSERT_CHARACTER  @ Si es 0, repetir verificación

    MOV R2, R12
VERIFY_CHARACTER:
    @Condición de parada
    CMP R2, R11
    BEQ END

    LDR R4, [R2, #0]

    @ Comparar con 'A'
    CMP R4, #65
    BEQ INSERT_CHARACTER

    @ Comparar con 'E'
    CMP R4, #69
    BEQ INSERT_CHARACTER

    @ Comparar con 'I'
    CMP R4, #73
    BEQ INSERT_CHARACTER

    @ Comparar con 'O'
    CMP R4, #79
    BEQ INSERT_CHARACTER

    @ Comparar con 'U'
    CMP R4, #85
    BEQ INSERT_CHARACTER  

    @Si no hay coincidencia se avanza a la siguiente letra 
    ADD R2, R2, #1
    B VERIFY_CHARACTER

INSERT_CHARACTER:
    @Cambio la vocal por el caracter
    STR R5, [R2, #0] 
    ADD R2, R2, #1
    B VERIFY_CHARACTER

END:
    NOP           @ No Operation, fin del programa