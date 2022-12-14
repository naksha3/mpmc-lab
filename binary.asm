.MODEL SMALL

.DATA
ARR DW 1,2,3,4,5,6,7
LEN DW ($-ARR)/2
MSG1 DB "KEY IS FOUND$"
MSG2 DB "KEY IS NOT FOUND$"
X DW 10

.CODE
MOV AX,@DATA
MOV DS,AX
MOV SI,0000H 
MOV DI,LEN
ADD DI,DI
SUB DI,2 
RPT: CMP SI,DI 
JA KNF ; IF SI > DI jump to KNF
MOV AX,X ; AX= key
MOV BX,SI ;BX (MID) = (SI + DI )/2
ADD BX,DI
SHR BX,1
CMP AX,ARR[BX] 
JE KF ; if key = middle element jump to KF
JB NEXT ; if KEY < middle element jump to NEXT
MOV SI,BX ; if KEY > middle element low (SI) = mid (bx)+2
ADD SI,2
JMP RPT

NEXT:MOV DI,BX 
 SUB DI,2
 JMP RPT

KF: LEA DX,MSG1 
 MOV AH,09H
 INT 21H
 JMP EXIT 

KNF:LEA DX,MSG2
 MOV AH,09H
 INT 21H

EXIT: MOV AH,4CH
 INT 21H
 END