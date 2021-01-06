.MODEL SMALL
.286	; чтобы использовать команды pusha popa
print macro f1		;вывод сообщений на экран
	push ax
	push dx
	mov dx,offset f1
	mov ah,9
	int 21h
	pop dx
	pop ax
endm
input macro f2		;ввод строки символов
	push ax
	push dx
	mov dx,offset f2
	mov ah,0ah
	int 21h
	pop dx
	pop ax
endm
curspos macro a,b 
	pusha
	mov dh,a
	mov dl,b 
	mov ah,02
	mov bh,0
	int 10h
	popa
endm 
.data
mess1 db 'Start: press r -- Stop: press s$'
mess2 db 'Insert / remove cell: press i$'
mess4 db 'Exit: press q$'
mess3 db 'Cursor control: arrows$'
mess5 db 'The Game "Life"$'
sec db ?
t db '%', '$'
non db ' ', '$'
sosed db ' ', '$'
arr1 db 800 dup (0), '$'
arr2 db 800 dup (0), '$'
.stack 256
.code
start:	mov ax,@data;установка dx
	mov ds,ax
	mov ax, 0003h	;режим
	int 10h
	mov ax, 600h	;рисуем левый квадрат (5;0) (24:39)
	mov cx, 500h
	mov dx, 1827h
	mov bh, 6ah
	int 10h
	mov ax, 600h	;рисуем правый квадрат (5;40) (24:79)	
	mov cx, 528h
	mov dx, 184fh
	mov bh, 89h
	int 10h
	curspos 0,31	;выводим на экран инструкцию
	print mess5
	curspos 1,23
	print mess1
	curspos 2,25
	print mess2
	curspos 3,28
	print mess3
	curspos 4,32
	print mess4
	mov bh, 5
	mov bl, 0
	curspos bh,bl
key:				;заполнение полей
	mov ah,8
    int 21h
	cmp al,69h
	jz @ins
	cmp al, 72h
	jnz t5
	jmp @run
t5:	cmp al,71h
    jnz t1
	jmp @exit
t1:    cmp al,0
    jnz key
    int 21h
    cmp al,75  
    jnz t3
	jmp @lt
t3:	cmp al,77  
    jnz t2
	jmp @rt
t2:    cmp al,80
    jnz t4
	jmp @dn
t4:    cmp al,72
    jnz key
@up:					;нажата стрелочка вверх
    dec bh
	cmp bh, 5h
	jge m_up
	add bh, 14h
m_up:curspos bh,bl
    jmp key
@ins:					;вставка живой клетки
	pusha
	mov di, offset arr1
	mov al, bh
	xor ah, ah
	mov cx, 28h
	sub ax, 5h
	mul cx
	xor bh, bh
	add ax, bx
	add di, ax
	mov ah, 1h
	mov al, 0h
	mov dl, [di]
	cmp dl, 1h
	je o
	mov [di],ah
	print t
	jmp m1
o:	mov [di],al
	print non
m1:	popa
	curspos bh,bl
	jmp key
@run: mov ah,8
    int 21h				;запуск игры "жизнь"
	cmp al, 0
	je pp
	cmp al,73h
	jnz pp
	jmp key
pp:	pusha 
	mov si, offset arr1
	mov di, offset arr2
	call processing
	call dly_time
	mov si, offset arr1
	mov di, offset arr2
	call draw
	popa
	jmp @run
@dn:					;нажата стрелочка вниз
    inc bh
	cmp bh, 18h
	jle m_dn
	sub bh, 14h
m_dn:	curspos bh,bl
    jmp key
@lt:   					;нажата стрелочка влево
	dec bl
	cmp bl, 0h
	jge m_lt
	add bl, 28h
m_lt:	curspos bh,bl
    jmp key
@rt:					;нажата стрелочка вправо
    inc bl
	cmp bl, 27h
	jle m_rt
	sub bl, 28h
m_rt:	curspos bh,bl 
	jmp key
@exit:
	curspos 24,79		;нажата q и мы выходим из программы
	mov ax,4c00h
	int 21h
dly_time proc 
	pusha
	mov ah,2ch; получить время:	ch-час, cl - мин, dh-сек, dl-сотая доля сек
	int 21h
	add dh,1h; задержка  1 сек
	cmp dh,60
	jb m2
	sub dh,60; скорректируем, если получили значение больше 60 сек
m2:	mov sec,dh; сохраним
check:	mov ah,2ch; спрашиваем время
	int 21h
	cmp dh,sec; сравниваем с заданным
	jne check ; если время не вышло - опрос
	popa ; иначе - выход
	ret
dly_time endp
processing proc ;процедура для обработки живых и неживых клеток 
				;в si - адрес массива клеток (800 значений)
				;в di - адрес массива соседей (800 значений)
	xor cx, cx 	;номер элемента в массиве
	xor bx, bx	;номер элемента в строчке, для соединения лева и права
	mov dh, 1h	;для оживления клеток
	xor dl, dl	;для убийства клеток
