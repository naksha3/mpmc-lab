.MODEL SMALL
.DATA
PA EQU 0D800H
 CR EQU 0D803H
.CODE
 MOV AX, @DATA ;
 MOV DS, AX ; 
 MOV AL, 80H ; 
 MOV DX, CR ;
 OUT DX, AL ; 
 MOV CX, 10 ;
 MOV DX, PA
 MOV AL, 11H ; 
 L1: OUT DX, AL
 CALL DELAY
 ROR AL, 1 ; 
 LOOP L1
 MOV AH, 4CH ;
 INT 21H ;
DELAY PROC
 PUSH CX
 PUSH BX
 MOV CX, 1000h
LOOP2:MOV BX, 0FFFFH
LOOP1:DEC BX
 JNZ LOOP1 ; 
 LOOP LOOP2 ; 
 POP BX
 POP CX
 RET
DELAY ENDP
END
