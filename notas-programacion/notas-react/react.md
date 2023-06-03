# React

React es una biblioteca de javaScript o libreria, 
una biblioteca o libreria es un conjunto de implementaciones o subprogramas ,son como herramientas en las cuales podemos trabajar. 
Se pueden crear componentes reautilizables 



# Conceptos basicos de React

## Componentes
Parte de la interfaz del usuario que es independiente y reutilizable, son como en programacion estructurada, 
se pueden divir en dos categorias principales:
* Funcionales
* Clases
### Funcionales
Un componente funcional es como una funcion de javaScript pero retorna un elemento de react ejemplo:
```jsx
function Saludo(props) {        
    return <h1>Hola, {props.nombre}</h1>;                    
}
```
El nombre del componente de JSX debe de iniciar con letra mayuscula.
En este ejemplo el props es como un objeto entonces por eso podemos usar el punto y poder acceder a las propiedades.
Props = propediades = properties
los props solo pueden ser enviados de padre a hijo

Esta tipo de mezcla de html y js se le llama JSX

---

### Clases
Un componente de clase es como una clase pero retorna un elemento JSX,
se debe extender React.Component.

Tambien debe de tener el metodo render para retornar un elemento JSX

```jsx
class Saludo extends React.Component {  
    render() {       
        return <h1>hola, {this.props.nombre}</h1>;
    }
}
```
El React.Component le ponemos esto para tener todos los componenetes de react.

---

## Hooks
Es una funcion especial que te permite trabajar con estados en componentes funcionales.

### useState

Esto sirve para crear estados para nuestros componentes
```jsx
const [contar, setContar] = useState(0);
```
el primer parametro es para guardar el valor, y la segunda es una funcion para cambiarle ese valor, en este ejemplo el valor por defecto es 0 pero puede ser texto, objeto, binarios, otro componente realmente puede ser muchas cosas y entonces para cambiarlo solo le ponemos algo como esto: `setContar(contar + 1)` asi le podemos cambiar 

### useEffect

Este componente se ejecuta cuando tu componente ya a sido montado no se puede ejecutar antes
```jsx
const [contar, setContar] = useState(0);

useEffect(() => {

}, []);
```
lo que el useEffect ejecutara es lo que se encuentra en la funcion flecha
en los corchetes se pone la variable que queremos que cuando se cambie se vuelva a ejecutar esa funcion 

Normalmente lo usan con useState para que cuando se cambie la variable se ejecute la funcion 

### useRef
recordemos que con useState renderiza la pagina pero a veces queremos cambiar algo sin que renderice o cargue la pagina para eso es useRef

```jsx
const nombre = useRef('Sebastian'); 
```
asi simplemente se crea pero useRef lo que crea es un objeto y este objeto obtiene la propiedad current y ese es el valor actual para acceder a el seria asi `nombre.current` ese valor sera persistente no cambiara no se perdera entre cambios de estado 

Si cambiamos el valor como decia no se volvera a renderizar 

Otra manera de usar este hook, es para acceder a elementos del DOM:
```jsx
const divDOM = useRef();
<div ref={ divDOM }></div>
```
dentro de divDOM estoy guardando la ubicacion del div es como hacer un `document.getElementById('')` y ya ahi le podria agregar muchas cosas que quiera

### useReducer
Este hook se recomienda que se haga cuando ya se esta poniendo complejo tu estado, es una alternativa al hook de useState

Esta es una funcion pura, asi que esta devuelve un valor y este valor se considerara el estado de la aplicacion, no podemos crear useEffect adentro de esta funcion y tampoco podemos hacer peticion a una API

Un recordatorio las funciones se pueden poner de la siguiente manera:
```jsx
const sumar = () => setContador(contador + 1);
const restar = () => {
    setContador(contador - 1);
}
```

useReducer su sintaxis basica es la siguiente
```jsx
const [state, dispatch] = useReducer(reducer, initialState, init); 
```
el estate tiene que ser un objeto, la funcion que usaremos para cambiar el estado

