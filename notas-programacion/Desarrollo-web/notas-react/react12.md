# React de 0 a experto

## Conceptos

- Babel: en js nos ayuda a la traduccion de codigo para que compile codigo moderno en los navegadores
  - React en el background utiliza babel, nos ayuda a usar las ultimas caracteristicas aceptadas de js y poderlo utilizar ese codigo incluso en navegadores web que todavia no lo soportan

## Codigo introduccion

```jsx
const divRoot = document.querySelector("#root"); //aqui guardo oel div que esta en el html con ese id
const h1tag = <h1>Marcela</h1>;

ReactDOM.render(h1tag, divRoot); //aqui le digo que renderice gracias a la libreria de ReactDOM el h1 en ese div
```

## Js moderno

## variables

No usar let, y recordar que pueden haber variables locales y globales en funciones o condicionales

```jsx
console.log(`hola ${variable}`)``; //template string, algo importante es que podemos hacer lo siguiente

console.log(`
hola
como estas?
`); //en diferentes lineas
```

## Objetos literales

```jsx
const amor = {
  //esto es un objeto literal
  nombre: "Marcela", //clave: valor
  edad: 17, //se recomienda que se use esa coma
  cosasLindas: {
    //tambien se puede poner objetos adentro, arreglos y asi
    carita: true,
    corazon: true,
  },
};

console.log(amor.nombre); //Marcela
// console.log({       //con esto estamos creando un objeto, que tiene una propiedad que se llama tambien amor y le asignamos el valor amor
//     amor :  amor
// })
// es lo mismo que hacer esto
console.log({ amor }); //ya que si es el mismo nombre asigna el valor
console.table(amor); //esto muestra una tablita cuando son objetos
```

Recordar que si asignamos de la siguiente manera se asigna el espacio en memoria entonces si cambio uno cambio los dos

```jsx
const amor2 = amor; //esto es como tener el mismo objeto en memoria pero con dos nombres
```

Asi que para solucionar esto existe el operador spret o algo asi

### Operador Spreet

```jsx
const amor2 = { ...amor }; //esto hace una copia del objeto en un nuevo espacio en memoria
```

## Arreglos

```jsx
const arreglo = new Array(100); //asi se puede crear un arreglo vacio, tambien se le pueden poner cuantas esposiciones tienen

arreglo.push(1); //si acemos esto tendremos 100 vacios y uno

const arreglo2 = [1, 2, 3, 4]; //asi se crearia un arreglo normalmente

let arreglo3 = arreglo2;
arreglo3.push(5); //lo mismo pasa como con los objetos, es el mismo espacio en memoria entonces afecta al arreglo 2 y 3

const arreglo4 = [...arreglo2, 5]; //con en operador spreed hacemos una copia entonces esto copia uno por uno entonces ya tenemos un arreglo con numeros del uno al 5

//una funcion adentro de un metodo se le conoce como colback
const arreglo5 = arreglo4.map(function (numero) {
  //la propiedad 'numero' resivira cada valor del arreglo y por cada valor hara lo que este adentro de la funcion y devolvera en este caso en un nuevo arreglo
  return numero * 2;
}); //recordar que esto crea un nuevo arreglo no afecta a los otros
```

## Funciones

```jsx
function saludar(propiedades) {} //asi se crearia una funcion

saludar("Hola"); //asi se llama

const saludar2 = function (propiedades) {}; //manera recomenada

const saludar3 = (propiedades) => {}; //funcion de flecha

const saludar4 = () => "hola mundo"; //si solo tenemos un return o retornamos una linea podemos solo colocarlo asi

//si queremos regresar un objeto solamente tenemos que ponerlo dentro de parentesis para decir que ese es el cuerpo de la funcion
const saludar5 = () => ({
  name: "Marcela",
  lastname: "Cruz",
});
```

## Desestructuracion

[Documentacion](https://developer.mozilla.org/es/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)

```jsx
const persona = {
  nombre: 'Marcela',
  edad: 18,
  novio: 'Sebastian',
}

const {nombre, edad} = persona;   //esto crea una variable nombre y le asigna solamente la propiedad de nombre, tambien se puede poner mas propiedades
const {nombre:nombrePersona} = persona;   //tambien se le puede dar otro nombre a la variable asi con dos puntos
```

Desestructuracion con una funcion:
```jsx
const retornar = ( persona ) => { //si sabemos que recibiremos un objeto podemos desestructurar de una vez
  const {nombre, edad} = persona;
  console.log(nombre, edad)
}

const retornar = ({nombre, edad}) => {    //asi de una vez lo desestructurizamos
  console.log(nombre, edad)
}

retornar(persona)
```
