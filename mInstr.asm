; Definiciones de las direcciones de memoria y registros
WORD_START: .word 0x0000  ; Dirección de inicio de la palabra
VGA_ADDR: .word 0x0235   ; Dirección de inicio para la VGA(560 en decimal)
CHECK_ADDR: .word 0x0230  ; Dirección de memoria para verificación (560 en decimal)
MEM_ADDR_564: .word 0x0234  ; Dirección de memoria para almacenamiento (564 en decimal)
MEM_ADDR_563: .word 0x0233 ; Dirección de memoria para 563

; Registros
R0 = 0            ; Registro cero (siempre cero)
R1 = WORD_START   ; Dirección de inicio de la palabra
R2 = VGA_ADDR     ; Dirección de la VGA
R3 = 0            ; Contador de caracteres
R4 = 0            ; Registro temporal
R5 = 0            ; Registro temporal
R6 = CHECK_ADDR   ; Dirección de memoria para verificación
R7 = MEM_ADDR_564 ; Dirección de memoria para almacenamiento
R8 = MEM_ADDR_563 ; Dirección de memoria para 563
R9 = 0            ; Registro temporal para cargar memoria

; Verificación inicial
CHECK_LOOP:
    ; Cargar el contenido de la dirección en CHECK_ADDR (560 en decimal)
    LOAD R5, 0(R6)
    
    ; Verificar si el contenido es 0
    CMP R5, R0
    BEQ R5, CHECK_LOOP  ; Si es 0, repetir verificación

    ; Si es diferente de 0, continuar al bucle principal
    JMP MAIN_LOOP

; Bucle principal
MAIN_LOOP:
    ;Finalizar esta etapa 
    CMP R1, #559
    BEQ R1, END
    ; Cargar el contenido de la dirección en R1
    LOAD R4, 0(R1)
    ; Verificar si el contenido es un espacio (código ASCII 32)
    CMP R4, #32
    BEQ R4, SPACE_FOUND  ; Si es un espacio, realizar verificación

    ; Comparar con 'a'
    CMP R4, #97
    BEQ R4, INCREMENT_COUNTER

    ; Comparar con 'e'
    CMP R4, #101
    BEQ R4, INCREMENT_COUNTER

    ; Comparar con 'i'
    CMP R4, #105
    BEQ R4, INCREMENT_COUNTER

    ; Comparar con 'o'
    CMP R4, #111
    BEQ R4, INCREMENT_COUNTER

    ; Comparar con 'u'
    CMP R4, #117
    BEQ R4, INCREMENT_COUNTER

    ; No es vocal, saltar a incrementar dirección
    JMP INCREMENT_ADDRESS

; Incrementar contador
INCREMENT_COUNTER:
    ADD R3, R3, 1  ; Incrementar contador de caracteres coincidentes
    JMP INCREMENT_ADDRESS  ; Incrementar dirección después de contar

; Verificación si se encuentra un espacio
SPACE_FOUND:
    ; Cargar el contenido de la dirección en CHECK_ADDR (560 en decimal)
    LOAD R5, 0(R6)
    
    ; Comparar el contenido con el valor en R3
    CMP R5, R3
    BNE R5, NOT_UPPERCASE  ; Si no son iguales, añade la letra en minúscula 
    
    ; Si son iguales, almacenar la dirección en MEM_ADDR_564 (564 en decimal)
    STORE R1, 0(R7)

    ; Actualizar WORD_START
    MOV R1, R8 
    ADD R1, R1, 1 
NOT_LOWERCASE:
    ; Cargar el contenido en la dirección de WORD_START
    LOAD R4, 0(R1)
    ; Convertir a mayúscula restando 32
    ; Cargar el contenido de la dirección en R4
    LOAD R5, 0(R4)       ; Cargar el valor de la dirección de memoria apuntada por R4 en R5
    ; Restar 32 al valor en R5
    SUB R5, R5, #32      ; Restar 32 al valor en R5
    ; Almacenar el resultado de vuelta en la dirección de memoria apuntada por R4
    STORE R5, 0(R2)
    
    ; Incrementar WORD_START y VGA_ADDR
    ADD R1, R1, 1
    ADD R2, R2, 1
    
    ; Verificar si WORD_START ha alcanzado la dirección 564
    LOAD R9, 0(R7)
    CMP R1, R9
    BEQ R1, INSERT_SPACE

    ; Repetir el proceso de conversión
    JMP NOT_LOWERCASE

;Cambiar de registro para añadir a VGA
NOT_UPPERCASE:
    ; Almacenar el carácter en la dirección VGA_ADDR
    LOAD R9, 0(R1)
    STORE R9, 0(R2)
    ; Incrementar WORD_START y VGA_ADDR
    ADD R1, R1, 1
    ADD R2, R2, 1
    
    ; Verificar si WORD_START ha alcanzado la dirección en 564
    LOAD R9, 0(R7)
    CMP R1, R9
    BEQ R1, INSERT_SPACE

    ; Repetir el proceso de conversión
    JMP NOT_UPPERCASE

INSERT_SPACE:
    LOAD R9, 0(R1)
    STORE R9, 0(R2)

    MOV R8, R7

; Incrementar dirección
INCREMENT_ADDRESS:
    ADD R1, R1, 1  ; Incrementar dirección de la palabra
    JMP MAIN_LOOP  ; Volver al inicio del bucle

; Finalizar programa
END:
    NOP           ; No Operation, fin del programa