# Hooks

## useState

Algo importante es que cuando cambia el estado el componente se vuelve a ejecutar todo el componente, por eso se recomienda que las funciones y otras cosas si no usan algo del componente se creen afuera.

```jsx
const Counter = ({ value }) => {
  const [counter, setCouter] = useState(value);
  //esto nos ayuda a cambiar el estado de algo, pueden ser numero, string objetos etc.
  //la primera es la constante donde se guarda el estado, y el segundo es la funcion para cambiar ese estado

  const add = () => {
    // setCouter(counter + 1)
    setCouter((c) => c + 1); //de esta manera tambien se puede resivir, aqui no estamos usando la constante counter simplemente ejecutamos una funcion donde el argumento toma el valor actual y podemos aumentarle
  };
  return (
    <>
      <h1>Counter App</h1>
      <h2>{counter}</h2>
      <button onClick={add}>click</button>
    </>
  );
};
```

### Custom Hook del Counter

```jsx
export const useCounter = (initialValue = 10) => {
  const [counter, setCounter] = useState(initialValue);

  const increment = (value = 1) => {
    setCounter(counter + value);
  };
  const decrement = (value = 1) => {
    if (counter === 0) return; //para que no sea menor a 0

    setCounter(counter - value);
  };
  const reset = () => {
    setCounter(0);
  };

  return {
    // counter: counter, lo mismo que :
    counter,
    increment,
    decrement,
    reset,
  };
};
```

### Usando mi hook

```jsx
export const CounterWithHook = () => {
  const { counter, decrement, increment, reset } = useCounter();
  return (
    <>
      <h1>Counter With Hook: {counter}</h1>
      <hr />
      <button className="btn btn-primary" onClick={() => increment(2)}>
        +1
      </button>
      <button className="btn btn-primary" onClick={reset}>
        Reset
      </button>
      {/*recordar que al poner reset solamente estamos enviando el evento como primer argumento, pero en este caso no resive ningun argumento */}
      <button className="btn btn-primary" onClick={() => decrement(7)}>
        -1
      </button>
    </>
  );
};
```

## useEffect

Nos ayuda a disparar eventos secundarios

```tsx
import { ChangeEvent, FC, useState } from "react";

import { UserForm } from "../interfaces";
import { Menssage } from "./Menssage";

export const SimpleForm: FC = () => {
  const [formState, setFormState] = useState<UserForm>({
    email: "plashba@gmail.mar",
    username: "Sebas",
  });

  const { email, username } = formState;

  const onInputChanges = (event: ChangeEvent<HTMLInputElement>) => {
    // if (event.target.name === "email")   //mi solucion
    //   setFormState({
    //     ...formState,
    //     email: event.target.value,
    //   });
    // else
    // setFormState({
    //     ...formState,
    //     username: event.target.value,
    //   });

    setFormState({
      //en esta solucion primero hago una copia de todas las propiedades y cambiamos la propiedad del name por el value, el name es de que input lo hicimos
      ...formState,
      [event.target.name]: event.target.value,
      //digamos que el name es email, pues esa va a cambiar por eso las llaves cuadradas
    });

    // useEffect(() => {   //el useEffect es utilizado para disparar efectos secundarios

    // }, [])  //si no tiene los corchetes se dibuja cada vez que se crea el componte
    //si esta vacio la dependencia le estamos diciendo que solo se llamara cuando el componente lo manden a llamar o se renderice
    //es bueno tener separado los effects para que haga una tarea unica
  };
  console.log(formState);

  return (
    <>
      <h1>Formulario</h1>
      <hr />

      <input
        type="text"
        className="form-control"
        placeholder="Username"
        name="username"
        value={username}
        onChange={onInputChanges}
      />
      <br />
      <input
        type="email"
        className="form-control"
        placeholder="plashba@se.mar"
        name="email"
        value={email}
        onChange={onInputChanges}
      />

      {username === "Sebas" && <Menssage />}
    </>
  );
};
```

