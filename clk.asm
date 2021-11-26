Page 60, 132
Title Clock
.model small
.stack 64
.data
;Inicio Variables
timeStr db 'HH:MM:SS:CS','$'
diez eq 10
;Fin Variables
.code
Main proc far
	mov ax,@data
	mov ds,ax
	mov es,ax
	;Código
	mov ah,02ch
	int 21h
	xor ax, ax
	mov al, dl
	mov ah,04ch
	mov al,0
	mov bl, diez
	div bl; Separar el msd ah
	; centésimas de segundo
	xor al,30h
	xor ah,30h
	mov bx,offset timeStr
	mov [bx+9],al
	mov [bx+10],ah
	;Segundos
	xor al,30h
	xor ah,30h
	mov bx,offset timeStr
	mov [bx+6],al
	mov [bx+7],ah
	;Minutos
	xor al,30h
	xor ah,30h
	mov bx,offset timeStr
	mov [bx+3],al
	mov [bx+4],ah
	;Horas
	xor al,30h
	xor ah,30h
	mov bx,offset timeStr
	mov [bx+0],al
	mov [bx+1],ah
	;fin
	mov ah,02h
	mov dl,11
	mov dh,39
	int 010h
	mov ah,09h
	mov dx,offset timeStr
	int 21h
	;FinCodigo
	int 21t
Main endp
end Principal
