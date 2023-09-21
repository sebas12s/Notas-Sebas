# React

## Componentes

Es una pieza de codigo encapsulada que puede tener un estado o no

## Instalacion vite

instalamos con vite y yarn

- `yarn create vite`
- `yarn` para crear las dependencias
- `yarn dev` para correr la aplicacion
- `yarn add prop-types` asi podemos instalar dependencias con yarn

## Importaciones

Cuando tengamos muchos importaciones entonces un ejemplo en componentes podemos poner un archivo index.js y ahi solamente hacer las importaciones de la siguiente manera

- `export * from ./componente` estoy diciendo que exporte todo lo que este en ese componente
  Y ya al importarlos solamente hacemos esto
- `import {componete1, componente2} from './carpeta'` y ya podemos obtener los componentes desde la carpeta

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
      <p>{mar2.name}</p>
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

## Despliegue

Hacemos un `yarn build o npm run build` ya que ese html tenemos que subir el de buil de produccion

La carpeta que crea `dist` esta la dejamos caer en netlify y ya sube nuestra app

Si lo quiero subir a github pages, se subi a un repositorio y todo eso y la carpeta de dist se pone docs

Despues en el repositorio vamos a settings>pages> seleccionamos la rama y despues la carpeta de docs, si salen erroes en el despliegue es porque esta apuntando mal en el index.html en los archivos de ccs y js entonces podemos arreglar eso

## Pruebas

Se tienen que hacer antes de pasar a produccion, si no hay tiempo tampoco hay que matarse para probar todo, si no hay tiempo prueben la ruta critica o principal de la aplicacion y asi con lo mas importante

- AAA
  - Arrenge - Arreglar
    - Preparamos el estado inicial
    - Inicializamos variables
    - Importaciones necesarias
  - Act - Actuar
    - Aplicamos acciones o estimulos
    - Llamar metodos
    - Simular clicks
  - Assert - Afirmar
    - Observar el comportamiento resultante
    - Son los resultados esperados

Se dividen en dos:

- Unitarias: enfocadas en pequeñas funcionalidades
- Integracion: enfocadas en como reaccionan varias piezas en conjunto


## .env
En react se crea el archivo de .env y se pueden crear asi 
```
REACT_APP_API_KEY_GIF=htt
```
Y se llaman
```
const apiKeyGif = process.env.REACT_APP_API_KEY_GIF
```
Ya la podemos asignar a una variable