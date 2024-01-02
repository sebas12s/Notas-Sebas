# App Gif

- [App Gif](#app-gif)

Creamos primero la funcionalidad de agregar con un input nuevos objetos a un arreglo el codigo es el siguiente:

contenedor padre:

```jsx
const GifExpertApp = () => {
  const [categorias, setCategorias] = useState(['One Piece', 'Dragon Ball']);

  // const addCategory = () => {    ya no usaremos esto
  // setCategorias([...categorias, 'Naruto'])   //asi puedo agregar un nuevo elemento a un arreglo con useState
  // setCategorias(cat => [...cat, 'Naruto'])   //es lo mismo que arriba pero aqui en cat se almacena todo lo que tenga la variable anteriormente y entonces creo una copia con `...cat` y le agrego uno nuevo, con un callback
  // }

  return (
    <>
      <h1>Marcela Gif</h1>
      <AddCategory setCategorias={setCategorias} /> {/*Aqui estoy enviando la funcion, tambien se puede enviar funciones */}
      {/* <button onClick={addCategory}>    ya no usaremos esta funcions
        Click
      </button> */}
      <ol>
        {categorias.map((categoria, index) => {
          //el segundo argumento es el numero de lo ingresado 0 1 2 y asi
          return <li key={index}>{categoria}</li>;
        })}
      </ol>
    </>
  );
};
```

AddCategory:

```jsx
export const AddCategory = ({ setCategorias }) => {
  const [inputValue, setInputValue] = useState('Marcela');
  const onChangesEvent = ({ target }) => {
    //aqui de una vez desestrocturo el target
    setInputValue(target.value);
  };

  const onSubmitEvent = (event) => {
    event.preventDefault(); //esto evita que se haga un refresh en el navegador

    if (inputValue.trim().length <= 1) return;
    //recordar un par de cosas, trim nos ayuda a eliminar los espacio de enfrente y de al final
    //.length nos dice cuantas letras tiene y si son pocas o no hay retorna la funcion, entonces no actualiza el arreglo

    setCategorias((cat) => [inputValue.trim(), ...cat]);
    setInputValue(''); //esto para que el input value se limpie, ya que ese valor tenemos en el input
  };

  return (
    <form onSubmit={onSubmitEvent}>
      {/*Gracias al form al simplemente darle enter ya envia el formulario, sin necesidad de de un boton */}
      <input
        // onChange={event => onChangesEvent(event)}
        onChange={onChangesEvent} //es lo mismo que lo de arriba
        type='text'
        placeholder='Buscar Gifs'
        value={inputValue}
      />
    </form>
  );
};
```

Otra manera de hacerlo

```jsx
const GifExpertApp = () => {
  const [categorias, setCategorias] = useState(['One Piece', 'Dragon Ball']);

  const onAddCategory = (newCategory) => {
    //aqui resivo el valor enviado por el hijo,

    if (categorias.includes(newCategory)) return; //con esta linea le estoy diciendo que si el arreglo de categorias incluye la nueva no la agregue

    setCategorias([newCategory, ...categorias]); //y agrego el nuevo valor al arreglo del State
  };

  return (
    <>
      <h1>Marcela Gif</h1>
      <AddCategory
        // setCategorias={setCategorias}
        onNewCategory={onAddCategory} //esta es otra manera de hacerlo le enviamos la funcion aqui simplemente estamos enviando la referencia para que lo tome el hijo
      />
      <ol>
        {categorias.map((categoria) => {
          //no hay que user el index ya que si se elimina igual estara el indice y no queremos eso
          return <li key={categoria}>{categoria}</li>;
        })}
      </ol>
    </>
  );
};
```

```jsx
export const AddCategory = ({ onNewCategory }) => {
  const [inputValue, setInputValue] = useState('Marcela');
  const onChangesEvent = ({ target }) => {
    setInputValue(target.value);
  };

  const onSubmitEvent = (event) => {
    event.preventDefault();

    if (inputValue.trim().length <= 1) return;

    // setCategorias((cat) => [inputValue.trim(), ...cat]);
    onNewCategory(inputValue.trim()); //aqui solamente envio el valor del input a la funcion que resivi como parametro
    setInputValue('');
  };

  return (
    <form onSubmit={onSubmitEvent}>
      <input
        onChange={onChangesEvent}
        type='text'
        placeholder='Buscar Gifs'
        value={inputValue}
      />
    </form>
  );
};
```

Peticion

```js
//ya solo cuando quiera hacer la peticion le envio un string y hace la peticion y me envia un objeto con la informacion qu equiero
export const getGifs = async (category) => {
  //aqui solamente resivo la categoria y es la que pongo en el url
  const url = `https://api.giphy.com/v1/gifs/search?api_key=SK8MOO4ueUail50JcDK0iRfdRFWvLPc2&q=${category}&limit=10`;
  //en postaman nos da mucha faacilidad para poner el key y los otros argumentos que me pedia
  //despues solo copie la url que habia creado y aqui la puse con el hhtps://

  const res = await fetch(url); //aqui hacemos la peticion normalmente
  const { data } = await res.json(); //desestructuramos de una vez la data y esto es un arreglo

  const gifs = data.map((img) => ({
    //para cada valor que tenga el arreglo de data hago un objeto en gifs
    id: img.id,
    title: img.title,
    url: img.images.downsized_medium.url,
  })); //esto me devuelve un arreglo por cada valor que tenga data solamente con la informacion que necesito
  return gifs;
};
```

```jsx
export const GigGrid = ({ category }) => {
  const [images, setImages] = useState([]);

  const getImages = async () => {
    const newImages = await getGifs(category);
    setImages(newImages);
  };

  // useEffect(() => {    //asi estabamos ya enviando las categorias a la api, pero ahora tendremos un estado para las categorias que le enviamos
  //   getGifs(category);
  // }, []);   //como sabemos que el useEffect se ejecuta cuando nosotros le digamos en ese arreglo, si esta vacio solamente le digo que se ejecutara el codigo de en medio cuando se cree el componente, solamente

  useEffect(() => {
    getImages();
  }, []);

  return (
    <>
      <h3>{category}</h3>
      <div className='card-grid'>
        {
          // images.map((img) => (  tambien se puede desestructurara
          //   <li key={img.id}>{img.title}</li>
          // ))

          images.map((img) => (
            <GifItem
              key={img.id}
              {...img} //con esto envio todasss las propiedades que tenga img, ya las puedo resivir normal en el otro componente
            />
          ))
        }
      </div>
    </>
  );
};
```

```jsx
//este es el gifitem
export const GifItem = ({ title, url }) => {
  return (
    <div className='card'>
      <img src={url} alt={title} />
      <p>{title}</p>
    </div>
  );
};
```

Para GigGrid haremos un hook para la peticion y eso

Un hook simplemente es una funcion que regresa algo

```jsx
export const GifGrid = ({ category }) => {
  const { images, isLoading } = useFetchGifs(category);

  return (
    <>
      <h3>{category}</h3>
      {isLoading && <h2>Cargando...</h2>} {/* estoy diciendo que si isLoading es true me muestre la carga si no, no muestra nada  */}
      <div className='card-grid'>
        {images.map((img) => (
          <GifItem key={img.id} {...img} />
        ))}
      </div>
    </>
  );
};
```

Nuetro hook, simplemente tiene la logica y envia lo que queriamos

```js
export const useFetchGifs = (category) => {
  const [images, setImages] = useState([]);
  const [isLoading, setIsLoading] = useState(true); //esto es para que cuando no esten las imagenes sea true

  const getImages = async () => {
    const newImages = await getGifs(category);
    setImages(newImages);
    setIsLoading(false); //y ya que cargaron las images le ponemos false
  };

  useEffect(() => {
    getImages();
  }, []);

  return {
    images: images,
    isLoading: isLoading,
  };
};
```
