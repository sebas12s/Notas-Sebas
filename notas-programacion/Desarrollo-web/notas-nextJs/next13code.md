# Codigo

layout.js

```jsx
export default function RootLayout({ children }) {
  //simplemente es una funcion
  return (
    //retorna en si toda la aplicacion, o el html
    <html lang="en">
      <body>
        <nav>
          {" "}
          {/* esto aparece en todas las paginas */}
          <h3>NavBar</h3>
          <ul>
            <li>
              <a href="/">Home</a>{" "}
              {/*Asi podemos navegar entre las paginas pero esto carga toda la pagina desde sero */}
            </li>
            <li>
              <a href="/amor">Amor</a>
            </li>
          </ul>
        </nav>
        {children}
      </body>{" "}
      {/*y resive las paginas como propiedades*/}
    </html>
  );
}
```

aqui en el layout como vemos se inyectan todas nuestras paginas, igual podemos poner codigo aqui que queramos que aparezca en todas las paginas, podria ser un navbar

## Link

Importando link con el ejemplo anterior, esta seria una manera correcta de manejar

```jsx
<nav>
  <h3>NavBar</h3>
  <ul>
    <li>
      <Link href="/">Home</Link> {/*Esto ya no vuelve a recargar la pagina*/}
    </li>
    <li>
      <Link href="/amor">Amor</Link>
    </li>
  </ul>
</nav>
```

## Layout

Se pueden craer otros layouts en las rutas para que todo lo que este adentro de esa ruta tenga como un nav y eso

```jsx
export default function AmorLayout({ children }) {
  return (
    <>
      <nav>
        <h3>Amor</h3>
        <ul>
          <li>Marcela</li>
          <li>Perritos</li>
        </ul>
      </nav>

      {children}
    </>
  );
}
```

De esta manera puedo poner un nav solo para la seccion

## Metadata

se pone de la siguiente manera los metadatos, se pone en el layout

```jsx
export const metadata = {
  //esto es como un objeto, o un json, esta nos sirve para los metadatos de nuestra pagina
  title: "Marcela", //asi podemos poner el title y metadatos
  description: "Pagina nextjs",
  keywords: "amor, marcela",
};
```

Podemos cambiar con el layout en las demas rutas tambien los metadatos, como el title, aunque no es solamente con el layout si no con todos los componentes, ponemos `export const metadata = {}`

## Font

asi se ponen las fuentes

```jsx
import Navbar from "../components/Navbar";
import { Roboto_Mono } from "next/font/google"; //asi puedo importar de google cualquier fuente

export const metadata = {
  title: "Marcela",
  description: "Pagina nextjs",
  keywords: "amor, marcela",
};

const font = Roboto_Mono({
  //aqui guardo nuestra fuente o los estilos de nuestra fuente en alguna constante
  weight: ["300", "400"],
  style: ["italic", "normal"],
  subsets: ["latin"],
});

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={font.className}>
        {" "}
        {/* y asi la puedo poner como una clase, por eso .className */}
        <Navbar />
        {children}
      </body>
    </html>
  );
}
```

## not-found

```jsx
export default function NotFound() {
  return (
    <section>
      <h1>404</h1>
      <p>Pagina no encontrada</p>
      <Link href="/">Volver</Link>
    </section>
  );
}
```

Creamos nuestra pagina de alerta por si no encontro

---

## cliente servidor

como todo se esta renderizando de parte del servidor, acciones que solo se pueden hacer en el frontend no dejan pero para que dejen se coloca la siguiente palabra

```jsx
"use client"; //con esto ya decimos que es de parte del cliente

export default function HomePage() {
  return (
    <section>
      <h1>Home Page</h1>
      <button
        onClick={() => {
          alert("Me gusta Marcela");
        }}
      >
        clik
      </button>
    </section>
  );
}
```

ya con eso acepta acciones del frontend, o como un componente cliente

## FetchData

Traeremos datos de una api, y los mostraremos en pantalla mediante fetch pero como es un commponente del servidor es mas facil

