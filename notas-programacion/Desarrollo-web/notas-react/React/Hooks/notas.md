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

Custom Hook del Counter

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
Usando mi hook
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
      <button className="btn btn-primary" onClick={reset}>Reset</button>{/*recordar que al poner reset solamente estamos enviando el evento como primer argumento, pero en este caso no resive ningun argumento */}
      <button className="btn btn-primary" onClick={() => decrement(7)}>-1</button>
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
import { useEffect } from "react"

interface Coordenadas {
  x: number,
  y: number
}

export const Menssage = () => {

  useEffect(() => {

    const onMouseMove = ({x, y}: Coordenadas) => {
      const coord = {x, y}
      console.log(coord)
    }

    //cuando se monta el componente se activa esto y el return serve para cuando se elimine el componente
    window.addEventListener('mousemove', onMouseMove)
    // window.addEventListener('mousemove', () => {})   //no puedo hacer esto ya que el eventListener seria diferente al de abajo por eso hacemos una funcion que apunte al mismo espacio de memoria

    return () => {    //el return puede funcionar que cuando deje de existir el componente, es como la limpieza
      window.removeEventListener('mousemove', onMouseMove) 
    }
  }, [])

  return (
    <>
        <h1>Hola</h1>
    </>
  )
}
```

Con Hook
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
          email: '',
          username: '',
          password: ''
        })
      }

      console.log(formState)
    return {
        ...formState,       //envio todas las propiedades de formState
        onInputChanges, 
        onResetForm 
    }
}
```