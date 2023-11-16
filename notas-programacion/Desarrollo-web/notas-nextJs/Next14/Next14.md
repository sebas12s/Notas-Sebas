# Next.js 14

## Crear una aplicacion

El arroba es para poner la version en este caso la ultima

- `npx create-next-app@latest nameapp`

Para que corra la app es

- `npm run dev`

## Archivos y carpeta

Es la explicacion de una estructura de carpetas y archivos en una app de next

- `.next`: no se le da seguimiento no tocar
- `app`: donde esta toda nuestra app
  - `global.css`: nuestros estilos globales de la aplicacion
  - `layout.tsx`: donde se renderiza nuestra `page.tsx` este layout es el root layout como el main de react
- `node_modules`: los modulos de node
- `public`: contenido estatico que subimos
- `.eslintrc.json`: configuracion de lint
- `.gitignore`: para no darle seguimiento
- `next-env.d.ts`: archivos de definicion, nos ayudan para el typado
- `next.config.js`: configuraciones de como se crea nuestra app o como queremos que corra
- `package-lock.json`: las dependencias de nuestras dependencias
- `package.json`: donde estan todas las dependecias
- `postcss.config.js`: para hacer configuracion
- `README.md`: es para la documentacion para dar instrucciones
- `tailwind.config.js`: nuestras configuraciones de tailwind
- `tsconfig.json`: nuestra configuracion de TypeScript

## Codigo / Datos

- Cuando encerramos la carpeta en parentesis decimos que no queremos que la tome como una ruta, nos puede ayudar a solamente emcapsular archivos

## Nombres Especiales

Nombres especiales de archivos

- `page.tsx`: son paginas completas, que al entrar a la ruta de carpetas lo que mostrara sera el page
- `layout.tsx`: nuestro cascaron que estara arriba de todas las paginas, aqui podemos poner cosas que queramos que esten abajo de todo
- `not-found`: nuestra pagina especial que queramos que aparezca cuando haya un error de not-found
- `error.tsx`: nuestra pagina especial que queremos que aparezca cuando haya un error
- `route.ts`: es para crear nestras apis, es el archivo para las apis

## Server Components

Todos los componentes adentro del directorio app son server components, son componentes del lado del servidor

Se recomienda que todo lo que podamos sea generado por lado del servidor solo las piezas interactivas les pongamos el `use client` ya que en un server component no se pueden ejecutar efectos secundarios

Un dato que debemos que conocer es que los server components solo una vez se contruyen no se estan va de llamar como los client component

## Build de produccion

La misma experiencia no es la misma en produccion y en desarrollo

Los escripst sirven para diferentes cosas

- `"dev": "next dev"`: este como ya sabemos para correr la aplicacion en modo desarrollador
- `"build": "next build"`: esto arregla la app para produccion
- `"start": "next start"`: este sirve para levantar la app de produccion pero si no hacemos el build antes no funcionara

Cuando hacemos el build ya podemos levantar la app de produccion con el `npm run start`

Ya en la carpeta de next ahi estan nuestras paginas y lo que se subira si subimos nuestra app a internet

## Rutas

Hay nombres que estan restringidos para ponerles a las paginas como

- `layout`
- `page`
- `error`
- `loading`

Y asi no se les puede poner

Las rutas se crean mediante carpetas adentro del app, y adentro de esa carpeta con el nombre page entonces si queremos crear una ruta `/about` creamos `app/about/page.tsx` y eso seria lo que se muestre en esa ruta

## Metatags

En el layout ahi podemos poner nuestro titulo y una descripcion general aunque podemos tambien poner metatags por paginas

<!-- !Description -->

- MetaTag Description: Este es suma importante en tus pagina por que lo que este ahi los motores de busqueda puedan asociarla a lo que estan buscando

Para poner metatags en next simplemente se exporta una constante metadata y next busca esa constante si no esta toma la metadata del layout padre o del layout principal

- mr: esto es una abreviacion para ya tener la metadata

```tsx
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Contact Page',
  description: 'Pagina del contact',
  keywords: ['Contact', 'Mar', 'Next'],
};
```

Esto es todo tambien podemos encontrar muchos metadatos como los keywords entre otros

## Layout

Podemos crear mas layouts anidados como el principal que tenemos pero podemos darnos cuenta que en el layout recibe los children es un higher order components, pero no lo llamamos en ningun lado, cuando tenemos un layout recibira todos los componentes o childrens que esten en su nivel y abajo

Un layout algo que quiero que este en todas las paginas como el navbar y esas cosas

- lrc: para crarlo rapido

Es importante que el archivo se llame `layout.tsx`

```tsx
export default function PublicLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div>
      <h1 className='text-4xl text-cyan-900 mt-4 ml-4'>Marcela Hermosa</h1>
      {children}
    </div>
  );
}
```

