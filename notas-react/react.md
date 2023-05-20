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