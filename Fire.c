.model small
.data
fire db 00H,00h,79h,50H,30H,71H ; seven segment equivalent code for FIRE help db
73h,38h,79h,76h,00h,00h ; seven segment equivalent code for HELP
pa equ 0C800h
pb equ 0C801h
pc equ 0C802h
ctr equ 0C803h
.code
mov ax,@data
mov ds,ax
mov dx,ctr
mov al,80H ; all ports in output ports out dx,al
disp: mov DI,10
fire1: lea SI,fire ;call display dec DI
jnz fire1
mov DI,10
help1: lea SI,help ;call display dec DI
jnz help1
mov ah,06H
mov dl,0FFH
int 21h
jz disp
mov ah,4CH
int 21H
display proc
mov dx,pc
mov al,07H ;To enable all the digits out dx,al
mov cx,06H
mov bl,00
back: mov al,bl ;To select one digit from digit 1 to 6 (0-5) mov dx,pc
out dx,al
mov dx,pa
Lodsb ;Send the data to the selected digit out dx,al
call delay
inc bl ; increment bl to select next higher digit loop back
ret display
endp
delay proc
push CX
push dx
mov cx,0FFFH
outloop: mov dx,0FFFH
inloop: dec dx
jnz inloop
loop outloop
pop dx
pop cx
ret
delay
endp end