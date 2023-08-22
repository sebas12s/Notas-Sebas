# Nextjs 13

## Como crear un proyecto
`npx create-next-app "nombre"` sin las comillas

Para correrlo es `npm run-dev`

## Carpetas

* app: todas las paginas de nuestra aplicacion
* components: los componentes que podemos re utilizar
* node_modules: los archivos necesarios para que corra next
* public: iconos o images, tambien archivos que el frontend puede llamar
* jsconfig: un archivo donde configuramos como se configuraran las rutas
* package.json: para ejecutar nuestros scripts 

## Codigo
app/page.jsx

Este page es nuestra ruta principal

En la carpeta de app puedo crear mis rutas con carpetas entonces cuando ponga esa direccion el archivo que buscara sera el page de esa carpeta

Para crear rutas solamnete ponemos las carpetas y adentro mas carpetas si queremos alargar la ruta y asi

En la carpeta app todo archivo que no sea page o layout sera ignorado

afuera de app podemos crear una carpeta de components ahi podemos guardar como el navbar y eso

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