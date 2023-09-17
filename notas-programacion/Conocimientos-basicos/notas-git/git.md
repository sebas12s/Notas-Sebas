# Notas de Git

'-' solo uno significa que usaras una letra

'--' significa que usaras una palabra

- `.gitkeep` este archivo se crea cuando no tenemos nada en la carpeta entonces para que git le de seguimiento creamos ese archivo

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
- `git status --short` version compacta de status
- `git add "el nombre del archivo"` esto como que agrega el archivo para que git pueda ver sus cambios y asi para agregarlos a git, tambien se usa `git add .` para agregar todos los archivos
- `git add -A` agrega todo los archivos
- `git commit -m "mensaje"` esto envia los cambios solo con el commit es suficiente pero es una mala practica no dejarle un mensaje, -m le estamos diciendo que le enviaremos un mensaje
- `git commit -am "mensaje"` este tambien hace el git commit pero solo con archivos que antes se le habian hecho add antes
- `git commit --amend` esto lo que hace es que todos los cambios que hice los pega al commit anterior despues ya solo nos pide si quermos cambiar el mensaje y ya esta hecho
- `git commit --amend -m "mensaje"` podemos colocar el mensaje de una vez del commit, esto nos funciona tambien para cambiarle el nombre al commit

## Comandos

- `git reset "nombre del archivo"` esto le quita el add al archivo
- `git rm --cached "nombre del archivo"` con esto se le quita el add tambien
- `git reset HEAD` esto le quita el add a los archivos
- `git checkout -- .` esto nos devuelve los cambios al ultimo commit
- `git checkout -- archivo` esto nos devuelve los cambios al ultimo commit solo en el archivo

## Buscar palabras

- `git grep "la palabra"` esto nos muestra donde aparece esa palabra
- `git grep -n "la palabra"` nos aparece en que linea
- `git grep -c "la palabra"` esto nos muestra la cantidad de veces en la que aparece
- `git log -S "la palabra"` esto si va entre comillas y esto busca en todos los commits la palabra

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
- `git shortlog -sn` esto solo nos muestra cuantos han hecho la cantidad
- `git shortlog -sn --all` esto incluso los borrados
- `git shortlog -sn --all --no-merges` con esto le decimos que no nos incluya los merges asi solo miramos los commits
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
- `git diff --staged` nos mestra lo que se cambio en los archivos que le dimos add

Pero usando VScode al presionar el archivo se puede ver mejor los cambios

Para ver los cambios de una o de otra ejecutamos:

- `git diff "primera clave" "segunda clave"` asi podemos comparar diferentes versiones, pone al principio la version mas vieja

## Checkout

- `git checkout "la clave de la version" "el archivo que queremos que nos devuelva"` esto nos muestra en el archivo como era con la clave de la version

- `git checkout main "el archivo que queremos que nos devuelva"` con solo poner main nos muestra la ultima version
- `git checkout` esta es una manera de volver a versiones anteriores, igual tener mucho cuidado

## Reset

- `git reset "clave de la version" --hard` reset nos permite regresar, con hard todo!! vuelve al estado que le estemos diciendo
- `git reset "clave de la version" --soft` esto igual vuelve a la version anterior pero todavia guarda lo que tengamos
- `git reset --soft HEAD^1` el HEAD es el ultimo commit, o al que este apuntando y con el `^1` le decimos uno anterior y podemos poner mas numeros
- `git reset --hard HEAD` elimina los cambios realizados que aún no se hayan hecho commit.

## Revert

- `git revert HEAD` esto devuelve al ultimo commit
- `git revert HEAD~1` esto devuelve al ultimo penultimo commit y asi puedo poner mas numeros

## Eliminar

- `git rm --cached "archivo"` este comando permite borrar archivos este borra del staging y del directorio local pero los deja en el disco duro
- `git rm --force "archivo"` borra en todos lados se puede recuperar pero se usan comandos mas avanzados
- `git rm archivo` esto elimina el archivo o directorio pero todavia esta en el staged ya para eliminarlo hacemos otro commit o podemos volver a tenerlo con un reset

## Renombrar
- `git mv archivo archivo` si ponemos el mismo archivo lo renombra

## Ramas

Primera rama sabemos que se llama main la segunda rama es la experimental pero se le llama mas development si la rama actual la ultimma version muestra un bug un ejemplo, se le puede hacer otra rama eso le dicen hotfix despues lo arreglamos y lo enviamos a la ultima version eso se le conoce como un merge

