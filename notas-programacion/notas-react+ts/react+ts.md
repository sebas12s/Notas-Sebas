# React + TypeScript

## Crear una app con TypeScript
npx create-react-app "nombre" --template typescript

---

## Comencemos

```tsx
const incrementar = ( numero: number = 1 ):void => {
        setCounter(counter + numero);
    }
```
numero: number asi se le tienen que poner el tipo de dato que recibira, y despues de los parentesis que recibira en este caso nada

Tambien se le puede poner el valor por defecto

`numero: any` poniendo any le digo que recibire cualquier tipo de dato

```tsx
<button 
    onClick={ () => incrementar() } 
    className='btn btn-outline-primary mt-2'>
    +1
</button>

<button 
    onClick={ () => incrementar(2) }    
    className='btn btn-outline-primary mt-2'>
    +2
</button>

<button 
    onClick={ () => setCounter(0) }    
    className='btn btn-outline-danger mt-2'>
    Reset
</button>
```
Se pone esa funcion anonima para llamar a la funcion en onClick funcion por que si solo ponemos la funcion no funciona tenemos que poner esa funcion flecha

Las clases son de Bootstrap

## Ejemplo 
```tsx
interface User{     
    uid: string;
    name: string;
}

export const Usuario = () => {

    const [user, setUser] = useState<User>();

    const login = () => {
        setUser({
            uid: 'ABC123',
            name: 'Sebastian Perez'
        })
    }
    console.log(user)
  return (
    <div className='mt-5'>
        <h3>Usuario: useState</h3>

        <button 
            onClick={ login }
            className='btn btn-outline-primary' >
            login
        </button>

        <pre> { JSON.stringify( user ) } </pre>
    </div>
  )
}
```
### Interface
Son como los reglamentos que seguira un objeto en ts tambien se puede poner en otro archivo en este caso le estamos diciendo que esa interface tendra ese reglamento es obligatorio que todos los objetos tengan las dos propiedades con el tipo de valor

El valor de useState es por defecto `useState<undefined>()` por eso no acepta de primeras que cambiemos por un objeto pero cuando estan los signos '<>' esta diciendo que es de tipo generico, entonces le puedo decir que informacion o que tipo de dato tiene internamente entonces por eso le puse `useState<User>()` para decirle que tiene ese tipo de objeto entonces solo recibira ese tipo de objeto

Tambien se le puede poner un valor por defecto
```tsx
const [user, setUser] = useState<User>({
    uid: '',
    name: ''
});
```
Pero siempre respetando el modelo del objeto por la interface

Tambien podemos crear un objeto por aparte pero tambiene se tiene que respetar la interface
```tsx
const tempUser: User = {
    uid: '21212',
    name: 'Marcela Cruz'
}
```
Con los dos puntos le pongo el tipado para que sepa que sera ese tipo de objetos

---

## useEffect y useRef
Primero aqui pudimos ver que usamos una funcion propia de Js que es setInterval `let segundos = setInterval( funcion, 1000 )` es algo que hace una funcion al tiempo que le pongamos y se usa en milisegundos, para limpiar el intervalo o pararlo se usa `clearInterval(segundos)` 

### Type
Es el timpo de argumento que seran los que se mandan en una funcion 
```tsx
type TimerArgs = {
    milisegundos: number
}

const Timer = ( args: TimerArgs ) => {}
const Timer = ( { milisegundos }: TimerArgs ) => {}
```
Aqui estamos diciendo que el argumento milisegundos de args sera number

Tambien se puede hacer desestructurizado

Tambien puede pasar esto
```tsx
type TimerArgs = {
    milisegundos: number,
    segundos: number
}

<Timer milisegundos={} />
```
aqui me pedira que falta los segundos ya que lo pusimos en el tipo de los argumentos, pero se puede solucionar asi:
```tsx
type TimerArgs = {
    milisegundos: number,
    segundos?: number
}
```
con el signo estamos diciendo que puede ser opcional, es de tipo number o undefine

---

```tsx
setInterval(() => setSegundos(s => s + 1 ), 1000);

```
En este ejemplo el setInterval su funcion es la funcion para cambiar el estado cada segundo entonces creo otra funcion adentro y al agregar una propiedad por defecto le da el valor actual entonces le dio 0 siguiendo el ejemplo

