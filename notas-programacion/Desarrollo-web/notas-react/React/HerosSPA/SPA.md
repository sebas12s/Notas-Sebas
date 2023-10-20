# App de heros Single Page Application (SPA)

## Estructura de directorios

- `public`: donde ponemos las imagenes y eso
- `src`: todo el codigo
  - Esta app se dividia en dos partes, la autenticacion y la parte de heroes, entonces creamos dos directorios para divir eso
  - `auth`: directorio de las pantallas principales de autenticacion
    - `components`: sus componentes de esta pantalla
    - `hooks`: sus hooks de esta pantalla
    - `pages`: los componentes que ocupan por completo la pantalla por eso pages
  - `heroes`: directorio de las pantallas principales heroes
    - `components`: sus componentes de esta pantalla
    - `data`: la data que usamos en estas pantallas, como nombres, titulos etc
    - `helpers`: funciones que nos ayudaban a traer la data de diferente manera
    - `hooks`: sus hooks de esta pantalla
    - `pages`: los componentes que ocupan por completo la pantalla por eso pages
    - `routes`: las rutas especiales para esta parte heroes
  - `hooks`: hooks globales que se pueden usar en cualquier lado
  - `interfaces`: las interfaces usadas en el codigo
  - `router`: router principal en este ejemplo tiene el route del login y el router por aparte de los heroes
  - `ui`: directorio especial para la interface de usuario
    - `components`: sus componentes de esta pantalla, en este caso el navbar especial de la ui de la pagina
    - `hooks`: sus hooks de esta pantalla
  - `HeroesApp.tsx`: archivo padre
  - `main.tsx`: archivo que engloba toda la aplicacion

## codigo

### main.tsx

```tsx
import React from 'react';
import ReactDOM from 'react-dom/client';

import { BrowserRouter } from 'react-router-dom';

import { HeroesApp } from './HeroesApp';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    {/* Envolvemos en BrowserRouter por que estamos en una pagina web para que funcione nuestras rutas en la app */}
    <BrowserRouter>
      <HeroesApp />
    </BrowserRouter>
  </React.StrictMode>
);
```

### HeroesApp.tsx

```tsx
import { AppRouter } from './router/AppRouter';

export const HeroesApp = () => {
  return (
    <>
      {/* simplemente en nuestro padre ponemos nuestro router principal */}
      <AppRouter />
    </>
  );
};
```

### AppRouter.tsx

```tsx
import { Routes, Route } from 'react-router-dom';
import { LoginPages } from '../auth/pages';
import { HeroesRoutes } from '../Heroes';
// las importaciones para todos hicimos archivos de barril para que se nos sea mas facil

export const AppRouter = () => {
  return (
    <>
      {/* para comenzar con nuestras rutas lo envolvemos en routes y vamos poniendo nuestras rutas y el elemento en este caso el componente que queremos que nos envie a el  */}
      <Routes>
        <Route path='login' element={<LoginPages />} />
        <Route path='/*' element={<HeroesRoutes />} />
        {/* el asterisco le digo que me envie a HeroesRoutes si en la url nos envian a cualquier lado, el asterisco es cualquier cosa */}
      </Routes>
    </>
  );
};
```

#### LoginPages

```tsx
import { useNavigate } from 'react-router-dom';
export const LoginPages = () => {
  const navigate = useNavigate(); //este hook nos ayuda a la navegacion de la libreria

  const onLogin = () => {
    // usando la funcion que creamos con el hook el primer argumento es a donde queremos irnos y el segundo un objeto donde, remplace nos dice que remplazara la pagina, entonces no nos envia a otra si no la remplaza, asi que ya no podmeos volver a la pagina que estabamos
    navigate('/marvel', {
      replace: true,
    });
  };

  return (
    // un simple componente con un onClick
    <div className='container mt-5'>
      <h1>Login</h1>
      <hr />

      <button className='btn btn-info' onClick={onLogin}>
        Login
      </button>
    </div>
  );
};
```

#### HeroesRoutes

```tsx
import { DcPages, HeroPages, MarvelPage, SearchPages } from '../';
import { Navbar } from '../../ui';
import { Routes, Route, Navigate } from 'react-router-dom';

export const HeroesRoutes = () => {
  return (
    // nuestro segundo raouter el que es solo para la parte de heroes
    <>
      <Navbar />
      {/* aqui si usamos el navbar */}
      <div className='container'>
        <Routes>
          {/* y como en el anterior las rutas */}
          <Route path='marvel' element={<MarvelPage />} />
          <Route path='dc' element={<DcPages />} />
          <Route path='search' element={<SearchPages />} />
          <Route path='hero/:id' element={<HeroPages />} />
          {/* estos ':id' es un id para poder obtener este dato de la url, todo lo que este despues de hero/ sera el id */}

          <Route path='/' element={<Navigate to='/marvel' />} />
          {/* pagina principal */}
        </Routes>
      </div>
    </>
  );
};
```

