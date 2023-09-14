# Visual Studio Code

## Atajos

## Chrome
* ctrl + shift + l    inspect


### VSCode
* ctrl + ,    configuraciones

* ctrl + shift + p    comand palette
* ctrl + /    comentar
* ctrl + alt +      comentar una parte de una linea
Este ultimo lo modifique yo, ponemos en toggle y lo que queremos modificar
* ctrl + click      si tenemos una ruta que no este el archivo lo crea o te envia al archivo que esta apuntando un un src

* alt + F12     sin salir del archivo podemos ojear la funcion
* ctrl + click      podemos ir a la funcion
* ctrl + cursor     podemos ver mas opciones de la funcion

* ctrl + w      elimina la pestaña
* ctrl + shift + t      abre de nuevo la pestaña
* ctrl + k + ctrl + w       esto cierra todas las pestañas
* ctrl + tab        para cambiar entre pestañas
* ctrl + n      crea un nuevo archivo

* ctrl + `      abre la terminal

* ctrl + p      buscador de archivos

creacion de carpetas y archivo    
* crear archivo     carpeta/archivo.sm      y asi se pueden poner muchas mas carpetas
* solo directorios      crear directorio

* ctrl + p => @     buscar entre funciones y eso
* ctrl + p => :     busca la linea que pongamos

* ctrl + k + v      preview markdown

### Activity bar
* ctrl + shift + e   explorer        
* ctrl + shift + f   buscador   
* ctrl + shift + g   git   
* ctrl + shift + d   debug
* ctrl + shift + x   extenciones

### Codigo
* ctrl + space      para las sugerencias de autocompletado
* tab       tabulacion
* shift + tab       tabulacion contraria
* ctrl + flecha     curso navega entre palabras
* ctrl + shift + flecha     selecciona entre palabras            

* alt + shift + f   ordena todo el codigo      
* alt + flechas     mueve toda la linea

* ctrl + shift + k      elimina toda la linea
* ctrl + shift + l      selecciona los que tengan algo parecido a la linea donde esta el cursor
* ctrl + z      deshacer
* ctrl + shift + z      rehacer

* ctrl + alt + s    hace que podamos crear etiquetas o encerrar en etiquetas muy rapido de la siguiente manera `li>ul>p.classname`  y asi

* alt + shift + flechas   copia la linea completa 
* ctrl + alt + flechas      crea mas cursores

* ctrl + D      selecciona lo que se parece

* alt + shift + i   crea muchos cursores si tienes muchas lineas seleccionadas 

* F2    remplaza digamos el nombre de una clase en todas las lineas donde se usa o se esta llamando 


* User Shipset: ctrl + shift + p, para crear shipset
```json
"Console Mar": {
    "prefix": "Mar",
    "body": [
      "console.log('${1:Marcela}');", //esto es para cuando queremos poner una palabra ya y para solo cambiarla, ya aparece toda seleccionada simplemente para cambiarla
      "$2" //este es para cuando le demos tab aparezca ahi el cursor como la siguiente etapa
    ],
    "description": "Console"
  }
```

Asi se pueden crear con multiples lineas, dato no se pueden poner taps
```json
"Class Hero": {
    "prefix": "clhero",
    "body": [
      "class ${1:Hero} {",
      "  constructor() {",
      "     console.log('${1:Hero} initialized');",
      "  }",
      "  show${1:Hero}() {",
      "     return this;",
      "  }",
      "} ",
      "$2"
    ],
    "description": "Class Hero"
  },
```


## Extenciones

* ctrl + shift + p  Todo higlight: para encontrar los comentarios
* ctrl + shift + p  CodeSnap: seleccionas el pedazo de codigo para tomarle, tocando la imagen se puede guardar la imagen o copiarla