.model small
.data
.code
pa equ 0c800h
pb equ 0c801h
pc equ 0c802h
cr equ 0c803h
count db 10
mov ax,@data
mov ds,ax
mov dx,cr
mov al,80h
out dx,al
mov bh,count
mov al,88h ; at a time one coil is selected
up:mov dx,pc
out dx,al
call delay
ror al,1 ; rotate anticlockwise dec
bh jnz up
mov bh,count
mov dx,pc
mov al,88h
back: out dx,al
call delay
rol al,1 ; rotate clockwise dec
bh
jnz back
mov ah,4ch
int 21h
delay proc
push cx
push dx
mov cx,8000h
outloop:mov dx,4000h
inloop: dec dx
jnz inloop
loop outloop
pop dx
pop
cx ret
delay endp
end
