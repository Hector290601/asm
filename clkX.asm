Page 60, 132
Title relojito
.model small
.stack 64
.data
; aquí van las variables
diez equ 10
cadReloj db 'HH:MM:SS:CS','$'
.code
Principal   proc
	mov ax, @data
	mov ds, ax
	mov es, ax	
	; aquí va nuestro código
	; limpiar pantalla
	; limpia pantalla
	MOV AH,0FH;		limpia pantalla
	INT 10H
	MOV AH,0
	INT 10H
	
anima:
	;invocando tiempo del sistema	
	mov ah, 02ch
	int 21h
	; contruir la cadena
	; ch - hora  16 --????!!!OOOO 31h 36h   16/10 cociente1 res 6
	; cast de segundos a caracteres
	xor ax,ax
	mov al,ch;
    mov bl,diez
	div bl; separamos digitos al 1 msd ah 6 lsd
	xor al,30h
	xor ah,30h
	mov bx,offset cadReloj
	mov [bx],al
	mov [bx+1],ah ; ya hicimos cast	
	; cl - minutos  16 --????!!!OOOO 31h 36h   16/10 cociente1 res 6
	; cast de segundos a caracteres
	xor ax,ax
	mov al,cl;
    mov bl,diez
	div bl; separamos digitos al 1 msd ah 6 lsd
	xor al,30h
	xor ah,30h
	mov bx,offset cadReloj
	mov [bx+3],al
	mov [bx+4],ah ; ya hicimos cast	
	; dh - segundos  16 --????!!!OOOO 31h 36h   16/10 cociente1 res 6
	; cast de segundos a caracteres
	xor ax,ax
	mov al,dh;
    mov bl,diez
	div bl; separamos digitos al 1 msd ah 6 lsd
	xor al,30h
	xor ah,30h
	mov bx,offset cadReloj
	mov [bx+6],al
	mov [bx+7],ah ; ya hicimos cast	
	; dl - centésimas  16 --????!!!OOOO 31h 36h   16/10 cociente1 res 6
	; cast de CS a caracteres
	xor ax,ax
	mov al,dl;
    mov bl,diez
	div bl; separamos digitos al 1 msd ah 6 lsd
	xor al,30h
	xor ah,30h
	mov bx,offset cadReloj
	mov [bx+9],al
	mov [bx+10],ah ; ya hicimos cast	
	; ubicar en pantalla donde se va a imprimir
	mov ah,02h
	mov dl,39
	mov dh,11
	int 010h
	;imprimir string en pantalla
	mov ah,09h
	mov dx,offset cadReloj
	int 21h
    in al,60h
    ;dec al
	;sub al,081h
	cmp al,081h
    jne anima; jump if not equal
	
	; limpia pantalla
	MOV AH,0FH;		limpia pantalla
	INT 10H
	MOV AH,0
	INT 10H
	
	mov ah,04ch ; cede el control del programa al sistema operativo
	mov al,0
	int 21h
Principal  endp	
end Principal