```tsx
import { useEffect } from "react";

interface Coordenadas {
  x: number;
  y: number;
}

export const Menssage = () => {
  useEffect(() => {
    const onMouseMove = ({ x, y }: Coordenadas) => {
      const coord = { x, y };
      console.log(coord);
    };

    //cuando se monta el componente se activa esto y el return serve para cuando se elimine el componente
    window.addEventListener("mousemove", onMouseMove);
    // window.addEventListener('mousemove', () => {})   //no puedo hacer esto ya que el eventListener seria diferente al de abajo por eso hacemos una funcion que apunte al mismo espacio de memoria

    return () => {
      //el return puede funcionar que cuando deje de existir el componente, es como la limpieza
      window.removeEventListener("mousemove", onMouseMove);
    };
  }, []);

  return (
    <>
      <h1>Hola</h1>
    </>
  );
};
```

### Con Hook

```tsx
import { FC } from "react";

import { Menssage } from "./Menssage";
import { useForm } from "../hooks/useForm";

export const FormWithHook: FC = () => {
  const { onInputChanges, username, email, password, onResetForm } = useForm({
    email: "",
    username: "",
    password: "",
  });

  return (
    <>
      <h1>Formulario Hook</h1>
      <hr />

      <input
        type="text"
        className="form-control"
        placeholder="Username"
        name="username"
        value={username}
        onChange={onInputChanges}
      />
      <br />
      <input
        type="email"
        className="form-control"
        placeholder="plashba@se.mar"
        name="email"
        value={email}
        onChange={onInputChanges}
      />
      <br />
      <input
        type="password"
        className="form-control"
        placeholder="Contraseña"
        name="password"
        value={password}
        onChange={onInputChanges}
      />

      <button onClick={onResetForm} className="btn btn-primary mt-3">
        Reset
      </button>

      {username === "Sebas" && <Menssage />}
    </>
  );
};
```

```tsx
import { ChangeEvent, useState } from "react";
import { UserForm } from "../interfaces";

export const useForm = (initialForm: UserForm) => {
  const [formState, setFormState] = useState<UserForm>(initialForm);

  const onInputChanges = (event: ChangeEvent<HTMLInputElement>) => {
    setFormState({
      ...formState,
      [event.target.name]: event.target.value,
    });
  };

  const onResetForm = () => {
    setFormState({
      email: "",
      username: "",
      password: "",
    });
  };

  console.log(formState);
  return {
    ...formState, //envio todas las propiedades de formState
    onInputChanges,
    onResetForm,
  };
};
```

## Multiple Custom Hook

```tsx
import { useCounter, useFetch } from "../hooks";

export const MultipleCustomHook = () => {
  const { increment, decrement, counter } = useCounter(1);
  const { character, isLoading } = useFetch(counter);
  // const { author, quote } = !!data && data[0]   // esto es del video pero digo que si data tiene un valor que tome la data en la posicion 0,
  //digo con el doble !! que si tiene algun valor si tiene algun valor devuelve true si no devuelve false
  // si data no tiene nada es undefined si le paso ! eso es true y con dos !! es false asi podemos saber si tenemos datos

  // if (isLoading) {  asi tambien podemos hacer para la pantalla de carga mientras carga retornamos esto si no nunca entra al if y carga lo de abajo
  //   return (
  //     <div className="alert alert-success text center">
  //       Cargando...
  //     </div>
  //   )
  // }

  return (
    <>
      <h1>Character Rick y Morty</h1>
      <hr />
      <button onClick={() => decrement()} className="btn btn-outline-success">
        -1
      </button>
      <button onClick={() => increment()} className="btn btn-outline-success">
        +1
      </button>
      <br />

      {isLoading && (
        <div className="alert alert-success text center">Cargando...</div>
      )}
      <div className="card w-25 mt-4">
        <img
          src={character?.image}
          alt={character?.name}
          className="card-img-top"
        />
        <h3 className="card-body">{character?.name}</h3>
      </div>
    </>
  );
};
```

### useFetch

