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