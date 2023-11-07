# Tailwind

Framework de css

Tailwind usa principios

- Mobile first: significa que el proyecto se estila primeramente para telefonos

## Tailwind Play

[Documentacion](https://play.tailwindcss.com/)
Es una interface para probar todo lo de tailwind

## Instalacion

[Documentacion](https://tailwindcss.com/docs/installation)

Yo lo hare en una app normal de html

- `npm install -D tailwindcss`

Inicializamos nuestro tailwindconfig

- `npx tailwindcss init`

Configuramos donde estaremos usando tailwind

```js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{html,js}'], //aqui podemos poner mas incluso si no esta en src podemos configurar
  theme: {
    extend: {},
  },
  plugins: [],
};
```

Creamos un archivo scc y importamos lo siguiente, esto en el src

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Y hacemos build para que se convierta nuestro codigo de tailwind a css !El archivo que importamos a nuestro html es el que hacemos el build no el que esta la configuracion
`npx tailwindcss -i ./src/input.css -o ./public/output.css --watch`
Esto es para que se vaya creando el codigo css al principio ponemos el archivo css donde esta la configuracion donde importamos y el segundo donde queremos alojar todo el css que vaya creando

Y sha podemos usar tailwind en el html

## Directivas de Tailwind

[Documentacion](https://tailwindcss.com/docs/functions-and-directives#tailwind)

- `@tailwind base`: inicializa todos los elementos de nuestro html sin estilo
- `@tailwind components`: nos permite acceder a todos las clases de tailwind
- `@tailwind utilities`: agrega todas las utilidades al proyecto y nos permite acceder a ellas
- `@layer`: Utiliza la directiva @layer para indicar a Tailwind en qué "contenedor" pertenece un conjunto de estilos personalizados. Las capas válidas son base, components, y utilities.
- `@apply`: es para crear clases propias de css pero uniendo las de tailwind
- `@config`: es para especificar que archivo de configuracion queremos usar para un css especial

La funcion de screen nos ayuda a configurar breakpoints

## Breakpoints

Un breakpoint es el salto donde cambia la pantalla

Debido a que Tailwind es mobile first, todo el tiempo se estará trabajando con el breakpoint small.

Son medidas que cuanta tailwind
[Documentacion](https://tailwindcss.com/docs/responsive-design#using-custom-breakpoints)

- sm: telefono movil
- md: tablet
- lg: computadoras
- xl: pantallas mas grandes..

## Clases

## Colors

[Documentacion](https://tailwindcss.com/docs/customizing-colors)
Tambien muestra como agregar colores o incluso paletas completas

Algo importante de los colores ahi esta en la documentacion

### bg

Son para colocar colores y diferentes tonalidades puedes ver en la documentacion mas colores

```jsx
  <div className='w-64 h-64 bg-red-300'></div>
  <div className='w-64 h-64 bg-red-400'></div>
  <div className='w-64 h-64 bg-red-600'></div>
```

## Sizing

### Width and Height

[Documentacion](https://tailwindcss.com/docs/width)

- `w-1` == `width: 0.25rem; /* 4px */`

Podemos ver que cada 4 es 1 rem

- `w-4` == `width: 1rem; /* 16px */`
- `w-8` == `width: 2rem; /* 32px */`

Y tambien pueden haber intermedios como 4.5 5 5.5 y asi

- `w-auto` == `width: auto`

Tambien se puede manejar los porcentajes

- `w-1/2` == `width: 50%;`

Tambien pueden haber 1/4 1/6

De igual manera esta

- `w-full` == `width: 100%;`

Y asi mucho en la documentacion

Tambien podemos poner normalmente

- `w-[32rem]`

De igual manera con height
