.MODEL SMALL
.STACK


.DATA


    msgCadena1 DB 13,'Ingresa primer cadena: $',10,13, "$"
    msgCadena2 DB 10,13,'Ingresa segunda cadena: $', 10,13, "$"


    cadenaIgual DB 10,13, 'Son iguales $'
    cadenaNoIgual DB 10,13, 'No  son iguales $'


    cadenaIngresada DB 100 DUP('$')
    cadenaIngresada2 DB 100 DUP('$')


.CODE




    inicia:


    MOV AX,@DATA
    MOV DS, AX




    ;Mensaje
    MOV AH,09
    LEA DX,msgCadena1
    INT 21H


 
    LEA si, cadenaIngresada ; cargar primera cadena
    leerCadena1:
        MOV AX,0000
        mov AH,01H
        int 21H


        ;Guardamos el valor tecleado por el usuario en la posición si del vector
        mov [si],al
        inc si ;Incrementamos nuestro contador
        cmp al,0dh ;Se repite el ingreso de datos hasta que se teclea ENTER


        ja leerCadena1
       


    ;Mensaje
    MOV AH,09
    LEA DX,msgCadena2
    INT 21H




    ;cargamos en si la segunda cadena
    LEA si, cadenaIngresada2
    leerCadena2:
        MOV AX,0000
        mov AH,01H
        int 21H


        ;Guardamos el valor tecleado por el usuario en la posición si del vector
        mov [si],al
        inc si ;Incrementamos nuestro contador
        cmp al, 0dh ;Se repite el ingreso de datos hasta que se teclea ENTER
        ja leerCadena2
       


        mov cx,100   ;Cantidad a comparar, usamos 100 porque "si" tiene 100, 100 posiciones del array pues




;-----CREAR REGISTRO EXTRA PARA PONER AHÍ LA CADENA 2


    MOV AX,DS  ;mueve el segmento datos a AX
    MOV ES,AX  ;Mueve los datos al segmento extra para poder usar el cmpsb
;----------------------------------------------------


       
    comparar:
       
        lea si,cadenaIngresada ;cargamos en 'si' la cadena que contiene cadenaIngresaa
        lea di,cadenaIngresada2 ;cargamos en 'di' la cadena que contiene cadenaIngresada2


        repe cmpsb  ;compara las dos cadenas


        Jne diferente
        je iguales




    diferente:
        mov ah,09
        mov dx,offset cadenaNoIgual
        int 21h


        mov ah,04ch
        int 21h


   
    iguales:
        mov ah,09
        mov dx,offset cadenaIgual
        int 21h


        mov ah,04ch
        int 21h


END
