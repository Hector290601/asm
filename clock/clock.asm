Page 60, 132
Title Reloj
.model small
.stack 64
.data
;Inicio variables
ten equ 10
esd equ 201d
hor equ 205d
ver equ 186d
esiz equ 187d
eid equ 200d
eii equ 188d
strArriba1 db esd, hor, hor, hor, hor, hor,'$'
strArriba2 db hor, hor, hor, hor, hor,hor, esiz, '$'
strAbajo1 db eid, hor, hor, hor, hor, hor,'$'
strAbajo2 db hor, hor, hor, hor, hor,hor, eii, '$'
strClk db ver, 'HH:MM:SS:CC', ver, '$'
;Fin variables
.code

Main proc far
	mov ax,@data
	mov ds,ax
	mov es,ax
	;Codigo
	;limpiar pantalla
	mov ah,0fh
	int 10h
	mov ah,0
	int 10h
	cuadrado:
		arriba1:
			mov ah,02h
			mov dl,39
			mov dh,10
			int 010h
			mov ah,09h
			mov dx,offset strArriba1
			int 21h
		arriba2:
			mov ah,09h
			mov dx,offset strArriba2
			int 21h
		abajo1:
			mov ah,02h
			mov dl,39
			mov dh,12
			int 010h
			mov ah,09h
			mov dx,offset strAbajo1
			int 21h
		abajo2:
			mov ah,09h
			mov dx,offset strAbajo2
			int 21h
	obtenerHora:
		mov ah,02ch
		int 21h
		xor ax,ax
		mov al,ch
	hora:
		mov bl,ten
		div bl
		xor al,30h
		xor ah,30h
		mov bx,offset strClk
		mov [bx+1],al
		mov [bx+2],ah
		xor ax,ax
		mov al,cl
	minuto:
		mov bl,ten
		div bl
		xor al,30h
		xor ah,30h
		mov bx,offset strClk
		mov [bx+4],al
		mov [bx+5],ah
		xor ax,ax
		mov al,dh
	segundo:
		mov bl,ten
		div bl
		xor al,30h
		xor ah,30h
		mov bx,offset strClk
		mov [bx+7],al
		mov [bx+8],ah
		xor ax,ax
		mov al,dl
	jmp continua1
	intermedio:
	jmp obtenerHora
	continua1:
	sentesimaSegundo:
		mov bl,ten
		div bl
		xor al,30h
		xor ah,30h
		mov bx,offset strClk
		mov [bx+10],al
		mov [bx+11],ah
	imprimir:
		mov ah,02h
		mov dl,39
		mov dh,11
		int 010h
		mov ah,09h
		mov dx,offset strClk
		int 21h
	in al,60h
		cmp al,081h
	mov ah,01h
	mov cx,02607h
	int 10h
	jne intermedio
	mov ah,0fh
	int 10h
	mov ah,0
	int 10h
	;finCodigo
	mov ah,04ch
	mov al,0
	int 21h
Main endp
end Main