```ts
import { useEffect, useState } from "react";
import { Character } from "../interfaces";

export const useFetch = (id: number) => {
  const [character, setCharacter] = useState<Character>();
  const [isLoading, setIsLoading] = useState(true);

  const getFetch = async () => {
    if (id <= 0) id = 1;
    const res = await fetch(`https://rickandmortyapi.com/api/character/${id}`);
    const data = await res.json();
    setCharacter({
      //aqui creo un character con la data que resivi
      id: data.id,
      name: data.name,
      status: data.status,
      image: data.image,
    });
    setIsLoading(false);
  };

  useEffect(() => {
    getFetch();
  }, [id]);

  return {
    character,
    isLoading,
  };
};
```

## useRef

useRef es como un useState pero no renderiza la pagina

```tsx
export const FocusScreen = () => {
  const inputRef = useRef<HTMLInputElement>(null); // useRef le ponemos null para que acepte si no tiene algun elemento

  const onClick = () => {
    inputRef.current?.select(); // solamente inputRef.current como le pusimos un ref al input entonces el current es el input es la referencia,
    //con el select seleccionamos todo el input
    //tambien esta el focus para solo poner el cursor sobre el input
    //pasar el ref a un elemento de html para obtenerlo es lo mismo que poner un queryselector, obtenemos la referencia
  };

  return (
    <>
      <h1>Focus Screen</h1>
      <hr />

      <input
        ref={inputRef}
        type="text"
        placeholder="Ingrese su nombre"
        className="form-control"
      />

      <button className="btn btn-primary mt-2" onClick={onClick}>
        Set Focus
      </button>
    </>
  );
};
```

## useLayoutEffect

Este es como el useEffect pero este se dispara despues que todo se haya renderizado o todas las mutaciones del DOM se hayan completado, texto y todas las modificaciones

Nos puede ayudar a conocer el tamaño de algo, aunque lo mismo podemos hacer con el useEffect solo con eso de tener en cuenta que este se dispara despues de todas las mutaciones del DOM

```tsx
import { useRef, useState, ChangeEvent, useLayoutEffect } from "react";
import { Box } from "../interfaces";

export const Layout = () => {
  const pRef = useRef<HTMLInputElement>(null);
  const [boxSize, setBoxSize] = useState<Box>({
    width: 0,
    height: 0,
  });
  const [change, setChange] = useState("");

  const onChange = (event: ChangeEvent<HTMLInputElement>) => {
    setChange(event.target.value);
  };

  useLayoutEffect(() => {
    //esta es algo para que nos pueda servir pero puede ser lo mismo que el useEffect
    setBoxSize({
      width: pRef.current?.getBoundingClientRect().width || 0, //gracias a toda esa linea con el getBoun.. puedo obtener informacion de la caja y ahi puedo sacar el height y width
      height: pRef.current?.getBoundingClientRect().height || 0,
    });
  }, [change]);

  return (
    <>
      <h1>BoxSize</h1>
      <input type="text" className="form-control mb-2" onChange={onChange} />
      <p ref={pRef} className="mb-2 d-inline">
        {change}
      </p>
      <p>
        <strong>BoxSize:</strong>
      </p>
      <p>width: {boxSize.width}</p>
      <p>height: {boxSize.height}</p>
    </>
  );
};
```

## useMemo

### Metodo Memo

```tsx
import { useState } from "react";
import { useCounter } from "../hooks";
import { Small } from "./Small";

export const Memorize = () => {
  const { counter, increment } = useCounter();
  const [show, setShow] = useState(true);
  return (
    <>
      <h1>
        Counter: <Small counter={counter} />
      </h1>
      <hr />

      <button className="btn btn-success" onClick={() => increment(1)}>
        +1
      </button>
      {/**El problema que teneoms es que cuando se ejecuta este boton se vuelve a ejecutar el conter o la etiqueta Small cuando no queremos eso
       * para eso usamos el metodo Memo de memorizar
       * En las pruebas no tengo ese problema
       */}
      <button
        className="btn btn-outline-success"
        onClick={() => setShow(!show)}
      >
        Show/Hide {JSON.stringify(show)}
      </button>
    </>
  );
};
```

```tsx
import React from "react";

export const Small = React.memo(({ counter }: { counter: number }) => {
  console.log("Me volvi a dibujar");
  //esto ayuda que solo se cargue cuando cambiemos o llamemos el componente no se re dibuje cuando se llama el componente padre
  return <small>{counter}</small>;
});
```

### useMemo

```tsx
import { useState, useMemo } from "react";
import { useCounter } from "../hooks";

const heavyStuff = (iteration = 100) => {
  for (let i = 0; i < iteration; i++) {
    console.log("Ahi vamos");
  }
  return `${iteration} iteraciones realizadas`;
};

