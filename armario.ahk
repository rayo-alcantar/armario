#include reader.ahk

;hacemos la bienvenida como en todos mis programas, dando la versión actual.
version := 0.1
soundplay, sounds\open.mp3
sleep, 3000
speaking("Armario by pancho, versión " version)
sleep, 1000
;hacemos la variable global para los roandoms
global r1:=0
global r2:=0
global r3:=0

;hacemos los archivos necesarios.
IfNotExist categories\config.ini
{
	IniWrite, 1, categories\config.ini, arriba, clave
	IniWrite, 1, categories\config.ini, abajo, clave
	IniWrite, 1, categories\config.ini, otros, clave
}

IfNotExist categories\arriba.txt
{
	speaking("creando categoría superior")
	sleep, 1000
	Fileappend, arriba`n, categories\arriba.txt
}
else{
	speaking("Listo.")
	sleep, 300
}
;hacemos el archivo abajo.
IfNotExist categories\abajo.txt
{
	speaking("Creando categoría inferior...")
	Fileappend, Abajo.`n, categories\abajo.txt
}
else {
	speaking("Listo.")
	sleep, 400
}
;verificamos que esté el achivo otros. y si no, se crea.
IfNotExist categories\otros.txt
{
	speaking("Creando categoría otros...")
	sleep, 300
	Fileappend, Otros.`n, categories\otros.txt
}
else{
	speaking("Listo.")
	sleep, 400
}
;haemos el menú para las categorías
menu, categoria, add, Parte superior, arriba
menu, categoria, add, Parte inferior, abajo
menu, categoria, add, Prendas extra, otros
gui, add, text,, Armario elije una opción.
gui, add, button, Gagregar, &Agregar una prenda
gui, add, button, Grandom, &Randomizar oufit
gui, add, button, Gsalir, &Cerrar el armario
gui, show,, Armario by pancho
return
;hacemos las etquetas para la gui
agregar:
speaking("Elige la categoría a la que le deseas añadir una prenda.")
sleep, 500
menu, categoria, show
return
random:
aleatorio()
return
salir:
speaking("Cerrando armario..")
soundplay, sounds\close.mp3
sleep, 3000
exitapp
return

;Hacemos las etiqutas para los mensú.
arriba:
agregar("arriba")
return
abajo:
agregar("abajo")
return
otros:
agregar("otros")
return

;hacemos la función agregar
agregar(d)
{
	;hacemos la variable para el texto de la prenda.
	inputbox, p, Prenda, Escribe la prenda a añadir; si quieres con descripción.
	;la añadimos
	fileappend, %p%`n, categories\%d%.txt
	;Tomamos la clave (que será el número de línea de cada archivo) y la modificamos, aumentando en 1.
	IniRead, o, categories\config.ini, %d%, clave
	o+=o
	IniWrite, %o%, categories\config.ini, %d%, clave
}
;hacemos la función aleatorio.
aleatorio()
{
	;leemos las líneas que tiene cada archivo.
	IniRead, o, categories\config.ini, arriba, clave
	IniRead, o2, categories\config.ini, abajo, clave
	IniRead, o3, categories\config.ini, otros, clave
	;hacemos variables random para saber cual vamos a arrojar. pero antes, nos aseguramos de que no salga una línea  en balnco.
	o-=1, o2-=1, o3-=1
	random, r1, 2, %o%
	random, r2, 2, %o2%
	random, r3, 2, %o3%
	;tomamos el texto de las líneas.
	FileReadLine, l1, categories\arriba.txt, r1
	FileReadLine, l2, categories\abajo.txt, r2
	FileReadLine, l3, categories\otros.txt, r3
	msgbox, 48, Resultado, Puedes usar %l1%, con %l2% y %l3%.
}