##### Navbar.tsx

```tsx
import { Link, NavLink, useNavigate } from 'react-router-dom';

export const Navbar = () => {
  //este es un hook que nos da ya react-router-dom para ayudarnos con la navegacion
  const navigate = useNavigate();

  const onLogout = () => {
    navigate('/login', {
      replace: true, //lo que pasa con el replace es que no me deje ir a la pagina anterior con las flechitas de arriba del navegador ya que no estamos yendo a otra si no remplazando la pagina por esa entonces no hay otra pagina a la cual volver
    });
  };
  return (
    <nav className='navbar navbar-expand-sm navbar-dark bg-dark p-3'>
      {/* son como etiquetas a pero que nos da react-router-dom, y en to solamente ponemos a donde queremos ir  */}
      <Link className='navbar-brand' to='/'>
        Asociaciones
      </Link>

      <div className='navbar-collapse'>
        <div className='navbar-nav'>
          {/* este componente es especial para el nav ya que nos devuelve unas propiedades que nos pueden ayudar como este isActive esto nos devuelve true si estamos parados en esa pagina por eso le puse clases especiales */}
          <NavLink
            className={({ isActive }) => {
              return isActive
                ? 'nav-item nav-link active'
                : 'nav-item nav-link';
            }}
            to='/marvel'
          >
            Marvel
          </NavLink>

          <NavLink
            className={({ isActive }) => {
              return isActive
                ? 'nav-item nav-link active'
                : 'nav-item nav-link';
            }}
            to='/dc'
          >
            DC
          </NavLink>

          <NavLink
            className={({ isActive }) => {
              return isActive
                ? 'nav-item nav-link active'
                : 'nav-item nav-link';
            }}
            to='/search'
          >
            Search
          </NavLink>
        </div>
      </div>

      <div className='navbar-collapse collapse w-100 order-3 dual-collapse2 d-flex justify-content-end'>
        <ul className='navbar-nav ml-auto'>
          <span className='nav-item nav-link text-info'>Mar</span>

          {/* aqui solamente usamos otra vez el navigation para ir a otra pagina */}
          <button className='nav-item nav-link btn' onClick={onLogout}>
            Loguot
          </button>
        </ul>
      </div>
    </nav>
  );
};
```

##### MarvelPage.tsx

```tsx
import { HeroList } from '../components';

export const MarvelPage = () => {
  return (
    <>
      <h1>Marvel</h1>
      <hr />
      {/* un componente especial que me ayuda a listar listar los heroes dependiendo su publisher por eso lo envio */}
      <HeroList publisher='Marvel Comics' />
    </>
  );
};
```

###### HeroList.tsx

```tsx
import { HeroCard } from '.';
import { getHeroesByPublisher } from '../helpers';
import { useMemo } from 'react';

export const HeroList = ({ publisher }: { publisher: string }) => {
  // aqui usamos el useMemo para memorizar los datos que me devuelve la funcion getHeroesBy... esto lo hacemos por si algun padre de la este componente se cargue no se tenga que volver a llamar la peticion a la data
  const listHeroes = useMemo(
    // esto devuelve un array
    () => getHeroesByPublisher(publisher), //esta funcion solo devuelve los que tengan el publisher enviado
    [publisher] //le digo que solo se volvera a redibujar cuando publisher se cambie
  );

  return (
    <div className='row rows-cols-1 row-cols-md-3 g-3'>
      {listHeroes.map((heroe) => (
        // y por cada heroe que este en la lista haremos una card
        <HeroCard key={heroe.id} {...heroe} />
        // con el operador spreed le digo que le enviare todas las propiedades de heroe
      ))}
    </div>
  );
};
```

###### getHeroesByPublisher.ts

```ts
import { heroes } from '../data/data';

export const getHeroesByPublisher = (publisher: string) => {
  // recibo el publisher y hago un arreglo con los dos publisher validos para validar si viene uno que no es de un error
  const validPublisher = ['DC Comics', 'Marvel Comics'];
  if (!validPublisher.includes(publisher)) {
    // aqui le digo que si mi arreglo no incluye el publisher que recibo tire un error
    throw new Error(`${publisher} invalid`);
  }

  //y ya solamente retorno todos los heroes que tengan el mismo publisher del que enviaron
  return heroes.filter((heroe) => heroe.publisher === publisher);
};
```

