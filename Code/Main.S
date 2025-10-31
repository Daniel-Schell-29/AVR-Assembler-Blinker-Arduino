#define _SER_OFFSET 0x00
#include "avr/io.h"

.global main_asm

main_asm:
    cli                     ;deactivate interuppts

    ldi     r17,    1 << 4  ;Bitmask for PB5
    out     0x04,   r17

counter_led:                ;used for counting r18 intervalls 4->8->1
    ldi     r18,    4       ;delay count 1 unit of this bit should be 100ms just loop delay(100)
    ldi     r16,    250
    ldi     r19,    0       ;State flag: 0=counting_up, 1=counting_down

loop:
    ldi     r17,    1 << 4
    out     0x05,   r17     ;Turn on LED

    push    r21
    MOV     r21,    r18
delay_LEDon:
    rcall   delay           ;call delay subroutine
    dec     r21     
    brne    delay_LEDon     ;repeat delay
    pop     r21

    ldi     r17,    0
    out     0x05,   r17     ;Turn off LED

    push    r21
    MOV     r21,    r18

delay_LEDoff:
    rcall   delay           ;call delay subroutine
    dec     r21          
    brne    delay_LEDoff    ;repeat delay
    pop     r21

;=========counting up and down===========
    cpi     r19,    0       ;for branching
    brne    counting_down   ;if not equal to 0 do branch
    
;---counting up---
    cpi     r18,    8
    
    brge    set_to_one      ;if r18>=8 start counting down

    inc     r18             ;increase led counter
    rjmp    loop


set_to_one:
    ldi     r19,    1
    rjmp    loop

counting_down:

    dec     r18             ;decrease led counter

    breq    counter_led     ;reset led counter if it reaches 0
    rjmp    loop

;---------------------------------------------
;End of loop
;---------------------------------------------


;=========delay function==========
;delay function length stored in r16

delay:
    push    r17             ;1 c
    push    r22             ;1 c
    push    r20
    mov     r20,    r16

counter_delay:
    ldi     r17,    16
outer_delay:
    ldi     r22,    249     ;not 255 to account for overhead from loops(calculated!)

inner_delay:
    nop                     ; No operation              ;+1 cycle
    dec     r22             ; Decrement r22             ;+1 cycle
    brne    inner_delay     ; Branch if not zero        ;+2 cycles if taken, +1 if not
    nop                     ; No operation              ;+1 cycle
    dec     r17             ; Decrement r17             ;+1 cycle
    brne    outer_delay     ; Branch if not zero        ;+2 cycles if taken, +1 if not
    dec     r20             ; Decrement copy of r16     ;+1 cycle
    brne    counter_delay   ; Branch if not zero        ;+2 cycles if taken, +1 if not
    pop     r22             
    pop     r17             
    pop     r20
    ret
;---------------------------------------------