## Link

Es un componente que nos ayuda para la navegacion y solo se muestra la pagina no hace como el refresh

```tsx
<Link href={'/amor'}>Amor</Link>
```

## CSS

Para estilos globales se crea un archivo `globals.css` y si queremos ponerle un estilo a un componente le tenemos que poner module como `nombre.module.css`

## Redirect

```tsx
import { redirect } from 'next/navigation';

export default function HomePage() {
  redirect('/dashboard/counter'); //esto nos ayuda a redireccionar a alguna ruta, le estoy diciendo que la page principal sea una redireccion al dashboar/counter
}
```

## Next Image

[Documentacion](https://nextjs.org/docs/app/api-reference/components/image)
es un un componente propio de next para poner imagenes pero ya nos trae muchas funcionalidades extras y muy valiosas

Despues de poner todas las proopiedades

```tsx
<Image
  className='rounded-full w-8 h-8'
  src='https://images.unsplash.com/photo-1542909168-82c3e7fdca5c'
  alt='User avatar'
  width={50}
  height={50}
  priority={false}
  // normalmente esta propiedad esta en false entonces se cargaran las imagenes que se vayan a ver en ese momento, en este caso que tenemos muchas mientras vayamos haciendo scroll se iran cargando
  // pero si lo ponemos en true se cargan la imagen nada mas se cargue la pagina
/>
```

Tenemos que configurar next.config para especificar de donde aceptaremos las imagenes para evitar hacks y eso en las imagenes

```js
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: 'https', //le decimos que protocolo vamos a aceptar
        hostname: 'images.unsplash.com', //y el dominio en el que estan, en este caso la imagen de ejemplo
      },
    ],
  },
};

module.exports = nextConfig;
```

## usePathname

```tsx
const pathName = usePathname(); //este hook de de next nos da el path de donde estamos
```

## Data Feching

Next ya usa la api de fetch pero les agrega nuevas funcionalidades

[Documentacion](https://nextjs.org/docs/app/building-your-application/data-fetching)

Un dato es que por defecto todas las peticiones del fetch son cached, esto quiere decir que si hacemos una peticion con los mismos argumentos las demas veces sera reutilizada la misma respuesta, la informacion en cache no hasta al servidor

```tsx
const getPokemon = async (id: string): Promise<Pokemon> => {
  try {
    const res = await fetch(`https://pokeapi.co/api/v2/pokemon/${id}`, {
      cache: 'force-cache', // con esto le digo que la informacion se quede en cache
    });
    const data = await res.json();
    return data;
  } catch (error) {
    notFound(); //esta funcion envia al not-found de la app
  }
};
```

Si no usamos fetch y usamos axios o otro manejador lo que se tiene que hacer es

```tsx
export const revalidate = 3600;
```

Exportamos el revalidate tiene que tener ese nombre, en segundos igual

## Page Error

[Documentacion](https://nextjs.org/docs/app/building-your-application/routing/error-handling)

Para crear una pagina de error de nuevo es un nombre de archivo especial que tiene que ir en el mismo nivel del que queremos manejar el error commo un layouts

Es use client

Estructura basica

```tsx
'use client'; // Error components must be Client Components

import { useEffect } from 'react';

export default function Error({
  error,
  reset,
}: {
  // esto ya nos da dos propiedades, el error y la funcion de reset reinicia solamente el componente el pedazo donde hubo el error recargar toda la pagina
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // mostramos el error en consola cada vez que cambie el error
    console.error(error);
  }, [error]);

  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={() => reset()}>Try again</button>
    </div>
  );
}
```

## Rutas dinamicas

Para poder resivir algo de la url y poder controlar eso, la carpeta se crea entre corchetes ejemplo: dashboard/pokemon/\[id] de esta manera para que lo que pongamos en la url sea el id y lleva ese nombre

```tsx
interface Props {
  params: { id: string }; //siempre lo que viene en la url son strings
}