```jsx
async function loadPost() {
  //recordar qeue para poner el await la funcion tiene que ser async
  const res = await fetch("https://pokeapi.co/api/v2/pokemon/"); //para hacer una peticion se usa fetch, esto me dio una respuesta
  const data = await res.json(); // de la respuesta lo convertimos en json y lo guardamos en otra variable

  // console.log(data)       //esto nos muestra en la terminal no en el navegador recuerden que esto es un componente del servidor
  await new Promise((res) => setTimeout(res, 3000)); //esto ejecuta codigo asincrono por eso await
  //con esto le dije que ejecutarala promemsa despues de 2 segundos entonces como que solo espero 2 segundos para que se lanzara el return
  //esto lo hicimos simulando si una peticion se tarda, para que cargue el loading
  return data.results;
}

async function PostPage() {
  const posts = await loadPost(); //como retornamos los datos aqui los guardamos en post
  console.log(posts);

  //   if (Array.isArray(posts)) {        //esto me sirvio para ver si era un arreglo
  //     console.log('si')
  //   } else {
  //     console.error('posts no es un arreglo.');
  //   }

  return (
    <div>
      {posts.map((post) => (
        // porque tenemos un boton en este componente en el servidor creamos un componente cliente
        <CardPok post={post} /> //y ya solo pasamos el objeto con el map
      ))}
    </div>
  );
}
```

porque el componente tiene un boton y necesita ser un client entonces por eso creamos otro componente

```jsx
function CardPok({ post }) {
  //aqui tenemos como argumento el post que me envian un objeto
  return (
    <div key={post.id}>
      {/* y ya retornamos la informacion con el boton que queriamos */}
      <h3>{post.name}</h3>
      {/* recordar que aqui en el argumento envio el objeto asi que tendra el .name */}
      <button
        onClick={() => {
          alert("Marcela preciosa");
        }}
      >
        Amor
      </button>
    </div>
  );
}
```

## Loading

podemos crear cualquier pagina que queramos con el loading

```jsx
export default function LoadingPage() {
  return <h1>LoadingPage...</h1>;
}
```

## Parametros de la url

hice un ejemplo de obtener un valor de la url y mostrar ese pokemon o por lo menos solo el nombre

```jsx
async function loadPost(pokemon) {
  const res = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokemon}`);
  const data = await res.json();
  console.log(data);
  return data;
}

async function PostPage({ params }) {
  //la pagina en si ya tiene una propiedad por defecto
  const pokemonObj = await loadPost(params.pokemon);
  const imagen = pokemonObj.sprites.other["official-artwork"].front_default; //aqui obtuve la imagen, recuerden que con corchetes tambien se puede recorrer un objeto, poniendo el nombre en corchetes
  const pokemon = pokemonObj.forms[0].name;
  return (
    <div>
      <h2>{pokemon}</h2>
      <img src={imagen} alt="pokemon" />
    </div>
  );
}
```

## Suspense

```jsx
return (
  <div>
    <h2>{pokemon}</h2>
    <img src={imagen} alt="pokemon" />
    <hr />
    <h3>Otros pokemones</h3>
    <Suspense fallback={<div>Cargando pokemones...</div>}>
      {" "}
      {/*el suspense es un componente de react y pone lo que este este fallback mientras se carga lo que esta adentro, esto funciona por si queremos mostrar la pagina aunque no cargue esta parte, entonces eso lo muestra y despues carga esto*/}
      <PostPage />
    </Suspense>
  </div>
);
```

## Import Alias

```jsx
import CardPoke from "@/components/CardPoke"; // next usa el arroba para decir que es el root entonces ya no tenemos que seguir subiendo niveles como: '../../../' y asi
```

## useRouter

```jsx
"use client";
import { useRouter } from "next/navigation";

const router = useRouter(); //ya despues solo usamos funcionalidades del router

<button
  className="bg-sky-500 px-3 py-2 rounded-md"
  onClick={() => {
    alert("Me gusta mucho Marcela");
    router.push("/"); //el push es para enviarnos a otra ruta
  }}
>
  Click
</button>;
```

## useParams

```jsx
const params = useParams(); //para obter el path podemos usar el hook y funciona igual que el params de los argumentos
console.log(params);
const pokemonObj = await loadPost(params.pokemon);
const imagen = pokemonObj.sprites.other["official-artwork"].front_default;
const pokemon = pokemonObj.forms[0].name;
```

## API Route Handlers

```js
import { NextResponse } from "next/server";

export function GET() {
  //tienen que llevar estos nombres de las peticiones, siempre hay que exportarlo
  // return new Response('Marcela hermosa')     //response es un objeto que ya viene por parte del navegador y next los soporta, response ya tiene metodos aunque tambien le podemos colocar solamente texto
  // el response siempre lleva el new

  // return NextResponse.json('Marcela hermosa')      //con nextResponse nos ahorra cositas con solamente el response, retornamos datos

  return NextResponse.json({
    //tambien podemos retornar objetos
    message: "Obteniendo datos",
  });

  //algo importante que antes de retornar puedo, extraer parametros, obtener datos de una DB, o incluso comunicarme con otro backend
}

