# Hooks

- [Hooks](#hooks)
  - [useState](#usestate)
    - [Custom Hook del Counter](#custom-hook-del-counter)
    - [Usando mi hook](#usando-mi-hook)
  - [useEffect](#useeffect)
    - [Con Hook](#con-hook)
  - [Multiple Custom Hook](#multiple-custom-hook)
    - [useFetch](#usefetch)
  - [useRef](#useref)
  - [useLayoutEffect](#uselayouteffect)
  - [useMemo](#usememo)
    - [Metodo Memo](#metodo-memo)
    - [useMemo](#usememo-1)
  - [useCallback](#usecallback)
  - [useReducer](#usereducer)
    - [Reducer](#reducer)
    - [useReducer practico](#usereducer-practico)
      - [Con un custom Hook useTodo](#con-un-custom-hook-usetodo)
  - [ReactRouter](#reactrouter)
  - [useContext](#usecontext)

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
      <button className='btn btn-primary' onClick={() => increment(2)}>
        +1
      </button>
      <button className='btn btn-primary' onClick={reset}>
        Reset
      </button>
      {/*recordar que al poner reset solamente estamos enviando el evento como primer argumento, pero en este caso no resive ningun argumento */}
      <button className='btn btn-primary' onClick={() => decrement(7)}>
        -1
      </button>
    </>
  );
};
```

## useEffect

Nos ayuda a disparar eventos secundarios

```tsx
import { ChangeEvent, FC, useState } from 'react';

import { UserForm } from '../interfaces';
import { Menssage } from './Menssage';

export const SimpleForm: FC = () => {
  const [formState, setFormState] = useState<UserForm>({
    email: 'plashba@gmail.mar',
    username: 'Sebas',
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

    // useEffect(() => {   //el useEffect es utilizado para disparar evectos secundarios

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
        type='text'
        className='form-control'
        placeholder='Username'
        name='username'
        value={username}
        onChange={onInputChanges}
      />
      <br />
      <input
        type='email'
        className='form-control'
        placeholder='plashba@se.mar'
        name='email'
        value={email}
        onChange={onInputChanges}
      />

      {username === 'Sebas' && <Menssage />}
    </>
  );
};
```

```tsx
import { useEffect } from 'react';

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
    window.addEventListener('mousemove', onMouseMove);
    // window.addEventListener('mousemove', () => {})   //no puedo hacer esto ya que el eventListener seria diferente al de abajo por eso hacemos una funcion que apunte al mismo espacio de memoria

    return () => {
      //el return puede funcionar que cuando deje de existir el componente, es como la limpieza
      window.removeEventListener('mousemove', onMouseMove);
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
import { FC } from 'react';

import { Menssage } from './Menssage';
import { useForm } from '../hooks/useForm';

export const FormWithHook: FC = () => {
  const { onInputChanges, username, email, password, onResetForm } = useForm({
    email: '',
    username: '',
    password: '',
  });

  return (
    <>
      <h1>Formulario Hook</h1>
      <hr />

      <input
        type='text'
        className='form-control'
        placeholder='Username'
        name='username'
        value={username}
        onChange={onInputChanges}
      />
      <br />
      <input
        type='email'
        className='form-control'
        placeholder='plashba@se.mar'
        name='email'
        value={email}
        onChange={onInputChanges}
      />
      <br />
      <input
        type='password'
        className='form-control'
        placeholder='Contraseña'
        name='password'
        value={password}
        onChange={onInputChanges}
      />

      <button onClick={onResetForm} className='btn btn-primary mt-3'>
        Reset
      </button>

      {username === 'Sebas' && <Menssage />}
    </>
  );
};
```

```tsx
import { ChangeEvent, useState } from 'react';
import { UserForm } from '../interfaces';

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
      password: '',
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
import { useCounter, useFetch } from '../hooks';

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
      <button onClick={() => decrement()} className='btn btn-outline-success'>
        -1
      </button>
      <button onClick={() => increment()} className='btn btn-outline-success'>
        +1
      </button>
      <br />

      {isLoading && (
        <div className='alert alert-success text center'>Cargando...</div>
      )}
      <div className='card w-25 mt-4'>
        <img
          src={character?.image}
          alt={character?.name}
          className='card-img-top'
        />
        <h3 className='card-body'>{character?.name}</h3>
      </div>
    </>
  );
};
```

### useFetch

```ts
import { useEffect, useState } from 'react';
import { Character } from '../interfaces';

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
        type='text'
        placeholder='Ingrese su nombre'
        className='form-control'
      />

      <button className='btn btn-primary mt-2' onClick={onClick}>
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
import { useRef, useState, ChangeEvent, useLayoutEffect } from 'react';
import { Box } from '../interfaces';

export const Layout = () => {
  const pRef = useRef<HTMLInputElement>(null);
  const [boxSize, setBoxSize] = useState<Box>({
    width: 0,
    height: 0,
  });
  const [change, setChange] = useState('');

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
      <input type='text' className='form-control mb-2' onChange={onChange} />
      <p ref={pRef} className='mb-2 d-inline'>
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
import { useState } from 'react';
import { useCounter } from '../hooks';
import { Small } from './Small';

export const Memorize = () => {
  const { counter, increment } = useCounter();
  const [show, setShow] = useState(true);
  return (
    <>
      <h1>
        Counter: <Small counter={counter} />
      </h1>
      <hr />

      <button className='btn btn-success' onClick={() => increment(1)}>
        +1
      </button>
      {/**El problema que teneoms es que cuando se ejecuta este boton se vuelve a ejecutar el conter o la etiqueta Small cuando no queremos eso
       * para eso usamos el metodo Memo de memorizar
       */}
      <button
        className='btn btn-outline-success'
        onClick={() => setShow(!show)}
      >
        Show/Hide {JSON.stringify(show)}
      </button>
    </>
  );
};
```

```tsx
import React from 'react';

export const Small = React.memo(({ counter }: { counter: number }) => {
  console.log('Me volvi a dibujar');
  //esto ayuda que solo se cargue cuando cambiemos o llamemos el componente no se re dibuje cuando se cambia algo del componente padre
  return <small>{counter}</small>;
});
```

### useMemo

```tsx
import { useState, useMemo } from 'react';
import { useCounter } from '../hooks';

const heavyStuff = (iteration = 100) => {
  for (let i = 0; i < iteration; i++) {
    console.log('Ahi vamos');
  }
  return `${iteration} iteraciones realizadas`;
};

export const MemoHook = () => {
  const { counter, increment } = useCounter(300);
  const [show, setShow] = useState(true);

  //useMemo memoriza un valor y no se ejecutara la funcion solo si cambia el valor que le pongamos en los corchetes
  //ese valor memorizado solo se cambiara si se cambia los corchetes

  const memorizedValue = useMemo(() => heavyStuff(counter), [counter]);
  // useMemo retorna un valor y se vuelve retornar si la dependencia cambia '[]'
  // el primer argumento que tiene es una callback que tiene que retornar algo

  return (
    <>
      <h1>
        Counter: <small>{counter}</small>
      </h1>
      <hr />

      <h4>{memorizedValue}</h4>

      <button className='btn btn-success' onClick={() => increment(1)}>
        +1
      </button>
      <button
        className='btn btn-outline-success'
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
import { useState, useCallback } from 'react';
import { ShowIncrement } from './ShowIncrement';

export const CallbackHook = () => {
  const [counter, setCounter] = useState(10);

  // const increment = () => {       //recordar que las funciones se guardan en diferentes espacios de memoria entonces cada vez que se re didibuja el componente se crea una nueva funcion
  //     setCounter(counter + 1)
  // }

  //useCallback es parecido al useMemo pero este memoriza funciones y lo que regresa es una funcion que puedo ejecutar
  const increment = useCallback((num: number) => {
    //asi tambien se pueden poner argumentos a la funcion incrementar, ahora cuando llamemos a la funcion incrementar necesitara un argumento, pero recordemos que esto solo es un callback, si no le ponemos argumentos, incrementar tampoco le tenemos que enviar
    // setCounter(counter + 1)     //counter aqui entra como 10 siempre, esta funcion se ejecuta pero siempre el counter es 10 por que lo memoriza
    setCounter((c) => c + num); // aqui tomamos el valor que tenia y le sumamos uno y aqui ya funciona esto
    //aqui ya es la misma funcion no crea nuevas funciones si no es la misma
    // y ya abajo en le componente si le ponemos un React.memo solamente una vez se redibuja
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

```tsx
import { FC } from 'react';
import React from 'react';

interface Increment {
  increment: (num: number) => void;
}

export const ShowIncrement: FC<Increment> = React.memo(({ increment }) => {
  console.log('Hola');

  return (
    <>
      <button
        className='btn btn-success'
        onClick={() => {
          increment(5);
        }}
      >
        +1
      </button>
    </>
  );
});
```

## useReducer

### Reducer

No es mas que una simple funcion, debe de ser una funcion pura, no puede ser asincrona, tambien debe de retornar un nuevo estado y usaualmente reciben dos argumentos el valor incial y la accion

Funcion pura: se refiere a que no debe tener efectos secundarios, tiene que resolverce todo internamente sin llamar a otras funciones, no deben tener tareas asincronas y tiene que retornar un nuevo estado no debemos de mutar el estado. No se deben llamar el localStorage o sessionStorage.

```ts
const intialState = [
  {
    id: 1,
    todo: 'Hacer ejercicio',
    done: false,
  },
];

const newTodo = {
  id: 2,
  todo: 'Hacer ejercicio 2',
  done: false,
};

const addTodoAction = {
  //normalmente asi se ve la accion del Reducer, tiene un type y el payload lo que cambiaremos
  type: 'add todo',
  payload: newTodo,
};

//los Reducer siempre tienen dos arguentos el initialState y la accion
const todoReducer = (state = intialState, action: any) => {
  if (action.type === 'add todo') {
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

### useReducer practico

Interfaces:

```ts
export interface TodoState {
  id: number;
  description: string;
  done: boolean;
}

export interface TodoAction {
  type: string;
  payload: TodoState;
}

export interface OnNewTodo {
  onNewTodo: (Todo: TodoState) => void;
}

export interface TodoItemInterface {
  todo: TodoState;
  onDeleteTodo: (todo: TodoState) => void;
  onDoneTodo: (todo: TodoState) => void;
}

export interface TodosItemInterface {
  todos: TodoState[];
  onDeleteTodo: (todo: TodoState) => void;
  onDoneTodo: (todo: TodoState) => void;
}
```

Componente principal TodoApp.tsx

```tsx
import { useEffect, useReducer } from 'react';
import { todoReducer } from './todoReducer';
import { TodoList } from './components/TodoList';
import { TodoAdd } from './components/TodoAdd';
import { TodoState } from '../interfaces';

const initialState: TodoState[] = [
  // {
  //   id: new Date().getTime(), //esto genera numeros, pero normalmente no se tiene que hacer asi
  //   description: 'Recolectar la piedra del alma',
  //   done: false,
  // },
];

const init = () => {
  //el tercer argumento del reducer el valor inicial,
  return JSON.parse(localStorage.getItem('todos') || '[]');
  //le estoy pasando el arreglo de objetos que estan en el storage, todos los valores que tengan la clave todos, y con parse paso el string a json

  //le estoy diciendo que el valor inicial siempre sera lo que este en el localStorage entonces aunque se reinicie la pagina siempre se almacenara los que esten y pues si es vacio sera un string vacio
};

export const TodoApp = () => {
  //aqui le mandamos nuestro reducer y nuestro valor inicial
  const [todos, dispatch] = useReducer(todoReducer, initialState, init);
  //-todos son nuestras tareas nuestro arreglo, y dispatch es la funcion para cambiar ese estado o la que dispacha acciones al reducer
  //cuando tenemos mas de un reducer podemos ser mas especificos con el dispatch como dispatchTodo, pero como solo tenemos uno podemos dejarlo asi

  useEffect(() => {
    //esto es el local storage un lugar para guardar informacion del lado del cliente y esta informacion se queda solamente en el computador ya si queremos podemos enviarla a un api o lo que queramos pero es una forma de guardar informacion, pero solo sepuede guardar strings con el clave valor pero con string por eso lo pasamos con un stringfy
    localStorage.setItem('todos', JSON.stringify(todos));
    //usamos un useEffect porque necesitamos crear uno cuando los todos cambien
  }, [todos]);

  const onNewTodo = (todo: TodoState): void => {
    const action = {
      type: 'Add Todo',
      payload: todo,
    };

    dispatch(action); //el dispatch es la funcion que me ayuda a enviar esa accion
  };

  const onDeleteTodo = (todo: TodoState): void => {
    const action = {
      type: 'Delete Todo',
      payload: todo,
    };

    dispatch(action);
  };

  const onDoneTodo = (todo: TodoState) => {
    dispatch({
      //podemos mandar de una vez el objeto con el type y el payload en el dispatch
      type: 'Done Todo',
      payload: todo,
    });
  };

  return (
    <>
      <h1>
        TodoApp 12, <small>Pendientes.. 2</small>
      </h1>
      <hr />

      <div className='row'>
        <div className='col-7'>
          <TodoList
            todos={todos}
            onDeleteTodo={onDeleteTodo}
            onDoneTodo={onDoneTodo}
          />
        </div>
        <div className='col-5'>
          <h4>Agregar TODO</h4>
          <hr />
          <TodoAdd onNewTodo={onNewTodo} />
        </div>
      </div>
    </>
  );
};
```

TodoReducer.ts, nuestra funcion que maneja todas nuestras accione para nuestro reducer

```ts
import { TodoAction, TodoState } from '../interfaces';

export const todoReducer = (initialState: TodoState[], action: TodoAction) => {
  //interface complicado, siempre me complico pero en la interface solo tengo que poner la estructura del objeto y como es un arreglo de eso solo le especifico el arreglo aqui mismo
  switch (action.type) {
    case 'Add Todo':
      return [...initialState, action.payload]; //creamos un nuevo estado si es Add Todo y agregamoso el payload donde esta el nuevo todo

    case 'Delete Todo':
      //el filter devuelve un nuevo arreglo solo con los que cumplan con la condicion que pusimos en este caso me devuelve todos los que no tengan el mismo id que estamos mandando
      return initialState.filter((todo) => todo.id !== action.payload.id);

    case 'Done Todo':
      //con esto le digo que por cada tarea recorra cada uno y cuando el id sea igual al que nosotros estammos enviando retornara un nuevo objeto con todas las propiedades del todo solamente cambiando la que esta abajo en este caso seria lo contrario de done
      return initialState.map((todo) => {
        if (todo.id === action.payload.id) {
          return {
            ...todo,
            done: !todo.done,
          };
        }

        return todo;
      });

    default: //le digo que si no esta ni una de las acciones anteriores le devuelvo el initialState
      return initialState;
  }
};
```

TodoList.tsx

```tsx
import { TodosItemInterface } from '../../interfaces';
import { TodoItem } from './TodoItem';

export const TodoList = ({
  todos,
  onDeleteTodo,
  onDoneTodo,
}: TodosItemInterface) => {
  return (
    <ul className='list-group'>
      {todos.map((todo: any) => (
        <TodoItem
          key={todo.id}
          todo={todo}
          onDeleteTodo={onDeleteTodo}
          onDoneTodo={onDoneTodo}
        />
      ))}
    </ul>
  );
};
```

TodoItem.tsx

```tsx
import { TodoItemInterface } from '../../interfaces';

export const TodoItem = ({
  todo,
  onDeleteTodo,
  onDoneTodo,
}: TodoItemInterface) => {
  return (
    //usamos el ternario para decir que si es true pues solamente le ponemos la clase de tachado si no nada
    <li className='list-group-item d-flex justify-content-between'>
      <span
        className={`align-self-center ${
          todo.done === true ? 'text-decoration-line-through' : ''
        } `}
        onClick={() => {
          onDoneTodo(todo);
          //esta funcion esta desde el padre y la fuimos llamando por commponente por componente cuando ya la usamos hasta aqui recordar qeu solo es una funcion que llamamos o importamos entonces la pudemos usar como si estuviera en este archivo y ya sabemos que es lo que recibe y ya le enviamos eso y la funcion hace la logica
        }}
      >
        {todo.description}
      </span>
      <button
        className='btn btn-danger'
        onClick={() => {
          onDeleteTodo(todo);
        }}
      >
        Eliminar
      </button>
    </li>
  );
};
```

TodoAdd.tsx

```tsx
import { useForm } from '../../hooks';
import { OnNewTodo } from '../../interfaces';

export const TodoAdd = ({ onNewTodo }: OnNewTodo) => {
  const { description, onInputChanges, onResetForm } = useForm({
    //le debemos de mandar un valor inicial y ya podemos extraere las funciones y los argumentos
    id: 0,
    description: '',
    done: false,
  });

  //esta es mi solucion y funciona pero tambien se puede usar el customHook de useForm que creamos
  //   const todoInput = useRef<HTMLInputElement>(null); //con esto le digo que el useRef estar en un inputElement
  //   const handleSubmit = (event: any) => {
  //     event.preventDefault(); //esto es para que no se reinicie el navegador
  //     onNewTodo({
  //       id: new Date().getTime(),
  //       description: todoInput.current?.value,
  //       done: false,
  //     });
  //   };

  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault(); //esto es para que no se reinicie el navegador

    if (description.length <= 1) return; //si tiene 1 letra no se podra ejecutar

    onNewTodo({
      //al enviar el formulario creamos uno nuevo y sabemos que en description gracias a nuestro hook esta lo que escribimos
      id: new Date().getTime(),
      description: description,
      done: false,
    });
    onResetForm();
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type='text'
        placeholder='¿Qué hay que hacer?'
        className='form-control'
        name='description'
        onChange={onInputChanges}
        value={description}
      />
      {/*Gracias a la propiedad name puede funcionar nuestro hook y para que funcione tiene que ser el name igual a la propiedad qeu queremos cambiar*/}
      <button type='submit' className='btn btn-success mt-4'>
        Agregar formulario
      </button>
    </form>
  );
};
```

#### Con un custom Hook useTodo

Paso toda la logica a un cutomHook y ya solo obtengo en el padre lo que estoy retornando las funciones y los todos

```tsx
import { useEffect, useReducer } from 'react';
import { TodoState } from '../interfaces';
import { todoReducer } from '../08-useReducer/todoReducer';

const initialState: TodoState[] = [];

const init = () => {
  return JSON.parse(localStorage.getItem('todos') || '[]');
};

export const useTodo = () => {
  const [todos, dispatch] = useReducer(todoReducer, initialState, init);

  useEffect(() => {
    localStorage.setItem('todos', JSON.stringify(todos));
  }, [todos]);

  const onNewTodo = (todo: TodoState): void => {
    const action = {
      type: 'Add Todo',
      payload: todo,
    };

    dispatch(action);
  };

  const onDeleteTodo = (todo: TodoState): void => {
    const action = {
      type: 'Delete Todo',
      payload: todo,
    };

    dispatch(action);
  };

  const onDoneTodo = (todo: TodoState) => {
    dispatch({
      type: 'Done Todo',
      payload: todo,
    });
  };

  const todosCount = todos.length; //para saber cuantos todos tenemos
  const todosDone = todos.filter((todo) => todo.done === false).length; //para saber cuantas tenemos sin completar

  return {
    todos,
    todosCount,
    todosDone,
    onDeleteTodo,
    onNewTodo,
    onDoneTodo,
  };
};
```

## ReactRouter

Tenemos que instalarlo a nuestras dependencias y ya envolvemos nuestra aplicacion con el router

higher-order component (HOC), asi se le conoce a los componentes como el BrowserRouter ya que son componentes comunes pero estan solo para almacenar otros componentes

```tsx
import ReactDOM from 'react-dom/client';
import './index.css';

import { BrowserRouter } from 'react-router-dom';
//usamos el browserRouter porque estamos en un navegador pero ne react native es otro y asi con los demas framworks de js

import { MainApp } from './09-useContext/MainApp';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <BrowserRouter>
    {/* tenemos que envolver a toda nuestra app */}
    <MainApp />
  </BrowserRouter>
);
```

```tsx
import { Routes, Route, Navigate } from 'react-router-dom';
import { HomePage } from './HomePage';
import { AboutPage } from './AboutPage';
import { LoginPage } from './LoginPage';
import { Navbar } from './Navbar';

export const MainApp = () => {
  return (
    <>
      <Navbar />
      <hr />

      {/* podemos definir las rutas en cualquier lado pero normalmente se hacen en el padre  */}
      <Routes>
        <Route path='/' element={<HomePage />} />
        <Route path='/login' element={<LoginPage />} />
        <Route path='/about' element={<AboutPage />} />

        {/* <Route path='/*' element={<AboutPage />} /> */
        /*Asi tambien podemos enviarlos a una pagia por si no se encuentra ninguna pagina con lo que esta poniendo */}
        <Route path='/*' element={<Navigate to='/about' />} />
        {/* pero normalmente se hace esto con navigate porque antes con la solucion de arriba se quedaba en la direccion que hayamos puesto en la url pero esto nos ayuda a navegar directamente a esa url */}
      </Routes>
    </>
  );
};
```

```tsx
import { Link, NavLink } from 'react-router-dom';

export const Navbar = () => {
  return (
    <nav className='navbar navbar-expand-lg bg-body-tertiary rounded-3'>
      <div className='container-fluid'>
        {/* esto funciona como en next, primero si queremos  navegar a las diferentes paginas podriamos poner una etiqueta 'a' pero esa etiqueta hace un refresh y eso puede perjudicar entonces para eso se usa Link que nos ayuda a solo cambiar lo necesario sin refresh */}
        <Link className='navbar-brand' to='/'>
          useContext
        </Link>
        <div className='collapse navbar-collapse' id='navbarNav'>
          <ul className='navbar-nav'>
            {/* NavLink es un link especial para los navs, nos deja ponerle una clase especial si el componente esta activo, eso es lo que recibimos en las props de la clase si esta activo y si esta activo solamente le ponemos otra clase, todas las clases son de bootstrap */}
            {/* aunque no solo eso se usa cuando el link necesita reaccion basado en la ruta en la que se encuentre no solo le podemos dar clases si no escribir logica */}
            <NavLink
              to='/'
              className={({ isActive }) =>
                `nav-link ${isActive ? 'active' : ''}`
              }
            >
              Home
            </NavLink>
            <NavLink
              to='/login'
              className={({ isActive }) =>
                `nav-link ${isActive ? 'active' : ''}`
              }
            >
              Login
            </NavLink>
            <NavLink
              to='/about'
              className={({ isActive }) =>
                `nav-link ${isActive ? 'active' : ''}`
              }
            >
              About
            </NavLink>
          </ul>
        </div>
      </div>
    </nav>
  );
};
```

## useContext

Nos ayuda a que podamos compartir informacion entre componentes no solo en cascada si no en cualquier componente qeu queramos, 3 abajo o 2 arriba asi se podria compartir la informacion, entonces esta el `context` ahi es donde se guarda la informacion y ya no tenemos que enviar por propiedades

Un ejemplo donde podemos usar useContext es en el ejemplo anterior de router donde las paginas se tienen que conectar pero no estan adentro de una ni de otra para poder usar las props

Toda la extructura de componentes se podria decir que tambien es un concepto, el router nos crea componentes ya como el `Navigarion.Provider` cuando ponemos `Provider` queremos decir que proveemos algo

Normalmente se crea un directorio con el nombre `context`

Se crean dos archivos, recomendacion

Normalmente el provider y el context los ponen juntos pero es mejor que vayan separado

UserContext.tsx el nombre le podemos poner cualquiera pero mientras lleve el `Context` para saber que es un contexto

```tsx
import React, { createContext } from 'react';

interface UserContextInterface {
  amor: string;
  setAmor: React.Dispatch<React.SetStateAction<string>>; //con esto hacemos que acepte la funcion del useState
}
export const UserContext = createContext({} as UserContextInterface); //con el as le estoy diciendo que confie que lo que recibire sera de este tipo aunque no lo especifique
```

Y aparte esta el provider

```tsx
import { UserContext } from './UserContext';
import { useState } from 'react';

//como el provider son higher-order component (HOC) entonces siempre tiene que llevar sus children, aunque tambien puede tener otras props pero esas son las comunes
export const UserProvider = ({ children }: any) => {
  const [amor, setAmor] = useState('');

  return (
    //usamos nuestro userContext y le ponemos el provider y en value estara toda la informacion que cualquier hijo obtendra, ya despues solamente ponemos el componente lo mas alto que podamos o donde creamos que necesitaremos para que todos tengan la informacion
    //en value puedo poner funciones numero de todo
    <UserContext.Provider value={{ amor, setAmor }}>
      {children}
    </UserContext.Provider>
  );
};
```

Colocamos este componente donde queramos y donde encierre todos los hijos que queremos que obtenga los valores

Y ya aqui podemos obtener lo que provea el provider

```tsx
import { useContext } from 'react';
import { UserContext } from './context/UserContext';

export const LoginPage = () => {
  const { amor, setAmor } = useContext(UserContext); //tenemos que poner y usar el hook y ponemos nuestro contexto creado
  //siempre va en busca de arriba no para abajo, busca en sus padres no en los hijos
  console.log(amor); //y aqui ya podemos ver el value que tenemos en el provider

  return (
    <>
      <h1>LoginPage</h1>
      <hr />
      <h4>{amor}</h4>
      {/* //y ya podemos trabajar con esa informacion */}
      <button
        className='btn btn-primary'
        onClick={() => {
          setAmor('Macela'); //inlcuso podemos obtener funciones gracias al provider y poder establecer el valor del value desde aqui ya que es un useState y el estado es el que esta en el value
        }}
      >
        Establecer amor
      </button>
    </>
  );
};
```
