# Redux

Nos ayuda a poder controlar donde se encuentra la informacion de nuestra aplicacion en todo momento

Algo importante es saber que redux no es de react si no es totalmente diferente

El proceso en redux tiene que ser sincrono no debemos hacer peticiones http y eso pero si necesitamos un proceso asincrono ahi es donde se implementan los middlewares

Hay 3 diferentes no hay que equivocarse

- Redux: es el patron en el cual se basa en crear nuevos estados mediante reducers
- React Redux: hasta hace unos años era la forma tradicional de trabajar con react y redux, pero realmente era crear mucho codigo para hacer eso
- Redux Toolkit: una serie de herramientas para implementar el patron de react y sea mas facil

## Instalacion

[Documentacion](https://redux-toolkit.js.org/tutorials/quick-start)

- `yarn add @reduxjs/toolkit react-redux`

## Codigo

Normalmente no todos los estados tienen que estar en el store si es algo que puede estar facil en el componente tambien lo podemos poner ahi no es obligatorio tener todo en el store

Para mayor control podemos crear una carpeta store y ahi poner nuestro store, por si no lo explique antes el store es donde esta almacenado todos los reducer o donde estara el estado

Y esta es la configuracion principal para nuestro store

```ts
import { configureStore } from '@reduxjs/toolkit';

export const store = configureStore({
  reducer: {},
});
```

Y gracias al provider que nos da react-redux lo podemos proveer a toda nuestra app, claro no es obligatorio ponerlo en el main pero si hay que ponerlo en algun lugar donde lo puedan tener todos nuestros hijos

```tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App.tsx';
import './index.css';
import { Provider } from 'react-redux';
import { store } from './store';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>
);
```

Redux toolkit nos ayuda hacer accines que mutan la variable pero esto crea uno nuevo haciendo que sea como se recomienda

### Slices

Explicacion: Un "slice" en Redux Toolkit es como una caja que contiene todas las reglas y herramientas para controlar una parte particular de la información en tu aplicación. En lugar de tener una enorme caja con todas tus cosas, divides tus cosas en cajas más pequeñas y cada caja tiene un conjunto de reglas para manipular lo que hay dentro.

En otras palabras, un "slice" en Redux es una forma de organizar y gestionar partes específicas de los datos en tu aplicación de una manera más ordenada y fácil de entender. Ayuda a mantener el código limpio y ordenado, y facilita la tarea de trabajar con diferentes partes de tu aplicación por separado. Cada "slice" tiene su propio conjunto de reglas (llamado reducer) y herramientas (llamadas acciones) para manejar su información.

Un Slice nos ayuda a darle un name a este slice a definirle un initialState y poder poner nuestros reducer

Creamos una carpeta adentro de store con el nombre de slices y creamos nuestro slices

```tsx
import { createSlice } from '@reduxjs/toolkit';

export const counterSlice = createSlice({
  //creamos nuestro Slice,
  name: 'counter', //solo lo nombramos, y creamos su valor inicial y los reducers
  initialState: {
    counter: 10,
    times: 0, //si nosotros en los reducer no cambiamos el times se sigue enviando el valor que le pongamos en el initial
  },
  reducers: {
    increment: (state) => {
      //aqui recibimos el estado actual
      //esto es conocido como un reducer aunque solo sea una funcion
      state.counter += 1; //este .counter es el valor que tenemos en el initialState
      //y como pueden ver lo estamos mutando pero esto es permitido gracias a redux ya que no lo muta
    },
    decrement: (state) => {
      state.counter -= 1;
    },
    incrementeBy: (state, action) => {
      //tambien podemos obtener la accion donde ahi esta el payload y el type y lo que le enviemos en la accion del dispath es el payload
      state.counter += action.payload;
    },
  },
});

// aqui exportamos nuestras acciones, simplemente asi no nos debemos de preocupar por los types o payload
//pero algo muy importante lo que estamos exportando aqui no es lo mismo que nuestros reducer de arriba, estas acciones se crean aparte
export const { increment, decrement, incrementeBy } = counterSlice.actions;
```

pero antes asi esta nuestro store:

```ts
import { configureStore } from '@reduxjs/toolkit';
import { counterSlice } from './slices/counter';
import { pokemonSlice } from './slices/pokemon';

export const store = configureStore({
  //aqui configuramos nuestros stores que simplemente los nombramos asi y le damos el valor de nuestros slice.reducer
  reducer: {
    counter: counterSlice.reducer,
    pokemon: pokemonSlice.reducer,
  },
});
```

Y asi puedo extraer los estados

```tsx
import { useSelector, useDispatch } from 'react-redux';
import { decrement, increment, incrementeBy } from './store/slices/counter';

function App() {
  const { counter } = useSelector((state: any) => state.counter); //usamos el useSelector para recibir el estado del que pongamos ahi, en este ejemplo counter entonces en nuestro store nos trae el estado del reducer counter, y ya podemos extraer el valor del state
  const dispatch = useDispatch(); //usamos el hook para crear nuestro dispath para poder llamar las acciones que exportamos en nuestro slices

  return (
    <>
      <h1>Count is {counter}</h1>
      <div className='card'>
        <button
          onClick={() => {
            dispatch(increment()); //y asi llmamos alguna accion
          }}
        >
          Increment
        </button>
        <button
          onClick={() => {
            dispatch(decrement());
          }}
        >
          Decrement
        </button>
        <button
          onClick={() => {
            dispatch(incrementeBy(4)); //el valor que le enviamos a la accion es el payload
          }}
        >
          Increment by
        </button>
      </div>
    </>
  );
}

export default App;
```

### Codigo async

Cuando tenemos codigo async tenemos que hacer otro paso, usar un thunk

Nuestro Slices

```ts
import { createSlice } from '@reduxjs/toolkit';

export const pokemonSlice = createSlice({
  name: 'pokemon',
  initialState: {
    page: 0,
    pokemons: [],
    isLoading: false,
  },
  reducers: {
    //creamos nuestros dos reducers que abajo se convierten en actions donde las llamamos y ejecutan este codigo o cambian si tienen que cambiar algo
    startLoadingPokemon: (state) => {
      state.isLoading = true; //sabemos que no podemos mutar el estado pero con redux toolkit aunque lo mutemos crea otro
    },
    setPokemons: (state, action) => {
      //aqui cambiamos nuestro estado gracias a este reducer
      state.isLoading = false;
      state.page = action.payload.page;
      state.pokemons = action.payload.pokemons;
    },
  },
});

export const { startLoadingPokemon, setPokemons } = pokemonSlice.actions;
```

Anteriormente ya lo configuramos en el store

Pero para poder llamar una peticion a alguna api eso es asyncrono entonces creamos un thunks

Los thunks es una accion que dispara otra accion cuando resuelve la peticion asyncrona, entonces cuando se resuelva el codigo asyncrono se desparara una accion de las que tenemos en el slice

```ts
import { setPokemons, startLoadingPokemon } from '.';
import { pokemonApi } from '../../../api/pokemonApi';

export const getPokemons = (page: number = 0) => {
  //retornamos otra fucion y tenemos los dos argumentos uno que es el dispath para hacer el dispath de las acciones y el segundo argumento es el getState este nos ayuda a obtener el estado actual
  return async (dispatch: any, getState: any) => {
    dispatch(startLoadingPokemon()); //cuando realizamos la peticion ponemos en true el loading, aqui simplemente llamamos nuestra accion que pone el loading en true

    // const res = await fetch(     //normal cn fetch
    //   `https://pokeapi.co/api/v2/pokemon?limit=10&offset=${page * 10}`
    // );
    // const data = await res.json();

    //y asi seria con axios
    const { data }: any = await pokemonApi.get(
      // y aqui usamos nuestra base de la url y esto de una vez nos devuelve la data
      `/pokemon?limit=10&offset=${page * 10}`
    );

    dispatch(
      //aqui ya usamos la accion que nos ayuda a cambiar los valores de nuestro state, gracias a la peticion de axios
      setPokemons({
        //recordemos que lo que le enviamos en el reducer es el payload
        pokemons: data.results,
        page: page + 1,
      })
    );
  };
};
```

la base de la url pokemonApi

```ts
import axios from 'axios';