export function POST() {
  //el navegador no permite llamar todos asi que lo hicimos con postman
  return NextResponse.json({
    message: "Creando datos",
  });
}

export function PUT() {
  return NextResponse.json({
    message: "Actualizando datos",
  });
}

export function DELETE() {
  return NextResponse.json({
    message: "Aliminando datos",
  });
}
```

```js
export async function GET() {
  const res = await fetch("https://jsonplaceholder.typicode.com/users"); //aqui tambien podemos pedir datos de otro backend,
  const data = await res.json();

  return NextResponse.json(data);
}
```

### Params

```js
export async function GET(request, { params }) {
  //request nos da informacion sobre la peticion que hemos hecho, y esta los parametros como en el front, un objeto con la clave del nombre de la carpeta y el valor de lo que hayamos puestos
  const res = await fetch(
    `https://jsonplaceholder.typicode.com/users/${params.id}`
  );
  const data = await res.json();

  return NextResponse.json(data);
}
```

### Querys

```jsx
export async function GET(request, { params }) {
  // new URL(request.url)    //con esto el string que esta en la url lo convierte en un objeto

  // URL: http://localhost:3000/api/users/1?nombre=Marcela&apellido=Perez
  // asi podemos pedir datos de una base de datos con la url
  const { searchParams } = new URL(request.url); //y aqui descompongo el searchParams
  console.log(searchParams); // URLSearchParams { 'nombre' => 'Marcela', 'apellido' => 'Perez' }

  //con get podemos obtener el valor de las claves que pongamos aqui
  console.log(searchParams.get("nombre")); //Marcela
  console.log(searchParams.get("apellido")); //Perez

  const res = await fetch(
    `https://jsonplaceholder.typicode.com/users/${params.id}`
  );
  const data = await res.json();

  return NextResponse.json(data);
}
```

### Post

```jsx
export async function POST(request) {
  // request.body    //asi se ve en otros backend pero en next de una vez se convierte la informacion en json
  // en request se almacena lo que el cliente envia al servidor, para eso es POST
  // recordar que es asincrono, ya podemos pedir que nos envie un nombre o algo asi y ya guardarlo en una base de datos
  const data = await request.json();

  return NextResponse.json({
    message: "Creando datos",
  });
}
```

## .env

asi se ponen las variables de entorno

```jsx
TOKEN=12marcela    //asi se ponen las variables de entorno
SECRET_KEY=sebasmarce
```

```jsx
process.env.TOKEN; //y asi es para obtenerlo
```

# App CRUD Prisma

Conexion a la base de datos despues de ya configurar nuestro prisma

```js
import { PrismaClient } from "@prisma/client"; //esto nos da una clase

export const prisma = new PrismaClient();

//simplemente con esto ya estamos conectados a la base de datos, ya que en env ahi esta nuestra variable ya esta la base de datos y por eso ya es tan facil conectarla
```

En api haremos uso de las variables `[id]` con esta carpeta y usaremos GET, POST etc.

---

Estas son como funcionan

api/task

```js
import { prisma } from "@/libs/prisma";
import { NextResponse } from "next/server";

//asi podemos obtener datos de nuestra base de datos

