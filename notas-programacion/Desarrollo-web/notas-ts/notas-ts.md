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
let si: (number | undefined) = undefined;
```