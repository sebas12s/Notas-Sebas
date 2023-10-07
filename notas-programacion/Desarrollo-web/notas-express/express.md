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
  - [Express Settings](#express-settings)
  - [Static Files](#static-files)
  - [Router](#router)
  - [Template engine](#template-engine)
    - [Ejs](#ejs)
    - [Partial ejs](#partial-ejs)
  - [Fetch](#fetch)

## Codigo

Un ejemplo sin express:

```js
import http from 'http';
import { createReadStream } from 'fs';

//normalmente nosotros devolvemos un html, aqui estoy devolviendo un simple html y se lo mando al res
const server = http.createServer((req, res) => {
  const datos = createReadStream('./static/index.html');
  datos.pipe(res);
});

server.listen(3000);
```

Con express

```js
const express = require('express');

const app = express();

app.get('/', (req, res) => {
  //tiene el req y res como siempre y la ruta
  res.sendFile('./static/index.html', {
    //este sendFile ya es un especial para poder enviar archivos
    root: __dirname, //recuerden que el __dirname nos da la ruta hasta donde esta el archivo, por eso lo ponemos como root y ya podemos poner la ruta del archivo arriba
  });
});

app.listen(3000, () => {
  //le digo con la funcion que cuando este escuchando ejecute eso
  console.log('Escuchando en el puerto 3000');
});
```

## Routing /URL

```js
const express = require('express');

const app = express();

app.get('/', (req, res) => {
  //para obtener toda la url podemos hacer el req.url
  res.send('Welcome'); //ademas de enviar el metodo end usamos send que es de express
});

app.get('/she', (req, res) => {
  //asi se pueden ir creando rutas las que queramos
  res.send('Mar');
});

app.use((req, res) => {
  //este use es si ya visito tadasa las poagina y ni una coicide con la que estamos colocando en la url busca esta
  res.status(404).send('No se encontro la pagina'); //el estatus como su nombre le dice es para ponerle un estado a la peticion
});

app.listen(3000, () => {
  console.log('Escuchando en el puerto 3000');
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
app.get('/products', (req, res) => {
  res.send('list');
});

app.post('/products', (req, res) => {
  res.send('creando');
});
```

---

```js
app.all('/info', (req, res) => {
  //el metodo all, le digo que esta funcionando en todo los petodos, get, post, etc
  res.send('info');
});
```

---

## Response HTTP

El servidor puede responder con muchas cosas como html, videos, audios, texto, json y asi

```js
//como anteriormente texto tambien imagenes o archivos
app.get('/archivo', (req, res) => {
  //para este tipo de archivos usamos el sendFile
  res.sendFile('./static/img.jpg', {
    root: __dirname, //le digo que desde la raiz comience a buscar aqui
  });
});
```

Tambien se puede enviar json

```js
app.get('/user', (req, res) => {
  res.json({
    //tambien se puede enviar el json
    name: 'Marcela', //en esto de json si deja enviar sin las comillas pero recurden que no es asi el json
  });
});
```

Status

```js
app.get('/isLive', (req, res) => {
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

app.post('/user', (req, res) => {
  console.log(req.body); //aqui simplemente hacemos un clg de body, en este caso fue texto pero tambien pueden ser json y todo eso
  res.send('Contenido creado');
});
```

## Request Params

```js
app.get('/hello/:user', (req, res) => {
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
app.get('/hello', (req, res) => {
  console.log(req.query); //aqui podemos obtener las query, ya lo recibimos nosotros como un objeto { name: 'sebas', age: '18' }
  //ya podemos hacer logica con el query
  if (req.query.name === 'sebas') {
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

app.get('/profile', (req, res) => {
  res.send('Profile');
});
```

Se pueden tener dos o mas middlewares y se ejecutaran como estas en el codigo en cascada

```js
app.use((req, res, next) => {
  //asi podriamos hacer un poco de logica
  if (req.query.login === 'sebasplashba') {
    next();
  } else {
    res.send('No autorizado');
  }
});
//recordar que el orden importa ya que todas las rutas que esten despues de este middleware esperan el query login
//entonces si no quiero proteger alguna ruta solo la pongo arriba del middleware
app.get('/profile', (req, res) => {
  res.send('Admin');
});
```

Recordar que simplemente son funciones entonces podemos importarlas

Este es un ejemplo la importamos en nuestro archivo y ya la podemos usar

```js
app.use(morgan('dev'));
```

Este es muy basico pero hay muchos que hacen mejores funcionalidades

## Express Settings

```js
app.set('appName', 'Express Curse'); //set de settings, asi podemos guardar como varaibles y las llamamos con get como esta abajo, clave y valor es lo que nos devuelve
app.set('port', 3000); //tambien podemos tener muchas mas
app.set('case sensitive routing', true); //como esta configuracion ayuda para que respete si la url esta en mayuscula o minuscula

//no se usa mucho eso pero es un ejemplo de las configuraciones

//normalmente se trabaja en este orden
//settings
//middlewares
//routes

app.listen(app.get('port'), () => {
  console.log(
    `Escuchando ${app.get('appName')} en el puerto ${app.get('port')}`
  );
});
```

## Static Files

Esto es cuando queremos enviar mas de un archivo al front entonces cofiguramos en express la carpeta en la que esta, normalmente estas carpetas se llaman public o static

Para esto usamos un middleware

```js
//normalmente estas public se colocan en lo ultimo despues de las rutas
app.use(express.static('./public')); //ya con esto puede ser visto en el navegador, todo lo que coloque en esta carpeta puede ser accedido
//tambien podemos poner mas carptas
app.use('/public', express.static('./public')); //si le agrego el primer parametro le estoy diciendo que solo puede ser accedido en esa url
```

Hay un caso si tenemos todos los archivos en una carpeta en src tenemos que mandar toda la ruta relativa, completa, ya que no funcionara solo poner `./public` si no tenemos que poner toda la ruta entonces para eso usamos el modulo `path`

```js
app.use('/public', express.static(path.join(__dirname, 'public')));
```

De esta manera unimos hasta la carpeta donde estamos con la carpeta que queremos hacer publica

## Router

Es para manejar las rutas que tenemos en diferentes archivos, express ya nos da un modulo para esto

```js
const express = require('express');

const router = express.Router();

router.get('/ella', (req, res) => {
  res.json({
    love: 'Marcela',
  });
});
//almacena todas las rutas en esa variable router, asi puedo poner muchas rutas en el mismo archivo y solo exportamos la variable
module.exports = router;
```

```js
const express = require('express');
const routerGet = require('./routes/get');
//solo la importamos
const app = express();

app.use(routerGet); //y ya lo usamos y podemos acceder a las rutas normalmente

app.listen(3000, () => {
  console.log('Escuchando en el puerto 3000');
});
```

## Template engine

### Ejs

Hay un modulo que nos ayuda a enviar html al front y asi enviar muchos archivos con funcionalidades extras ese es ejs

Los archivos se guardan con la extension `ejs` como `index.ejs`

Este es un motor de plantillas

```js
const express = require('express');
const path = require('path');
const routerGet = require('./routes/get');
const app = express();
require('ejs'); //solo haciendo esto ya esta en nuestra app

//esta configuracin es importante, con la primera le estoy diciendo a express que utilice ejs para renderizar nuestras paginas
//con el segundo le estoy diciendo donde buscar las paginas, por eso solamente utilizamos render para enviar solamente el archivo
app.set('view engine', 'ejs'); //este es la configuracion del motor de plantillas que estamos utilizando
app.set('views', path.join(__dirname, 'views')); //estoy configurando que hare publico

app.use(routerGet);

app.listen(3000, () => {
  console.log('Escuchando en el puerto 3000');
});
```

```js
const { Router } = require('express');
const router = Router();

router.get('/', (req, res) => {
  //aqui podemos usar mas logica y pasar esas variables o datos al html gracias a ejs
  const title = 'Marcela linda preciosa';

  //y para pasar los datos al html le pasamos un objeto con los datos
  res.render('index', { title }); //ejs nos da este metodo que es render
});

router.get('/she', (req, res) => {
  //si quiero mandar mas solo pongo el render
  res.render('she'); //recordar que en el render pongo el archivo
});

module.exports = router;
```

Y si queremos obtener las variables en el html hacemos lo siguiente `<h1><%= title %></h1>` la sintaxis es la de `<%= %>`

### Partial ejs

Esto nos ayuda a separar pedazos de codigo de ejs y poderlos unir a otros ejs

En este ejemplo separamos el header y el footer de la pagina ya que se usara siempre

header
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Ejs</title>
  </head>
  <body>
```

footer
```html
</body>
</html>
```

y ya en las paginas lo usabamos de esta manera
```js
<%- include('partials/header.ejs') %>
    <h1>She is beatiful</h1>
<%- include('partials/footer.ejs') %>
```
Esa tambien seria la sintaxis e incluir la ruta al archivo

---
Este es otro ejemplo ya usando mas sintaxis de js en este caso un if como en en la sintaxis de ejs solo incluyo `<% %>`

```js
<%- include('partials/header.ejs') %>
<h1><%= title %></h1>

<% if(isActive) { %>
  <p>Esta activo</p>
<% } else { %>
  <p>Esta inactivo</p>
<% } %> 
<%- include('partials/footer.ejs') %>
```
---

## Fetch

En este ejemplo no usamos fetch si no axios pero hicimos la petcion a otro servidor y ya podemos enviar los datos al cliente, como un json o con la pagina

```js
router.get('/api', async (req, res) => {
  const { data } = await axios.get('https://pokeapi.co/api/v2/pokemon/');
  console.log(data.results);

  res.render('api', {
    data: data.results,
  });
});
```

```js
<%- include('partials/header.ejs') %>
<h1>Api</h1>

<% data.map((d) => { %>
    <h2><%= d.name %></h2>
<% }) %>

<%- include('partials/footer.ejs') %>
```