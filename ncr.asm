COUT MACRO VAR
	MOV AH, 2
	MOV DL, VAR
	INT 21H
ENDM
.MODEL SMALL

.DATA
	N DB 8
	R DB 4
	RES DB ?
.CODE
	MOV AX, @DATA
	MOV DS, AX

	MOV RES, 0
	MOV AH, N
	MOV AL, R

	CALL NCR

	;Result Display
	MOV AL, N
	MOV AH, 0
	CALL DISPLAY

	COUT 'C'

	MOV AL, R
	MOV AH, 0
	CALL DISPLAY

	COUT ' '
	COUT '='
	COUT ' '

	MOV AL, RES
	MOV AH, 0
	CALL DISPLAY

	JMP EOF

	NCR PROC NEAR
		
		; r == 0
		CMP AL, 0
			JE ONE

		; r == n
		CMP AL, AH
			JE ONE

		; r == 1
		CMP AL, 1
			JE EN

		MOV BH, AH
		DEC BH
		; r == n - 1
		CMP AL, BH 
			JE EN
		
		DEC AH
		PUSH AX
		CALL NCR
		POP AX

		PUSH AX
		DEC AL
		CALL NCR
		POP AX
		RET

		ONE:
			ADD RES, 1
			RET 
			
		EN:
			ADD RES, AH
			RET 
	NCR ENDP

	DISPLAY PROC NEAR
		PUSH CX

		MOV BX, 10     ;INITIALIZES DIVISOR
		MOV DX, 0000H    ;CLEARS DX
		MOV CX, 0000H    ;CLEARS CX
    
		;SPLITTING PROCESS STARTS HERE
		L1:  MOV DX, 0000H    ;CLEARS DX DURING JUMP
		DIV BX      ;DIVIDES AX BY BX
		PUSH DX     ;PUSHES DX(REMAINDER) TO STACK
		INC CX      ;INCREMENTS COUNTER TO TRACK THE NUMBER OF DIGITS
		CMP AX, 0     ;CHECKS IF THERE IS STILL SOMETHING IN AX TO DIVIDE
		JNE L1     ;JUMPS IF AX IS NOT ZERO
    
		L2:
		POP DX      ;POPS FROM STAK TO DX
		ADD DX, 30H     ;CONVERTS TO IT'S ASCII EQUIVALENT
	
		MOV AH, 02H     
		INT 21H      ;CALLS DOS TO DISPLAY CHARACTER
		LOOP L2    ;LOOPS TILL CX EQUALS ZERO

		POP CX
		RET 
	DISPLAY ENDP

	EOF:
		MOV AH, 4CH
		INT 21H
END