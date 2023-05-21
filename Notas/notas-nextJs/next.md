# Next.js

next es un framework para crear contenido estatico y generado del lado del servidor.
Next esta basado en react.
Con next se asume que se esta usando node.js desde el backend.

SEO search engine optimization 
next es un framework y react la libreria entonces next es el framework de react o algo asi jajaja

en next tambien renderiza un componente pero es obligatorio que sea un export default function y el nombre aunque este no tiene el mismo nombre que el archivo
esto se hace en la carpeta pages tampoco se le puede cambiar el nombre al index 

Static generation y server-side rendering

Lo del nombre en pages es obligatorio que sean minusculas por que va ser el path que se use en la urls

---

## Como crear una aplicacion de next 
ejecutamos el siguiente comando:
npx create-next-app@latest
### Para correrlo es:
npm run dev

---

## Explicacion de los archivos que estan al crear next 
la carpeta .next es una carpeta importante menciona mucho produccion
pages es la carpeta donde le decimos como queremos que sea maneja nuestro sistemas de rutas en la aplicacion.

Los index sera lo primero que busque aunque no se ponga en la ruta index si esta en una carpeta lo buscara.

En el archivo app.js todos los componentes pasaran por ahi es necesario ya si queremos poner algo ahi en todas las pantallas.

En la carpeta public ahi podemos poner archivos estaticos codigo que no sera compilado.

Con la carpeta styles solo son dos archivos de css pero uno puede ser asi que se usara global y tambien los que se pueden importar por componentes.

---

## Componentes especiales
### Head
Funciona como un Head normal.
Si tenemos dos Head el agrega todo al head del navegador
de la misma manera sobreescribe si es necesario o simplemente agrega si en uno no estaba lo que estamos agregando al nuevo Head

### Link
Cuando usamos la etiqueta 'a' se re carga la pagina entonces con la etiqueta link eso no pasa, es como que la cargara antes y ya solo hace el cambio instantaneo
es un prerefresh o algo asi tambien se le puede desactivar esa funcionalidad pero por defecto esta activada