El argumento de retorno del setInterval es `NodeJS.Timeout` este es el tipado se puede dar cuenta uno dejando el cursos en la funcion y despues de los dos puntos

```tsx
export const Timer = ( { milisegundos }: TimerArgs ) => {

    const [segundos, setSegundos] = useState(0);
    
    const ref = useRef<NodeJS.Timeout>()

    useEffect( () => {
      ref.current && clearInterval(ref.current)
      ref.current = setInterval(() => setSegundos(s => s + 1 ), milisegundos);
    }, [milisegundos])
    

  return (
    <>
        <h4>Timer: <small>{ segundos }</small></h4>
    </>
  )
}
```
expliquemos este ejemplo para que `ref,current` pueda resivir el valor de setInterval tiene de ser del tipo setInterval por eso se define asi 

El useEffect se ejecutara cada vez que cambie el parametro milisegundos este parametro se resive y puede ser 2000 o 1000 entonces por eso se decide cada 1 o 2 segundos

Y el ref lo que hace es que guarda esos cambios sin recargar

con esta linea `ref.current && clearInterval(ref.current)` es lo mismo que hacer lo siguiente:
```tsx
if(ref.current) {
    clearInterval(ref.current)
}
```
es decir que si existe se limpie el intervalo 

---

## useReducer

como sabemos que useReducer se tienen que hacer algunas cosas:

```tsx
const initialState = {
    contador: 0
}
```
Como el initialState y las acciones

```tsx
type ActionType = 
    | { type: 'incrementar' }
    | { type: 'decrementar' }
    | { type: 'custom', payload: number };
```
Esta es una manera wapa de hacerlo le estoy diciendo que el tipo puede ser eso o el otro o el otro y asi 

Despues sigue la constante donde se cambiara el state, aunque no se cambia no se sobreescribe simplemente se crea un nuevo
```tsx
const contadorReducer = ( state: typeof initialState, action: ActionType ) => {
    switch ( action.type ) {
        case 'incrementar':
            return {
                ...state,
                contador: state.contador + 1
            }
        case 'decrementar':
            return {
                ...state,   
                contador: state.contador - 1
            }
        case 'custom':
            return {
                ...state,
                contador: action.payload
            }
        default:
            return state;
    }
}
```
Con el typeof simplemente le estoy diciendo que sera del tipo de y como initialState es de tipo number de ese sera y action del tipo actionTypes

Tambien nunca se debe mutar el contador decir algo como `state.contador = state.contador + 1` "NO" por eso se ponen los 3 puntos crea una misma variable con el mismo valor pero no en el mismo lugar de memoria y ya solo le damos el nuevo valor de contador, siempre tiene que retornar el estado por eso en default si no llega ni uno de eso retorna el viejo estado

```tsx
export const ContadorRed = () => {

    const [ contadorState, dispatch] = useReducer(contadorReducer, initialState);

    return (
        <>
            <h2>Contador: { contadorState.contador }</h2> 
            <button className="btn btn-outline-primary"
                    onClick={ () => dispatch({ type: 'incrementar' }) }>
                +1
            </button>
            <button className="btn btn-outline-primary"
                    onClick={ () => dispatch({ type: 'decrementar' }) }>
                -1
            </button>

            <button className="btn btn-outline-danger"
                    onClick={ () => dispatch({ type: 'custom', payload: 100 }) }>
                100
            </button>
        </>
    ) 
}
```

Explico primero el useReducer, tambien tiene dos variables en el array, donde se guardara el nuevo estado y tambien la funcion que lo cambiara o en este caso la funcion que hara si hace algo o otra cosa, la accion

En la funcion useReducer esta el reducer donde esta la logica de que puede retornar el estado y en la otra esta el valor inicial ese valor nunca cambiara

Y por ultimo el payload es un valor que queremos que nos de o nosotros poner antes cuando creamos el componente este payload lo tenemos en la accion


## CustomHooks
Haremos un ejemplo con un formulario:
```tsx
const [formulario, setFormulario] = useState({
        email: '',
        nombre: ''
    });
```
Tenemos un useState que ayuda para que se actualice el formulario, como vemos aqui tambien se puede poner un objeto 