###### HeroCard.tsx

```tsx
import { Link } from 'react-router-dom';
import { HeroCardInterface } from '../../interfaces';

export const HeroCard = ({
  id,
  superhero,
  publisher,
  alter_ego,
  first_appearance,
  characters,
}: HeroCardInterface) => {
  const heroImgUrl = `/public/heroes/${id}.jpg`; //gracias a como guardamos las imagenes de forma especial por eso ponemos traer cada imagen ya que tienen el id y por eso la almacenamos asi

  return (
    // aqui solamente creamos una tarjeta ayudandonos con clases de bootstrap y animaciones especiales de Animate.css, para usar primero importarlas o poner el link en el html
    <div className='col animate__animated animate__fadeIn'>
      <div className='card'>
        <div className='row no-gutters'>
          <div className='col-4'>
            <img src={heroImgUrl} className='card-img' alt={superhero} />
          </div>
          <div className='col-8'>
            <div className='car-body'>
              <h5 className='car-title'>{superhero}</h5>
              <p className='card-text'>{alter_ego}</p>
              {alter_ego !== characters && <p>{characters}</p>}

              <p className='card-text'>
                <small className='text-muted'>{first_appearance}</small>
              </p>

              <Link to={`/hero/${id}`}>MoreInfo</Link>
              {/* recordemos que tenemos una ruta donde hero/ despues del '/' recibe todo como id entonces aqui le estoy diciendo que al precionar este link me enviara a esa ruta con el id en la url */}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
```

##### DcPages.tsx

```tsx
import { HeroList } from '../components';

export const DcPages = () => {
  return (
    <>
      <h1>DC Comics</h1>
      <hr />
      {/* Se repite lo mismo pero le enviamos el publisher DC para que me traiga de la data solo los de DC Comics */}
      <HeroList publisher='DC Comics' />
    </>
  );
};
```

##### SearchPages.tsx

```tsx
import React from 'react';

import { useLocation, useNavigate } from 'react-router-dom';
import queryString from 'query-string';

import { useForm } from '../../hooks/useForm';
import { HeroCard } from '../components';
import { getHerosByName } from '../helpers';

export const SearchPages = () => {
  // usamos dos hooks de react-router, el navigation que ya conocemos y el locatioon
  const navigate = useNavigate();
  const location = useLocation();
  //useLocation, nos da informacion de la url como desde donde estamos y el search que esta es una propiedad que nos devuelve todos las variables o todo lo que hayamos puesto despues la url en este ejemplo ponemos un query= a lo que escribimos en input
  const { q } = (queryString.parse(location.search) as { q: string }) || ''; // aqui le digo que lo que nos devuelvve queryString... sera un string por eso el 'as' pero si no viene nada es null o undefined sera una cadena vacia
  //queryString es otra libreria que de la url nos manda separada las variables que enviemos como un objeto por eso desestrucuturamos de una vez la q que enviamos mas abajo
  const heroes = getHerosByName(q); //esta funcion nos devuelve un arreglo de heroes que incluyan en su nombre lo este en la variable del query que es lo que escribimos

  //estos booleanos nos ayudan para mostrar o ocultar partes, si la query.length es 0 es porque no hemos escrito nada esto es true
  const showSearch = q?.length === 0;
  // y aqui primero pregunto si q hay valores o si es true hay valores, entonces pregunto si q.length es mayor a 0 en otras palabras si ya escribi algo, y si heroes.lenght, mi arreglo de heroes este en 0 esto sera true
  const showError = q && q?.length > 0 && heroes.length === 0;

  // usamos nuestro hook de formulario para controlar si cambiamos algo en el inputCHanges y en searchText esta lo que escribimos
  const { searchText, onInputChanges } = useForm({
    //mas informacion del este hook en la carpeta de notas React hooks
    searchText: q, //le digo que como valor iniciar el texto sera lo que tengamos en el query de busqueda en la url lo que hayamos escrito en el input
  });

  const onSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault(); //al enviar el formulario para que no se recargue

    //y hago una navegacion como no le pongo el / entonces nos envia a donde estamos parados, con esa variable por eso el '?' y lo que pusimos en el input
    navigate(`?q=${searchText}`);
  };

  return (
    <>
      <h1>Search</h1>
      <hr />

      <div className='row'>
        <div className='col-5'>
          <h4>Searching</h4>
          <hr />
          <form onSubmit={onSubmit}>
            <input
              type='text'
              placeholder='Search a hero'
              className='form-control'
              name='searchText'
              autoComplete='off'
              value={searchText}
              onChange={onInputChanges}
            />
            <button className='btn btn-outline-info mt-1'>Search</button>
          </form>
        </div>

        <div className='col-7'>
          <h4>Results</h4>
          <hr />
          {/* esta es una forma algo complicada para hacer las validaciones de booleanos que teniamos arriba para saber cuando mostrar y cuando no mostrar estas partes */}

          {/* {q?.length === 0 ? (
            <div className='alert alert-info animate__animated animate__fadeIn'>
              Search a hero
            </div>
          ) : (
            heroes.length === 0 && (
              <div className='alert alert-danger animate__animated animate__fadeIn'>
                There's no results {q}
              </div>
            )
          )} */}

          {/* con display none desaparece entonces hacemos la validacion de arriba si showSearch es true entonces se tiene que mostrar pero si es false se esconde igual con la de abajo */}
          <div
            className='alert alert-info animate__animated animate__fadeIn'
            style={{ display: showSearch ? '' : 'none' }}
          >
            Search a hero
          </div>

          <div
            className='alert alert-danger animate__animated animate__fadeIn'
            style={{ display: showError ? '' : 'none' }}
          >
            There's no results {q}
          </div>

          {/* mostramos los heroes devueltos */}
          {heroes.map((hero) => (
            <HeroCard key={hero.id} {...hero} />
          ))}
        </div>
      </div>
    </>
  );
};
```

