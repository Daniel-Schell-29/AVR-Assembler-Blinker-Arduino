.include "m328pdef.inc"
.org 0x0000

rjmp main

main:

sbi DDRB, DDB5      ; Set Digital Port 13 as output (LED pin)

counter_led:

ldi r04, 4 ;delay count 1 unit of this bit should be 250ms just loop delay(250)

MOV r16, 250

r03=0 ;used for counting r04 intervalls from 4 --> 8--->1 if 8 has been hit sets to 1 to get down to 1

loop:

sbi PORTB, PORTB5   ; Turn on LED



push r02

MOV r02, r04

delay_LEDon:

    rcall delay          ; Call delay subroutine

    dec r02          

    brne delay_LEDon    ;repeat delay

pop r02



cbi PORTB, PORTB5   ; Turn off LED



push r02

MOV r02, r04

delay_LEDoff:

    rcall delay          ; Call delay subroutine

    dec r02          

    brne delay_LEDoff   ;repeat delay

pop r02



push r02

MOV r02, r04

ADD r03, 0  ;for branching

brne counting_down ;if not equal to 0 do 



;counting up

CMP r02, 8

BGE set_to_one ;if r04 >=8 start counting down

inc r01 ;increase led counter



pop r02

rjmp loop





counting_down:

pop r02



dec r04 ;decrease led counter

breq counter_led ;reset led counter if it reaches 0

rjmp loop



set_to_one:

    MOV r03, 1



rjmp loop           ; Repeat loop

;delay function length stored in r16

delay:

push r17       ;1 cycle

push r18      ; 1 cycle

counter_delay:

ldi r17, 16

outer_delay:

ldi r18, 249 ;not 255 to account for overhead from loops(calculated!) #CHECK AGAIN

inner_delay:

nop               ; No operation; 1 cycle

dec r18          ; Decrement r18; 1 cycle

brne inner_delay    ; Branch if not zero; 2 cycles if taken, 1 if not

nop               ; No operation; 1 cycle

dec r17          ; Decrement r17; 1 cycle

brne outer_delay    ; Branch if not zero; 2 cycles if taken, 1 if not

dec r16          ; Decrement r16; 1 cycle

brne counter_delay    ; Branch if not zero; 2 cycles if taken, 1 if not

pop r18        ; Restore r18; 1 cycle

pop r17        ; Restore r17; 1 cycle

ret
