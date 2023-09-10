# React

## Componentes

Es una pieza de codigo encapsulada que puede tener un estado o no

## Instalacion vite

instalamos con vite y yarn

- `yarn create vite`
- `yarn` para crear las dependencias
- `yarn dev` para correr la aplicacion
- `yarn add prop-types` asi podemos instalar dependencias con yarn

## Codigo

Primer hola mundo, lo minimo que tiene que llevar una aplicacion de react

```jsx
import React from "react";
import ReactDOM from "react-dom/client";

const App = () => {
  return <h1>Marcela</h1>;
};

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```

### Fragmento

Cuando queramos mandar mas de dos etiquetas en un componente, se puede usar el fragmento, esto nos ayuda para no crear ese div y que pueda afectar nuestra aplicacion con estilo y eso

```jsx
export const FirstLove = () => {
  return (
    <>
      {" "}
      {/*Este es el fragmento esto no crea un div ni nada solo ayuda a agrupar*/}
      <h1>Marcela</h1>
      <h2>Linda</h2>
    </>
  );
};
```

Mostrar variables

```jsx
const mar = [1, 2, 3, 4, 5];
const mar2 = {
  love: "Sebas",
  name: "Marcela",
};
export const FirstLove = () => {
  return (
    <>
      <h1>Marcela</h1>
      <p>{mar}</p> {/*en las llaves se puede colocar codigo de js, y se puede renderisar arreglos pero no objetos */}
      <p>{mar2.name}</p>{" "}
      {/*Asi si se puede poner un elemento del objeto pero no todo el objeto */}
      <p>{JSON.stringify(mar2)}</p> {/*Asi se puede colocar el objeto */}
    </>
  );
};
```

### Propiedades

```jsx
export const FirstLove = (props) => {
  //aqui podemos obtener propiedades
  return <div>{props.name}</div>;
};
```

```jsx
<FirstLove name='Marcela'/>     {/*y asi se envian las propiedades, tienen que tener el mismo nombre del que las pongamos*/}

<Counter value={1} />       //asi se envia un numero

```

```jsx
export const FirstLove = ({ name = "Sebas" }) => {
  //aunque es mas normal desestructurarlo de una vez y poner solo el nombre, igual se envia como el nombre, tambien le podemos agregar por defecto algo a las propiedades
  return <div>{name}</div>;
};
```

Para volver obligatorias las propiedades se usa una dependencia de `prop-types`

```jsx
//de esta manera, se pone el nombre del componente despues esa propiedad y un objeto con el nombre de las propiedades y despues lo que importamos y despues el tipo de dato y si es requerido
FirstLove.propTypes = {
  name: PropTypes.string.isRequired,
};
//asi tambien podemos definir algo por defecto a las props
FirstLove.defaultProps = {
  name: "Sebas",
};
```

### Eventos

[Documentacion](https://es.legacy.reactjs.org/docs/events.html)

## Hooks

### useState

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
