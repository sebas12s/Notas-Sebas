# Notas de Git
En la terminal ejecutamos este primer comando

`git init` esto se ejecuta para decir donde estan todos los archivos como la carpeta donde estaran todos

`git status` nos muestra el estatus o si hay commits y asignar

`git add "el nombre del archivo"` esto como que agrega el archivo para que git pueda ver sus cambios y asi para agregarlos a git, tambien se usa `git add .` para agregar todos los archivos    

`git rm --cached "nombre del archivo"` cpm esto se le quita el add

`git commit -m "mensaje"` esto envia los cambios solo con el commit es suficiente pero es una mala practica no dejarle un mensaje

## Git log
`git log` esto muestra todos los cambios que se han hecho  

`git log --stat` esto muestra mas detalladamente los cambios

`git log --all` te muestra mas cosas

`git log --all --graph` te muestra como unas flechitas como el git mejorado

`git log --all --graph --decorate --oneline` esto te muestra todo mas comprimido y mas bonito

`git log --oneline` esto muestra solo los commits

## Git add 
`git add .` se agrega a una aerea separada y espera que lo envies al repositorio que se creo .git entonces si lo queremos enviar le damos un commit 

El repositorio el nombre por defecto que tiene es master
en nombres especificos es asi:
cuando no le hemos dado git add el archivo esta sin rastrear o untracked
cuando le damos git add se envia a la memoria ram o a esa area que se llama staging 
ahi espera a enviarlo al repositorio que se llama master que se hace con git commit 