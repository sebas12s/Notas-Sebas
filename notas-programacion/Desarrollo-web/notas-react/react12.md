# JavaScript Moderno

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

### Objetos

```jsx
const persona = {
  nombre: "Marcela",
  edad: 18,
  novio: "Sebastian",
};

const { nombre, edad } = persona; //esto crea una variable nombre y le asigna solamente la propiedad de nombre, tambien se puede poner mas propiedades
const { nombre: nombrePersona } = persona; //tambien se le puede dar otro nombre a la variable asi con dos puntos
```

Desestructuracion con una funcion:

```jsx
const retornar = (persona) => {
  //si sabemos que recibiremos un objeto podemos desestructurar de una vez
  const { nombre, edad } = persona;
  console.log(nombre, edad);
};

const retornar = ({ nombre, edad = 12 }) => {
  //asi de una vez lo desestructurizamos, y le podemos poner tambien un valor por defecto por si no esta esa propiedad
  return {
    nombreClave: nombre,
    edad: edad,
    ltlng: {
      lt: 12,
      lng: 11,
    },
  };
};

const {
  nombreClave,
  edad,
  ltlng: { lt, lng },
} = retornar(persona); //si queremos desestructurar un objeto dentro de un objeto podemos ponerlo asi, ponemos la propiedad o el nombre del objeto y despues le decimos que tipo constantes queremos
```

### Arreglos

```jsx
const personajes = ["Hinata", "Boa", "Mikasa"];

const [p1, p2, p3] = personajes; //en corchetes para desestructurar

const [, , p3] = personajes; //si quermos solo el tercero podemos poner solamente comas e ignora esa posicion

const use = (valor) => {
  return [
    valor,
    () => {
      console.log("Marcela");
    },
  ];
};

const arr = use("Hinata");

arr[1](); //asi se llamaria normalmente la funcion que esta en el arreglo algo extraño, estoy llamando ese valor y estoy ejecutando la funcion con los parentesis

const [nombre, setNombre] = use("Hinata");
setNombre(); //y asi se desestructura la funcion simplemente
```

## Import and Export

Al exportar solamente asi tenemos que hacer la llamada entre llaves porque tenemos que especificar que estamos importando, pero si en el otro archivo lo exportamos por defecto `export default` ya al importar podemos ponerle cualquier nombre que queramos `import holamarcela from './'` esto toma el por defecto y lo agrega a holamarcela \

Si tenemos exportaciones individuales en el mismo archivo si los ponemos entre llaves `import heroes, {habilidades} from './//'`

Tambien se puede exportar todo abajo en un mismo export de la siguiente manera

```jsx
export {
  heroes as default, //y asi tambien le ponemos el por defecto a una exportacion
  habilidades,
};
```

```jsx
import { heroes } from ".//"; //asi podriamos obtener algo hayamos exportado, desestructurado

const getHerores = (id) => {
  return heroes.find((heroe) => heroe.id == id); //el find resive una funcion como argumento, cuando es asi se le conoce como callback, esto devuelve si se cumple la condicion regresa un true entonces solamente retorna el heroe que haya sido un true
};

const getHerores2 = (owner) => {
  return heroes.filter((heroe) => heroe.owner == owner); //si mas de uno cumple la condicion devuelve todos esos
};
```

## Promesas

Las promesas son asincronas primero se ejecuta el codigo sincrono y despues lo asincrono o despues las promesas

```jsx
const promesa = new Promise((resolve, reject) => {
  //esto resive un callback, y este resive dos argumentos
  //resolve es otro callback que se ejecutara cuando la promesa sea existosa
  //reject se ejecuta cuando la promesa falla

  setTimeout(() => {
    //esto nos permite ejecutar algo cada medida de tiempo
    resolve(argumentos); //despues de dos segundos se ejecuta esto, entonces como se ejecuto bien se lansa el then de abajo
    //tambien se le puede enviar argumentos
    reject("Error"); //esto es lo que se envia cuando hay un error
  }, 2000); //el segundo argumento es la cantidad de milisegundos que quermos esperar
});

// promesa.then()    //ejecuta esto cuando se ejecuto bien todo
// promesa.catch()   //cuando no se ejecuto bien
// promesa.finally() //y este es cuando se ejecute cualquiera de los otros dos se ejecutar este de ultimo

promesa
  .then((argumento) => {
    //aqui podemos obtener el argumento del resolve
    console.log("Marcela");
  })
  .catch((err) => cosole.warn(err)); //y aqui resiviriamos el reject
```

Ejemplo con un argumento:

```jsx
const getHero = (id) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const p1 = getHeroById(id); //aqui obtengo un heroe segun el id que me manden
      if (p1) {
        //le digo que si esta devuelva el heroe
        resolve(p1);
      } else {
        //si no esta que mande el error
        reject("No existe el heroe");
      }
    }, 2000);
  });
};

getHero(3)
  .then(console.log)
  // .catch(err => console.warn(err))
  .catch(console.warn); //cuando le queremos mandar el argumento a la funcion como la linea de arriba podeoms obviar todo eso y solo poner la funcion que queremos retornar
```

## Fetch

Usaremos una api de giphy donde usaremos una key

```jsx
// Mi api key
const key =
  "https://api.giphy.com/v1/gifs/random?api_key=zrwRtI3KoIDCHhx0G8IkzxHc7YY7gEAx";

const res = fetch(`https://api.giphy.com/v1/gifs/random?api_key=${key}`)
  .then((res) => res.json()) //esto es una peticion en cadena, se ejecuta el primer then esto devuelve una promesa y despues se ejecuta el otro
  // .then(data => {
  //   const img = data.data.images.original.url
  .then(({ data }) => {
    const { url } = data.images.original; //asi tambien se podria hacer las dos lineas de arriba
  });
```

## Async y Await

```jsx
//para manejar los errores aqui se usan el try catch

const getImage = async () => {
  try {
    const key =
      "https://api.giphy.com/v1/gifs/random?api_key=zrwRtI3KoIDCHhx0G8IkzxHc7YY7gEAx";
    const res = await fetch(
      `https://api.giphy.com/v1/gifs/random?api_key=${key}`
    ); //lo que hace es que espera a que la promesa se cumpla antes de ejecutar la linea de abajo entonces lo podemos hacer como si fueran sincrono
    const data = await res.json();
  } catch (error) {
    console.error(error);
  }

  //este ejemplo es el mismo de arriba pero usan async y await, siempre que usemos await tiene que ser usado en await
};
```

## Operador Ternario

```jsx
const activo = true;

const mesaje = activo ? "Activo" : "Inactivo"; //le digo que si activo es true el mensaje sera el primero si no, se pone la condicion despues de los dos puntos
//si solo queremos que se ejecute la condicion de verdadero
const mensaje2 = activo && "Activo"; //esto ayuda para que solamente se ejecute la condicion de if y no la de else porque el de arriba no funciona si no hay algo despues de los dos puntos
```

# React

## Componentes
Es una pieza de codigo encapsulada que puede tener un estado o no

## Instalacion vite

instalamos con vite y yarn
* `yarn create vite`
* `yarn`  para crear las dependencias
* `yarn dev` para correr la aplicacion