# Notas de Git

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
- `git config --global init.defaultBranch main` esto es para poner por defecto nuestra rama principal sea main

para cambiar el usuario y el email se usa lo siguiente:

- `git config --global user.name "tu usuario"`
- `git config --global user.email "tu email"`
- `git config --global -e` esto es para mostrarme los cambios de user y email y nos ayuda a modificarlos tambien

Para salir de esa interface se preciona Esc `:wq!` y listo
Para salir del editor de codigo de git le da uno esc despues `:x!`

## Basico

- `git init` asi se comienzan a gestionar los archivos y crea la carpeta de git
- `git status` nos muestra el estatus o si hay commits y asignar
- `git add "el nombre del archivo"` esto como que agrega el archivo para que git pueda ver sus cambios y asi para agregarlos a git, tambien se usa `git add .` para agregar todos los archivos
- `git commit -m "mensaje"` esto envia los cambios solo con el commit es suficiente pero es una mala practica no dejarle un mensaje, -m le estamos diciendo que le enviaremos un mensaje
- `git commit -am "mensaje"` este tambien hace el git commit pero solo con archivos que antes se le habian hecho add antes

## Comandos

- `git reset "nombre del archivo"` esto le quita el add al archivo
- `git rm --cached "nombre del archivo"` con esto se le quita el add tambien
- `git reset HEAD` esto le quita el add a los archivos
- `git checkout -- .` esto nos devuelve los cambios al ultimo commit

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
- `git shortlog` Indica que commits ha realizado un usuario, mostrando el usuario y el título de sus commits.
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

- `git show` Mostrara todos los cambios que hemos hecho, esto incluye las líneas que hemos cambiado, cuando y quien hizo dicho cambios.
- `git show "nombre del archivo"` esto te muestra los cambios que se hicieron en el ultimo commit
- `git diff` nos mestra lo que se cambio

Para ver los cambios de una o de otra ejecutamos:

- `git diff "primera clave" "segunda clave"` asi podemos comparar diferentes versiones, pone al principio la version mas vieja

## Checkout

- `git checkout "la clave de la version" "el archivo que queremos que nos devuelva"` esto nos muestra en el archivo como era con la clave de la version

- `git checkout main "el archivo que queremos que nos devuelva"` con solo poner main nos muestra la ultima version
- `git checkout` esta es una manera de volver a versiones anteriores, igual tener mucho cuidado

## Reset

- `git reset "clave de la version" --hard` reset nos permite regresar, con hard todo!! vuelve al estado que le estemos diciendo
- `git reset "clave de la version" --soft` esto igual vuelve a la version anterior pero todavia guarda lo que tengamos en staging eso no se borra
- `git reset --hard HEAD` elimina los cambios realizados que aún no se hayan hecho commit.

## Eliminar

- `git rm --cached` este comando permite borrar archivos este borra del staging y del directorio local pero los deja en el disco duro
- `git rm --force` borra en todos lados se puede recuperar pero se usan comandos mas avanzados

## Ramas

Primera rama sabemos que se llama main la segunda rama es la experimental pero se le llama mas development si la rama actual la ultimma version muestra un bug un ejemplo, se le puede hacer otra rama eso le dicen hotfix despues lo arreglamos y lo enviamos a la ultima version eso se le conoce como un merge

Al crear una rama toma nuestro ultimo commit y crea la rama

- `git branch` nos muestra todas las ramas locales
- `git branch --all` asi podemos ver las ramas del repostorio y el repositorio remoto
- `git branch -a` lista todas las ramas locales y remotas.
- `git branch -r` esto muestra las ramas remotas

- `git branch "el nombre"` con esto podemos crear una rama 
- `git checkout "el nombre de la rama"` asi podemos cambiar a la otra rama para trabajar en ella con `git status` podemos ver en que cabecera es en la que estamos
- `git checkout -b "nombre_rama"` es una union de branch y ckeckout, crea la rama y me cambia a ella
- `git checkout -` cambia a la rama anterior en la que estabas


head es un indicador de cual version estamos

- `git show-branch` esto muestra el history de las brach y cual era
- `git show-branch --all` esto muestra algo similiar pero con mas datos

- `git push origin "el nombre de la rama"` esto es para enviar nuestras branch a repositorio remoto
- `git branch -M "nombre"` esto mueve todos los cambios de la rama actual a la rama que estamos poniendo pero esto borra la rama actual no lo hagan
- `git push "repositorio remoto" --delete "el nombre de la rama"` eliminar una rama del repositorio remoto
- `git branch -d "el nombre del branch"` asi se borra la branch del local

Recordar que marge es como un commit entonces tiene que llevar un mensaje git merge se puede hacer en cualquier rama para traer las ultimas versiones del trabajo

- `git merge "el nombre de la rama que quermos unir"` esto une la rama actual con la que pongamos, pero los cambios se quedan en la rama que estemos

## Remote

Normalmente el repositorio remoto se llama `origin` 

- `git clone url_del_servidor_remoto` nos trae una copia master a nuestro directorio y todos los cambios al repositorio local esto lo trae del repositorio remoto
- `git push` ejecutamos esto despues de hacer add y commit entonces cuando ejecutemos enviamos la ultima version del repositorio local al repositorio remoto
- `git fetch` esto trae del repositorio remoto las actualizaciones a nuestro repositorio local trae todos los cambios
- `git merge` como solo el fetch no te lo copia en tus archivos entonces tienes que hacer este comando para que te lo copie y puedas trabaajar en el
- `git pull` este fuciona ambos conceptos entonces trae los cambios a nuestro repositorio local y despues lo copia a nuestros archivos (pull, merge)

## Tag
- `git tag -a "v0.1"` el nombre puede ser el que quieras pero es normal ponerle ese nombre
- `git tag -a v0.1 -m ""` con la m es obligatorio que lleve un mensaje
- `git tag -a v0.1 -m "" "la clave del commit"` asi le puedo poner tag a antiguos commits
- `git tag` si solo ponemos asi podemos ver los tags que tenemos
- `git show-ref --tags` pero asi muestra la clave de donde esta ese tag 
- `git push origin --tags` asi podemos subir nuestro tags al repositorio remoto
- `git tag -d "el nombre del tag"` asi se borra un tag 
- `git push origin :refs/tags/nombretag` asi se pueden borrar los tag del repositorio remoto



## Extras

- `git status --short` version compacta de status

- `git pull` una combinacion de fetch y merge
- `git fetch origin` trae los cambios de la rama
