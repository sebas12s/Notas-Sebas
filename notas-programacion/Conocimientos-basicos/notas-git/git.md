# Notas de Git

Probando

'-' solo uno significa que usaras una letra

'--' significa que usaras una palabra

En la terminal ejecutamos este primer comando

- `git help` nos muestra la mayoria de comandos que podemos usar
- `git help comando` esto nos puede mostrar la documentacion de los comandos
- `git help --all` todas las opciones de git

## Configuracion

- `git config` esto muestra todas las configuraciones que se le puede dar
- `git config --list` este comando te muetra la configuracion por defecto de tu git
- `git config --list --show-origin` esto te muestra donde esta guardado los cambios

para cambiar el usuario y el email se usa lo siguiente:

- `git config --global user.name "tu usuario"`
- `git config --global user.email "tu email"`
- `git config --global -e` esto es para mostrarme los cambios de user y email y nos ayuda a modificarlos tambien

Para salir de esa interface se preciona Esc `:wq!` y listo

## Comandos

- `git init` asi se comienzan a gestionar los archivos y crea la carpeta de git
- `git config --global init.defaultBranch main` esto es para poner por defecto nuestra rama principal sea main
- `git status` nos muestra el estatus o si hay commits y asignar
- `git add "el nombre del archivo"` esto como que agrega el archivo para que git pueda ver sus cambios y asi para agregarlos a git, tambien se usa `git add .` para agregar todos los archivos
- `git reset "nombre del archivo"` esto le quita el add al archivo
- `git rm --cached "nombre del archivo"` con esto se le quita el add tambien
- `git commit -m "mensaje"` esto envia los cambios solo con el commit es suficiente pero es una mala practica no dejarle un mensaje, -m le estamos diciendo que le enviaremos un mensaje
- `git commit -am "mensaje"` este tambien hace el git commit pero solo con archivos que antes se le habian hecho add antes 
- `git checkout -- .` esto nos devuelve los cambios al ultimo commit
- `git show` Mostrara todos los cambios que hemos hecho, esto incluye las líneas que hemos cambiado, cuando y quien hizo dicho cambios.

## Git log

- `git log` esto muestra todos los cambios que se han hecho los commits
- `git log "nombre del archivo"` Muestra todo el historial del archivo
- `git log --stat` esto muestra mas detalladamente los cambios
- `git log --all` te muestra mas cosas
- `git log --all --graph` te muestra como unas flechitas como el git mejorado
- `git log --all --graph --decorate --oneline` esto te muestra todo mas comprimido y mas bonito
- `git log --oneline` esto muestra solo los commits

- `git log --oneline` Te muestra el id commit y el título del commit.
- `git log --decorate` Te muestra donde se encuentra el head point en el log.
- `git log --stat` Explica el número de líneas que se cambiaron brevemente.
- `git log -p` Explica el número de líneas que se cambiaron y te muestra que se cambió en el contenido.
- `git shortlog:` Indica que commits ha realizado un usuario, mostrando el usuario y el título de sus commits.
- `git log --graph --oneline --decorate`
- `git log --pretty=format:"%cn hizo un commit %h el dia %cd"` Muestra mensajes personalizados de los commits.
- `git log -3` Limitamos el número de commits.
- `git log --after=“2018-1-2”`
- `git log --after=“today” y`
- `git log --after=“2018-1-2” --before=“today”` Commits para localizar por fechas.
- `git log --author=“Name Author”` Commits hechos por autor que cumplan exactamente con el nombre.
- `git log --grep=“INVIE”` Busca los commits que cumplan tal cual está escrito entre las comillas.
- `git log --grep=“INVIE” –i` Busca los commits que cumplan sin importar mayúsculas o minúsculas.
- `git log – index.html` Busca los commits en un archivo en específico.
- `git log -S “Por contenido”` Buscar los commits con el contenido dentro del archivo.
- `git log > log.txt` guardar los logs en un archivo txt

ahi se muestra unos numeros donde dice commit: esos numeros son como el nombre de esa modificacion como el ID

## Cambios

- `git show "nombre del archivo"` esto te muestra los cambios que se hicieron en el ultimo commit
- `git diff` nos mestra lo que se cambio

Para ver los cambios de una o de otra ejecutamos:

- `git diff "primera clave" "segunda clave"` asi podemos comparar diferentes versiones, pone al principio la version mas vieja

## Checkout
`git checkout "la clave de la version" "el archivo que queremos que nos devuelva"` esto nos muestra en el archivo como era con la clave de la version
- `git checkout main "el archivo que queremos que nos devuelva"` con solo poner main nos muestra la ultima version
- `git checkout` esta es una manera de volver a versiones anteriores, igual tener mucho cuidado

## Reset
- `git reset "clave de la version" --hard` reset nos permite regresar, con hard todo!! vuelve al estado que le estemos diciendo
- `git reset "clave de la version" --soft` esto igual vuelve a la version anterior pero todavia guarda lo que tengamos en staging eso no se borra 

## Eliminar

## Ramas
Primera rama sabemos que se llama main la segunda rama es la experimental pero se le llama mas development si la rama actual la ultimma version muestra un bug un ejemplo, se le puede hacer otra rama eso le dicen hotfix despues lo arreglamos y lo enviamos a la ultima version eso se le conoce como un merge

- `git branch` nos muestra todas las ramas locales
- `git branch -a` lista todas las ramas locales y remotas.
- `git branch -r` esto muestra las ramas remotas

## Extras

- `git status --short` version compacta de status

- `git pull` una combinacion de fetch y merge
- `git fetch origin` trae los cambios de la rama
