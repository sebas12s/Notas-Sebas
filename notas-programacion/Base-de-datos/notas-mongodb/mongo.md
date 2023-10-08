# Mongodb

## Instalacion

Se instala en la pagina de mongo [Download](https://www.mongodb.com/try/download/community) el server para poder ejecutarlo en la computadora

Despues en la interface le di completa y desactive la configuracion que me daba y solo siguiente y siguiente

Despues configure la variable de entorno, entre a file/mongo y hasta la carpeta bin y copie le path y configure ese path para poder ejecutar los comandos de mongo

y por ultimo para poder ejecutar mongo creamos una carpeta en c que se llama data y adentro otra que se llama db y con eso se ejecuto mongo

Algo extra es que tuve que descargar mongoshell para poder usar mongosh para correr nuestro mongodb y ya coloque la variable de entorno

## Comandos

- `mongod` este es para correr mongo en la commputadora o iniciar el servidor
- `mongosh` para ya poder ejecutar mongo en la linea de comandos

## Conceptos

- Colecciones: son como las tablas de sql pero aqui se llaman collections
- Adentro de estas colecciones ya podemos almacenar nuestros datos en formato json, aunque mongodb a los objetos o json llama documentos

## Shell Mongo

Usamos mongosh para ejecutar y nos abre el interprete de js entonces ahi podemo ejecutar codigo de js

Podemos crear funciones, traer bibliotecas y todo lo que se podria hacer en el interprete del navegador o de node

Aunque tambien tiene palabras clave que solo en mongo funcionan

### Comandos

- `db` nos dice que base de datos estamos usando
- `show dbs` esto nos muestra las bases de datos, cuando instalamos mongodb solo tenemos tres bases de datos `admin`, `config` y `local`
- `help` nos mueustra ayuda con esto comandos
- `db.help()` esto nos muestra todo lo que podemos usar con el comando que este antes del help
- `use nombredb` esto es para crear una nueva base de datos
  Algo importante es que mientras no insertemos algun dato esa base de datos no sera creada

- `db.nombrecoleccion.insert({clave: valor})` asi podemos insertar un dato en una nueva coleccion
- `show collections` asi podemos ver nuestras colecciones
- `db.dropDatabase()` con esto eliminas la base de datos local
- `db.createCollection("name")` asi podemos craer colecciones en la db
- `db.nameCollection.drop()` asi eliminamos las colecciones
- `db.nameCollection.find()` esto busca todos los documentos que tenga esa coleccion

Recordar que podemos almacenar objetos de js por entonces pueden extendenser mucho y asi

Mongodb no es obligatorio seguir un esquema, un orden, algunos pueden tener mas claves o otro no y asi

Para insertar mas productos solo le envio un arreglo de objetos json, algo asi

```js
db.products.insertMany([
  {
    name: 'Marce',
    isBeautiful: true,
    qualities: { uno: 'Linda', dos: 'hermoso corazon' },
  },
  {
    name: 'Sofia',
    isBeautiful: true,
    qualities: { uno: 'Linda', dos: 'hermoso corazon' },
  },
]);
```

- `db.nameCollection.find({clave:valor})` asi podemos buscar alguno en especial, puedo poner mas condiciones de clave valor
- `db.nameCollection.findOne({})` solo busca uno
- `db.nameCollection.find({clave: valor}, {clave: 1, clave: 0})` si despues otra llaves con las claves y el valor 1 o 0 las muestra o no, 1 es que muestre solo esas claves, solo mostrara las claves que pongamos con uno y 0 las oculta
- `db.nameCollection.find({}).sort({clave: 1})` con sort le digo que ordene alfabeticamente mediante la clave que pongamos ahi, entonces me devolvera los documentos ordenados mediante esa clave
- `db.nameCollection.find({}).limit(5)` esto pone el limite de lo que regresa
- `db.nameCollection.count()` esto devuelve cuantos documentos tenemos
- `db.nameCollection.find().forEach(product => print("Product" + product.name))` como es un interprete de js podemos usar todas sus funciones aqui usamos forEach para recorrer los documentos y por cada uno imprimiamos el nombre, aqui no se usa clg si no un print
- `db.nameCollection.update({clave: valor}, {clave: valor})` con esto podemos actualizar un documento el pimer objeto es para buscar a cual actualizar y el segundo es que queremos modificar, pero esto actualiza todo el documento, solo deja lo que dejemos en el segundo objeto
- `db.nameCollection.update({clave: valor}, {$set: {clave: valor}})` con la palabra set hago que solo ese valor se actualice
- `db.nameCollection.update({clave: valor}, {$set: {clave: valor}}, {upsert: true})` si le agrego el tercer objeto si no encuentra el valor lo crea con los nuevos campos que estan en set
- `db.nameCollection.update({clave: valor}, {$inc: {clave: 1.4}})` este inc nos ayuda a incrementar los valores numericos, solo ponemos la clave y en cuanto queremos incrementar
- `db.nameCollection.update({clave: valor}, {$rename: {clave: newclave}})` asi puedo renombrar las claves de los objetos
- `db.nameCollection.remove({clave: valor})` asi podemos eliminar documentos
- `db.nameCollection.remove({})` si lo mando vacio elimina todos los documentos