###### getHerosByName.ts

```ts
import { heroes } from '../data/data';

export const getHerosByName = (name: string) => {
  //al query que recibimos de la url lo pasamos a minusculas y le quitamos los espacios al principio y al final
  name.toLowerCase().trim();

  if (name.length === 0) return []; //si no tiene ninguna letra pues solamente retornamos un arreglo vasio

  //y aqui retornamos gracias al filter solo los heroes que en minusculas (porque arriba los pusimos en minusculas tambien) incluyan en su nombre lo que enviamos en la query del url
  return heroes.filter((hero) => hero.superhero.toLowerCase().includes(name));
};
```

##### HerosPages.tsx

```tsx
import { useMemo } from 'react';

import { Navigate, useNavigate, useParams } from 'react-router-dom';
import { getHeroById } from '../helpers';

export const HeroPages = () => {
  const { id } = (useParams() as { id: '' }) || ''; //le digo que id sera un string que confie por eso el as o si no viene algun valor sera un string vacio
  //desestrucuturamos el id de la url que nos devuelve
  //useParams tambien nos da informacion sobre la url en este caso nos devuelve toda la url y el id que pusimos en el router despues de /:id, id es el nombre podemos poner cualquier otro
  const navigate = useNavigate();

  const hero = useMemo(() => getHeroById(id), [id]); //aqui solamente nos devuelve un heroe dependiendo del id que pongamos en la url

  const onNavigateBack = () => {
    // hero?.publisher === 'DC Comics' ? navigate('/dc') : navigate('/marvel');
    navigate(-1); //si le damos en ese boton nos devuelve a una pagina atras
  };

  if (!hero) {
    //le digo que si no hay un heroe me devuelva al home
    return <Navigate to={'/marvel'} />;
  }

  return (
    //y aqui solammente creo una tarjeta con la informacion del heroe con bootstrap y animation.css
    <div className='row mt-5'>
      <div className='col-4'>
        <img
          src={`/public/heroes/${id}.jpg`}
          alt={hero.superhero}
          className='img-thumbnail animate__animated animate__fadeInLeft'
        />
      </div>
      <div className='col-8'>
        <h3>{hero.superhero}</h3>
        <ul className='list-group list-group-flush'>
          <li className='list-group-item'>
            <b>Alter ego:</b> {hero.alter_ego}
          </li>
          <li className='list-group-item'>
            <b>Publisher:</b> {hero.publisher}
          </li>
          <li className='list-group-item'>
            <b>First appearence:</b> {hero.first_appearance}
          </li>
        </ul>
        <h5 className='mt-3'>Characters</h5>
        <p>{hero.characters}</p>

        <button className='btn btn-outline-success' onClick={onNavigateBack}>
          Back
        </button>
      </div>
    </div>
  );
};
```

###### getHeroById.ts

```ts
import { heroes } from '../data/data';

export const getHeroById = (id: string) => {
  //devuelvo el heroe por eso el find para buscar uno con el id que tenga el que recibimos
  return heroes.find((hero) => hero.id === id);
};
```
