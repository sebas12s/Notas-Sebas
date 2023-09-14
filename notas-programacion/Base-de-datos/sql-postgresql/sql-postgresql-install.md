# PostgreSQL

## Instalacion

* Docker desktop
* Table plus

* Para instalar con doker son los dos siguientes comandos
    * `docker pull postgres:15.3` : La base de datos
    * `docker pull dpage/pgadmin4`  : Para conectarnosa pgadmin un entorno para nuestra base de datos, aunque no es necesario si se trabaja con Table plus

* Configuracion para levantar contenedores 
* docker-compose.yml
* Archivo:
```yml
version: '3'

services:
  myDB:
    image: postgres:15.3
    container_name: my-database
    restart: always
    ports:
      - 5432:5432
    environment:
      - POSTGRES_USER=alumno
      - POSTGRES_PASSWORD=123456
      - POSTGRES_DB=course-db
    volumes:
      - ./postgres:/var/lib/postgresql/data
  
  pdAdmin:
    image: dpage/pgadmin4
    container_name: pgadmin4
    restart: always
    depends_on:
      - myDB
    ports:
      - 8080:80
    environment:
      - PGADMIN_DEFAULT_EMAIL=alumno@google.com
      - PGADMIN_DEFAULT_PASSWORD=123456
    volumes:
      - ./pgadmin:/var/lib/pgadmin
      - ./pgadmin:/certs/server.cert
      - ./pgadmin:/certs/server.key
      - ./pgadmin:/pgadmin4/servers.json
```
* Configuraciones para levantar postgresql y pgadmin
* Se crea un directorio sql y ahi dejamos caer el documento
* En la terminal vamos a la carpeta
* Ejecutamos el siguiente comando: `docker compose up -d` esto hace que las dos imagenes corran en nuestra computadora

---

* Para bajar las dos imagenes es `docker compose down`
* `coker compose up -d` para volverlas a subir

--- 

* Table plus:
    * Le damos al '+'
    * Seleccionamos postgresql -> Crear
    * Le colocamos cualquier nombre, cualquier nombre
    * Host/Socket es localhost solamente se deja asi
    * Port: `5432` normalmente se pone ahi
    * Username: el que tenemos en el archivo, el de la base de datos
    * Database: lo mismo, la que esta en el archivo -> Save

* pgadmin: 
    * Username: el del archivo -> English
    * AddnewServer
    * Name: el que uno quiera
    * Pestaña connection
    * Host name/address: es el nombre de la base de datos no el localhost ya que docker hace una conexion entre esos dos contenedores por aparte `my-database`
    * Port: 5432
    * Maintenance database: la que esta en el archivo
    * Userneme: la de la base de datos del archivo -> save

Y listo asi se hace la conexion de estas dos maneras 