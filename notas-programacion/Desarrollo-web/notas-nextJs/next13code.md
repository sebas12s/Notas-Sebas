# Codigo 
layout.js
```jsx
export default function RootLayout({ children }) {    //simplemente es una funcion 
 return (   //retorna en si toda la aplicacion, o el html
    <html lang="en">
      <body>
        <nav>     {/* esto aparece en todas las paginas */}
          <h3>NavBar</h3>
          <ul>
            <li>
              <a href="/" >Home</a>   {/*Asi podemos navegar entre las paginas pero esto carga toda la pagina desde sero */}
            </li>
            <li>
              <a href="/amor">Amor</a>
            </li>
          </ul>
        </nav>
        {children}
      </body>   {/*y resive las paginas como propiedades*/}
    </html>
  )
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
      <Link href="/" >Home</Link>  {/*Esto ya no vuelve a recargar la pagina*/}
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
export const metadata = {   //esto es como un objeto, o un json, esta nos sirve para los metadatos de nuestra pagina
  title: 'Marcela',   //asi podemos poner el title y metadatos
  description: 'Pagina nextjs',
  keywords: 'amor, marcela'
}
``` 

Podemos cambiar con el layout en las demas rutas tambien los metadatos, como el title, aunque no es solamente con el layout si no con todos los componentes, ponemos `export const metadata = {}` 

## Font
asi se ponen las fuentes
```jsx
import Navbar from "../components/Navbar"
import {
  Roboto_Mono
} from 'next/font/google'     //asi puedo importar de google cualquier fuente

export const metadata = {   
  title: 'Marcela',   
  description: 'Pagina nextjs',
  keywords: 'amor, marcela'
}

const font = Roboto_Mono({    //aqui guardo nuestra fuente o los estilos de nuestra fuente en alguna constante
  weight: ['300', '400'],
  style: ['italic', 'normal'],
  subsets: ['latin']
})
 
export default function RootLayout({ children }) {    
 return (   
    <html lang="en">
      <body className={font.className}>   {/* y asi la puedo poner como una clase, por eso .className */}
        <Navbar />

        {children}
      </body>   
    </html>
  )
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
'use client'  //con esto ya decimos que es de parte del cliente

export default function HomePage() {
    return(
        <section>
            <h1>Home Page</h1>
            <button onClick={()=> {
                alert('Me gusta Marcela')
            }}>
                clik
            </button>
        </section>
    )
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
        <CardPok post={post}/>   //y ya solo pasamos el objeto con el map
      ))}
    </div>
  );
}
```
porque el componente tiene un boton y necesita ser un client entonces por eso creamos otro componente
```jsx
function CardPok({post}) {      //aqui tenemos como argumento el post que me envian un objeto
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