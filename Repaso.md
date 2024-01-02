# Repaso, temas a reforzar

1. Funcion reduce de js:

```js
const totalToPay = productsInCart.reduce(
  (prev, current) => current.product.price * current.quantity + prev,
  0
);
```

1. Muchas promesas y como resolverlas al mismo tiempo:

```tsx
const fileUploadPromises = [];
fileUploadPromises.push(fileUpload(file));
// esta funcion nos devuelve la imagen ya subida en cloudinary le enviamos la imagen y esta la sube a ese servicio pero solo una
// estas son promesas como no hay un await simplemente regresa las promesas no la imagen, entonces simplemente almacenamos las promesas en el arreglo

// y con esta linea podemos ejecutar todas las promesas y nos devuelve el arreglo con lo que devolvia la promesa
const photosUrl = await Promise.all(fileUploadPromises);
```

3. Estudiar el for of y todos esos

4. Estudiar el cache de next

5. Una app del backend que tiene los metodos http se le llama: En una RESTful API

6. Estudiar los Objects y Arrays como funciones como :

```ts
Object.values(cart).forEach((value) => {
  items += value as number;
});
```

1.  con esto creo un array con adentro va la longitud, .fill nos ayuda a llenar ese espacio con lo que pongamos, y con el map recorro cada uno:

```tsx
Array(rating)
  .fill(0)
  .map((x, i) => <Star key={i} />);
```

## React

1. En un formulario de react a la funcion de onsubmit el `event.preventDefault` hace que no se recarge la app cuando se envie

2. Se pueden poner en un componente el hijo (children) y mas propiedades: `const WidgetItem = ({ children, title }) => {`

3. En las props de la funcion onChange, en el `targe.value` esta el valor del input

4. En un useState, en la funcion del set puedo obtener el state actual con un callback `setCategorias(cat => [...cat, 'Naruto'])` en cat esta mi state actual

5. Recordemos que cuando mandamos la referencia a una funcion asi: `onChange={onChangesEvent}` es lo mismo que hacer asi `onChange={e => onChangesEvent(e)}`

6. Tambien puedo recibir funciones como parametros en un compontente

7. `useRef` una forma de usar la referencia de algo :

```tsx
<input
  ref={inputFileRef} //para guardar la referencia
  type='file'
  multiple //este es para que deje seleccionar multiples imagenes
  onChange={onFileInputChange}
  style={{ display: 'none' }}
/>

// es como si el icono fuera el input cuando le damos click
<IconButton
  color='primary'
  disabled={isSaving}
  onClick={() => inputFileRef.current.click()}
  // como tenemos una referencia el punto current y simulamos el click de esa referencia al darle click
>
```

## JS

1. `.trim()` nos ayuda a eliminar los espacios en blanco de al comienzo y al final

2. `.includes()` con esto le digo que si incluye en una cadena de texto lo que le puse, pueden ser palabras o letras

3. Operador spread se puede utilizar tanto en objetos y en arreglo, aunque tambien en los argmentos de las funciones, sirve para esparcir

4. `.ToFixed()` es para poner decimales en js

5. Cuando ponemos un + a una variable que es un string pero es un numero eso lo convierte en numero `+cookieTab`

6. Con dos puntos podemos renombrar una variable cuando desestructuramos de un objeto `const { data: session } = useSession();`

7. El metodo `.join()` unira los elementos de un arreglo a un string unico y si queremos un separador en cada uno es lo que le ponemos adentro del parentesis

8. Cuando ponemos un signo de exclamacion en las propiedades de un objeto lo hago no nuleable, si o si tiene que venir `userId: session!.user!.id`

9. `.split()` nos ayuda a separar un string en un arreglo pero lo separo por lo que le ponga en el parentesis, como es un arreglo incluso esta sintaxis es permitida `name: email.split('@')[0]`

10. En js el isNaN es una funcion que nos devuelve true si no es un numero o no se puede convertir en uno `isNaN('m')` y false si es un numero

11. Cuando en un objeto ponemos en una clave y un valor del mismo nombre (el valor con una variable) podemos reducir el objeto `{name, love}` === `{name: name, love: love}`

12. `JSON.parse()` esto transforma un string a un objeto si tiene la forma de un objeto

13. `JSON.stringify()` esto convierte algo a un string

14. Tambien en las importaciones le podemos asignar algun alias a lo que importamos `import MiComponent as ComponentMar from '/..'`

15. Cuando importamos algo y hay muchas funciones o variables exportadas podemos hacer asi: `import * as todosApi from '@/..';` y todo estara en un alias que se llama todosApi y todas las funcines las podemos llamar como: todosApi.funcion y asi

16. Con el `arreglo.map((valor, index) => {})` sabemos que recorre uno por uno y el segundo argumento es el indice

17. Tambien podemos recorrer un objeto no solo `person.name` si no tambien `person['name']` en este caso hasta podemos pasar una variable `cookieCart[id]`

18. Para eliminar una propiedad de un objeto solamente ponemos el delete antes de que propiedad queremos `delete cookieCart[id];`

19. El doble signo `!!` convierte cualquier valor a su equivalencia en booleano, si es una cadena de texto `"mar"`, o `12`, o un objeto arreglo sera true, pero si es `0`, `""`, `null`, `undefined` eso sera falso, estos valores se les conocen como `truthy` y `falsy`

20. `truthy` y `falsy` son la representacion de cualquier valor en booleano como arriba dije, si es un numero o algo eso es un true pero si es null o undefined es false

21. `arreglo.filter((valor) => valor === 0)` esta funcion devuelve los valores que cumplan con la condicion

22. Como un ternario es un if else esto solo es un if, si se cumple se hace si no, no hace nada `{valor1 !== valor2 && 'No son iguales'}` &&

23. Se puede hacer mas de una desestructuracion `const { state: { logged } } = obj`

24. Para crear un formulario como los que se crean en postman se hace asi `const formData = new FormData();` para ingresar valores ver documentacion

25. Para hacer un error controlado `if (!uid) throw new Error('El UID del usuario no existe');`

26. Diferencias entre el `forEach` y el `.map` es que el forEach no devuelve un nuevo arreglo, pero el `.map` si

27. Si lo que devuelve es un array podemos desestructurarlo como lo hacemos con un objeto `const [funct, errorMenssage] = formValidations[formField];` y este formValidations[] es como decir formValidatios.name, pero como tenemos en una variable el valor lo hacemos con corchetes

28. Como podemos crear propiedades de objeto solo haciendo `obj.algo = 12` tambien con los corchetes `formCheckedValues['${formField}Valid']`

29. Tambien podemos acceder a alguna propiedad de un objeto con los corchetes:

```tsx
setFormState({
  ...formState,
  [event.target.name]: event.target.value,
});
```

30. La funcion `title.substring(0, 17)` nos ayuda a cortar un string, de donde a donde queremos

31. `++`

## Ts

1. una interface se puede crear asi: `(): { [id: string]: number } => {` aqui le digo que devolvera un objeto donde la clave sera un string y el valor number

2. Cuando le ponemos a algo el `as` le estamos diciendo al compilador que sera de ese tipo: `const nombre as string`

3. En una interface en react al poner, `React.ReactNode`, le digo que sera de `JSX.Element | JSX.Element[]`

## Next

1. Recordar que un server component solamente se ejecuta una vez al crearlo por que se crea en el servidor
