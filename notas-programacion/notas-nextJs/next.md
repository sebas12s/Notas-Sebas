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

Adentro de pages no van los componentes ya que ahi solo estan las paginas o las pantallas o las apis se crea en la raiz

---

Algo importante en pages hay una forma de poner las nuevas paginas pero es en carpetas pero el archivo se debe llamar por index asi al entrar a la carpeta se lee el index

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

Revisar la documentacion oficial ya que se le puede agregar muchos mas atributos a la etiqueta

### Style
El link no se puede estilizar poniendo el style en la misma etiqueta
```jsx 
<Link style={{ marginRight='100px' }} href="/">Home</Link>
```
Tampoco deja importar el estilo como lo hacia en react por cada componente, entonces se hace lo siguiente:
```jsx
import Style from './Navbar.module.css'
```
Asi se debe importar los estilos pero otra cosa que no deja es el llamado puro tiene que ser por id o por clases, entonces para poner un estilo se hace de la siguiente manera:
```css
.menu-container a {
    margin-right: 10px;
}
```
Aqui ya lleva la clase entonces si deja aunque despues pongamos una etiqueta directa
```jsx
<nav className={ Style['menu-container'] }>
    <Link href="/">Home</Link>
    <Link href="/about">About</Link>
    <Link href="/contact">Contact</Link>
</nav>
``` 
Recordemos que Style es la variable que pusimos arriba donde guardamos los estilos, y ahi no podemos poner `Style.menu-container` por que js no deja `Style.menu` si dejaria pero cuando lleva caracteres como el menos se debe poner asi como esta

---
## Hooks
### useRouter
Recuerden para desestructurar se usa los "{}"
```jsx
const { asPath } = useRouter();
```
Aqui estamos usando un hook especial de next y estamos desestrucuturando la variable
```jsx
<Link href={ href } legacyBehavior>
    <a style={ asPath === href ? style : null }>{ text }</a>
</Link>
```
aqui ya le estoy diciendo si asPath es igual al href que le aplique un estilo especial con un console.log puedomes ver todo lo que nos devuelve el hook useRouter
entonces en asPath se guarda la direccion /

---

## Layouts
Es importante que no se repita el codigo en muchas paginas si se repite lo tenemos que cambiar esto se le llama layouts

Aqui en next se le llama layouts pero simplemente es un componente 

Creamos una carpeta adentro de componentes y ahi es donde ponemos los layouts

Los layouts son como partes que se repetiran entonces las creamos para no repetir codigo

```jsx
className={'code'}
className='code'
```
Ahorita en un problema en los layouts para poner el nombre de la clase se puede poner de las dos maneras

---
## Ejemplo 
veamos este ejemplo
```jsx
const menuItems = [
  {
      text: 'Home',
      href: '/'
  },
  {
    text: 'About',
    href: '/about'
  },
  {
      text: 'Contact',
      href: '/contact'
  },
  {
      text: 'Pricing',
      href: '/pricing'
  },
];

export const NavBar = () => {
  return (
    <nav className={ Style['menu-container'] }>
        {
        menuItems.map( ({ text, href }) => (    //recordar que el map recorre un array y devuelve una funcion por cada array recorrido y es obligatorio que lleve el key tiene que ser unico 
          <ActiveLink key={ href } text={ text } href={ href } />
        ))
        }   {/*se pone estos {} para poder trabajar js*/}
    </nav>
  )
}
```
Tambien se puede hacer asi y creo que es una manera mas entendible
```jsx
export const NavBar = () => {
  return (
    <nav className={ Style['menu-container'] }>
        {
        menuItems.map( menuItems => (
          <ActiveLink key={ menuItems.href } text={ menuItems.text } href={ menuItems.href } />
        ))
        }
    </nav>
  )
}
```
Ya que lo que se crea es una funcion de flecha por cada iteracion del array pero arriba se hizo desestructuralizado