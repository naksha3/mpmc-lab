.MODEL SMALL
.DATA
PA EQU 0D800H
 CR EQU 0D803H
.CODE
 MOV AX, @DATA ;
 MOV DS, AX ; DATA segment Initialization
 MOV AL, 80H ; Port A, B & C - Output
 MOV DX, CR ;
 OUT DX, AL ; Initialize 8255
 MOV CX, 10 ; Set LOOP counter to repeat clk times
 MOV DX, PA
 MOV AL, 11H ; Store bit Pattern IN AL
 L1: OUT DX, AL
 CALL DELAY
 ROR AL, 1 ; Rotate AL right by one bit to get next Pattern
 LOOP L1
 MOV AH, 4CH ;
 INT 21H ; Exit to DOS
DELAY PROC
 PUSH CX
 PUSH BX
 MOV CX, 1000h
LOOP2:MOV BX, 0FFFFH
LOOP1:DEC BX
 JNZ LOOP1 ; Repeat INNER LOOP FFFFH ×1000H times
 LOOP LOOP2 ; Repeat OUTER LOOP FFFFH times
 POP BX
 POP CX
 RET
DELAY ENDP
END
