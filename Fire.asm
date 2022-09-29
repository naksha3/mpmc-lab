.MODEL SMALL
.DATA
 PB EQU 0D801H
 PC EQU 0D802H
 CR EQU 0D803H
FIRE DB 86H,88H,0F9H,8EH
 HELP DB 8CH,0C7H,86H,89H
.code
 MOV AX, @DATA ;
 MOV DS, AX ; DATA segment Initialization
 MOV AL, 80H ; Port A, B & C - Output
 MOV DX, CR ;
 OUT DX, AL ; Initialize 8255
 MOV CX, 10 ; Display FIRE & HELP 10 times
 RPT: PUSH CX
 LEA SI, FIRE ; Store offset address of message “DATA_fire” IN si
 CALL DISPLAY ; Display message “FIRE”
 CALL DELAY
 LEA SI, HELP ; Store offset address of message “DATA_help” IN si
 CALL DISPLAY ; Display message “HELP”
 CALL DELAY
 POP CX
 LOOP RPT
 MOV AH, 4CH
 INT 21h ; Exit to DOS
DELAY PROC
 PUSH CX
 PUSH BX
 MOV CX, 1000H
 LOOP2:MOV BX, 0FFFFH
LOOP1:DEC BX
 JNZ LOOP1 ; Repeat INNER loop FFFF times
 LOOP LOOP2 ; Repeat OUTER loop 1000h times
 POP BX
 POP CX
 RET
DELAY ENDP
DISPLAY PROC
 MOV BL, 4 ; Four display codes to be sent
BACK2:MOV CL, 8 ; Eight bits IN each display code
 MOV AL, [SI]
BACK1:ROL AL, 1
 MOV DX, PB ;
 OUT DX, AL ; DATA bit sent over PB0
 PUSH AX
 MOV AL, 1 ; SEND falling edge of the pulse over PC0
 MOV DX, PC ;
 OUT DX, AL ;
 DEC AL ;
 OUT DX, AL ;
 POP AX
 DEC CL
 JNZ BACK1 ; Check if ALl 8 bits are sent or not
 INC SI
 DEC BL
 JNZ BACK2 ; Check if ALl 4 display codes sent or not
 RET
DISPLAY ENDP
END
