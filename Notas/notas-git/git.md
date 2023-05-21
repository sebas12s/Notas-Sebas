# Notas de Git
En la terminal ejecutamos este primer comando

`git init` esto se ejecuta para decir donde estan todos los archivos como la carpeta donde estaran todos

`git status` nos muestra el estatus o si hay commits y asignar

`git add "el nombre del archivo"` esto como que agrega el archivo para que git pueda ver sus cambios y asi para agregarlos a git, tambien se usa `git add .` para agregar todos los archivos    

`git rm --cached "nombre del archivo"` cpm esto se le quita el add

`git commit -m "mensaje"` esto envia los cambios solo con el commit es suficiente pero es una mala practica no dejarle un mensaje

---

## Configuracion
`git config` esto muestra todas las configuraciones que se le puede dar 

`git config --list` este comando te muetra la configuracion por defecto de tu git

`git config --list --show-origin` esto te muestra donde esta guardado los cambios

para cambiar el usuario y el email se usa lo siguiente:

`git config --global user.name "tu usuario"`

`git config --global user.email "tu email"`

---

## Git log
`git log` esto muestra todos los cambios que se han hecho  

`git log --stat` esto muestra mas detalladamente los cambios

`git log --all` te muestra mas cosas

`git log --all --graph` te muestra como unas flechitas como el git mejorado

`git log --all --graph --decorate --oneline` esto te muestra todo mas comprimido y mas bonito

`git log --oneline` esto muestra solo los commits

ahi se muestra unos numeros donde dice commit: esos numeros son como el nombre de esa modificacion como el ID

---

## Cambios
`git show "nombre del archivo"` esto te muestra los cambios que se hicieron

`git diff` nos mestra lo que se cambio

para ver los cambios de una o de otra ejecutamos:

`git diff` y los dos numeros que aparece con git log asi podemos comparar diferentes versiones, pone al principio la version mas vieja

---

## Git add 
`git add .` se agrega a una aerea separada y espera que lo envies al repositorio que se creo .git entonces si lo queremos enviar le damos un commit 

El repositorio el nombre por defecto que tiene es master
en nombres especificos es asi:
cuando no le hemos dado git add el archivo esta sin rastrear o untracked
cuando le damos git add se envia a la memoria ram o a esa area que se llama staging 
ahi espera a enviarlo al repositorio que se llama master que se hace con git commit 

---

## Ramas