cseg at 0h
ajmp init
cseg at 100h

; ------------------------------------------------
; Interrupt für TIMER0: Einsprung bei 0Bh
;-------------------------------------------------
ORG 0Bh
call showRow
reti

ORG 20h
init:
mov IE, #10010010b
mov tmod, #00000010b
mov tl0, #0c0h  ; Timer-Initionalsierung 
mov th0, #0c0h
mov P1,#00h
mov P2, #10000000b
mov P3, #00000000b
mov R2, #00h
setb tr0 ; startet timer
call endless
;---------------------------

endless:

ljmp endless


showRow: ; Spalten-Eintrag aus Datenbank holen
mov DPTR, #table
mov r0, a
movc a,@a+dptr
mov R4, A
mov a, r0
inc a

cjne r2, #08h, shiftrow ; Zeile 8 erreicht?
subb a, #08h
mov r2,#00h
inc R3

cjne r3, #04h, shiftrow ; Wiederholungen des Buchstabens
add a, #08h
mov r3, #00h
call shiftrow
ret

shiftRow: ; Rotate P2 (Zeile) und Zeige P2 und P3 an
inc R2
mov R1, a
mov A, P2
rl A
mov P2, A
mov P3, R4
mov a, R1
ret




org 300h
table:
db 01111110b, 01000010b, 01000010b, 01111110b, 01000010b, 01000010b, 01000010b, 01000010b ; A
db 01111110b, 00000010b, 00000010b, 01111110b, 01000000b, 01000000b, 01000000b, 01111110b ; S 
db 00111110b, 01100010b, 01000010b, 01000010b, 01000010b, 01000010b, 01100010b, 00111110b ; D
db 01111110b, 00000010b, 00000010b, 00011110b, 00000010b, 00000010b, 00000010b, 00000010b ; F
db 00000000b
end