export default function PokemonIdPage(params: Props) {
  console.log(params); // en params vienen dos argumentos params: que es el nombre que pusimos en la carpeta y el valor en este ejemplo id: '1'
  // y search params son los parametros opcionales si enviamos algo como ?q=mar&p=sebas eso son los search params
  return (
    <div>
      <h1>Hello Page</h1>
    </div>
  );
}
```

## Metadata Dynamica

Nos ayuda a poner metadata pero si la necesitamos de alguna peticion o de otro lado se hace esta funcion

```tsx
export async function generateMetadata({ params }: Props): Promise<Metadata> {
  // recibe igual los params y regresa una promesa de Metadata
  const { name, id } = await getPokemon(params.id);
  // y simplemente retornamos nuestar metadata como anterior vimos
  return {
    title: `${id} - ${name}`,
    description: `Página del pokemon ${name}`,
  };
}
```

## Not-found

Tambien podemos editar la pantalla 404 que aparece por defecto, esta pagina es cuando entramos a una url que no existe
[Documentacion](https://nextjs.org/docs/app/api-reference/file-conventions/not-found)

Creamos un archivo `not-found.tsx` y esa pantalla que coloquemos ahi sera nuestra not-found, funciona como los layouts si queremos tener diferentes not-founds para cada pagina los ponemos en la raiz de esa pagina o el lugar donde queramos

## Contenido Estatico de ante mano

Un ejemplo con pokeapi cuando queremos llamar a un pokemon por id hacemos la peticion entonces a un pokemon en el servidor hace eso y envia el html pero en el momento que hacemos la peticion

Pero podemos generar las paginas de manera estatica tambien de ante mano de peticiones que sepamos que no cambiaran y si cambian tambien se puede poner funcionalidades

Entonces creamos las paginas en momento de construccion, en el build de la aplicacion

```tsx
interface Props {
  params: { id: string };
}

//! Solo se ejecuta en build time
// el nombre de la funcion es obligatorio
export async function generateStaticParams() {
  // tenemos que regresar un arreglo con los parametros que queremos en este caso en la url que es la carpeta con el corchetes y como en el corchetes tiene [id] asi tenemos que enviar el arreglo de objetos
  return [
    { id: '1' },
    { id: '2' },
    { id: '3' },
    { id: '4' },
    { id: '5' },
    { id: '6' },
  ];
}
```

Solo con esa funcion, en el caso de este ejemplo de pokemonapi ya genero las paginas estaticas del 1 al 6

### ALGO IMPORTANTE

Cuando generamos paginas estaticas mediante el url se recomienda mucho que mejor sean nombres o algo legible para un humano lo que este en la url

Un ejemplo, si tenemos el id del pokemon mejor que este el nombre del pokemon ya que es mas legible, tambien para los bots de google y todo eso del SEO

Esto se llama Slug

El slug es una pequeña parte de un enlace que permite identificar un contenido específico en una web

Un ejemplo seria: `dashboar/pokemon/pokemon-charmander` no `dashboar/pokemon/4`

## Estados globales Redux

No todas las aplicacione de next necesitan un estado global, ya que una aplicacion generada del lado del servidor no es necesario por que se sabe el estado desde el momento en el que entra pues estaremos conectados con el servidor

### Redux toolkit

- Instalaciones:
  - `npm install @reduxjs/toolkit react-redux`
- Creamos nuestro store

src/store/index.ts

```ts
import { configureStore } from '@reduxjs/toolkit';

export const store = configureStore({
  reducer: {},
});

// Para tener tipados estrictos para nuestro dispatch y para nuestro store
export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
```

Y nuestro provider recordemos tiene que estar lo mas arriba posible que queramos, entonces seria bueno ponerlo en el layout pero como necesita ser un client component creamos un higher-order component (HOC) para poner el provider

```tsx
'use client';

import { Provider } from 'react-redux';
import { store } from '.';

interface Props {
  children: React.ReactNode;
}

export const Providers = ({ children }: Props) => {
  return <Provider store={store}>{children}</Provider>;
};
```

Y ya encerramos en el layout a nuestros childrens con esto

```tsx
return (
  <html lang='en'>
    <body className={inter.className}>
      <Providers>{children}</Providers>
    </body>
  </html>
);
```

Veamos un slices y un reducer

```ts
import { configureStore } from '@reduxjs/toolkit';
import counterSlice from './counter/counterSlices';
import { TypedUseSelectorHook, useDispatch, useSelector } from 'react-redux';

export const store = configureStore({
  reducer: {
    counter: counterSlice,
    // aqui no le ponemos el .reducer como era antes porque lo estamos exportando por defecto en el slices, esta es la manera recomenda
  },
});

// Para tener tipados estrictos para nuestro dispatch y para nuestro store
export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

// Use throughout your app instead of plain `useDispatch` and `useSelector`
export const useAppDispatch: () => AppDispatch = useDispatch;
export const useAppSelector: TypedUseSelectorHook<RootState> = useSelector;

// Estos dos ultimos sostituyen al dispatc y useSelector, esta es la manera de usarlo en typeScript
```

Nuestro Slices

```ts
import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface CounterState {
  count: number;
}

const initialState: CounterState = {
  count: 12,
};

