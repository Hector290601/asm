Page 60, 132 ;Define el tamaño máximo de líneas para listar en una página y el número máximo de caracteres por línea
Title EXAMEN FINAL ;Se usa para que el títlo que definamos aparezca en la segunda línea de todas las páginas
calc macro A,B,C,D ;Crea un macro llamado calc, que recibe los parámetros A, B, C y D
	local @salta3 ;Crea una variable local llamada salta3, la cuál es una pila y la cuál existe dentro del macro, pero no fuera de él
	mov ax,01 ; Mueve el valor 01d al registro ax, en específico a la parte baja
	mov bx, A ;mueve el parámetro A al registro b
	mov dx,C ;mueve el parámetro C al registro d
	sub dx,2 ;resta 2 al valor que se tiene en el registro d
	mov cx,dx ;mueve el contenido del registro d al registro c
@salta3: ;esto es lo que hace la variable salta3
	mul bl ;multiplica b1 por cl
              loop @salta3 ;reinicia el ciclo salta3, haciendo un for, para realizar el factorial de b
	mov bx,B ;coloca el parámetro B en el registro b
	mul bl ;multiplica el  factorial de C por B
	mov D,ax ; coloca el valor del registro ax en el parámetro D
calc endm ;termina el macro
.model small ;establece el modelo de la memoria a small, que se compone de un segmento de código y uno de datos
.stack 64 ;establece el tamaño del stack en 64 decimal
.data ;establece que lo escrito a continuación va al segmento de datos
x  dw  02 ;establece el valor de la variable X a 02, con un tamaño de double word
Y  dw  00 ;establece el valor de la variable Y a 00, con un tamaño de double word
W  dw  02 ;establece el valor de la variable W a 02, con un tamaño de double word
array  dw  00, 00, 00, 00, 00, 00, 00, 00 ;establece un arreglo de 1 x 8 elementos de tamaño double word
n dw 5 ;establece el valor de n a 5 con tamaño double word
coef dw  01, 03, -05, 03 ;establece el valor de coef al arreglo indicado, con tamaños de double word
.code ;indica que lo que sigue a continuación va al segmento de código del programa
Principal   proc  far ;crea el procedimiento llamado principal
	mov ax, @data ;mueve la pila data al registro ax
	mov ds, ax ;mueve el valor del registro ax al segmento ds, que es el segmento de datos, el cuál puede contener datos, variables o áreas de trabajo definidas.
	mov es, ax ;mueve el valor del registro ax al registro es, el cuál se usa en cadenas con caracteres para manejar el direccionamiento de memoria
	push x ;añade el valor de x a la pila, disminuyendo sp en dos
	lea dx, array ;obtiene la dirección real de array y lo coloca en el registro dx
	push dx ;añade el valor de dc a la pila, disminuyendo sp en dos
call GEN ;llama al procedimiento GEN, antes de eso, guarda el valor del IP y termina el pipeline
	pop dx ;elimina a dx del stack y aumenta el valor de sp en dos
	pop dx ;vuelve a eliminar dx del stack
	lea di , array ;obtiene la dirección real de array y lo guarda en di, el cuál es el registro del destination index
	lea si, coef ;obtiene la dirección real de coef y lo guarda en si, el cuál es el registro del source index
	add di,14 ;suma 14 al valor del registro di
	mov dx,02 ;coloca el valor 02 en el segmento dx
mov bx,00 ;coloca el valor 0 en el segmento b
mov cx,08 ;colova el valor 3 en el segmento c
@salta2: ;definición de salta2
Inc bx ;incrementa bx
mov ax,bx ;coloca el valor de bx en ax
div dl ;divide el valor de dl en ax
cmp ah, 00 ;compara el valor de ah con 00
jne @dont ;si no es igual a cero, salta a la pila dont
mov ax,[si] ;coloca el valor de si en ax
	mul byte ptr[di] ;multiplica los bits del apuntador di con el valor de ax
	add Y, ax ;suma ax al valor de Y
	inc si ;incrementa si
	inc si ;incrementa si
@dont: ;definición de dont
	dec di ;decrementa el valor de di en uno
	dec di ;decrementa el valro de di en uno
	loop @salta2 ;ejecuta la pila salta2 haciendo un for
	calc Y,x,n,W ;llama al macro calc con los parámetros Y, x, n y W
	mov ax, 04c00h ;coloca el valor 4c00h en el segmento ax
	int 21h ;llama a la interrupción 21h,
Principal  endp ;termina el procedimeinto principal
GEN proc far ;crea el procedimiento GEN como un procedimiento lejano
	mov bp,sp ;mueve el valor de sp, el cuál es el stack pointer al registro bp, el cuál permite la referencia a parámetros
	mov dx,[bp] ;mueve el apuntador de bp con el registro dx
	mov si, [bp+2] ;mueve el apuntador de bp + 2 al registro si
	mov ax,01 ;mueve el valor 01 al registro ax
	mov cx,08 ;mueve el valor 03 al registro cx
@salta: ;definición de salta
	mul dl ;multiplica dl
	mov [si],ax ;mueve el valor de ax al apuntador de si
	inc si ;incrementa el valor de si
	inc si ;incrementa el valor de si
	loop @salta ;hace un bucle
	ret ;regresa el control al sistema
GEN endp ;termina el procedimiento GEN
