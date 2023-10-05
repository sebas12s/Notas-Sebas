# Express

Recordar que esto usa el modelo client/server

- [Express](#express)
  - [Codigo](#codigo)
  - [Routing /URL](#routing-url)
  - [Metodos HTTP](#metodos-http)
    - [Get](#get)
    - [POST](#post)
    - [PUT](#put)
    - [DELETE](#delete)
    - [PATCH](#patch)
  - [Response HTTP](#response-http)
  - [HTTP response status codes](#http-response-status-codes)
  - [Request Body](#request-body)
  - [Request Params](#request-params)
  - [Query](#query)
  - [Middlewares](#middlewares)

## Codigo

Un ejemplo sin express:

```js
import http from "http";
import { createReadStream } from "fs";

//normalmente nosotros devolvemos un html, aqui estoy devolviendo un simple html y se lo mando al res
const server = http.createServer((req, res) => {
  const datos = createReadStream("./static/index.html");
  datos.pipe(res);
});

server.listen(3000);
```

Con express

```js
const express = require("express");

const app = express();

app.get("/", (req, res) => {
  //tiene el req y res como siempre y la ruta
  res.sendFile("./static/index.html", {
    //este sendFile ya es un especial para poder enviar archivos
    root: __dirname, //recuerden que el __dirname nos da la ruta hasta donde esta el archivo, por eso lo ponemos como root y ya podemos poner la ruta del archivo arriba
  });
});

app.listen(3000, () => {
  //le digo con la funcion que cuando este escuchando ejecute eso
  console.log("Escuchando en el puerto 3000");
});
```

## Routing /URL

```js
const express = require("express");

const app = express();

app.get("/", (req, res) => {
  //para obtener toda la url podemos hacer el req.url
  res.send("Welcome"); //ademas de enviar el metodo end usamos send que es de express
});

app.get("/she", (req, res) => {
  //asi se pueden ir creando rutas las que queramos
  res.send("Mar");
});

app.use((req, res) => {
  //este use es si ya visito tadasa las poagina y ni una coicide con la que estamos colocando en la url busca esta
  res.status(404).send("No se encontro la pagina"); //el estatus como su nombre le dice es para ponerle un estado a la peticion
});

app.listen(3000, () => {
  console.log("Escuchando en el puerto 3000");
});
```

## Metodos HTTP

Estos son lo verbos relacionados con HTTP no con el servidor

### Get

El cliente esta obteniendo algo por eso es get, cuando el cliente pide y el servidor envia algo

### POST

Es cuando el cliente envia algo al servidor o crea

### PUT

Es cuando el cliente esta intentando actualizar algo

### DELETE

Es cuando queremos eliminar algo

### PATCH

Cuando usamos put actualizamos todos los datos, pero con PATCH solo actualizamos una parte de ellos

```js
//asi podemos obtener todos los petodos http
app.get("/products", (req, res) => {
  res.send("list");
});

app.post("/products", (req, res) => {
  res.send("creando");
});
```

---

```js
app.all("/info", (req, res) => {
  //el metodo all, le digo que esta funcionando en todo los petodos, get, post, etc
  res.send("info");
});
```

---

## Response HTTP

El servidor puede responder con muchas cosas como html, videos, audios, texto, json y asi

```js
//como anteriormente texto tambien imagenes o archivos
app.get("/archivo", (req, res) => {
  //para este tipo de archivos usamos el sendFile
  res.sendFile("./static/img.jpg", {
    root: __dirname, //le digo que desde la raiz comience a buscar aqui
  });
});
```

Tambien se puede enviar json

```js
app.get("/user", (req, res) => {
  res.json({
    //tambien se puede enviar el json
    name: "Marcela", //en esto de json si deja enviar sin las comillas pero recurden que no es asi el json
  });
});
```

Status

```js
app.get("/isLive", (req, res) => {
  res.sendStatus(204); //asi tambien podemos enviar solamente un status
});
```

## HTTP response status codes

[Documentacion](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

## Request Body

Los request no solo es un titulo si no se divide en algunas areas

- Endpoint: esta como el titulo del request, podria ser la url
- Header: informacion sobre lo que le enviaremos, json un ejemplo
- Body: el contenido, {clave: valor}

Esta estructura tambien puedo usar en el response, aunque el codigo de estado lo especificamos en el header

```js
//poner antes que pase por la ruta
app.use(express.text()); //esto es para que express pueda procesar texto
app.use(express.json()); //de la misma manera si queremos enviar datos json
app.use(express.urlencoded({ extended: false })); //esto nos ayuda a poder procesar formularios, el objeto y el extended false, le estoy diciendo que los valores seran simples como strings o arreglos basicos si le pongo en true acepta el analisis de objetos anidados

app.post("/user", (req, res) => {
  console.log(req.body); //aqui simplemente hacemos un clg de body, en este caso fue texto pero tambien pueden ser json y todo eso
  res.send("Contenido creado");
});
```

## Request Params

```js
app.get("/hello/:user", (req, res) => {
  //los dos puntos hacen que esa parte de la url sean como una variable y poder acceder a ella
  console.log(req.params); // en este ejemplo me aparece asi { user: 'sebas' }
  // tambien podemos hacer /hello/:user/:nada asi bastantes y ya nos aparece en params

  //esto es un objeto entonces tambien podemos desestructurarlo
  const { user } = req.params;

  console.log(typeof user); //este typeof nos dice que tipo de datoos es
  res.send(`Hello ${user}`);

  // ({params: {user}}, res)    //esta es una manera de desestructurar en cadena
});
```

## Query

Se da en la url y es el signo `?` que ponemos, es una consulta como ejemplo: `http://localhost:3000/hello?name=Sebastian` asi se veria la url, si queremos poner mas de un query `http://localhost:3000/hello?name=sebas&age=18`

Recordar que podemos convinar los params y el query

Si en la url en diferentes espacios ponemos `name=sebas&name=marcela` esto devuelve un arreglo `{name: ['sebas', 'marce']}`

```js
app.get("/hello", (req, res) => {
  console.log(req.query); //aqui podemos obtener las query, ya lo recibimos nosotros como un objeto { name: 'sebas', age: '18' }
  //ya podemos hacer logica con el query
  if (req.query.name === "sebas") {
    res.send(`Hello Admin`);
  } else {
    res.send(`Hello`);
  }
});
```

## Middlewares

Estas son funciones que antes que llegue a la ruta pedida se ejecuta logica o lo que queramos

```js
//esto simplemente es una funcion y para que le ejecute express la utiliza y por eso usamos use
//por estas funciones pasan antes que cualquier otra ruta
app.use((req, res, next) => {
  //primero pasara por esta ruta antes que toodas las url
  console.log(`Route: ${req.url} Method: ${req.method}`); //Route: /profile Method: GET

  next(); //este argumento no lo da express para que siga con el flujo a donde pedimos
});

app.get("/profile", (req, res) => {
  res.send("Profile");
});
```

Se pueden tener dos o mas middlewares y se ejecutaran como estas en el codigo en cascada

```js
app.use((req, res, next) => {
  //asi podriamos hacer un poco de logica
  if (req.query.login === "sebasplashba") {
    next();
  } else {
    res.send("No autorizado");
  }
});
//recordar que el orden importa ya que todas las rutas que esten despues de este middleware esperan el query login
//entonces si no quiero proteger alguna ruta solo la pongo arriba del middleware
app.get("/profile", (req, res) => {
  res.send("Admin");
});
```

Recordar que simplemente son funciones entonces podemos importarlas

Este es un ejemplo la importamos en nuestro archivo y ya la podemos usar

```js
app.use(morgan("dev"));
```

Este es muy basico pero hay muchos que hacen mejores funcionalidades