Al crear una rama toma nuestro ultimo commit y crea la rama

- `git branch` nos muestra todas las ramas locales
- `git branch --all` asi podemos ver las ramas del repostorio y el repositorio remoto
- `git branch -a` lista todas las ramas locales y remotas.
- `git branch -r` esto muestra las ramas remotas
- `git branch -m 'nombre de rama' 'el nuevo nombre'` para cambiarle el nombre

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
- `git branch -d "el nombre del branch" -f` borrar la rama de manera forzada

Recordar que marge es como un commit entonces tiene que llevar un mensaje git merge se puede hacer en cualquier rama para traer las ultimas versiones del trabajo

- `git merge "el nombre de la rama que quermos unir"` esto une la rama actual con la que pongamos, pero los cambios se quedan en la rama que estemos 

### Conflictos
Se soluciona manualmente, nos aparece los cambios de las dos ramas y ya decidimos que dejar y que no 

### Conflictos

Se soluciona manualmente, nos aparece los cambios de las dos ramas y ya decidimos que dejar y que no

## Remote

Normalmente el repositorio remoto se llama `origin`

- `git remote add origin url_del_servidor_remoto` para agregar un repositorio remoto, el origin es cualquier nombre pero es un estandar que se llame origin 
- `git clone url_del_servidor_remoto` nos trae una copia master a nuestro directorio y todos los cambios al repositorio local esto lo trae del repositorio remoto
- `git clone url_del_servidor_remoto "carpeta` esto es si queremos ponerlo en una carpeta
- `git push` ejecutamos esto despues de hacer add y commit entonces cuando ejecutemos enviamos la ultima version del repositorio local al repositorio remoto
- `git push -u origin main` esto ya deja por defecto el origin main entonces solo ejecutamos el `git push` y `git pull` sin especificar nada ya que la `-u` configuro por defecto
- `git fetch` esto trae del repositorio remoto las actualizaciones a nuestro repositorio local trae todos los cambios
- `git merge` como solo el fetch no te lo copia en tus archivos entonces tienes que hacer este comando para que te lo copie y puedas trabaajar en el
- `git pull` este fuciona ambos conceptos entonces trae los cambios a nuestro repositorio local y despues lo copia a nuestros archivos (fetch, merge)
- `git remote prune origin` esto actualiza el repositorio local con el remoto, si en el remoto eliminaron ramas, etiquetas etc tambien las eliminan del local
- `git remote rename origin "nuevo nombre` para cambiarle el nombre al remoto

## Tag

- `git tag -a "v0.1"` el nombre puede ser el que quieras pero es normal ponerle ese nombre
- `git tag -a v0.1 -m ""` con la m es obligatorio que lleve un mensaje
- `git tag -a v0.1 -m "" "la clave del commit"` asi le puedo poner tag a antiguos commits
- `git tag` si solo ponemos asi podemos ver los tags que tenemos
- `git show nombretag` esto muestra cosas del tag incluyendo el mensaje
- `git show-ref --tags` pero asi muestra la clave de donde esta ese tag
- `git push origin --tags` asi podemos subir nuestro tags al repositorio remoto
- `git tag -d "el nombre del tag"` asi se borra un tag
- `git push origin :refs/tags/nombretag` asi se pueden borrar los tag del repositorio remoto

## Stashed

Es como guardar unos cambios en alguna parte y volver al ultimo commit es como que esos cambios nunca hubieran pasado pero estan ahi guardados, nos ayuda si hicimos unos cambios pero queremos volver al ultimo commit sin perder los cambios

No se recomienda guardar muchas cosas en stash mientras resolvamos saquemos de stash lo que tengamos

- `git stash` esto me regresa al ultimo commit y envia todos los cambios que teniamos al stash
- `git stash save "mensaje"` asi podemos agregarles un mensaje
- `git stash list` esto nos muestra los stach hechos, la posicion 0 es el ultimo que agregamos
- `git stash list --stat` tambien muestra los cambios pero como el el `git stash show`
- `git stash pop` esto vuelve a lo que teniamos en el stash y elimina el stash
- `git stash apply stash@{0}` asi con el stach que queramos podemos obtener alguno tambien no el ultimo como con el pop
- `git stash branch "nombre de la rama"` y esto envia el stash a otra rama o la crea si no existe la rama, pero al volver a main igual tengo el stash
- `git stash drop` con esto eliminamos el stash
- `git stash drop stash@{0}` asi tambien por si queremos eliminar uno en especifico
- `git stash clear` esto tambien borra los stash por completo
- `git stash show stash@{0}` con esto podemos ver mas o menos que se modifico

