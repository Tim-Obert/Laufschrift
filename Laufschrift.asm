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
mov tl0, #0EFh  ; Timer-Initionalsierung 
mov th0, #0EFh
mov P1,#00h
mov P2, #10000000b
mov P3, #00000000b
mov R2, #00h
setb tr0 ; startet timer
call endless
;---------------------------

endless:

ljmp endless


showRow:
mov DPTR, #table
mov r0, a
movc a,@a+dptr
mov R4, A
mov a, r0
inc a
cjne r2, #08h, shiftrow
subb a, #08h
mov r2,#00h
inc R3
cjne r3, #014h, shiftrow
add a, #08h
mov r3, #00h
call shiftrow

ret

shiftRow:
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
db 01111110b, 01000010b, 01000010b, 01111110b, 01000010b,01000010b, 01000010b, 01000010b
db 01111110b, 01100010b, 01000010b, 01000010b, 01000010b,01000010b, 01100010b, 01111110b
db 00000000b

end