Esto es lo que retorna: 
```tsx
<form autoComplete='off'>
        <div className='mb-3'>
            <label className='form-label'>Email:</label>
            <input type='email' 
                    className='form-control'
                    name='email'
                    onChange={ (ev) => handleChange(ev) }/>
        </div>
        <div className='mb-3'>
            <label className='form-label'>Nombre:</label>
            <input type='text' 
                    className='form-control'
                    name='nombre'
                    onChange={ handleChange }/>
        </div>
        <pre>{ JSON.stringify(formulario) }</pre>
    </form>
```
Recordemos que no puede resivir un objeto como children entonces por eso se usa el `JSON.stringify`

El ev es un gran evento que se envia a la funcion 

en el onChange le ponemos una funcion, `(ev) => handleChange(ev)` y cuando resive algo esa funcion en este caso resive todo el evento y esa misma propiedad se tiene que enviar tambien se puede dejar solamente como esta en el segundo input: `onChange={ handleChange }` pero cual es esa funcion?? ->

```tsx
const handleChange = ( ev: ChangeEvent<HTMLInputElement> ) => {
    console.log(ev.target.name)
    console.log(ev.target.value)
}
```
este es el evento o lo que se resive en el hay que especificar de que tipo es primero como es un `onChange` donde lo llamamos se pone `ChangeEvent` pero solamente esto no deja ya que es del tipo generico se puede ver dejando el cursor y si aparece `<T>` es generico, ya que puede ser no solo un input tambien otras cosas por eso se pone la otra parte `<HTMLInputElement>` para especificar que es un input y ya poder agarrar el name y el valor

Tambien se puede hacer de la siguiente manera para desestructuralizar el evento:

```tsx
const handleChange = ( { target }: ChangeEvent<HTMLInputElement> ) => {
    const { name, value } = target;
}
```
asi desestructuro el evento y traigo el target y del target despues desestructuro tambien y guardo en esas variables los mismos valores con el mismo nombre del evento y ahi ya guarde el name y el valor que tienen en ese momento 

```tsx
setFormulario({
    ...formulario,
    [ name ]: value
})
```
Esta funcion lo que hace es que se cambie el valor del formulario

Se recomienda que se desestructure el valor actual del formulario y cambiamos el unicamente el valor que estamos cambiando que seria email y nombre que eso esta en la propiedad de target.name entonces por eso ponemos name que sera igual a el value

Okey pero esto no es custom hook esto es un ejemplo para hacer un custom cuando tenemos que estare repitiendo todo eso 

Para crear se crea una carpeta hook y para el archivo useForm o como queramos pero siempre use, y no son mas que una funcion que puede llevar otros hooks o lo que queramos

```tsx
export const useForm = ( initState: any ) => {
  const [formulario, setFormulario] = useState(initState);

  const handleChange = ({ target }: ChangeEvent<HTMLInputElement> ) => {
    const { name, value } = target;

    setFormulario({
        ...formulario,
        [ name ]: value
    })
  }

  return {
    formulario, 
    handleChange
  }
}
```
este seria el hook que creo como podemos ver resivimos el initState que en este caso seria el objeto que teniamos al comienzo por eso lo ponemos ahi en useState y muy importante estamos exportando el formulario y la funcion que nos hace cambiar el formulario

```tsx
const { formulario, handleChange } = useForm({
        email: '',
        nombre: ''
    })
```
Como regresamos un objeto lo ponemos asi y ya solo ponemos las mismas variables que regresamos en el hook

Quitemos ese any del hook eso no debe de ser asi, un ejemplo en el useState toma el dato que se le pone, si ponemos un numero se pone en tipo number si texto en string entonces lo mismo queremos hacer en nuestro hook para que sea el dato que le pongamos
```tsx
interface FormData {
    email: string;
    nombre: string;
    edad: number
}
```
hacemos una interface en el codigo para decirle de que tipo seran los datos que ingresaremos en el objeto
```tsx
const { formulario, handleChange } = useForm<FormData>({
    email: '',
    nombre: '',
    edad: 0
})
```
Y sabemos que para poner una interface la ponemos a la par

Para poner eso en nuestro hook se entiende mejor con una funcion normal
```tsx
export function useForm( initState: any )
```
Asi se veria
```tsx
export function useForm<T>( initState:T ) {
```
solo con poner la T asi le estoy diciendo que sera del tipo que especifique en mi codigo

y con las funciones flecha se pone asi
```tsx
export const useForm = <T extends Object>( initState: T ) => {
```
solamente que debemos de extenderlo a este caso un objeto por que resive un objeto 

## useContext