## Clean

- `git clean` solo sirve para archivos que estan pendientes a darles add
- `git clean --dry-run` este comando nos sirve para que nos muestre que archivos nos borrara sin borrarlos
- `git clean -f` y ya este nos borra esos archivos pero solo archivos no carpetas tambien ignora todo lo que esta en gitignore
- `git clean -q` nos muestra los errores que tuvo la ejecucion pero no los archivos que fueron borrados
- `git clean -x` borra las copias incluso las que estan en gitignore
- `git clean -X` borra archivos que fueron ignorados por git
- `git clean -f -d` tambien borra directorios

## Git rebase

Nos sirve para que los cambios del master si los queremos en otra rama que no tenga esos cambios se puedan enviar a esa rama y los pone atras de los commits de la rama, como si siempre hubieran estado ahi los commits al crear la rama

- `git rebase main` esto se coloca en la rama y trae los nuevos commits que no estan en la rama y los coloca atras de los commits de la rama

- `git rebase -i HEAD~3` el head y cuantos commits queremos tomar y nos abre una interface para poder unir commits si queremos unir cambiamos el pick por squash si queremos solo unir el mas nuevo con el anterior solamente se le coloca squash al primero no a los dos

Tambien se le puede cambiar el nombre con la r de reword    

Tambien se puede editar don edit o e, con 

## Clean

- `git clean` solo sirve para archivos que estan pendientes a darles add
- `git clean --dry-run` este comando nos sirve para que nos muestre que archivos nos borrara sin borrarlos
- `git clean -f` y ya este nos borra esos archivos pero solo archivos no carpetas tambien ignora todo lo que esta en gitignore
- `git clean -q` nos muestra los errores que tuvo la ejecucion pero no los archivos que fueron borrados
- `git clean -x` borra las copias incluso las que estan en gitignore
- `git clean -X` borra archivos que fueron ignorados por git
- `git clean -f -d` tambien borra directorios

## Cherry-pick

Nos ayuda a traer un commit de otra rama a nuestra rama sin tener que treaer todo el historial de los cambios de la rama si no solo ese commit

- `git cherry-pick "el id del commit"` esto se hace desde la rama que queremos ingresarlo y ya nos trae el commit

Ya despues podemos hacer el merge

## Reflog

- `git reflog` esto nos ayuda a ver todos los cambios que hemos hecho o cosas que eliminamos y ya con su clave podriamos recuperar y ya podemos hacer un reset para traer esos cambios

Esto nos ayuda incluso si habiamos hecho un reset --hard poderlo recuperar porque ya solamente tomamos su hash y hacemos un `git reset --hard hash`

## Crear Alias

Para crear el alias se hace de la siguiente manera:

- `git config --global alias."el nombre del alias" "el pedazo del comando"` este si va entre comillas
- `git config --global alias.stats "shortlog -sn --all --no-merges"` este es un ejemplo ya solo se llama `git stats`
- `git config --get-regexp alias` es para ver todas nuestras alias
- `git config --global --unset alias.alias_name` para eliminar el alias

### Alias de log

- `git config --global alias.lg "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"`

## Blame

- `git blame -c "el nombre del archivo que queremos ver"` esto nos ayuda para ver que y quien hizo cada cosa
- `git blame "nombre del archivo o direccion" -L 33,50 -c` los numeros son las lineas de cual a cual queremos ver los cambios y la `-c` es para ordenar un poco

## gitignore

`.gitignore` es una archivo donde adentro de el podemos poner que archivos o carpetas queremos que no se le de seguimiento que git los ignore

Se pueden usar expresiones regulares ejemplo `*.log` todos los archivos .log seran ignorados

## Github

Si te sale un error de octobre no se que, genera un token y pon ese token como contraseña y tu correo

- `git remote` sale nuestro repositorio remoto 
- `git remote -v` nos sale estas opciones: fetch-traer cosas, push-enviar cosas 

### Release tag
Son como mas informacion de los tags es para explicar mejor nuestros tags