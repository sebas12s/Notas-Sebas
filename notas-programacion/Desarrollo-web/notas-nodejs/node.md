# Nodejs

- [Nodejs](#nodejs)
  - [REPEL](#repel)
  - [JavaScript](#javascript)
  - [Node](#node)
    - [Async/Sync](#asyncsync)
    - [Objetos globales](#objetos-globales)
    - [Modules](#modules)
      - [Export e import](#export-e-import)
      - [Os](#os)
      - [Path](#path)
      - [Fs](#fs)
      - [HTTP](#http)
      - [npm](#npm)
      - [npx](#npx)
    - [Event Loop](#event-loop)
  - [Promise](#promise)
    - [Async / Await](#async--await)
      - [Promisify](#promisify)
  - [Event](#event)
  - [Streams](#streams)
    - [Stream with http](#stream-with-http)
  - [Fetch](#fetch)

## REPEL

En la terminal si escribimos `node` nos habre el interprete de node `REPL`, este es como la consola del navegador, podemos interpretar codigo de js, clg o sumas y eso

```js
> do {
... let x = 0
... x++
... }
```

En este ejemplo tambien podemos poner muchas lineas de codigo solo con un enter nos podemos guiar por los 3 puntos que pone

Para salir de REPL es con `ctrl + c`, `ctrl + d` o `.exit`

Este interprete no es igual al del navegador si no tambien puede conectar con el sistema operativo por algo es del servidor, con `process` nos aparce mucha informacion sobre el sistema operativo, con `precess.versions` nos aparece tambien las versiones de node y asi

Otra manera de ejecutar codigo de node es con el siguiente comando:
`node -e` despues podemos ejecutar el codigo de js

Digamos que tengo mucho codigo ya escrito en REPEL, para guardarlo escribo `.save nombredelarchivo` y lo guarda

Digamos que nos salimos y queremos obtener el codigo que guardamos lo hacemos con `.load archivo`

## JavaScript

Recordar que toda la sintaxis de js es permitida en node, para ejecutar el codigo es `node nombrearchivo` y ya lo ejecuta

## Node

Recordar que en el front esta document o window pero node no se ejecuta en eso por eso no tenemos esas opciones pero tambien contamos con otras opciones como `process` o `os.userInfor()` esto me da informacion del usario

Cuando trabajamos con node estaremos encima del sistema operativo y muy aparte como interactua el front con el navegador

### Async/Sync

Sync o sincrono es que el codigo llevara un ordenn y ese tomara, entonces esperar a que se ejecute la peticion para ejecutar el siguiente codigo mas lo async o asincrono puede ejecutar otro codigo mientras espera la promesa del codigo para ejecutarlo

En las funciones de abajo que llevan sync es porque no son async, las que no tienes sync es porque se ejecutan async

### Objetos globales

son objetos que estan disponibles en toda la app, como node tiene tambien sus objetos globales como `console.log(__dirname)` o `console.log(__filename)` los dos devuelven la ruta del archivo completa o `console.log(module)`, `console.log(require)`, `console.log(process)` estos objeto globales se utilizan mucho

### Modules

Para dividir nuestra logica en muchos archivos, si hacemos un clg de `module` ahi podemos ver nuestras exportaciones entonces con esa palabra `module` hacemos las exportaciones.

Asi hacemos las exportaciones

```js
const nombre = "Sofia Marcela Cruz Galindo";
module.exports = nombre;
```

Para obtenerlo lo hacemos con

```js
const amor = require("///.");
//recordar que en la constante se almacenara lo que se este exportando en este caso un string pero pueden ser muchas cosas, funciones numero y asi muchas cosas
```

Para exportar mas de una cosa se hace de la siguiente manera

```js
const name = "Marce";
const num = 18;
const user = {
  name: "Sebas",
  num: 17,
};

// const group = {
//     name: name,
//     num: num,
//     user: user
// }

// module.exports = group
// aunque es lo mismo que hacer
module.exports = {
  //y asi se ve mejor
  name,
  num,
  user,
};

//otra manera de hacerlo es asi, recordar que es un objeto entonces le podemos extender
// module.exports.name = name
// y asi con todos
```

y ya para exportarlo puedo hacerlo con la desestructuracion

```js
const { name } = require("///.");
```

Solo lo que exportamos podemos obtener tambien podemos tener cosas que no exportemos

#### Export e import

Tambien se pueden importar y exportar como lo hacemos en react pero en el `package.json` debemos color para que podamos usarlo

```
"type": "module"
```

Importante si ponemos este no podemos usar la antigua manera

```js
module.exports = {
  name,
  num,
  user,
};
//esta es como se haria
export default {
  name,
  num,
  user,
};

import m from "//.."; //y asi lo importamos
```

#### Os

Os es informacion del sistema operativo

Node nos ofrece modulos ya creados solamente para importarlos [Documentacion](https://nodejs.org/api/modules.html)

```js
const os = require("os");

console.log(os.userInfo()); //nos trae informacion del usuario
console.log(os.uptime()); //el tiempo que he utilizado la computadora desde que la encendi
console.log(os.plataform()); //para ver en que sistema operativo estoy trabajando
console.log(os.totalmem()); //la memoria ram total
console.log(os.freemen()); //la memoria ram libre
console.log(os.release()); //la version del sistema operativo
```

#### Path

Nos permite poder conocer sus direcciones de carpetas o archivoss

Cuando estamos trabajando con linux o mac pueden traer diferentes funcionalidades, como se puede conocer que sistema operativo tenemos tambien nos trae funcionalidades especiales para ellas, un ejemplo seria las direcciones, por eso usamos esto para ayudarnos en cualquier sistema operativo

```js
const path = require("path");

console.log(path.sep); //lo que separa las carpetas
console.log(path.join("/public", "dist", "/styles", "main.js")); //esto une todos y ya me lo traeria la ruta completa
console.log(path.basename(ruta)); // le enviamos una ruta completa y este solo me trae la base de toda la ruta en el caso de arriba el main.js
console.log(path.dirname(ruta)); //este me da la ruta de carpetas pero sin el archivo lo contrario del anterior
console.log(path.parse(ruta)); //la misma informacion pero ahora lo devuelve como un objeto
console.log(path.resolve("dist")); //me autocomplementa la ruta desde el c y agrega esta
```

#### Fs

Es para trabajar con archivos en node, fs es de File Sistem

```js
const fs = require("fs");
const { readFile } = require("fs"); //tambien se puede desestructurar

const text = fs.readFileSync("//..", "utf-8"); //esto es para leer lo que tenga el archivo el primer argumentoe es la ruta el segundo es para que me ponga en un string
console.log(text.toString()); // asi tambien podemos convertir en string si no tenemos el utf

fs.writeFileSync("./data/nombrearchivo.md", "contenido"); //esto es para crear archivos, el priemro es la ruta y el archivo que quiero crear y el segundo argumento es lo que quiero poner adentro, tambien le podemos pasar variables con el string y asi y si ya existe el lo sobreescribira

fs.writeFileSync("./data/nombrearchivo.md", "contenido", {
  flag: "a",
}); //este tercer argumento con el flag a es para agregar al archivo no sobreescribir
```

Algo importante es que el `fs.readFileSync` como es sincrono lo podemos poner en una variable ya que espera a que este la respuesta pero un codigo `async no`

```js
fs.readFile("//..", (err, data) => {
  //es de esta manera que un codigo async trabaja, los dos argumentos del callback son los errores y la data que se esta leyendo del archivo
  console.log(err);
  console.log(data.toString());
});

fs.writeFile("//..", "archivo.md", (err, data) => {
  //de la misma  manera con write
  console.log(err);
  console.log(data.toString());
});
```

#### HTTP

Para entender http es tener en cuenta el modelo cliente servidor, el navegador (client) esta pidiendo algo al servidor, el servidor procesa y devuelve

Ese sistema de enviar o devolver archivos y todo eso viene de protocolo http

Entonces nosotros creamos un servidor, un programa que permite recibir las peticiones del cliente

Cuando el navegador le esta pidiendo algo al servidor se le conoce como `request` y lo que devuelve el servidor se le conoce como `response` entonces con node creamos un programa que resiva y envie peticiones

Algo importante con los puertos, hay algunos que ya estan reservados entonces no podemos poner ahi nuestro servidor [Wikipedia](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers)

```js
const http = require("http");

http
  .createServer((request, response) => {
    //creamos un servidor y tiene los dos argumentos

    console.log(request.url); //request nos trae mucha informacion del cliente pero podemos accedr a su url
    //ya aqui puedo recibir toda la ruta como /about/mar y asi

    response.write("Marce linda"); //este servidor no espera una peticion mas si envia algo en este ejemplo un simple texto
    response.end(); //esto es necesario para node para decirle que ya acabamos con el envio
  })
  .listen(3000);
```

```js
const server = http.createServer((request, response) => {
  //tambien podemos ponerlo en una variable
  if (request.url === "/") {
    response.write("Bienvenido a mi home");
    return response.end();
  } else if (request.url === "/marce") {
    response.write("Marce linda");
    return response.end();
  }
  //el return recordar que sale de la funcion
  //y usar esas comillas deja hacer mas lineas y tambien podemos devolver html
  response.write(`        
        <h1>No se encontro</h1>
        <a href='/'>Volver al home</a>
    `);
  response.end();
});
server.listen(3000);
```

#### npm

[Librerias](https://www.npmjs.com/)

Una libreria muy buena para desarrollo es `nodemon` lo instalamos y ya la podemos usar, es para que recargue los cambios en caliente `npm i nodemon -D` si le pongo la `-D` es para decir que es solamente para desarrollo no para produccion, para ejecutar nodemon lo hacemos en un script `nodemon archivo` y asi lo ejecutamos

Si queremos descargar un modulo global es con `npm i nodemon -g` para instalarlo en el computador y ya lo tienen todos los archivos

Al principio no me dejaba hacer nada ni descargar nada entonces realice un `npm init`, tambien podemos dar `npm init -y` y esto nos crea el configurado por defecto

Aqui nos envia para inicializar nuestro proyecto, nos pide el nombre, version (es un formato de versiones semver 0.0.0, cambios pequeños el tecer 0, cambios grandes, el segundo y cambios que ya no son compatibles con las versiones el primer 0), desc, archivo principal, test, git, keywords (palabras claves para despues buscar nuestro project), autor.

En el archivo que crea hay una parte de `scripts` ahi podemos crear nuestros comandos para cuando le demos un ejemplo `npm run script` ejecute lo que pongamos

Al correr o descargar algun modulo con npm descarga 2 archivos y 1 directorio

- `package-lock.json` son las dependencias de los paquetes que descargamos
- `package.json` son los paquetes/dependencias que descargamos
- `node_modules` es el codigo funte de esos paquetes

Podemos descargar manualmente cada modulo pero si ya lo tenemos en `package.json` y queremos descargarlos simplemente ejecutamos `npm install`

Para eliminar algun paquete solo es `npm remove nombre`

#### npx

Un ejemplo con nodemon el comando nodemon esta almacenado en la carpeta `.bin` de los `node_modules` ahi estan todos los ejecutables que podemos utilizar en nuestro proyecto, son archivos que se ejecutan desde la terminal, ya que nodemon recibe como argumento el archivo y asi hay bastante como `cowsay`

A todo esto npx nos ayuda para ejecutar comandos sin descargarlos en nuestro computador en este ejemplo podemos usar `npx cowsay marce` y no lo instala

`nodemon archivo` si no esta global no podemos ejecutarlo asi por eso podemos usar el npx para ejecutar modulos que no estan el la computadora

### Event Loop

Hay que recordar que js es async entonces si algo se tarda pasara a la otra accion y asi no espera a que se ejecute para pasar a la otra

Para eso usamos el codigo async para que se envie a otro lado el codigo que queramos esperar y que ejecute lo demas

## Promise

```js
const { readFile } = require("fs");

//una funcion que lee un archivo, Promise es una funcion de JavaScript que nos permite hacer lo que esta abajo con el .then
const getText = (path) => {
  return new Promise((resolve, reject) => {
    //esta funcion obtiene dos parametros el resolve y el reject, el resolve es la respuesta de la promesa (then), el reject es por si algo salio mal (catch)
    readFile(path, "utf-8", (err, data) => {
      if (err) {
        reject(err);
      }
      resolve(data); //son funciones los argumentos por eso le podemos enviar asi
    });
  });
};

getText("//..")
  .then((result) => console.log(result)) //aqui obtengo lo que resuelve en este caso la data
  .catch((err) => console.log(err)); //obtengo el error
```

### Async / Await

Recordemos que el codigo Async no se puede almacenar en una variable ya que tiene que esperar la promesa por eso se puede trabajar con `.then` pero con async y await cambia

```js
const { readFile } = require("fs");

//esto es lo mismo que los then que tengo arriba ya solo tengo que llamar a la funcion
//y para manejar errores lo hacemos en el try catch
try {
  throw new Error("error"); //el throw es para que acabe a ejecurcion y ponemos un error
  const read = async () => {
    const result = await getText("//..");
    console.log(result);
  };
} catch (err) {
  console.log(err);
}
```

Recordemos que esto de `await` o el `.then` es porque lo que devuelve es una promesa (la funcion de arriba) pero para no tener que hacer asi tan larga nuestra funcion de promesa hay paquetes

#### Promisify

Esto nos ayuda a hacer que una funcion que espera un callback se convierta en una promesa

```js
const { readFile } = require("fs");
const { promisify } = require("util"); // ya es de node el modulo util

const readFilePromise = promisify(readFile); //readFile espera un callback entonces esta linea es lo mismo que la funcion qeu creamos de getText
const read = async () => {
  const result = await readFilePromise("//..", "utf-8"); // y el resultado es el mismo porque convertimos en una promesa el readFile
  console.log(result);
};
```

Aunque ahora podemos saltarnos usar el `util`

```js
const { readFile } = require("fs/promise"); //usando esta direccion ya nos devuelve una promesa

const read = async () => {
  const result = await readFile("//..", "utf-8"); //ya esto es lo mismo
  console.log(result);
};
```

## Event

Un evento en el front es el `addEventListener` el click y eso tambien es importante en en node

```js
const EventEmitter = require("events"); //con este modulo lo que nos ayuda a crear nuevos eventos, el nombre de la variable es un estandar

const customeEmitter = new EventEmitter(); //recordemos que la palabra new es para crear un nuevo objeto, este objeto me permite poder escuchar determinados eventos
//Ya con esta variable tengo un nuevo manejador de eventos

customeEmitter.on("response", (data, masDatos) => {
  // con el on es un escuchador, encontces le digo que cuando escuche un evento, en este caso response haga algo
  //el response solo es el nombre del evento que estoy creando, le puedo poner cualquier nombre
  //tambien podemos recibir mas datos

  console.log(data);
});

customeEmitter.emit("response", "Marcela hermosa", 12); //y asi emito el evento, es como un click pero aqui le digo que emita el evento response y envie los datos como los espera el evento

//Es importante que primero creemos el evento y despues lo emitamos
```

## Streams

Nos ayuda a dividir un archivo en multiples partes, como cuando miramos un video solo trae un pedazo y asi se va descargando asi mismo funciona esto

```js
const { writeFile } = require("fs/promises");

const bidData = async () => {
  await writeFile("./amor.txt", "Te Amo Marcela ❤️".repeat(1000000));
};

bidData();
```

Este es un ejemplo para crear un archivo pesado, con el repeat le digo que se repita ese string las veces que ponga

```js
const { createReadStream } = require("fs");
//el stream no es en promise ya que esta creado en eventos entonces se ejecutara cuando ocurra un evento

const stream = createReadStream("./amor.txt", {
  encoding: "utf-8",
  // highWaterMark    este es para aumentar las megas por llamada y asi tienen bastante propiedades este Stream
});

stream.on("data", (chunk) => {
  //aqui el nombre data si es necesario, esto esta leyendo y esta devolvio por pedazos de codigo con peso de 6kb y los devuelve en esa variable chuck
  console.log(chunk);
});

stream.on("end", () => {
  //ademas del evento data hay mas eventos como este que es cuando termine de ver el archivo
  console.log("Terminado");
});
```

### Stream with http

```js
const http = require("http");
const { createReadStream } = require("fs");

const server = http.createServer((req, res) => {
  const fileStream = createReadStream("./amor.txt", {
    encoding: "utf-8",
  });
  fileStream.on("data", (chunk) => {
    fileStream.pipe(res); //el Stream tiene un metodo que es el pipe que dice como que le envia el dato a otra funcion en este caso le enviamos los datos al res del http
    //al momenot de responder le paso la porsion de daots
  });
});

server.listen(3000);
```

## Fetch

Se puede hacer peticiones normales con fetch

```js
const dataFetch = async () => {
  const res = await fetch("https://pokeapi.co/api/v2/pokemon/");
  const { results } = await res.json();
  console.log(results);
};

dataFetch();
```

Aunque node y con el `type: module` del `package.json` ahora acepta que no este en una funcion async