despues esta la funcion useReducer resive 3 parametros:
* reducer: es una funcion normal afuera del componente

Aqui se pone la logica de las opciones 

```jsx
const reducer = (state, action) => {
    switch (action.type) {
        case 'INCREMENT':
            return { contador: state.contador + 1 }
        case 'DECREMENT':
            return { contador: state.contador - 1 }
        default:
            return state;
    }
}
```
esta resive dos parametros el estado anterior y un objeto que se llama action y esta funcion si o si retorna el estado

action tiene principalmente dos propiedades que son: el type y payloads 

normalmente se usa un swith

se recomienda que tengamos un objeto con todos los tipos que vamos a tener de la siguiente manera:
```jsx
const TYPES = {
    INCREMENT: 'INCREMENT',
    INCREMENT_5: 'INCREMENT_5',
    DECREMENT: 'DECREMENT',
    DECREMENT_5: 'DECREMENT_5',
    RESET: 'RESET'
}
```

* initialState: esto solo es el valor inicial pero tienen que retornar un objeto
```jsx
const initialState = { contador: 0 }
```
* init: se usa cuando queremos cambiarle el valor inicial al incio o cuando carga el componente se crea una funcion y se le cambia el valor:
```jsx
const init = (initialState) => {
    return {
        contador: initialState.contador + 100
    }
}
```
Recordermos que es un objeto asi que tiene que devolver un objeto y asi le cambie el valor inicial gracias a ese tercer parametro

ya en este ejemplo para cambiar el valor seria de la siguiente manera:
```jsx
const sumar = () => dispatch({ type:'INCREMENT' });
```
Donde se crea el `contador` es initialState ahi es donde creo el objeto que uso en todos los demas lugares, como en el state

Veamos este ejemplo mas completo:
```jsx
const initialState = { contador: 0 }

const TYPES = {
    INCREMENT: 'INCREMENT',
    INCREMENT_5: 'INCREMENT_5',
    DECREMENT: 'DECREMENT',
    DECREMENT_5: 'DECREMENT_5',
    RESET: 'RESET'
}

const reducer = (state, action) => {
    switch (action.type) {
        case TYPES.INCREMENT:
            return { contador: state.contador + 1 }
        case TYPES.DECREMENT:
            return { contador: state.contador - 1 }
        case TYPES.INCREMENT_5:
            return { contador: state.contador + action.payload }
        case TYPES.DECREMENT_5:
            return { contador: state.contador - action.payload }
        case TYPES.RESET:
            return initialState;
        default:
            return state;
    }
}

export const Contador = () => {
    
    const [state, dispatch] = useReducer(reducer, initialState)

    const sumar = () => dispatch({ type: TYPES.INCREMENT });
    const restar = () => dispatch({ type: TYPES.DECREMENT });
    const sumar_5 = () => dispatch({ type: TYPES.INCREMENT_5, payload: 5 });
    const restar_5 = () => dispatch({ type: TYPES.DECREMENT_5, payload: 5 });
    const reset = () => dispatch({ type: TYPES.RESET });

  return (
    <div style={{textAlign:'center'}}>
        <h2>Contador</h2>
        <nav>
            <button onClick={sumar}>+</button> 
            <button onClick={restar}>-</button>
            <button onClick={sumar_5}> +5</button> 
            <button onClick={restar_5}> -5</button>
            <button onClick={reset}>RESET</button>
        </nav>
        <h3>{ state.contador }</h3>

    </div>
  )
}
```
Aqui ya use el payload y esto es como el valor por defecto o cuando tenemos un valor por mandar se lo mandamos por el payload cuando queremos resivir un valor por ahi se lo mandamos   

#### Ya por ultimo la estrucuctura
Al nivel de components se crean dos carpetas los Reducers y las actions
En el action se ponen las types solamente 

En el archivo reducer, se pone las tres funciones el `initialState`, `init` y el `reducer` solamente ademas de solo poner reducer se pone en este caso `contadorReducer` como el nombre del archivo jsx `contadorinInitialState` yo sugiero usar camelCase y ya solo exportas pero no por defecto si no antes de la funciono y ya exportas lo que necesites