export const counterSlice = createSlice({
  name: 'counter',
  initialState, //usamos el initialState ya creado antes
  reducers: {
    // esta es la manera de hacer las funciones
    // se recomienda que estas funciones sean puras, me refiero que se manejen todo los cambios y todo adentro de la funcion, sin llamar a otras funciones o apis
    addOne(state) {
      state.count++;
    },
    substractOne(state) {
      if (state.count === 0) return;
      state.count--;
    },
    resetCount(state, action: PayloadAction<number>) {
      // esto es el tipado y ponemos adentro de los signos el tipo de dato que traera el payload
      if (action.payload === 0) action.payload = 0;
      state.count = action.payload;
    },
  },
});

export const { addOne, resetCount, substractOne } = counterSlice.actions;
export default counterSlice.reducer; //aqui exportamos como dije por defecto el reducer
```

Y para llamorlo como ya concemos pero usando los otros hoooks

```ts
const count = useAppSelector((state) => state.counter.count);
const dispatch = useAppDispatch();
```

asi dispachamos nuestras acciones

```tsx
onClick={() => {
  dispatch(addOne());
}}
```

Para obtener los valores en otros componentes de igual manera como son server components creamos un higher-order component (HOC) ejemplo:

```tsx
'use client';

import { useAppSelector } from '@/store';
import { IoCafeOutline } from 'react-icons/io5';
import { SimpleWidget } from '..';

export const WidgetsGrid = () => {
  const countState = useAppSelector((state) => state.counter.count);

  return (
    <div className='flex flex-wrap p-2 items-center justify-center'>
      <SimpleWidget
        icon={<IoCafeOutline size={50} className='text-cyan-600' />}
        href='/dashboard/counter'
        label='Carrito de compras'
        title={countState}
        subTitle='Productos agregados'
      />
    </div>
  );
};
```

Y ya lo usamos en nuestra page normalmente

```tsx
import { SimpleWidget } from '@/components';
import { WidgetsGrid } from '@/components/dashboard/WidgetsGrid';

export const metadata = {
  title: 'Dashboard Main',
  description: 'Dashboard Main Page',
};

export default function MainPage() {
  return (
    <div className='text-black'>
      <h1 className='mt-2 text-3xl'>Dashboar</h1>
      <span className='text-xl'>Informacion general</span>

      <WidgetsGrid />
    </div>
  );
}
```

Ejemplo completo en nuestra app del Dashboard con Next14

#### Middlewares

En terminos computacionales un middleware es como algo en medio, nada mas son funciones que se ejecutan en algun punto del tiempo, hay middleware de next y de redux como en este caso

los middleware intersertan cual accion al state

## Route Handlers

Endpoint me refiero a las peticiones que podemos hacer, get, post etc.

Con next13 podemos colocar nuestros endpoinst en cualquier parte de la app, antes era solo tenerlos en una carpeta api, entonces asi en cualquier carpeta podemos crear un archivo con nombre especial que se llame `route.ts` y ya con esto ya tenemos nuestra api

Pero en orden no esta tan bueno

Como dije podemos tener nuestro route.ts en cualquier lugar con la excepcion que no debemos de tener un page

adentro de app creamos una carpeta de api y ahi adentro podemos crear nuestro route.ts

```ts
export async function GET(request: Request) {}
export async function POST(request: Request) {}
export async function DELETE(request: Request) {}
export async function PUT(request: Request) {}
```

Las extensiones de snipets para crear uno es con `rag`

y ya tenemos nuestras peticiones y asi de simple

Siempre debemos de devolver un objeto response, la data se recomienda que sea un objeto para mayor facilidad a la hora de expandirlo

```ts
export async function GET(request: Request) {
  // dentro del request tenemos muchas cosas, pero no se puede hacer un console.log del mismo, si queremos ver que trae podemos poner un breakpoint
  return Response.json({
    count: 1000,
  });
}
```

Y ya podemos hacer una peticion simplemente asi `localhost:3000/api/counter` y ya aparece lo que establezcamos

## LocalStorage / SessionStorage / Cookis

- LocalStorage: en el local storage nunca sale de la computadora, es un espacio almacenado por dominio, si reiniciamos la computadora se mantendra en ese dominio, un ejemplo, localhost:3000
- SessionStorage: esto se mantiene mientras mantengamos una venta del navegador abierta
- Cookis: es como el localstorage ya que se mentienen por bastante tiempo, normalmente viajan en una peticion http, podemos obtenerlas miente el servidor y asi

### LocalStore

Para guardar algo en el localstorage tenemos que poner lo siguiente

```tsx
localStorage.setItem('nombre', JSON.stringfy(state));
```

Es como un clave valor pero el valor solo puede ser string

Y para obtenerlo se usa lo siguiente

```tsx
JSON.parse(localStorage.getItem('nombre') ?? '{}');
```

En este caso lo convertimos ne un objeto con el parse, no es necesario si solo enviamos un string normal, y tambien puse una validacion que si no viene nada que convierta ese string