countryman:	
	xor ax, ax
	cmp cx, 0	;рассмотрим уникальные углы. Хоть
	jne k1		;условий становится больше, но логика проще.
	jmp lu
k1:	cmp cx, 39
	jne k2
	jmp ru 
k2:	cmp cx, 760
	jne k3
	jmp ld
k3:	cmp cx, 799
	jne k4
	jmp rd
k4:	cmp bx, 0	;рассмотрим граничные условия, без уникальных углов.
	jne k5
	jmp l
k5:	cmp bx, 39
	jne k6
	jmp r
k6:	cmp cx, 40
	jge k7
	jmp u
k7:	cmp cx, 760
	jl k8
	jmp d
k8:	add al, [si+1]	;если мы с клеткой не из граничных условий
	add al, [si-1]	;
	add al, [si+40]	;si-41--si-40--si-39
	add al, [si-40]	;||		||		||
	add al, [si+41]	;si-1 --si -- si+1
	add al, [si-39]	;||		||		||
	add al, [si+39]	;si+39--si+40--si+41
	add al, [si-41]	;
	
go:	mov [di], al
	inc si
	inc di
	inc cx
	inc bx
	cmp bx, 40
	jne k9
	xor bx, bx 
k9:	cmp cx, 800
	jl countryman 
	sub si, 800
	sub di, 800
	sub cx, 800
population:
	mov ah, [di]
	mov al, [si]
	cmp ah, 3h		;если 3 соседа, либо рождается,
	je live			;либо продолжает жить
	cmp al, 1h		;если клетка живая
	jne rn 
	cmp ah, 2h		;и имеет 2 соседей 
	je live 		;то, клетка выживает
	mov [si], dl
	jmp rn
live:	mov [si], dh
rn:	inc si
	inc di
	inc cx
	cmp cx, 800
	jl population 
	ret 
lu:	
	add al, [si+39]	
	add al, [si+799]
	add al, [si+760]	;si+799--si+760--si+761
	add al, [si+761]	;||		||		||
	add al, [si+1]		;si+39--si -- si+1
	add al, [si+41]		;||		||		||
	add al, [si+40]		;si+79--si+40--si+41
	add al, [si+79]
	jmp go
ru:
	add al, [si-1]	
	add al, [si+759]	
	add al, [si+760]	;si+759--si+760--si+721
	add al, [si+721]	;||		||		||
	add al, [si-39]		;si-1 --si -- si-39
	add al, [si+1]		;||		||		||
	add al, [si+40]		;si+39--si+40--si+1
	add al, [si+39]
	jmp go
ld:
	add al, [si+39]
	add al, [si-1]
	add al, [si-40]
	add al, [si-39]
	add al, [si+1]
	add al, [si-759]
	add al, [si-760]
	add al, [si-721]
	jmp go
rd:
	add al, [si-1]
	add al, [si-41]
	add al, [si-40]
	add al, [si-79]
	add al, [si-39]
	add al, [si-799]
	add al, [si-760]
	add al, [si-761]
	jmp go
l:
	add al, [si+39]
	add al, [si-1]
	add al, [si-40]
	add al, [si-39]
	add al, [si+1]
	add al, [si+41]
	add al, [si+40]
	add al, [si+79]
	jmp go
r:
	add al, [si-1]
	add al, [si-41]
	add al, [si-40]
	add al, [si-79]
	add al, [si-39]
	add al, [si+1]
	add al, [si+40]
	add al, [si+39]
	jmp go
u:
	add al, [si-1]
	add al, [si+759]
	add al, [si+760]
	add al, [si+761]
	add al, [si+1]
	add al, [si+41]
	add al, [si+40]
	add al, [si+39]
	jmp go
d:
	add al, [si-1]
	add al, [si-41]
	add al, [si-40]
	add al, [si-39]
	add al, [si+1]
	add al, [si-759]
	add al, [si-760]
	add al, [si-761]
	jmp go
processing endp
draw proc
	pusha			;в si хранится массив для вывода
	mov bh, 5
	mov bl, 0
	xor cx,cx 
cy:	curspos bh, bl
	xor ax, ax
	mov al, [si]
	cmp al, 1h
	jne N
	print t
	jmp next
N:	print non	
next:
	cmp cx, 799
	je ot
	push bx 
	mov bx, offset sosed
	mov al, [di]
	add al, 30h
	mov [bx], al 
	pop bx
	mov ah, bl 
	add ah, 28h
	curspos bh, ah
	print sosed 
ot:	curspos 0,0
	inc cx 
	cmp cx, 800
	je e
	inc si
	inc di
	inc bl
	cmp bl, 40
	jne cy 
	xor bl,bl
	inc bh
	jmp cy
e:
	popa
	ret
draw endp
end start