y ya en el archivo donde estan los dispatch solo se importan y se hacen cambio los nombres de las funciones

---

### Estados
son los estados que pueden tener los componentes de las paginas web.

# JSX JavaScriptXML
Extencion de react para la sintaxis de js ejemplo: 
```jsx
const elemento = <h1>Hola</h1>;
```
Para hacer esto nos ayuda jsx aunque es opcional si lo quisieramos hacer
en pocas palabras JSX es una combinacion de js y html

# Componentes 
## Elementos 
Los elementos son como los div, h1 y asi las cosas pequeñas entonces un componente esta hecho de elementos
con JSX podemos crear cualquier elemento de html.
Los elementos de html se representan con letras minusculas `<h1></h1>` 
pero los componentes siempre inician con una letra mayuscula `<Boton></Boton>`

## Atributos
Tambien se le pueden ingresar atributos a los elementos, pero algunos se escriben de forma distinta
ejemplo seria una clase en html `<h1 class=''></h1>` pero en Jsx `<h1 className=''></h1>` y esto es por que class es una palabra reservada en js.

## camelCase
Es importante el camelCase      cuando la primera es minuscula y las demas palabras son mayusculas
css acepta pero con camelCase ejemplo
* background-image - css
* backgroundImage - jsx

Ejemplo:
```jsx
const estiloDiv = {
    color: "red",
    backgroundColor: "black"
};
```
y ya este estilo lo podriamos implementar asi:
```jsx
<div style={estiloDiv}>Hola</div>
```
las llaves nos ayuda a decir que lo que esta adentro de las llaves es js como las variables por eso se ponen las llaves

```jsx
<div style={{color: "green"}}>Hola</div>
```
asi se puede asignar en linea,
dobles llaves las primeras llaves nos dice que estamos insertando js y los que estan adentro nos permiten definir un objeto directamente como que se crearamos el objeto.

# Insertar un componente
Se crea un html un div con un id root 
ahi sera nuestra raiz de todo lo que se creara
entonces un ejemplo para insertar un elemento seria el siguiente:
```jsx
const elemento = <h1>Hello world</h1>;
```
Despues en el html:
```jsx
import ReactDOM from "react-dom";       
ReactDOM.render(        
    elemento,             
    document.getElementById("root")     
)
```
El import ReactDOM es como una variable donde guardaremos el paquete.
El ReactDOM lo tenemos que importar antes

Este ReactDOM.render simplemente recibe argumentos como toda funcion.

* El primer argumento es el elemento que queremos insertar
* El segundo es donde lo queremos insertar

---

## Reglas
En react si o si debemos incluir la barra al final cuando no tienen etiquete de cierre ejemplo: `<img />`

Tambien se puede incluir js en JSX 
{}  la señal seria estas llaves siempre lleva js
ejemplo:
```jsx
let palabra = "HOLA";
<p>{palabra} como estas</p>
```
entonces le estamos diciendo que lleva codigo js no solo variables si no tambien todo el codigo de js.

# Como se crea?
Ejecutamos lo siguiente:

npx create-react-app "nombre de la carpeta donde se creara" 

Si no queremos crear una carpeta nueva remplazamos el nombre de la carpeta por un . 

Asi se crea un archivo de react desde la terminal, esto descarga y crea todo lo necesario para crear archivos de react 
## Correrlo
Ejecutamos lo siguiente: 

npm start

---

En todas las carpetas creadas la mas importante es la de src, 
donde estan todos los archivos que contengan codigo fuente  

Recordar que los componentes son piezas de codigos como en POO seria como una clase

Es comun agregar una carpeta para los componentes dentro de src 

Las extenciones pueden ser js o jsx

El estandar para js de identacion es 2
se puede ir eliminando todos los archivos que no usamos en la carpeta que react nos creo

Normalmente se pone una hoja de estilos para cada componente

---