export const pokemonApi = axios.create({
  //con esto es para cuando necesitemos la base de la url fija entonces ya solo usariamos pokemonApi.get('') y la parte de la url que falta para obtener el api
  baseURL: 'https://pokeapi.co/api/v2',
});
```

Y para usarla es

```tsx
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { getPokemons } from './store/slices/pokemon';

export const PokemonApp = () => {
  const {
    pokemons: data, //cuando le pongo dos puntos en la desestructuracion estoy re nombrando ahora no es pokemons si no data
    isLoading,
    page,
  } = useSelector(
    //aqui obtenemos nuestro estado del reducer que ponemos ahi donde tenemos configurado en nuestro store
    (state: any) => state.pokemon
  );

  const dispatch = useDispatch(); // no importa de que pieza del store vayamos a usar el dispatch es el mismo

  useEffect(() => {
    //porque queremos hacer una accion asyncrona por eso llamamos nuestro thunks ya que es tambien una accion
    dispatch(getPokemons());
  }, []);

  return (
    <>
      <h1>Pokemon App</h1>
      <h2>isLoading {isLoading ? 'true' : 'false'} </h2>
      <hr />

      <ul>
        {data.map((poke: any) => (
          <li key={poke.name}>{poke.name}</li>
        ))}
      </ul>

      <button
        disabled={isLoading}
        onClick={() => dispatch(getPokemons(page + 1))} //tambien podemos usar las acciones que hayamos exportado en el slice pero como vieron antes si queremos obtener datos asyncronos y guardarlos al estado llamamos nuestra accion del sthuk
        //en este sthuk tenemos un argumento por eso lo enviamos
      >
        Next page
      </button>
    </>
  );
};
```
