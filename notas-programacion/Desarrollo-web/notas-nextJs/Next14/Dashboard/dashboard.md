# Dashboarda

Un dashboard que nos ayudara a conocer lo basico de next

- [Dashboarda](#dashboarda)
- [src](#src)
  - [app](#app)
    - [api](#api)
      - [counter](#counter)
        - [route.ts](#routets)
    - [dashboard](#dashboard)
      - [counter](#counter-1)
        - [page.tsx](#pagetsx)
      - [favorites](#favorites)
        - [page.tsx](#pagetsx-1)
      - [main](#main)
        - [page.tsx](#pagetsx-2)
      - [pokemon/\[id\]](#pokemonid)
        - [not-found.tsx](#not-foundtsx)
        - [page.tsx](#pagetsx-3)
      - [pokemons](#pokemons)
        - [\[name\]](#name)
          - [not-found.tsx](#not-foundtsx-1)
          - [page.tsx](#pagetsx-4)
        - [error.tsx](#errortsx)
        - [page.tsx](#pagetsx-5)
      - [layout.tsx](#layouttsx)
    - [globals.css](#globalscss)
    - [layout.tsx](#layouttsx-1)
    - [not-found.tsx](#not-foundtsx-2)
    - [page.tsx](#pagetsx-6)
  - [components](#components)
    - [dashboard](#dashboard-1)
      - [SimpleWidget.tsx](#simplewidgettsx)
      - [WidgetsGrid.tsx](#widgetsgridtsx)
    - [sidebar](#sidebar)
      - [Sidebar.tsx](#sidebartsx)
      - [SidebarMenuItem.tsx](#sidebarmenuitemtsx)
  - [pokemons](#pokemons-1)
    - [components](#components-1)
      - [PokemonCard.tsx](#pokemoncardtsx)
      - [PokemonGrid.tsx](#pokemongridtsx)
      - [PokemonFavorites.tsx](#pokemonfavoritestsx)
    - [interfaces](#interfaces)
      - [pokemon.ts](#pokemonts)
      - [pokemonsResponse.ts](#pokemonsresponsets)
      - [simplePokemon.ts](#simplepokemonts)
  - [shopping-card](#shopping-card)
    - [components](#components-2)
      - [Counter.tsx](#countertsx)
  - [store](#store)
    - [counter](#counter-2)
      - [counterSlices.ts](#counterslicests)
    - [middlewares](#middlewares)
      - [localStorageMiddleware.ts](#localstoragemiddlewarets)
    - [Pokemon](#pokemon)
      - [pokemonSlices.ts](#pokemonslicests)
    - [index.ts](#indexts)
    - [Providers.tsx](#providerstsx)

# src

## app

### api

#### counter

##### route.ts

Nuestra peticion get con la ruta en la que estamos

```ts
export async function GET(request: Request) {
  return Response.json({
    count: 1000,
  });
}
```

### dashboard

#### counter

##### page.tsx

Nuestra pagina del counter

```tsx
import { Counter } from '@/shopping-card';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Counter App',
  description: 'El counter de nuestra aplicacion',
};

export default function CounterPage() {
  return (
    <div className='flex flex-col items-center justify-center w-full h-full'>
      <span>Productos en el carrito de compras</span>
      <Counter value={20} />
    </div>
  );
}
```

#### favorites

##### page.tsx

```tsx
import { PokemonGrid, PokemonsResponse, SimplePokemon } from '@/pokemons';

export const metadata = {
  title: 'Favoritos',
  description: 'Listado de pokemones favoritos',
};

export default async function PokemonsPage() {
  return (
    <div className='flex flex-col'>
      <span className='text-5xl my-2'>
        Pokemones Favoritos <small className='text-cyan-700'>Mar</small>
      </span>

      <PokemonGrid pokemons={[]} />
    </div>
  );
}
```

#### main

##### page.tsx

```tsx
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

#### pokemon/[id]

##### not-found.tsx

```tsx
import Link from 'next/link';

export default function NotFound() {
  return (
    <main className='h-screen w-full flex flex-col justify-center items-center '>
      <h1 className='text-8xl font-extrabold  tracking-widest'>404</h1>
      <div className='bg-cyan-600 px-2 text-sm rounded rotate-12 absolute text-white'>
        Pokemon no encontrado
      </div>
      <button className='mt-5'>
        <div className='relative inline-block text-sm font-medium text-white group active:text-cyan-600 focus:outline-none focus:ring'>
          <span className='absolute inset-0 transition-transform translate-x-0.5 translate-y-0.5 bg-cyan-700 group-hover:translate-y-0 group-hover:translate-x-0'></span>

          <span className='relative block px-8 py-3 bg-cyan-700 border border-current'>
            <Link href={'/dashboard/pokemons'}>Regresar</Link>
          </span>
        </div>
      </button>
    </main>
  );
}
```

##### page.tsx

```tsx
import { Pokemon } from '@/pokemons';
import type { Metadata } from 'next';
import Image from 'next/image';
import { notFound } from 'next/navigation';

interface Props {
  params: { id: string };
}

//! Solo se ejecuta en build time
export async function generateStaticParams() {
  // para nuestra generacion statica de antemano
  const static151Pokemons = Array.from({ length: 151 }).map((pokemon, i) => {
    return `${i + 1}`;
  });
  // con el array from creamos un nuevo arreglo con la longitud que digamos y les estoy diciendo que por cada elemento del array devuelva un string de un numero, la iteracion + 1 para que sea un numero del 1 al 151
  // para poner todos los pokemones

  return static151Pokemons.map((id) => ({
    // recorro cada id del pokemon y le envio el nuevo arreglo con el objeto con el id, en si solo cree un objeto con el mismo id por cada uno
    id: id,
  }));
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  // en params recibe los dos argumentos el nombre de la carpeta de la ruta y los search o querys
  // para generar nuestra data de manera dinamica con algunas otras propiedades,

  try {
    const { name, id } = await getPokemon(params.id);
    // con nuestra funcion obtenemos el id y el name del pokemon con el id que enviemos

    return {
      // y ya lo usamos en nuestra Metadata dinamica
      title: `${id} - ${name}`,
      description: `Página del pokemon ${name}`,
    };
  } catch (error) {
    return {
      title: 'Pagina del Pokemon',
      description: 'Pagina del pokemon',
    };
  }
}

const getPokemon = async (id: string): Promise<Pokemon> => {
  try {
    const res = await fetch(`https://pokeapi.co/api/v2/pokemon/${id}`, {
      // cache: 'force-cache', // con esto le digo que la informacion se quede en cache
      // si lo revalido no hay que forzarle el cache ya que ya lo hace
      next: {
        revalidate: 60 * 60 * 30, //este revalidate es como que se haga la peticion de nuevo ya que le tenemos que se quede en cache
        // es por segundos y esto como revalida entonces se hace de nuevo la peticion y en el caso de generar paginas estaticas las vuelve a crear
      },
    });
    const data = await res.json();
    return data;
  } catch (error) {
    notFound(); //esta funcion envia al not-found de la app
  }
};

export default async function PokemonPage({ params }: Props) {
  const pokemon = await getPokemon(params.id);

  return (
    // componente creado con tailwind
    <div className='flex mt-5 flex-col items-center text-slate-800'>
      <div className='relative flex flex-col items-center rounded-[20px] w-[700px] mx-auto bg-white bg-clip-border  shadow-lg  p-3'>
        <div className='mt-2 mb-8 w-full'>
          <h1 className='px-2 text-xl font-bold text-slate-700 capitalize'>
            #{pokemon.id} {pokemon.name}
          </h1>
          <div className='flex flex-col justify-center items-center'>
            <Image
              src={
                pokemon.sprites.other?.['official-artwork'].front_default ?? ''
              }
              width={150}
              height={150}
              alt={`Imagen del pokemon ${pokemon.name}`}
              className='mb-5'
            />

            <div className='flex flex-wrap'>
              {pokemon.moves.map((move) => (
                <p key={move.move.name} className='mr-2 capitalize'>
                  {move.move.name}
                </p>
              ))}
            </div>
          </div>
        </div>
        <div className='grid grid-cols-2 gap-4 px-2 w-full'>
          <div className='flex flex-col items-start justify-center rounded-2xl bg-white bg-clip-border px-3 py-4  drop-shadow-lg '>
            <p className='text-sm text-gray-600'>Types</p>
            <div className='text-base font-medium text-navy-700 flex'>
              {pokemon.types.map((type) => (
                <p key={type.slot} className='mr-2 capitalize'>
                  {type.type.name}
                </p>
              ))}
            </div>
          </div>

          <div className='flex flex-col items-start justify-center rounded-2xl bg-white bg-clip-border px-3 py-4  drop-shadow-lg '>
            <p className='text-sm text-gray-600'>Peso</p>
            <span className='text-base font-medium text-navy-700 flex'>
              {pokemon.weight}
            </span>
          </div>

          <div className='flex flex-col justify-center rounded-2xl bg-white bg-clip-border px-3 py-4  drop-shadow-lg'>
            <p className='text-sm text-gray-600'>Regular Sprites</p>
            <div className='flex justify-center'>
              <Image
                src={pokemon.sprites.front_default}
                width={100}
                height={100}
                alt={`sprite ${pokemon.name}`}
              />

              <Image
                src={pokemon.sprites.back_default}
                width={100}
                height={100}
                alt={`sprite ${pokemon.name}`}
              />
            </div>
          </div>

          <div className='flex flex-col justify-center rounded-2xl bg-white bg-clip-border px-3 py-4  drop-shadow-lg'>
            <p className='text-sm text-gray-600'>Shiny Sprites</p>
            <div className='flex justify-center'>
              <Image
                src={pokemon.sprites.front_shiny}
                width={100}
                height={100}
                alt={`sprite ${pokemon.name}`}
              />

              <Image
                src={pokemon.sprites.back_shiny}
                width={100}
                height={100}
                alt={`sprite ${pokemon.name}`}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
```

#### pokemons

##### [name]

###### not-found.tsx

```tsx
import Link from 'next/link';

export default function NotFound() {
  return (
    <main className='h-screen w-full flex flex-col justify-center items-center '>
      <h1 className='text-8xl font-extrabold  tracking-widest'>404</h1>
      <div className='bg-cyan-600 px-2 text-sm rounded rotate-12 absolute text-white'>
        Pokemon no encontrado
      </div>
      <button className='mt-5'>
        <div className='relative inline-block text-sm font-medium text-white group active:text-cyan-600 focus:outline-none focus:ring'>
          <span className='absolute inset-0 transition-transform translate-x-0.5 translate-y-0.5 bg-cyan-700 group-hover:translate-y-0 group-hover:translate-x-0'></span>

          <span className='relative block px-8 py-3 bg-cyan-700 border border-current'>
            <Link href={'/dashboard/pokemons'}>Regresar</Link>
          </span>
        </div>
      </button>
    </main>
  );
}
```

###### page.tsx

```tsx
import { Pokemon, PokemonsResponse } from '@/pokemons';
import type { Metadata } from 'next';
import Image from 'next/image';
import { notFound } from 'next/navigation';

interface Props {
  params: { name: string };
}

//! Solo se ejecuta en build time
export async function generateStaticParams() {
  const res = await fetch(`https://pokeapi.co/api/v2/pokemon?limit=151`);
  const data: PokemonsResponse = await res.json();

  const static151Pokemons = data.results.map((pokemon) => ({
    name: pokemon.name,
  }));
  // como para hacer el la generacion statica necesitamos un arreglo con los parametros en este caso le enviamos todos los pokemones pero por nombre
  return static151Pokemons;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  try {
    const { name, id } = await getPokemon(params.name);

    return {
      title: `${id} - ${name}`,
      description: `Página del pokemon ${name}`,
    };
  } catch (error) {
    return {
      title: 'Pagina del Pokemon',
      description: 'Pagina del pokemon',
    };
  }
}

const getPokemon = async (name: string): Promise<Pokemon> => {
  try {
    const res = await fetch(`https://pokeapi.co/api/v2/pokemon/${name}`, {
      next: {
        revalidate: 60 * 60 * 30,
      },
    });
    const data = await res.json();
    return data;
  } catch (error) {
    notFound();
  }
};

export default async function PokemonPage({ params }: Props) {
  const pokemon = await getPokemon(params.name);

  return (
    <div className='flex mt-5 flex-col items-center text-slate-800'>
      <div className='relative flex flex-col items-center rounded-[20px] w-[700px] mx-auto bg-white bg-clip-border  shadow-lg  p-3'>
        <div className='mt-2 mb-8 w-full'>
          <h1 className='px-2 text-xl font-bold text-slate-700 capitalize'>
            #{pokemon.id} {pokemon.name}
          </h1>
          <div className='flex flex-col justify-center items-center'>
            <Image
              src={
                pokemon.sprites.other?.['official-artwork'].front_default ?? ''
              }
              width={150}
              height={150}
              alt={`Imagen del pokemon ${pokemon.name}`}
              className='mb-5'
            />

            <div className='flex flex-wrap'>
              {pokemon.moves.map((move) => (
                <p key={move.move.name} className='mr-2 capitalize'>
                  {move.move.name}
                </p>
              ))}
            </div>
          </div>
        </div>
        <div className='grid grid-cols-2 gap-4 px-2 w-full'>
          <div className='flex flex-col items-start justify-center rounded-2xl bg-white bg-clip-border px-3 py-4  drop-shadow-lg '>
            <p className='text-sm text-gray-600'>Types</p>
            <div className='text-base font-medium text-navy-700 flex'>
              {pokemon.types.map((type) => (
                <p key={type.slot} className='mr-2 capitalize'>
                  {type.type.name}
                </p>
              ))}
            </div>
          </div>

          <div className='flex flex-col items-start justify-center rounded-2xl bg-white bg-clip-border px-3 py-4  drop-shadow-lg '>
            <p className='text-sm text-gray-600'>Peso</p>
            <span className='text-base font-medium text-navy-700 flex'>
              {pokemon.weight}
            </span>
          </div>

          <div className='flex flex-col justify-center rounded-2xl bg-white bg-clip-border px-3 py-4  drop-shadow-lg'>
            <p className='text-sm text-gray-600'>Regular Sprites</p>
            <div className='flex justify-center'>
              <Image
                src={pokemon.sprites.front_default}
                width={100}
                height={100}
                alt={`sprite ${pokemon.name}`}
              />

              <Image
                src={pokemon.sprites.back_default}
                width={100}
                height={100}
                alt={`sprite ${pokemon.name}`}
              />
            </div>
          </div>

          <div className='flex flex-col justify-center rounded-2xl bg-white bg-clip-border px-3 py-4  drop-shadow-lg'>
            <p className='text-sm text-gray-600'>Shiny Sprites</p>
            <div className='flex justify-center'>
              <Image
                src={pokemon.sprites.front_shiny}
                width={100}
                height={100}
                alt={`sprite ${pokemon.name}`}
              />

              <Image
                src={pokemon.sprites.back_shiny}
                width={100}
                height={100}
                alt={`sprite ${pokemon.name}`}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
```

##### error.tsx

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
    <div className='w-full h-screen flex flex-col items-center justify-center'>
      <svg
        className='w-1/2 md:w-1/3 lg:w-1/4 text-blue-600'
        xmlns='http://www.w3.org/2000/svg'
        data-name='Layer 1'
        viewBox='0 0 1119.60911 699'
        xmlnsXlink='http://www.w3.org/1999/xlink'
      >
        <circle cx='292.60911' cy='213' r='213' fill='#f2f2f2'></circle>
        <path
          d='M31.39089,151.64237c0,77.49789,48.6181,140.20819,108.70073,140.20819'
          transform='translate(-31.39089 -100.5)'
          fill='#2f2e41'
        ></path>
        <path
          d='M140.09162,291.85056c0-78.36865,54.255-141.78356,121.30372-141.78356'
          transform='translate(-31.39089 -100.5)'
          fill='currentColor'
        ></path>
        <path
          d='M70.77521,158.66768c0,73.61476,31.00285,133.18288,69.31641,133.18288'
          transform='translate(-31.39089 -100.5)'
          fill='currentColor'
        ></path>
        <path
          d='M140.09162,291.85056c0-100.13772,62.7103-181.16788,140.20819-181.16788'
          transform='translate(-31.39089 -100.5)'
          fill='#2f2e41'
        ></path>
        <path
          d='M117.22379,292.83905s15.41555-.47479,20.06141-3.783,23.713-7.2585,24.86553-1.95278,23.16671,26.38821,5.76263,26.5286-40.43935-2.711-45.07627-5.53549S117.22379,292.83905,117.22379,292.83905Z'
          transform='translate(-31.39089 -100.5)'
          fill='#a8a8a8'
        ></path>
        <path
          d='M168.224,311.78489c-17.40408.14042-40.43933-2.71094-45.07626-5.53548-3.53126-2.151-4.93843-9.86945-5.40926-13.43043-.32607.014-.51463.02-.51463.02s.97638,12.43276,5.61331,15.2573,27.67217,5.67589,45.07626,5.53547c5.02386-.04052,6.7592-1.82793,6.66391-4.47526C173.87935,310.756,171.96329,311.75474,168.224,311.78489Z'
          transform='translate(-31.39089 -100.5)'
          opacity='0.2'
        ></path>
        <ellipse
          cx='198.60911'
          cy='424.5'
          rx='187'
          ry='25.43993'
          fill='#3f3d56'
        ></ellipse>
        <ellipse
          cx='198.60911'
          cy='424.5'
          rx='157'
          ry='21.35866'
          opacity='0.1'
        ></ellipse>
        <ellipse
          cx='836.60911'
          cy='660.5'
          rx='283'
          ry='38.5'
          fill='#3f3d56'
        ></ellipse>
        <ellipse
          cx='310.60911'
          cy='645.5'
          rx='170'
          ry='23.12721'
          fill='#3f3d56'
        ></ellipse>
        <path
          d='M494,726.5c90,23,263-30,282-90'
          transform='translate(-31.39089 -100.5)'
          fill='none'
          stroke='#2f2e41'
          strokeMiterlimit='10'
          strokeWidth='2'
        ></path>
        <path
          d='M341,359.5s130-36,138,80-107,149-17,172'
          transform='translate(-31.39089 -100.5)'
          fill='none'
          stroke='#2f2e41'
          strokeMiterlimit='10'
          strokeWidth='2'
        ></path>
        <path
          d='M215.40233,637.78332s39.0723-10.82,41.47675,24.04449-32.15951,44.78287-5.10946,51.69566'
          transform='translate(-31.39089 -100.5)'
          fill='none'
          stroke='#2f2e41'
          strokeMiterlimit='10'
          strokeWidth='2'
        ></path>
        <path
          d='M810.09554,663.73988,802.218,714.03505s-38.78182,20.60284-11.51335,21.20881,155.73324,0,155.73324,0,24.84461,0-14.54318-21.81478l-7.87756-52.719Z'
          transform='translate(-31.39089 -100.5)'
          fill='#2f2e41'
        ></path>
        <path
          d='M785.21906,734.69812c6.193-5.51039,16.9989-11.252,16.9989-11.252l7.87756-50.2952,113.9216.10717,7.87756,49.582c9.185,5.08711,14.8749,8.987,18.20362,11.97818,5.05882-1.15422,10.58716-5.44353-18.20362-21.38921l-7.87756-52.719-113.9216,3.02983L802.218,714.03506S769.62985,731.34968,785.21906,734.69812Z'
          transform='translate(-31.39089 -100.5)'
          opacity='0.1'
        ></path>
        <rect
          x='578.43291'
          y='212.68859'
          width='513.25314'
          height='357.51989'
          rx='18.04568'
          fill='#2f2e41'
        ></rect>
        <rect
          x='595.70294'
          y='231.77652'
          width='478.71308'
          height='267.83694'
          fill='#3f3d56'
        ></rect>
        <circle
          cx='835.05948'
          cy='223.29299'
          r='3.02983'
          fill='#f2f2f2'
        ></circle>
        <path
          d='M1123.07694,621.32226V652.6628a18.04341,18.04341,0,0,1-18.04568,18.04568H627.86949A18.04341,18.04341,0,0,1,609.8238,652.6628V621.32226Z'
          transform='translate(-31.39089 -100.5)'
          fill='#2f2e41'
        ></path>
        <polygon
          points='968.978 667.466 968.978 673.526 642.968 673.526 642.968 668.678 643.417 667.466 651.452 645.651 962.312 645.651 968.978 667.466'
          fill='#2f2e41'
        ></polygon>
        <path
          d='M1125.828,762.03359c-.59383,2.539-2.83591,5.21743-7.90178,7.75032-18.179,9.08949-55.1429-2.42386-55.1429-2.42386s-28.4804-4.84773-28.4804-17.573a22.72457,22.72457,0,0,1,2.49658-1.48459c7.64294-4.04351,32.98449-14.02122,77.9177.42248a18.73921,18.73921,0,0,1,8.54106,5.59715C1125.07908,756.45353,1126.50669,759.15715,1125.828,762.03359Z'
          transform='translate(-31.39089 -100.5)'
          fill='#2f2e41'
        ></path>
        <path
          d='M1125.828,762.03359c-22.251,8.526-42.0843,9.1622-62.43871-4.975-10.26507-7.12617-19.59089-8.88955-26.58979-8.75618,7.64294-4.04351,32.98449-14.02122,77.9177.42248a18.73921,18.73921,0,0,1,8.54106,5.59715C1125.07908,756.45353,1126.50669,759.15715,1125.828,762.03359Z'
          transform='translate(-31.39089 -100.5)'
          opacity='0.1'
        ></path>
        <ellipse
          cx='1066.53846'
          cy='654.13477'
          rx='7.87756'
          ry='2.42386'
          fill='#f2f2f2'
        ></ellipse>
        <circle
          cx='835.05948'
          cy='545.66686'
          r='11.51335'
          fill='#f2f2f2'
        ></circle>
        <polygon
          points='968.978 667.466 968.978 673.526 642.968 673.526 642.968 668.678 643.417 667.466 968.978 667.466'
          opacity='0.1'
        ></polygon>
        <rect
          x='108.60911'
          y='159'
          width='208'
          height='242'
          fill='#2f2e41'
        ></rect>
        <rect
          x='87.60911'
          y='135'
          width='250'
          height='86'
          fill='#3f3d56'
        ></rect>
        <rect
          x='87.60911'
          y='237'
          width='250'
          height='86'
          fill='#3f3d56'
        ></rect>
        <rect
          x='87.60911'
          y='339'
          width='250'
          height='86'
          fill='#3f3d56'
        ></rect>
        <rect
          x='271.60911'
          y='150'
          width='16'
          height='16'
          fill='currentColor'
          opacity='0.4'
        ></rect>
        <rect
          x='294.60911'
          y='150'
          width='16'
          height='16'
          fill='currentColor'
          opacity='0.8'
        ></rect>
        <rect
          x='317.60911'
          y='150'
          width='16'
          height='16'
          fill='currentColor'
        ></rect>
        <rect
          x='271.60911'
          y='251'
          width='16'
          height='16'
          fill='currentColor'
          opacity='0.4'
        ></rect>
        <rect
          x='294.60911'
          y='251'
          width='16'
          height='16'
          fill='currentColor'
          opacity='0.8'
        ></rect>
        <rect
          x='317.60911'
          y='251'
          width='16'
          height='16'
          fill='currentColor'
        ></rect>
        <rect
          x='271.60911'
          y='352'
          width='16'
          height='16'
          fill='currentColor'
          opacity='0.4'
        ></rect>
        <rect
          x='294.60911'
          y='352'
          width='16'
          height='16'
          fill='currentColor'
          opacity='0.8'
        ></rect>
        <rect
          x='317.60911'
          y='352'
          width='16'
          height='16'
          fill='currentColor'
        ></rect>
        <circle cx='316.60911' cy='538' r='79' fill='#2f2e41'></circle>
        <rect
          x='280.60911'
          y='600'
          width='24'
          height='43'
          fill='#2f2e41'
        ></rect>
        <rect
          x='328.60911'
          y='600'
          width='24'
          height='43'
          fill='#2f2e41'
        ></rect>
        <ellipse
          cx='300.60911'
          cy='643.5'
          rx='20'
          ry='7.5'
          fill='#2f2e41'
        ></ellipse>
        <ellipse
          cx='348.60911'
          cy='642.5'
          rx='20'
          ry='7.5'
          fill='#2f2e41'
        ></ellipse>
        <circle cx='318.60911' cy='518' r='27' fill='#fff'></circle>
        <circle cx='318.60911' cy='518' r='9' fill='#3f3d56'></circle>
        <path
          d='M271.36733,565.03228c-6.37889-28.56758,14.01185-57.43392,45.544-64.47477s62.2651,10.41,68.644,38.9776-14.51861,39.10379-46.05075,46.14464S277.74622,593.59986,271.36733,565.03228Z'
          transform='translate(-31.39089 -100.5)'
          fill='currentColor'
        ></path>
        <ellipse
          cx='417.21511'
          cy='611.34365'
          rx='39.5'
          ry='12.40027'
          transform='translate(-238.28665 112.98044) rotate(-23.17116)'
          fill='#2f2e41'
        ></ellipse>
        <ellipse
          cx='269.21511'
          cy='664.34365'
          rx='39.5'
          ry='12.40027'
          transform='translate(-271.07969 59.02084) rotate(-23.17116)'
          fill='#2f2e41'
        ></ellipse>
        <path
          d='M394,661.5c0,7.732-19.90861,23-42,23s-43-14.268-43-22,20.90861-6,43-6S394,653.768,394,661.5Z'
          transform='translate(-31.39089 -100.5)'
          fill='#fff'
        ></path>
      </svg>

      <div className='flex flex-col items-center justify-center'>
        <p className='text-5xl md:text-6xl lg:text-7xl font-bold tracking-wider text-gray-600 mt-8'>
          500
        </p>
        <p className='text-2xl md:text-3xl lg:text-4xl font-bold text-gray-600 mt-2'>
          Server Error
        </p>
        <p className='md:text-lg xl:text-xl text-gray-500 mt-4'>
          Whoops, something went wrong on our servers.
        </p>
      </div>
    </div>
  );
}
```

##### page.tsx

```tsx
import { PokemonGrid, PokemonsResponse, SimplePokemon } from '@/pokemons';

export const metadata = {
  title: 'Pokemons Page',
  description: 'Listado de pokemones',
};

const getPokemons = async (
  limit = 20,
  offset = 0
): Promise<SimplePokemon[]> => {
  // con esto le digo que devolvera una promesa de arreglos de simplePokemons
  const res = await fetch(
    `https://pokeapi.co/api/v2/pokemon?limit=${limit}&offset=${offset}`
  );
  const data: PokemonsResponse = await res.json();

  const pokemons = data.results.map((pokemon) => ({
    id: pokemon.url.split('/').at(-2)!,
    // con el sigon de exclamasion le digo que no puede ser null
    // .split es una funcion de strings que esta funcion corta el string en donde le ponga, este caso corta el url por cada / y nos devuelve un arreglo con los valores ya cortados sin contar el /
    // con el at le digo que posicion quiero en este caso la antepenultima por eso -2, porque la primera es 0 y la ultima seria -1 y la antepenultima -2 ahi es donde esta el id en el url
    name: pokemon.name,
  }));

  // throw new Error('Error kawai');

  return pokemons;
};

export default async function PokemonsPage() {
  const pokemons = await getPokemons(151);
  return (
    <div className='flex flex-col'>
      <span className='text-5xl my-2'>
        Listado de Pokemons <small className='text-cyan-700'>estático</small>
      </span>

      <PokemonGrid pokemons={pokemons} />
    </div>
  );
}
```

#### layout.tsx

```tsx
import { Sidebar } from '@/components';
export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className='bg-slate-100 overflow-y-scroll w-screen h-screen antialiased text-slate-300 selection:bg-blue-600 selection:text-white'>
      <div className='flex'>
        <Sidebar />
        <div className='p-2 w-full text-slate-800'>{children}</div>
      </div>
    </div>
  );
}
```

### globals.css

Nuestros estilos globales de nuestra aplicacion, como trabajamos con tailwind aqui pusimos nuestras importaciones de tailwind

### layout.tsx

```tsx
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import { Providers } from '@/store/Providers';
import './globals.css';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'Create Next App',
  description: 'Generated by create next app',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang='en'>
      <body className={inter.className}>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
```

### not-found.tsx

Nuestra pagina especial para el error not-found

```tsx
import Link from 'next/link';

export default function NotFound() {
  return (
    <main className='h-screen w-full flex flex-col justify-center items-center '>
      <h1 className='text-8xl font-extrabold  tracking-widest'>404</h1>
      <div className='bg-cyan-600 px-2 text-sm rounded rotate-12 absolute text-white'>
        Page Not Found
      </div>
      <button className='mt-5'>
        <div className='relative inline-block text-sm font-medium text-white group active:text-cyan-600 focus:outline-none focus:ring'>
          <span className='absolute inset-0 transition-transform translate-x-0.5 translate-y-0.5 bg-cyan-700 group-hover:translate-y-0 group-hover:translate-x-0'></span>

          <span className='relative block px-8 py-3 bg-cyan-700 border border-current'>
            <Link href={'/dashboard/main'}>Regresa al home</Link>
          </span>
        </div>
      </button>
    </main>
  );
}
```

### page.tsx

Nuestro Page Principal, que nos lleva a una pagina principal

```tsx
import { redirect } from 'next/navigation';

export default function HomePage() {
  redirect('/dashboard/main'); //esto nos ayuda a redireccionar a alguna ruta, le estoy diciendo que la page principal sea una redireccion al dashboar/main
}
```

## components

### dashboard

#### SimpleWidget.tsx

```tsx
import Link from 'next/link';

interface Props {
  title: number;
  subTitle?: string;
  label?: string;
  icon: React.ReactNode; //esto es lo mismo que decir JSX.Elemet pero poniendo ReactNode le decimos que pueden ser uno o muchos
  href: string;
}

export const SimpleWidget = ({
  label,
  href = '#',
  icon,
  title,
  subTitle,
}: Props) => {
  return (
    <div className='bg-white shadow-xl p-3 sm:min-w-[25%] min-w-full rounded-2xl border-1 border-gray-50 m-2'>
      <div className='flex flex-col'>
        {label && (
          // pregunto si el label viene que lo muestre si no, no se muestra
          <div>
            <h2 className='font-bold text-gray-600 text-center'>{label}</h2>
          </div>
        )}
        <div className='my-3'>
          <div className='flex flex-row items-center justify-center space-x-1 '>
            {icon}
            {/* aqui simplemente puse el icono que me enviarons */}
            <div id='temp' className='text-center'>
              <h4 className='text-4xl'>{title}</h4>
              {subTitle && <p className='text-xs text-gray-500'>{subTitle}</p>}
            </div>
          </div>
        </div>

        {href && (
          <div className='w-full place-items-end text-right border-t-2 border-gray-100 mt-2'>
            <Link href={href} className='text-indigo-600 text-xs font-medium'>
              Más
            </Link>
          </div>
        )}
      </div>
    </div>
  );
};
```

#### WidgetsGrid.tsx

```tsx
'use client';

import { useAppSelector } from '@/store';
import { IoCafeOutline } from 'react-icons/io5';
import { SimpleWidget } from '..';

export const WidgetsGrid = () => {
  // como obtener nuestro stado global de store con TypeScript por eso usamos useAppSelector
  const countState = useAppSelector((state) => state.counter.count);

  return (
    <div className='flex flex-wrap p-2 items-center justify-center'>
      <SimpleWidget
        icon={<IoCafeOutline size={50} className='text-cyan-600' />}
        // se pueden enviar por completo componentes como props en este caso le enviamos el icon
        href='/dashboard/counter'
        label='Carrito de compras'
        title={countState}
        subTitle='Productos agregados'
      />
    </div>
  );
};
```

### sidebar

#### Sidebar.tsx

```tsx
import Image from 'next/image';
import {
  IoBrowsersOutline,
  IoCalculator,
  IoLogoReact,
  IoHeartOutline,
} from 'react-icons/io5';
import { RiHonorOfKingsFill } from 'react-icons/ri';
import { SidebarMenuItems } from './SidebarMenuItems';

const menuItems = [
  // para crear los componentes mas faciles
  {
    path: '/dashboard/main',
    icon: <IoBrowsersOutline />,
    title: 'Dashboar',
    subTitle: 'Visualizacion',
  },
  {
    path: '/dashboard/counter',
    icon: <IoCalculator />,
    title: 'Counter',
    subTitle: 'Contador Client Side',
  },
  {
    path: '/dashboard/pokemons',
    icon: <RiHonorOfKingsFill />,
    title: 'Pokemons',
    subTitle: 'WikiPoke',
  },
  {
    path: '/dashboard/favorites',
    icon: <IoHeartOutline />,
    title: 'Favoritos',
    subTitle: 'Lista de favoritos',
  },
];

export const Sidebar = () => {
  // un dashboar un sidebar sacado de tailwind components
  return (
    <div
      id='menu'
      className='bg-gray-900 min-h-screen z-10 text-slate-300 w-[400px] left-0 overflow-y-scroll'
    >
      <div id='logo' className='my-4 px-6'>
        <h1 className='flex items-center text-lg md:text-2xl font-bold text-white'>
          <IoLogoReact className='mr-2' />
          <span>Dash</span>
          <span className='text-cyan-500'>8</span>.
        </h1>
        <p className='text-slate-500 text-sm'>
          Manage your actions and activities
        </p>
      </div>
      <div id='profile' className='px-6 py-10'>
        <p className='text-slate-500'>Welcome back,</p>
        <a href='#' className='inline-flex space-x-2 items-center'>
          <span>
            <Image
              className='rounded-full w-8 h-8'
              src='https://images.unsplash.com/photo-1542909168-82c3e7fdca5c'
              alt='User avatar'
              width={50}
              height={50}
            />
          </span>
          <span className='text-sm md:text-base font-bold'>Sebastian Mar</span>
        </a>
      </div>
      <div id='nav' className='w-full px-6'>
        {menuItems.map((item) => (
          //como el objeto de menuItems tiene el mismo nombre que las propiedades se las puedo enviar asi ...item
          <SidebarMenuItems key={item.path} {...item} />
        ))}
      </div>
    </div>
  );
};
```

#### SidebarMenuItem.tsx

```tsx
'use client';
import Link from 'next/link';
import { usePathname } from 'next/navigation';

interface Props {
  path: string;
  icon: JSX.Element;
  title: string;
  subTitle: string;
}

export const SidebarMenuItems = ({ icon, path, subTitle, title }: Props) => {
  const pathName = usePathname();

  return (
    <Link
      href={path}
      // si el pathname el que obtenemos de la url gracias al usePathname es igual al que enviaron entonces le damos una clase extra para que este activo
      className={`${
        pathName === path && 'bg-cyan-700'
      } w-full px-2 inline-flex space-x-2 items-center border-b border-none py-3  transition ease-linear duration-150`}
    >
      <div>{icon}</div>
      <div className='flex flex-col'>
        <span className='text-lg font-bold leading-5 text-white'>{title}</span>
        <span className='text-sm text-white/50 hidden md:block'>
          {subTitle}
        </span>
      </div>
    </Link>
  );
};
```

## pokemons

### components

#### PokemonCard.tsx

```tsx
'use client';

import Link from 'next/link';
import { SimplePokemon } from '..';
import Image from 'next/image';
import { IoHeart, IoHeartOutline } from 'react-icons/io5';
import { useAppDispatch, useAppSelector } from '@/store';
import { toggleFavorite } from '@/store/pokemon/pokemonSlices';

interface Props {
  pokemon: SimplePokemon;
}

export const PokemonCard = ({ pokemon }: Props) => {
  const { id, name } = pokemon;

  const isFavorite = useAppSelector((state) => !!state.pokemons.favorites[id]);
  // veamos, aqui estamos pidiendo el pokemon con el id que estamos enviando, con esto nos devuelve o el objeto o un undefined
  // con un ! le digo que sea lo contrario, si es undefined sera true y si hay valor sera false
  // pero con dos !! le digo que si es undefined primero es true y despues false por eso dos signos
  // tambien si viene algo con uno sera false y con dos sera true por eso nos devuelve true si viene algun valor y false si es undefined

  const dispatch = useAppDispatch();

  const onToggle = () => {
    dispatch(toggleFavorite(pokemon));
  };

  return (
    <div className='mx-auto right-0 mt-2 w-60'>
      <div className='bg-white rounded overflow-hidden shadow-lg'>
        <div className=' flex items-center flex-col text-center p-6 bg-gray-800 border-b'>
          <Image
            key={id}
            src={`https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png`}
            width={100}
            height={100}
            alt={name}
            priority={false}
          />
          <p className='pt-2 text-lg font-semibold text-gray-50 capitalize'>
            {name}
          </p>
          <div className='mt-5'>
            <Link
              href={`pokemons/${name}`}
              className='border rounded-full py-2 px-4 text-xs font-semibold text-gray-100'
            >
              Más información
            </Link>
          </div>
        </div>
        <div className='border-b'>
          <div
            onClick={onToggle}
            className='px-4 py-2 hover:bg-gray-100 flex items-center cursor-pointer'
          >
            <div className='text-red-500'>
              {isFavorite ? <IoHeart /> : <IoHeartOutline />}
            </div>
            <div className='pl-3'>
              <p className='text-sm font-medium text-gray-800 leading-none'>
                {isFavorite ? 'Favorito' : 'No es favorito'}
              </p>
              <p className='text-xs text-gray-500'>Click para cambiar</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
```

#### PokemonGrid.tsx

```tsx
import React from 'react';
import { SimplePokemon } from '..';
import { PokemonCard } from './PokemonCard';

interface Props {
  pokemons: SimplePokemon[];
}

export const PokemonGrid = ({ pokemons }: Props) => {
  return (
    <div className='flex flex-wrap gap-10 items-center justify-center'>
      {pokemons.map((pokemon) => (
        <PokemonCard key={pokemon.id} pokemon={pokemon} />
      ))}
    </div>
  );
};
```

#### PokemonFavorites.tsx

```tsx
'use client';

import { useAppSelector } from '@/store';
import { PokemonGrid } from '..';
import { IoHeartOutline } from 'react-icons/io5';

export const PokemonsFavorites = () => {
  const pokemosFavorites = useAppSelector((state) => state.pokemons.favorites);
  const pokemons = [];

  //   este for in nos ayuda a recorrer algun objeto aqui converti un objeto a un arreglo como lo necesitaba pero al ponerlo de la siguiente manera
  // Objet.values( pokemosFavorites ) esto ya lo convierte en un objeto como lo necesitamos
  for (const pokemon in pokemosFavorites) {
    pokemons.push(pokemosFavorites[pokemon]);
  }

  // lo que hice con esto es que mi estado es los que esten en favoritos al momento que se dibuje el componente entonces aunque los quitemos de favoritos cambiando nuestro store hasta que se vuelva a redibujar se cambiaran en este estado
  // entonces en el grid aunque no esten en favoritos se mantienen por si queiren volverlo a poner en favorito, cambiara el estado hasta que se redibuje el componente y se vuelva a enviar como initialState el nuevo listado de favoritos y ese listado les enviamos al grid
  // const [pokemonsState, setPokemonsState] = useState(pokemons);

  return (
    <>
      {pokemons.length >= 1 ? (
        <PokemonGrid pokemons={pokemons} />
      ) : (
        <NoFavorites />
      )}
    </>
  );
};

export const NoFavorites = () => {
  return (
    <div className='flex flex-col h-[5-vh] items-center justify-center'>
      <IoHeartOutline size={100} className='text-red-500' />
      <span>No hay favoritos</span>
    </div>
  );
};
```

### interfaces

#### pokemon.ts

Una interface para la peticion get de un pokemon en especifico, creada con quicktype

```ts
// Generated by https://quicktype.io

export interface Pokemon {
  abilities: Ability[];
  base_experience: number;
  forms: Species[];
  game_indices: GameIndex[];
  height: number;
  held_items: HeldItem[];
  id: number;
  is_default: boolean;
  location_area_encounters: string;
  moves: Move[];
  name: string;
  order: number;
  past_abilities: any[];
  past_types: any[];
  species: Species;
  sprites: Sprites;
  stats: Stat[];
  types: Type[];
  weight: number;
}

export interface Ability {
  ability: Species;
  is_hidden: boolean;
  slot: number;
}

export interface Species {
  name: string;
  url: string;
}

export interface GameIndex {
  game_index: number;
  version: Species;
}

export interface HeldItem {
  item: Species;
  version_details: VersionDetail[];
}

export interface VersionDetail {
  rarity: number;
  version: Species;
}

export interface Move {
  move: Species;
  version_group_details: VersionGroupDetail[];
}

export interface VersionGroupDetail {
  level_learned_at: number;
  move_learn_method: Species;
  version_group: Species;
}

export interface GenerationV {
  'black-white': Sprites;
}

export interface GenerationIv {
  'diamond-pearl': Sprites;
  'heartgold-soulsilver': Sprites;
  platinum: Sprites;
}

export interface Versions {
  'generation-i': GenerationI;
  'generation-ii': GenerationIi;
  'generation-iii': GenerationIii;
  'generation-iv': GenerationIv;
  'generation-v': GenerationV;
  'generation-vi': { [key: string]: Home };
  'generation-vii': GenerationVii;
  'generation-viii': GenerationViii;
}

export interface Sprites {
  back_default: string;
  back_female: string;
  back_shiny: string;
  back_shiny_female: string;
  front_default: string;
  front_female: string;
  front_shiny: string;
  front_shiny_female: string;
  other?: Other;
  versions?: Versions;
  animated?: Sprites;
}

export interface GenerationI {
  'red-blue': RedBlue;
  yellow: RedBlue;
}

export interface RedBlue {
  back_default: string;
  back_gray: string;
  back_transparent: string;
  front_default: string;
  front_gray: string;
  front_transparent: string;
}

export interface GenerationIi {
  crystal: Crystal;
  gold: Gold;
  silver: Gold;
}

export interface Crystal {
  back_default: string;
  back_shiny: string;
  back_shiny_transparent: string;
  back_transparent: string;
  front_default: string;
  front_shiny: string;
  front_shiny_transparent: string;
  front_transparent: string;
}

export interface Gold {
  back_default: string;
  back_shiny: string;
  front_default: string;
  front_shiny: string;
  front_transparent?: string;
}

export interface GenerationIii {
  emerald: OfficialArtwork;
  'firered-leafgreen': Gold;
  'ruby-sapphire': Gold;
}

export interface OfficialArtwork {
  front_default: string;
  front_shiny: string;
}

export interface Home {
  front_default: string;
  front_female: string;
  front_shiny: string;
  front_shiny_female: string;
}

export interface GenerationVii {
  icons: DreamWorld;
  'ultra-sun-ultra-moon': Home;
}

export interface DreamWorld {
  front_default: string;
  front_female: null;
}

export interface GenerationViii {
  icons: DreamWorld;
}

export interface Other {
  dream_world: DreamWorld;
  home: Home;
  'official-artwork': OfficialArtwork;
}

export interface Stat {
  base_stat: number;
  effort: number;
  stat: Species;
}

export interface Type {
  slot: number;
  type: Species;
}
```

#### pokemonsResponse.ts

```ts
// Generated by https://quicktype.io

export interface PokemonsResponse {
  count: number;
  next: string;
  previous: null;
  results: Result[];
}

export interface Result {
  name: string;
  url: string;
}
```

#### simplePokemon.ts

```ts
export interface SimplePokemon {
  id: string;
  name: string;
}
```

## shopping-card

### components

#### Counter.tsx

```tsx
'use client';
import { useAppDispatch, useAppSelector } from '@/store';
import {
  addOne,
  initCountState,
  resetCount,
  substractOne,
} from '@/store/counter/counterSlices';
import { useEffect } from 'react';

interface Props {
  value: number;
}

interface CountResponse {
  count: number;
}

const getApiCounter = async (): Promise<CountResponse> => {
  // obtenemos nuestro count de nuestra api
  const data = await fetch('/api/counter').then((res) => res.json());

  // return data as CounterResponse;  //esta es otra manera de ponerle el tipado sin ponerle lo que regresa (Promise<>)
  return data;
};

export const Counter = ({ value = 0 }: Props) => {
  const countState = useAppSelector((state) => state.counter.count);
  const dispatch = useAppDispatch();

  // con esto hay un problema si queremos darle el valor que recibimos del padre, puede ser data de alguna base de datos o lo que sea pero si queremos establecerla a nuestro state, con el useEffect no funciona
  // por que este commponente se vuelve a crear muchas veces entonce de nuevo se establece 20
  // useEffect(() => {
  //   dispatch(initCountState(value));
  // }, []);

  // ya no enviaremos el valor del padre si no desde nuestra api que creamos
  useEffect(() => {
    // aqui estoy diciendo que cuando se resuelva lo que recibo que es el objeto con el count de la api se lo asigne de nuevo al initCountState nuestra accion
    // lo mismo que arriba pero obteniendo el dato de una api
    getApiCounter().then((data) => dispatch(initCountState(data.count)));
  }, []);

  return (
    <>
      <span className='text-9xl'>{countState}</span>

      <div className='flex'>
        <button
          onClick={() => {
            dispatch(addOne());
          }}
          className='flex items-center justify-center p-2 rounded-xl bg-cyan-900 text-white hover:bg-cyan-700 transition-all w-[80px] m-2'
        >
          +1
        </button>

        <button
          onClick={() => {
            dispatch(substractOne());
          }}
          className='flex items-center justify-center p-2 rounded-xl bg-red-900 text-white hover:bg-red-700 transition-all w-[80px] m-2'
        >
          -1
        </button>

        <button
          onClick={() => {
            dispatch(resetCount(0));
          }}
          className='flex items-center justify-center p-2 rounded-xl bg-emerald-900 text-white hover:bg-emerald-700 transition-all w-[80px] m-2'
        >
          Reset
        </button>
      </div>
    </>
  );
};
```

## store

### counter

#### counterSlices.ts

```ts
import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface CounterState {
  count: number;
  isReady: boolean;
}

// creamos de una vez aqui nuestro initialState
const initialState: CounterState = {
  count: 12,
  isReady: false,
};

export const counterSlice = createSlice({
  name: 'counter',
  initialState, //usamos el initialState ya creado antes
  reducers: {
    // esta es la manera de hacer las funciones
    // se recomienda que estas funciones sean puras, me refiero que se manejen todo los cambios y todo adentro de la funcion, sin llamar a otras funciones o apis

    initCountState(state, action: PayloadAction<number>) {
      // esto lo hacemos porque el componente donde llamamos esto se redibuja muchas veces entonces como queremos enviarle un valor al state pero solo una vez creamos esa tipo banderita que si es isReady entonces que no haga nada pero si esta en false entonces quiere decir que no se a establecido el valor entonces ahi si le establecemos y lo ponemos false
      // tambien esto nos ayuda a mantener el state del counter a pesar de que cambiemos de paginas ya que no se estara poniendo el valor que le enviemos
      // por que si no hicieramos esto, el valor que le enviamos se estaria poniendo a nuestro state cada vez que se redibuje el state
      if (state.isReady) return;

      state.count = action.payload;
      state.isReady = true;
    },

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

export const { addOne, resetCount, substractOne, initCountState } =
  counterSlice.actions;
export default counterSlice.reducer; //aqui exportamos como dije por defecto el reducer
```

### middlewares

#### localStorageMiddleware.ts

```tsx
import { MiddlewareAPI, Dispatch, Action } from '@reduxjs/toolkit';
import { RootState } from '..';

export const localStorageMiddleware = (state: MiddlewareAPI) => {
  return (next: Dispatch) => (action: Action) => {
    // console.log({ state });  // en nuestro state esta el dispatch y el getState, entonces para obtener nuestro estado debemos de ejecutar esa funcion del getState
    next(action); //aqui uso el next que es el dispatch para hacer la acciones y el action pues simplemnete son las acciones
    // este middleware como todas las acciones pasan por aqui entonces cuando entran aqui y quiero dejar que ejecuta la accion que en mas de algun lado de la aplicacion ejecutamos tambien la debemos de dispachar aqui pero podemos hacer algo antes que se ejecute la accion
    // console.log(action); //en la accion recibimos el type y el payload

    // Repito esto intercede todas las acciones que ejecutmos

    if (action.type === 'pokemons/toggleFavorite') {
      const { pokemons } = state.getState() as RootState;
      // con la linea de arriba obtuve mi estado y desestructure el de pokemon, con el as le doy el typado y le digo qeu sera del rootState el que tengo en el index
      localStorage.setItem('favorite-pokemons', JSON.stringify(pokemons));
      //   y ya aqui convierto en string todo nuestro estado de pokemons que son nuestros favoritos y lo almaceno en el localStorage como antes lo hice
      return;
    }
  };
};
```

### Pokemon

#### pokemonSlices.ts

```ts
import { SimplePokemon } from '@/pokemons';
import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface PokemonsFavoritesState {
  // asi creo una interfaces donde les digo que sera un objeto donde la llave sera un string y despues tendra un objeto
  favorites: { [key: string]: SimplePokemon };
  // es igual el objeto simplemente le agregue una capa arriba, como estaba antes pero ahora estara adentro de favorites
}

// usar el localStorage nos da un problema al hacer el build de produccion ya que el localStorage es del front no esta en el servidor
// Ya que usamos el localStorage para generar algo en el html basado en next no da este error por lo que decia que no existe el localStorage en el servidor
// const getInitialState = (): PokemonsFavoritesState => {
//   // el localStorage se syncrono asi que no hay problema,
//   const favorites = JSON.parse(
//     // obtengo todo los objetos de nuestro localStorage
//     localStorage.getItem('favorite-pokemons') ?? '{}'
//   );

//   return favorites;
// };
// por el problema ya no usaremos esta manera de usar el localStorage aqui

const initialState: PokemonsFavoritesState = {
  // aqui esparzo cada uno de los objetos que que retorne en favorites
  // ...getInitialState(),
  favorites: {},
};

const pokemonSlices = createSlice({
  name: 'pokemons',
  initialState,
  reducers: {
    // establecemos nuestros favoritos en algun componente muy alto para ya tenerlos antes que los pidamos en alguna action, por eso usamos esta accione en el provider ya que la informacion esta en el localStorage no importa que no se hayan dibujado componentes o algo por el estilo
    setFavoritePokemons(state, action: PayloadAction<PokemonsFavoritesState>) {
      // entonces en el layout mandaremos nuestros favoritos para que cuando carguen ya esten los favoritos, pero solamente usando esta accion
      state.favorites = action.payload.favorites;
      // le agregamos un nivel mas al state para poder almacenarlo a favoritos y no al root del state
    },

    toggleFavorite(state, action: PayloadAction<SimplePokemon>) {
      const pokemon = action.payload;
      const { id } = pokemon;

      if (!!state.favorites[id]) {
        // aqui pregunto si existe el pokemon que acabo de recibir, con ayuda del doble !!
        // le envio el id del pokemon que envian y si esta lo elimino de favoritos con delete recordadr que nuestro estado es un objeto con las llaves con los ids entonces esas llaves son como poner state.'1', entonces elimino ese
        delete state.favorites[id];
        return;
      }
      // si no esta entonces lo creo, le pongo que state.'1' = {id: '1', name: ''} esto estoy diciendo
      state.favorites[id] = pokemon;

      // esto que hicimos aqui es una mala practica ya que llamamos acciones secundarias, y validamos arriba y si o si cae a guardar al local storage
      // localStorage.setItem('favorite-pokemons', JSON.stringify(state.favorites));
      // ya lo trabajamos con un middleware
    },
  },
});

export const { toggleFavorite, setFavoritePokemons } = pokemonSlices.actions;

export default pokemonSlices.reducer;
```

### index.ts

```ts
import { configureStore } from '@reduxjs/toolkit';
import counterSlice from './counter/counterSlices';
import { TypedUseSelectorHook, useDispatch, useSelector } from 'react-redux';

export const store = configureStore({
  reducer: {
    counter: counterSlice,
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

### Providers.tsx

Nuestro provider lo creamos aparte y lo pusimos en el layout mas alto pero como era un client component creamos un componente

```tsx
'use client';

import { Provider } from 'react-redux';
import { store } from '.';
import { setFavoritePokemons } from './pokemon/pokemonSlices';
import { useEffect } from 'react';

interface Props {
  children: React.ReactNode;
}

export const Providers = ({ children }: Props) => {
  // usamos un useEffect para que solo la primera vez que se cargue el provider se almacenen los favoritos
  useEffect(() => {
    const favorites = JSON.parse(
      localStorage.getItem('favorite-pokemons') ?? '{}'
    );

    store.dispatch(setFavoritePokemons(favorites));
  }, []);

  return <Provider store={store}>{children}</Provider>;
};
```
