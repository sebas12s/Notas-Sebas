# Notas TypeScript

## Variables

```ts
const msg: string = "Marcela"; //Asi le ponemos tipos de datos a las variables
```

Recordar que ts no se puede mostrar en el navegador entonces tenemos que compilarlo a js

Se pone el siguiente comando en la carpeta donde estamos trabajando `tsc nombredelarchivo` y esto compila todo el ts a js y ya podemos usar ese

---

Algo importante es que en nuestra carpeta de archivos (asumiendo que no estemos usando ningun framework ) para inciar la configuracion json se usa el siguiente comando: `tsc --init` y esto crea el archivo de configuracion y para compilar el codigo de ts a js con esta configuracion ya podemos hacer solamente el comando: `tsc`

---

Funcion anonima para encapsular el codigo, dentro de parentesis la funcion de flecha y despues la llamamos

Funcion anonima autoinvocada

```ts
(() => {})();
```

---

Ts tiene un modo observador que este nos ayuda al estar activado en la terminal compila al isntante el comando es el siguiente: `tsc --watch` o `tsc -w`

## Configuracion tsconfig.json

- `"sourceMap": true` esta opcion crea un nuevo archivo pero nos ayuda que en los `console.log` por poner un ejemplo nos aparezca en que linea fue creado o se afecto pero con referencia en ts no como normalmente lo hace con js y no importa que estemos importando el archivo js
  - Algo importante es que esta opcion solo es para modo desarrollo no al subir a produccion
- `"removeComments": true,` esta opcion nos ayuda que cuando se pase el codigo a js no se pasen los comentarios, ya que cuando ts se compila a js se pasan tambien los comentarios
- Abajo de todo podemos excluir documentos para que no se traspile y esas cosas, de la siguiente manera

```json
  "exclude": [
    "object/*.ts",  //aqui estoy ignorando todos los archivos ts que esten adentro de object
    "node_modules"  //la carpeta node_modules y asi
  ],
  "include": [    //tambien podemos incluirlo
    "node_modules"
  ]
```

- `"outFile": "./main.js"` esto nos ayuda a crear todos los archivos de ts a compilarlos a un solo archivo de js, en este caso estara en la raiz y sera main, todos los archivos de ts se transpilan a js en este archivo, para evitar muchos archivos, aunque tuvimos que cambiar un par de cosas
  - `"module": "amd"` cambiamos esto a 'amd'
  - Y tambien hay que tener cuidado con el `include` ya que include solo compilara los archivos que esten especificados ahi y esto lo enviara todo a `main.js`

## Tipos de datos

