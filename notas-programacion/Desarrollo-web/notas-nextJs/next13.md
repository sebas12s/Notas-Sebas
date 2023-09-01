# Nextjs 13

## Como crear un proyecto

`npx create-next-app "nombre"` sin las comillas

Para correrlo es `npm run-dev`

## Carpetas

- app: todas las paginas de nuestra aplicacion
- components: los componentes que podemos re utilizar
- node_modules: los archivos necesarios para que corra next
- public: iconos o images, tambien archivos que el frontend puede llamar
- jsconfig: un archivo donde configuramos como se configuraran las rutas
- package.json: para ejecutar nuestros scripts

## Codigo

app/page.jsx

Este page es nuestra ruta principal

En la carpeta de app puedo crear mis rutas con carpetas entonces cuando ponga esa direccion el archivo que buscara sera el page de esa carpeta

Para crear rutas solamnete ponemos las carpetas y adentro mas carpetas si queremos alargar la ruta y asi

En la carpeta app todo archivo que no sea page o layout sera ignorado

afuera de app podemos crear una carpeta de components ahi podemos guardar como el navbar y eso

es muy importante ver que las paginas en la carpeta app son en minusculas

# Layout

Se pueden tener mas layout en las rutas de carpetas

# Metadata

Esto esta relacionado con el SEO o si es buena nuestra pagina en rendimiento y eso

recuerda que si quieres ver mas puedes ir a la documentacion oficial
[Link](https://nextjs.org/docs/app/api-reference/functions/generate-metadata)

hay algo tambien que se llama openGraph es como cuando compartimos el link en whatsapp y aparece con una imagen por defecto eso es openGrap

Algo muy importante, los metadata solo funcionan en paginas del lado del servidor

## Fonts

Se puede poner diferentes tipos de letra de manera especial en next

## not-found

Podemos crear nuestra propia pagina de not-found en la carpeta app `not-found.jsx` ya con ese archivo lo reconoceria, importante es en la carpeta app

---

## cliente servidor

Con lo que llevamos todos estos componentes estan hechos del lado del servidor, todos los archivos creados estan procesados por el backend

En el momento que agregamos un manejador de eventos, dice que los manejadores de eventos no pueden ser pasados a componentes clientes, ya que todo esta creado en el servidor, y los manejadores de eventos son del frontend

No solo con un evento, tambien con los estados de react o algo de alguna api es pone `'use client'` para que ese componente se transforme

Y a todos sus hijos o los componentes que se llamen tambien seran use client, si solo lo necesita un su hijo tambien solo al hijo se lo podemos poner

Como mirabamos que los metadata solo en el servidor ahi puede funcionar que solo un componente hijo sea client

una comparacion por si queremos saber cuando es bueno usar componentes client [Link](https://nextjs.org/docs/getting-started/react-essentials)

## FetchData

con react usabamos un useState y un useReducer para poder llamar una api, pero podemos aprovechar que son componentes del lado del servidor para hacer nuestras peticiones

## Loading

Como un page y un layout se puede poner un loading para cuando la pagina se esta cargando, por cada ruta igual

## Parametros en las urls

se crea la carpeta de la ruta de la url `[cualquierNombre]` ese nombre solo es para darle nombre al parametro que esta en la url, ya en la funcion podemos obtener ese parametro ya que es el parametro

La funcion devuelve al crear un page ya devuelve dos props `{ params: { pokemon: '1' }, searchParams: {} }` esto devuelvo, entonces params ya tiene el valor que pusimos en la url, y como vemos el nombre es el que le pusimos a la carpeta, asi puedo obtener el valor de la url

## Suspense

Se usa para cuando hay una carga pero necesitamos que algo no espere la otra carga, entonces encerramos el elemento que no nos importa que espere a que cargue y se muestra la pagina aunque no se haya cargado lo que este en ese suspense

## Style

Si vamos a añadir estilos globales los tenemos que añadir en el layout ya que eso contiene todas las paginas `globals.css` asi se llama al documento en los componentes ya se pueden poner normales con el nombre que queramos, normalmente se ponen como el nombre del componente

## Src

ayuda para que tengamos nuestras paginas y archivos solamente en src y en jsconfig podemos configurar la arroba que vaya a src `"@/*": ["./src/*"]` de la siguiente manera

## useRauter

Es lo mismo que hace el link pero este hook de next nos ayuda a que pueda ejecutar codigo antes, recordar que es de un componente cliente

## useParams

se importa tambien de next/navigation y es lo mismo que sacar el argumento de params de la funcion, este funciona cuando no tenemos la funcion como raiz, en un componente adentro de la pagina entonces ahi no podemos tomar le params como propiedad entonces usamos el hook

## API

En una carpeta adentro de app podemos crear api ya podemos crear nuestras rutas y el nombre del archivo en general es `route.js` no devuelve algo jsx

Los nombres de las funciones tienen que llevar los metodos http, POST, GET etc.