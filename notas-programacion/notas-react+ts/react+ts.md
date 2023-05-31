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