export const MemoHook = () => {
  const { counter, increment } = useCounter(300);
  const [show, setShow] = useState(true);

  const memorized = useMemo(() => heavyStuff(counter), [counter]);
  // useMemo retorna un valor y se vuelve retornar si la dependencia cambia '[]'
  // el primer argumento que tiene es una callback que tiene que retornar algo

  return (
    <>
      <h1>
        Counter: <small>{counter}</small>
      </h1>
      <hr />

      <h4>{memorized}</h4>

      <button className="btn btn-success" onClick={() => increment(1)}>
        +1
      </button>
      {/**El problema que teneoms es que cuando se ejecuta este boton se vuelve a ejecutar el conter o la etiqueta Small cuando no queremos eso
       * para eso usamos el metodo Memo de memorizar
       * En las pruebas no tengo ese problema
       */}
      <button
        className="btn btn-outline-success"
        onClick={() => setShow(!show)}
      >
        Show/Hide {JSON.stringify(show)}
      </button>
    </>
  );
};
```

## useCallback

```tsx
import { useState, useCallback } from "react";
import { ShowIncrement } from "./ShowIncrement";

export const CallbackHook = () => {
  const [counter, setCounter] = useState(10);

  // const increment = () => {       //recordar que las funciones se guardan en diferentes espacios de memoria entonces cada vez que se re didibuja el componente se crea una nueva funcion
  //     setCounter(counter + 1)
  // }

  //useCallback es parecido al useMemo pero este memoriza funciones y lo que regresa es una funcion que puedo ejecutar
  const increment = useCallback((num: number) => {
    //asi tambien se pueden poner argumentos a la funcion incrementar, ahora cuando llamemos a la funcion incrementar necesitara un argumento
    // setCounter(counter + 1)     //counter aqui entra como 10 siempre, esta funcion se ejecuta pero siempre el counter es 10 por que lo memoriza
    setCounter((c) => c + num); // aqui tomamos el valor que tenia y le sumamos uno y aqui ya funciona esto
    //aqui ya es la misma funcion no crea nuevas funciones si no es la misma
    // y ya abajo en le componente si le ponemo sun React.memo solamente una vez se redibuja
  }, []); // si esta vacio como los otros solo una vez se ejecuta

  return (
    <>
      <h1>useCallback Hook: {counter}</h1>
      <hr />

      <ShowIncrement increment={increment} />
    </>
  );
};
```

## useReducer

### Reducer

No es mas que una simple funcion, debe de ser una funcion pura, no puede ser asincrona, tambien debe de retornar un nuevo estado y usaualmente reciben dos argumentos el valor incial y la accion

Funcion pura: se refiere a que no debe tener efectos secundarios, tiene que resolverce todo internamente sin llamar a otras funciones, no deben tener tareas asincronas y tiene que retornar un nuevo estado no debemos de mutar el estado. No se deben llamar el localStorage o sessionStorage.

```ts
const intialState = [
  {
    id: 1,
    todo: "Hacer ejercicio",
    done: false,
  },
];

const newTodo = {
  id: 2,
  todo: "Hacer ejercicio 2",
  done: false,
};

const addTodoAction = {
  //normalmente asi se ve la accion del Reducer, tiene un type y el payload lo que cambiaremos
  type: "add todo",
  payload: newTodo,
};

//los Reducer siempre tienen dos arguentos el initialState y la accion
const todoReducer = (state = intialState, action: any) => {
  if (action.type === "add todo") {
    return [...state, action.payload]; //estamos esparciendo el state, hago una copia del anterior y agrego la nueva que es el payload pero creamos uno nuevo no mutamos
  }

  return state; //siempre tiene que regresar un estado o objetos y asi
  //los reducer se utilizan normalmente para cambiar objetos o algo asi mas complejo ya que si es un simple string se hace un useState
};

// let -todos = todoReducer();
// -todos.push({        //normalmente hariamos esto pero esto no es correcto ya que hacemos una mutacion al arreglo
//     id: 2,
//     -todo: 'Hacer ejercicio 2',
//     done: false
// })
// console.log(todos)

let todos = todoReducer(intialState, addTodoAction);
console.log(todos);
```
