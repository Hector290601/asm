Page 60,132
Title FuncionamientoStack
.286
.model small
.stack 64
.data

X dw 09
Y dw 08h
Z dw 02
W db 0Eh
.code

Main proc far
	assume
	mov ax,@data
	mov ds,ax
	mov es,ax
	mov ax,X
	push ax
	push Y
	mov cx,offset Z