export async function GET() {
  const task = await prisma.task.findMany(); //lo que exportamos, nuestra base de datos y ponemos nuestra tabla y ahi ya podemos crear eliminar y en este caso traer, findMany busca todos los datos
  /*        esto es lo que devuelve en task, nuestro dato que ingresamos en la base de datos
    [
        {
            id: 1,
            title: 'Amor',
            description: 'Le tengo que decir a mi novia que la amo mucho',
            createAt: 2023-09-04T00:03:50.132Z
        }
    ]
    */

  return NextResponse.json(task);
}
```

```js
export async function POST(request) {
  //con postman para esta prueba envie el siguiente json
  /*
    {
        "title": "Amor 2 post",
        "description": "Decirle que la amo mas a mi novia"
    }
    */
  //entonces estos datos obtuve aqui

  //   const data = await request.json(); //post es para obtener datos, entonces en request obtnemos esos datos que nos envia el cliente, y ya lo convertimos en json
  const { title, description } = await request.json(); //asi tambien se pueden extraer
  const newTask = await prisma.task.create({
    data: {
      //data son las columnas que buscamos guardar, solo son dos ya que id y date se crean por si mismas
      // title: data.title
      // title: title,
      // description: description        //pero como son el mismo nombre solamente se pueden una vez
      title,
      description,
    },
  });

  return NextResponse.json(newTask); //newTask ya se encuentra la nueva tarea y ya se crea en la base de datos*
}
```

api/task/\[id\]

```js
export async function GET(request, { params }) {
  //obtener

  const task = await prisma.task.findUnique({
    //findUnique, solo uno nos traera
    where: {
      //donde id sea igual al parametro en este caso, ya que la url es string lo convertimos en number
      id: Number(params.id),
    },
  });

  return NextResponse.json(task);
}
```

```js
export async function DELETE(request, { params }) {
  //Eliminar
  try {
    //un try catch porque al no encontrar un dato para eliminar nos da error
    const taskRemoved = await prisma.task.delete({
      //esto devuelve a la variable la tarea borrada
      where: {
        //pero ya esta eliminada en la base de datos
        id: Number(params.id),
      },
    });
    return NextResponse.json(taskRemoved);
  } catch (error) {
    return NextResponse.json(error.menssage); //si nos da un erro devolvemos este mensaje del error
  }
}
```

```js
export async function PUT(request, { params }) {
  //Actualizar
  const data = await request.json();
  // {    //esto nos devuelve
  //   title: 'Tarea 2',
  //   description: 'Decirle preciosa a mi novia Marcela y que es muy inteligente'
  // }

  const taskUpdated = await prisma.task.update({
    where: {
      id: Number(params.id),
    },
    // data: {   //estos son los datos que actualizaran
    //   title: data.title,
    //   description: data.description
    // }
    data: data, //ya que nos envian tal y como lo queremos cambiar podemos poner solamente asi
    //tambien que pasemos asi nos ayuda a actualizar solamente lo que enviemos porque puede que solo quiera actualizar el title y asi
  });

  return NextResponse.json(taskUpdated);
}
```

## Formulario POST

```jsx
"use client";

import { useRouter } from "next/navigation";
import React from "react";

function NewPage() {
  const router = useRouter(); //aqui simplemente inicializo el useRouter

  //le ponemos un onsubmit para que haga algo al enviar el formulario, en este caso le mandamos una funcion que esta funcion resivira todas las acciones

  //el form envia este evento y en target esta el valor de lo que tiene, entonces buscandolo encontramos el title y la description
  const onSubmit = async (e) => {
    //tiene que ser async
    e.preventDefault(); //esto es para que no se actualice
    const title = e.target.title.value; //guardamos los valores de los inputs en constantes
    const description = e.target.description.value;

    const res = await fetch("/api/task", {
      //no tenemos que colocar http//localhost:3000 porque al estar en la misma ruta como que lo autocompleta entonces solamente ponemos lo que esta despues de eso
      //hacemos el llamado de nuestra api y el segundo argumento hacemos esto
      method: "POST", //decimos que sera un post que es para crear una nueva tarea
      body: JSON.stringify({ title, description }), //del cuerpo le enviamos los valores en formato json string
      headers: {
        //y esto es para que pueda ser entendido como un json
        "Content-Type": "application/json",
      },
    });

    const data = await res.json();

    router.push("/"); //aqui no podemos hacer un link ya que necesitamos hacer logica y despues redirigir
  };

  return (
    <div className="h-screen flex justify-center items-center">
      <form className="bg-slate-800 p-10 w-2/5" onSubmit={onSubmit}>
        <label htmlFor="title" className="font-bold text-sm">
          Titulo de la tarea
        </label>
        <input
          type="text"
          id="title"
          className="border border-gray-400 p-2 mb-4 w-full text-black"
          placeholder="Titulo"
        />

        <label htmlFor="description" className="font-bold text-sm">
          Descripcion de la tarea
        </label>
        <textarea
          rows="3"
          id="description"
          className="border border-gray-400 p-2 mb-4 w-full text-black"
          placeholder="Descripcion"
        ></textarea>

        <button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-3 rounded">
          Crear
        </button>
      </form>
    </div>
  );
}

export default NewPage;
```

## Listar las tareas

```jsx
import { prisma } from "@/libs/prisma";

async function loadTask() {
  // const res = await fetch('http//localhost:3000/api/task')    //esto si es en el servidor entonces por eso si se pone la ruta completa
  // const data = await res.json()
  //se recomienda que si separaras tu backend mejor usar esta manera de aqui arriba

  // const task = await prisma.task.findMany()    //esto es lo mismo, solamente que arriba hicimos la peticion a la api y aqui solamente a la base de datos

  return await prisma.task.findMany(); //asi tambien nos podemos ahorrar la constante
}

