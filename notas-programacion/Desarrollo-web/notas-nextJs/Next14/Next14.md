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

## Server Components

Todos los componentes adentro del directorio app son server components, son componentes del lado del servidor

Se recomienda que todo lo que podamos sea generado por lado del servidor solo las piezas interactivas les pongamos el `use client` ya que en un server component no se pueden ejecutar efectos secundarios

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