[Documentacion](https://www.typescriptlang.org/docs/handbook/2/everyday-types.html)

### Number

```ts
const a = 10; //esto nos dice que es de tipo : 10, ahorita explico, despues de los dos puntos nos dice que tipo de dato y como es una constante sabe que el 10 no cambiara
const b: number = 10; //aunque igual ponle el tipo de dato

let avengers: number;

avengers = Number("hola"); // var Number: NumberConstructo (value?: any) => number
//el Number nos dice que resive cualquier cosa 'any' pero siempre devuele un number

console.log({ avengers }); // {avengers: NaN}       //en consola ponemos las llaves para que devuelva el valor de la siguiente manera con el nombre de la variable, NaN es un numero
```

### Boolean

```ts
let isLove: boolean = true;
let isLove: boolean = false;
```

### String

```ts
const name: string = "Marcela' "; //Marcela'      //para colocar signos que sean reservados ponemos '\' para escaparlos
const name2: string = '"Marcela"'; //"Marcela"     //asi igual al reves puedes poner comillas dentro de comillas pero no las mismas
const name3: string = `Marcela`;
console.log(`Mi novia ${name3}`); //Mi novia Marcela      //para concatenar

console.log(name[10].toUpperCase()); //asi podemos seleccionar la letra 11 del nombre y aqui le estoy diciendo que me pase esa letra a mayusculas, pero name[10] es undefined porque no tiene 11 letras

console.log(name[10]?.toUpperCase()); //le estoy diciendo que si tiene 11 caracateres ejecute el toUpper.. si no no hace nada
console.log(name[10].toUpperCase() || "no hay letra"); //e incluso le puedo decir que si lo que esta antes me da undefined haga lo que esta despues del o ||
```

### Any

```ts
let nombre: any = 123;
nombre = "Marcela"; //como es any le puedo poner cualquier tipo de dato
console.log((nombre as string).chartAt(0)); //ponerle un as le decimos aunque sea un tipo any aqui que sea tipo string y el chartAt es un metodo de los string
console.log(<string>nombre.chartAt(0)); //asi tambien se puede poner
```

### Arrays

```ts
const arr: (string | number | boolean)[] = [1, 2, 3, "mar", true]; //asi puedo poner si quiero que tenga muchos mas tipos un arreglo o de la manera simple:
const arr: number[] = [1, 2, 3];
```

### Tuples

```ts
const hero: [string, number] = ["Huld", 100]; //esto hace que siempre el primer valor sea string y el segundo sea numero, no puede almacenar un numero en la posicion 0 y asi
const hero2: [string, number, boolean] = ["Hulk", 200, true]; //tambien se pueden poner 2 3 4 y asi
```

### Enums

```ts
enum AudioLevel { //mayuscula las primeras letras
  min = 1,
  medium = 5,
  max = 10,
}
let audio: AudioLevel = AudioLevel.min; // 1

enum AudioLevel {
  //si no tenemos un valor definindo agarran un valor como los arreglos, 0, 1, 2,
  min,
  medium,
  max,
}
enum AudioLevel {
  min = 3,
  medium, //en este caso si no tiene este toma el numero siguiente entonces seria 4
  max = 10,
}
```

### Void

```ts
function callMe(): void {} //ahi le podemos poner el tipo de dato, en este caso void esto nos dice que no retornara nada, entonces no llevara la palabra return
const callMe = (): void => {}; //funcion flecha

//Never
const error = (): never => {
  //el tipo de dato never es que siempre tronara, siempre habra un error
  throw new Error("Error");
};
const error2 = (): never | number => {
  //tambien podemos poner si queremos que regrese algo o de error
  throw new Error("Error");
};
```

### Null y Undefined

null no es lo mismo que undefined

```ts
let si: undefined = undefined;
let si: number | undefined = undefined;
```

## Funciones

```ts
function returnName(): string {
  return "Marcela";
}

//esto devuelve una funcion que regresa un string
const activateBati = (): string => {
  return "Bati señal";
};

const fullName = (
  firstName: string,
  lastName?: string,
  upper: boolean = false
): string => {
  //asi los hago obligatorio y les especifico el tipo de dato y el dato de retorno
  //con el simbolo de interrogacion se ponen opcionales
  //upper asi se pueden poner valores por defecto simplemente despues del tipo
  return `${firstName} ${lastName}`;
};
//ya al llamarla se tienen que enviar obligatoriamente los dos tipos
```

```ts
const fullName = (firstName: string, ...restArgs: string[]): string => {
  // esto ayuda para que cuando manden mas argumentos todos se almacenen en restArgs como un arreglo
  return `${firstName} ${restArgs.join(" ")}`; //join sirve para convertir todo en un  string y lo que este adentro de los parentesis es para separador del mismo
};
const variable = fullName("Sebastian", "Cristopher", "Hola");
```

```ts
const addNumbers = (a: number, b: number): number => a + b;

// let myFunction;   //any no se tendria que poner asi
// let myFunction: Function;   //le digo que sera de tipo function
let myFunction: (m: number, x: number) => number; //si quiero ser mas especifico le puedo decir que es de tipo funcion que retorna un number, tambien le estoy poniendo que argumentos tendra del tipo

myFunction = addNumbers; //le asigne la funciono no le pongo los parentesis para no llamarla solo asignarla y no se crea una copia entonces se asigna el mismo espacio en memoria, entonces es por referencia
```

## Objetos

```ts
let flash = {
  name: "Sebas",
  age: 17,
  amor: ["Dios", "Marcela"],

  /**
 * al crear un objeto asi simple crea un type
 * asi
 * let flash: {
    name: string;
    age: number;
    amor: string[];
  }
 */
};

flash = {
  //ya al asignar obligatorio nos pone cosas asi
  name: "Marcela",
  age: 18,
  amor: ["Dios", "Sebastian"],
};
//para ponerle el tipo podemos hacerlo asi
let flash: {
  name: string;
  age?: number; //asi tambien lo pongo opcional
  amor: string[];
  getName?: () => string; //asi tambien se pueden poner para harcer funciones dentro de un objeto y su tipado
} = {
  name: "Sebas",
  age: 17,
  amor: ["Dios", "Marcela"],
};
flash = {
  name: "Marcela",
  age: 18,
  amor: ["Dios", "Sebastian"],
  getName() {
    return this.name; //simplemente le digo que retornare el name de aqui por eso this
  },
};
```

```ts
type Hero = {
  //asi podemos crear los tipos para las clases asi le podemos agregar este mismo tipo a muchas clases
  name: string; //se puede hacer con coma o con punto y coma
  age?: number;
  amor: string[];
  getName?: () => string;
};
let flash: Hero = {
  name: "Sebas",
  age: 17,
  amor: ["Dios", "Marcela"],
};

// let superLet: (number | string | Hero)
let superLet: number | string | Hero = "Sebas"; //asi le podemos poner diferentes tipos como string, number o incluso un type de la misma manera le podemos dar un valor por defecto

console.log(typeof superLet); //asi podemos saber de que tipo es lo que esta ahi
```

```ts
type Villan = {
  nombre: string;
  edad?: number;
  mutante: boolean;
};
//un arreglo de objeto Villan
const villanos: Villan[] = [
  {
    nombre: "Lex Luthor",
    edad: 54,
    mutante: false,
  },
  {
    nombre: "Erik Magnus Lehnsherr",
    edad: 49,
    mutante: true,
  },
  {
    nombre: "James Logan",
    edad: undefined,
    mutante: true,
  },
];
```

## ES6

Ya no se utiliza var

```ts
const hero = {
  a: 1,
  b: 3,
};
hero = {}; //no deja inicializar un objeto ya que es una constante pero si nos deja cambiar sus hijos
hero.a = 5;

const nombre = () => {}; //tambien funciona con las funciones,
nombre = () => {}; //esto tirara error ya que no se le puede asignar una nueva variable
```

### Desestructuracion

#### Objetos

```ts
type Animes = {
  primero: string;
  segundo: string;
  tercero: string;
  cuarto: string;
};

const animes = {
  primero: "One Piece",
  segundo: "Naruto",
  tercero: "Demon",
  cuarto: "Dragon Ball",
};
const { primero, tercero } = animes; //asi puedo desestructurar un objeto en esas nuevas variables tengo los valores de esas claves

const printAnime = ({ tercero, ...resto }: Animes) => {
  //al resivir una objeto tambien puedo desestructurar de una vezs, y en '...resto' esta todo lo demas que manden
  console.log(tercero);
  console.log(resto.segundo);
};
```

#### Arreglos

```ts
const animes: string[] = ["One Piece", "Naruto", "Dragon Ball"];

const [anime1, anime2, anime3] = animes; //asi podemos extreer, el nombre puede ser cualquiera
const [anime1, , anime3] = animes; //si queremos solo el uno y tres
const [, , anime3] = animes; //asi solamente obtenemos el tercero
```

#### For of

```ts
type Avenger = {
  name: string;
  weapon: string;
};

const ironman: Avenger = {
  name: "Ironman",
  weapon: "Armorsuit",
};

const captainAmerica: Avenger = {
  name: "Capitán América",
  weapon: "Escudo",
};

const thor: Avenger = {
  name: "Thor",
  weapon: "Mjolnir",
};

const avengers: Avenger[] = [ironman, captainAmerica, thor]; //como todos son del tipo Avenger entonces por eso es un arreglo de Avengers

for (const variable of avengers) {
  //el for of recorre un arreglo en este caso 'avengers' y almacena el primer cada valor en la variable y hace algo por cada uno
  console.log(variable);
}
```

#### Clases en JavaScript
```js
class Avenger {   //una clase en js 
  name, 
  power,
  constructor(name = "No name", power = 0) {    //recordar que el constructor es cuando llamamos un nuevo objeto, y lo que le enviamos es lo de los parentesis
    this.name = name;
    this.power = power;
  }
}

class FlyingAvenger extends Avenger {   //al extenderlo tenemos todas sus propiedades y constructores y eso
  flying,   //y ya le podemos agregar mas propiedades
  constructor(name, power) {
    super(name, power);   //al darle super estoy llamando al constructor padre del que estoy extendiendo
    this.flying = true;
  }
}

const hulk = new Avenger("Hulk", 9001);
const falcon = new FlyingAvenger("Falcon", 50);
```

## Clases en TypeScript