export default async function HomePage() {
  const task = await loadTask(); //aqui guardo las tareas

  return (
    <section className="container mx-auto">
      <div className="grid grid-cols-3 gap-3 mt-10">
        {" "}
        {/*este componente lo separamos en task*/}
        {task.map((task) => (
          <div
            key={task.id}
            className="bg-slate-900 p-3 hover:bg-slate-800 hover:cursor-pointer"
          >
            <h3 className="font-bold text-2xl mb-2">{task.title}</h3>
            <p>{task.description}</p>
            <p>{new Date(task.createAt).toLocaleDateString()}</p>{" "}
            {/* esto es para que la fecha de la base de datos se convierta en string visible */}
          </div>
        ))}
      </div>
    </section>
  );
}
```

```jsx
"use client";

import { useRouter } from "next/navigation";

function TaskCard({ task }) {
  const router = useRouter();

  return (
    <div
      className="bg-slate-900 p-3 hover:bg-slate-800 hover:cursor-pointer"
      onClick={() => {
        router.push(`/task/edit/${task.id}`);
      }}
    >
      <h3 className="font-bold text-2xl mb-2">{task.title}</h3>
      <p>{task.description}</p>
      <p>{new Date(task.createAt).toLocaleDateString()}</p>
    </div>
  );
}
```
```jsx
import NewPage from "@/app/new/page";   // recordar que en new page tenemos para agregar una nueva tarea

export default NewPage;     //entonces nosotros simplemente exportamos la interface de crear, ya solamente tenemos que cambiar 
```
## Nuevo formulario create, update, delete

```jsx
"use client";

import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";

function NewPage({ params }) {
  const router = useRouter();
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");

  useEffect(() => {
    //este useEffect es para cuando cargue la pagina ejecute algo
    if (params.id) {
      fetch(`/api/task/${params.id}`)
        .then((res) => res.json()) //esto es lo mismo que ponerlos en constantes y usar await
        .then((data) => {
          //en la base de datos tenemos valores, entonces esos valores le damos a las variables
          setTitle(data.title);
          setDescription(data.description);
        });
    }
  }, []);

  const onSubmit = async (e) => {
    e.preventDefault();
    // const title = e.target.title.value;   //ya no necesito obtenerlo al momento en que enviamos la funcion ya que en la variable title del useState ya estara
    // const description = e.target.description.value;

    if (params.id) {
      // si existe un id en la url, eso pregunto con el if
      const res = await fetch(`/api/task/${params.id}`, {
        method: "PUT",
        body: JSON.stringify({ title, description }),
        headers: {
          "Content-Type": "application/json",
        },
      });
      const data = await res.json();
    } else {
      //le digo si no tiene un id la url es porque no hay tarea para editar entonces se crea
      const res = await fetch("/api/task", {
        method: "POST",
        body: JSON.stringify({ title, description }),
        headers: {
          "Content-Type": "application/json",
        },
      });

      const data = await res.json();
    }

    router.refresh(); //para que se vean los datos se tiene que refrescar entonces con router lo podemos hacer
    router.push("/");
  };

  return (
    <div className="h-screen flex justify-center items-center">
      <form className="bg-slate-800 p-10 w-2/5" onSubmit={onSubmit}>
        <label htmlFor="title" className="font-bold text-sm">
          Titulo de la tarea
        </label>
        <input
          type="text"
          id="title"
          className="border border-gray-400 p-2 mb-4 w-full text-black"
          placeholder="Titulo"
          onChange={(e) => setTitle(e.target.value)} //aqui le estoy diciendo que cuando haga cambios este input el valor le envie a la variable o se lo cambie gracias al useState, lo mismo con el description
          value={title}
        />

        <label htmlFor="description" className="font-bold text-sm">
          Descripcion de la tarea
        </label>
        <textarea
          rows="3"
          id="description"
          className="border border-gray-400 p-2 mb-4 w-full text-black"
          placeholder="Descripcion"
          onChange={(e) => setDescription(e.target.value)}
          value={description}
        ></textarea>

        <div className="flex justify-between">
          <button
            className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-3 rounded"
            type="submit" //y este le estamos diciendo que este boton es el que envia
          >
            {params.id ? "Actualizar" : "Crear"}{" "}
            {/*detallito para cuando exista el params.id es porque actualizara */}
          </button>

          {/* {params.id ? <button className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-3 rounded ml-4">Delete</button> : <></>} */}
          {params.id && ( //asi tambien podemos hacer una condicion o como esta arriba
            <button
              className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-3 rounded"
              type="button" //es importante que este tenga este type, ya que asi le decimos que hara otra accion no la de enviar
              onClick={async () => {
                const res = await fetch(`/api/task/${params.id}`, {
                  method: "DELETE",
                });

                const data = await res.json()
                console.log(data)

                router.refresh();
                router.push("/");
              }}
            >
              Delete
            </button>
          )}
        </div>
      </form>
    </div>
  );
}
```