# JournalApp

- [JournalApp](#journalapp)
  - [src](#src)
    - [assets](#assets)
    - [auth](#auth)
      - [layout](#layout)
        - [AuthLayout.jsx](#authlayoutjsx)
      - [pages](#pages)
        - [LoginPages.jsx](#loginpagesjsx)
        - [RegisterPage.jsx](#registerpagejsx)
      - [routes](#routes)
        - [AuthRoutes.jsx](#authroutesjsx)
    - [firebase](#firebase)
      - [config.js](#configjs)
      - [providers.js](#providersjs)
    - [helpers](#helpers)
      - [fileUpload.js](#fileuploadjs)
      - [loadNotes.js](#loadnotesjs)
    - [hooks](#hooks)
      - [useCheckAuth.js](#usecheckauthjs)
      - [useForm.js](#useformjs)
    - [journal](#journal)
      - [components](#components)
        - [ImageGallery.jsx](#imagegalleryjsx)
        - [Navbar.jsx](#navbarjsx)
        - [SideBar.jsx](#sidebarjsx)
        - [SideBarItem.jsx](#sidebaritemjsx)
      - [layout](#layout-1)
        - [JournalLayout.jsx](#journallayoutjsx)
      - [pages](#pages-1)
        - [JournalPage.jsx](#journalpagejsx)
      - [routes](#routes-1)
        - [JournalRoutes.jsx](#journalroutesjsx)
      - [views](#views)
        - [NoteView.jsx](#noteviewjsx)
        - [NothingSelectedView.jsx](#nothingselectedviewjsx)
    - [router](#router)
      - [AppRouter.jsx](#approuterjsx)
    - [store](#store)
      - [auth](#auth-1)
        - [authSlice.js](#authslicejs)
        - [thunks.js](#thunksjs)
      - [journal](#journal-1)
        - [journalSlice.js](#journalslicejs)
        - [thunks.js](#thunksjs-1)
      - [store.js](#storejs)
    - [theme](#theme)
      - [AppTheme.jsx](#appthemejsx)
      - [purpleTheme.js](#purplethemejs)
    - [ui](#ui)
      - [componentes](#componentes)
        - [CheckingAuth.jsx](#checkingauthjsx)
    - [JournalApp.jsx](#journalappjsx)
    - [main.jsx](#mainjsx)

## src

!No puse los archivos de barril

### assets

Imagenes, docs etc.

### auth

Todo lo relacionado con la autenticacion

#### layout

Como un tipo cascaron que puedo reutilizar en otros lados

##### AuthLayout.jsx

```jsx
import { Grid, Typography } from '@mui/material';

export const AuthLayout = ({ children, title }) => {
  // nuestro cascaron donde tendremos las pantallas de auth
  return (
    //el grid es como un div pero con varios atributos que nos pueden llegar a servir
    <Grid
      container //le digo que se comporte como un contenedor
      spacing={0}
      direction='column' //este es como el display flex
      alignItems='center'
      justifyContent='center'
      sx={{ minHeight: '100vh', backgroundColor: 'primary.main', padding: 4 }} //sx es como el atributo styles para poner cualquier estilo pero nos ayuda a reconocer el color del theme que colocamos
    >
      <Grid
        item //y los items del container
        className='box-shadow' //tambien con materia ui se pueden poner clases normales
        xs={3}
        sx={{
          backgroundColor: 'white',
          padding: 3,
          borderRadius: 2,
          width: { sm: 450 },
        }}
      >
        <Typography variant='h5' sx={{ mb: 1 }}>
          {title}
        </Typography>

        {children}
      </Grid>
    </Grid>
  );
};
```

#### pages

Paginas que ocupan la pagina completa

##### LoginPages.jsx

```jsx
import { useDispatch, useSelector } from 'react-redux';
import { Google } from '@mui/icons-material';
import { Link as RouterLink } from 'react-router-dom';
import {
  Grid,
  Typography,
  TextField,
  Button,
  Link,
  Alert,
} from '@mui/material';
import { AuthLayout } from '../layout/AuthLayout';
import { useForm } from '../../hooks';
import {
  startGoogleSingIn,
  startLoginWithEmailPassword,
} from '../../store/auth';
import { useMemo } from 'react';

const formData = {
  email: '',
  password: '',
  displayName: '',
};

export const LoginPages = () => {
  const { status, errorMessage } = useSelector((state) => state.auth);
  // para obtener mis estados en redux y para dispachar nuestras acciones
  const dispath = useDispatch();

  const { email, password, onInputChanges } = useForm(formData); // propio de mi hook para controlar los form

  const isAuthenticating = useMemo(() => status === 'checking', [status]);
  // esto devuelve true si el status es ckecking y se memoriza cada vez que el status cambia

  const onSubmit = (event) => {
    event.preventDefault();

    // al enviar el formulario hacemos login con este thunks
    dispath(startLoginWithEmailPassword({ email, password }));
  };

  const onGoogleSingIn = () => {
    // si le damos click a este boton pues hacemos la funcion del popup para iniciar sesion
    dispath(startGoogleSingIn());
  };

  return (
    <AuthLayout title='Login'>
      <form
        onSubmit={onSubmit}
        className='animate__animated animate__fadeIn animate__faster'
      >
        <Grid container>
          <Grid item xs={12} sx={{ mt: 2 }}>
            <TextField //un input ya modificado
              label='Correo' //el titulo del input
              type='email' //su tipo
              placeholder='correo@google.com'
              fullWidth //full del ancho
              name='email'
              value={email}
              onChange={onInputChanges}
            ></TextField>
          </Grid>

          <Grid item xs={12} sx={{ mt: 2 }}>
            <TextField
              label='Contraseña'
              type='password'
              placeholder='Contraseña'
              fullWidth
              name='password'
              value={password}
              onChange={onInputChanges}
            ></TextField>
          </Grid>

          <Grid container spacing={2} sx={{ mb: 2, mt: 1 }}>
            <Grid item xs={12} display={!!errorMessage ? '' : 'none'}>
              <Alert severity='error'>{errorMessage}</Alert>
            </Grid>

            <Grid item xs={12} sm={6}>
              {/* el xs es para pantallas pequeñas y el sm para  */}
              <Button
                disabled={isAuthenticating}
                type='submit'
                variant='contained'
                fullWidth
              >
                Login
              </Button>
            </Grid>
            <Grid item xs={12} sm={6}>
              <Button
                disabled={isAuthenticating}
                onClick={onGoogleSingIn}
                variant='contained'
                fullWidth
              >
                <Google />
                <Typography sx={{ ml: 1 }}>Google</Typography>
              </Button>
            </Grid>
          </Grid>

          <Grid container direction='row' justifyContent='end'>
            <Link to='/auth/register' color='inherit' component={RouterLink}>
              {/* esto es muy interesante en component le digo que se comporte como el Link de react router dom para que funcione este link de material asi ya le podemos poner el to y las funcionalidades del react router dom */}
              Crear una cuenta
            </Link>
          </Grid>
        </Grid>
      </form>
    </AuthLayout>
  );
};
```

##### RegisterPage.jsx

```jsx
import { Link as RouterLink } from 'react-router-dom';
import {
  Grid,
  TextField,
  Button,
  Link,
  Typography,
  Alert,
} from '@mui/material';
import { AuthLayout } from '../layout/AuthLayout';
import { useForm } from '../../hooks';
import { useMemo, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { startCreatingUserWithEmailPassword } from '../../store/auth';

const formData = {
  email: '',
  password: '',
  displayName: '',
};

const formValidations = {
  //un objetoo personalizado que la primera posicioon es la validacion y el segundo el mensaje de error
  // esto se la enviamos a nuestro customHook y ahi se encarga el
  email: [(value) => value.includes('@'), 'El correo debe de contener una @'],
  password: [
    (value) => value.length >= 6,
    'La contraseña debe de tener mas de 6 caracteres',
  ],
  displayName: [(value) => value.length >= 1, 'El nombre es obligatorio'],
};

export const RegisterPage = () => {
  const dispatch = useDispatch();
  // aunque usemos redux tambine podemos usar useState
  const [formSubmitted, setFormSubmitted] = useState(false);

  const { status, errorMessage } = useSelector((state) => state.auth);
  // de igual manera para obtener nuestro state y para memorizar si es checking los usamos para desabilitar los botones
  const isCheckingAuthentication = useMemo(
    () => status === 'checking',
    [status]
  );

  // nuestro custom hoook
  const {
    displayName,
    email,
    password,
    onInputChanges,
    formState,
    isFormValid,
    displayNameValid,
    emailValid,
    passwordValid,
  } = useForm(formData, formValidations);

  const onSubmit = (event) => {
    event.preventDefault();
    setFormSubmitted(true); //para unas validaciones si ya se envio el formulario

    if (!isFormValid) return; //si no es valido el formulario no creamos el usuario con nuestra accion esto si es valido lo obtenemos del custom hoook
    dispatch(startCreatingUserWithEmailPassword(formState));
  };

  return (
    <AuthLayout title='Register'>
      <form
        onSubmit={onSubmit}
        className='animate__animated animate__fadeIn animate__faster'
      >
        <Grid container>
          <Grid item xs={12} sx={{ mt: 2 }}>
            <TextField
              label='Nombre Completo'
              type='text'
              placeholder='Mar'
              fullWidth
              name='displayName'
              value={displayName}
              onChange={onInputChanges}
              error={!!displayNameValid && formSubmitted}
              // un signo es false y dos signos es true, entonces pregunto si displayNameValid === true return true eso estoy haciendo jasj si no es true retorna false y que formSubmitted este en true
              //esto tambien funciona por que displayNameValid tambien puede tener texto, entonces si tiene texto sera true igual
              helperText={displayNameValid} // aqui solo le digo que si tiene valor sea ese
            ></TextField>
          </Grid>
          <Grid item xs={12} sx={{ mt: 2 }}>
            <TextField
              label='Correo'
              type='email'
              placeholder='correo@google.com'
              fullWidth
              name='email'
              value={email}
              onChange={onInputChanges}
              error={!!emailValid && formSubmitted}
              helperText={emailValid}
            ></TextField>
          </Grid>

          <Grid item xs={12} sx={{ mt: 2 }}>
            <TextField
              label='Contraseña'
              type='password'
              placeholder='Contraseña'
              fullWidth
              name='password'
              value={password}
              onChange={onInputChanges}
              error={!!passwordValid && formSubmitted}
              helperText={passwordValid}
            ></TextField>
          </Grid>

          <Grid container spacing={2} sx={{ mb: 2, mt: 1 }}>
            <Grid item xs={12} display={!!errorMessage ? '' : 'none'}>
              <Alert severity='error'>{errorMessage}</Alert>
            </Grid>

            <Grid item xs={12}>
              {/* el xs es para pantallas pequeñas y el sm para  */}
              <Button
                disabled={isCheckingAuthentication}
                variant='contained'
                fullWidth
                type='submit'
              >
                {/* si queremos que el boton envie el formulario tiene que tener el type submit */}
                Crear cuenta
              </Button>
            </Grid>
          </Grid>

          <Grid container direction='row' justifyContent='end'>
            <Typography sx={{ mr: 1 }}>Ya tienes una cuenta?</Typography>
            <Link to='/auth/login' color='inherit' component={RouterLink}>
              Ingresar
            </Link>
          </Grid>
        </Grid>
      </form>
    </AuthLayout>
  );
};
```

#### routes

Nuestras rutas relacionadas con el auth

##### AuthRoutes.jsx

```jsx
import { Routes, Route, Navigate } from 'react-router-dom';
import { LoginPages, RegisterPage } from '../pages';

export const AuthRoutes = () => {
  return (
    <Routes>
      {/* configuracion de rutas */}
      <Route path='login' element={<LoginPages />} />
      <Route path='register' element={<RegisterPage />} />

      <Route path='/*' element={<Navigate to='/auth/login' />} />
    </Routes>
  );
};
```

### firebase

Donde esta nuestro provider y nuestra configuracion para usar firebase

#### config.js

```js
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore/lite';

// configuracion especial para que nuestro front reconozca nuestra base de datos, esta no la proporciona en firebase toda esta configuracion

const firebaseConfig = {
  apiKey: 'AIzaSyCGNKFK3RvPLi1L3n9DYu0ibeTyTVqGm5g',
  authDomain: 'journal-app-b604d.firebaseapp.com',
  projectId: 'journal-app-b604d',
  storageBucket: 'journal-app-b604d.appspot.com',
  messagingSenderId: '1019156227488',
  appId: '1:1019156227488:web:248779e9fb0721e4f1f0c5',
};

export const FirebaseApp = initializeApp(firebaseConfig); //simplemente para configurar

export const FirebaseAuth = getAuth(FirebaseApp); //para la autenticacion

export const FirebaseStore = getFirestore(FirebaseApp); //esto en si es la configuracion de la base de **datos**
```

#### providers.js

Nuestros proveedores de algunas funcionalidades de firebase

```js
import {
  GoogleAuthProvider,
  createUserWithEmailAndPassword,
  signInWithPopup,
  updateProfile,
  signInWithEmailAndPassword,
} from 'firebase/auth';
import { FirebaseAuth } from './config';

const googleProvider = new GoogleAuthProvider(); // intenciamos un nuevo objeto para poder logearnos abajo

export const singInWithGoogle = async () => {
  // funcion para logearnos gracias a un popup con google
  try {
    const result = await signInWithPopup(FirebaseAuth, googleProvider);
    // con esto obtenemos el usuario que se logueo, todas son funciones que nos provee firebase

    // const credentials = GoogleAuthProvider.credentialFromResult(result);     //aqui podemos acceder a las credenciales si las necesitamos como token y eso

    const { displayName, email, photoURL, uid } = result.user; //aqui ya tengo la informacion del usuario que hayamos ingresado en el pop up

    // si todo salio bien ok true y la informacion
    return {
      ok: true,
      displayName,
      email,
      photoURL,
      uid,
    };
  } catch (error) {
    const errorCode = error.code;
    const errorMessage = error.message;

    return {
      ok: false,
      errorCode,
      errorMessage,
    };
  }
};

export const registerUserWithEmailPassword = async ({
  email,
  password,
  displayName,
}) => {
  // para podernos registrar solamente con email y password
  try {
    const resp = await createUserWithEmailAndPassword(
      FirebaseAuth,
      email,
      password
    );
    // en esta respuesta si tenemos que poner nuestra configuracion de firebase y nuesto email y password en este caso los obtenemos con las props
    const { uid, photoURL } = resp.user;

    //esto es para actualizar el perfil de usuario, y con currentUser eso nos ayuda para saber nuestro usario actual, y el segundo argumento es lo que podemos cambiar, esto es una promesa que no regresa nada por eso solo le ponemos el await
    await updateProfile(FirebaseAuth.currentUser, { displayName });

    return {
      ok: true,
      uid,
      email,
      photoURL,
      displayName,
    };
  } catch (error) {
    return {
      ok: false,
      errorMessage: error.message, //este error lo tenemos gracias a firebase pero podemos personalizarlo si queremos
    };
  }
};

export const loginWithEmailPassword = async ({ email, password }) => {
  // para logearnos con el email y password que ya hayamos registrado
  try {
    const resp = await signInWithEmailAndPassword(
      FirebaseAuth,
      email,
      password
    );
    // es lo mismo que antes
    const { uid, photoURL, displayName } = resp.user;

    return {
      ok: true,
      uid,
      photoURL,
      displayName,
      email,
      password,
    };
  } catch (error) {
    return {
      ok: false,
      errorMessage: error.message,
    };
  }
};

export const logoutFirebase = async () => {
  return await FirebaseAuth.signOut(); //esto cierra todo
};
```

### helpers

Pedazos de codigo que extraemos de otros componentes o funciones para que no se haga tan grandes y sean mas leibles

#### fileUpload.js

```js
export const fileUpload = async (file) => {
  if (!file) throw new Error('No existe la imagen');

  const cloudUrl = 'https://api.cloudinary.com/v1_1/sebas-mar/upload';

  const formData = new FormData(); //esto es par crear un formdata como en postman
  formData.append('upload_preset', 'react-journal'); //clave valor
  formData.append('file', file); //es necesarioo este form data para cloudinary el file es la imagen

  try {
    //hacemos la peticion post y le enviamos el formdata como body como en postmans
    const res = await fetch(cloudUrl, {
      method: 'POST',
      body: formData,
    });

    if (!res.ok) throw new Error('No se pudo subir la imagen');

    const cloudRes = await res.json();

    return cloudRes.secure_url; //esta es la url del json que nos envian la url que esta en cloudinary
  } catch (error) {
    throw new Error(error.message);
  }
};
```

#### loadNotes.js

```js
import { collection, getDocs } from 'firebase/firestore/lite';
import { FirebaseStore } from '../firebase/config';

export const loadNotes = async (uid = '') => {
  if (!uid) throw new Error('El UID del usuario no existe');

  const collectionRef = collection(FirebaseStore, `${uid}/journal/notes`); //esta es la referencia le puse que queria la coleccion y la configuracion y mi url

  const docs = await getDocs(collectionRef); //aqui tambien puedo poner filtros y muchas cosas mas pero solo pedi todas los documentos que se encuentran en la referencia anterior

  const notes = [];
  //docs es un arreglo de muchas cosas, en ellas esta el id y una funcion donde contiene la data, como es funcion la llamamos y ahi esta la data
  docs.forEach((doc) => {
    notes.push({ id: doc.id, ...doc.data() }); //hago una copia o esparzo todo lo que contenga en la funcion de data
  });

  return notes;
};
```

### hooks

Nuestros hooks generales

#### useCheckAuth.js

```js
import { onAuthStateChanged } from 'firebase/auth';
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { login, logout } from '../store/auth';
import { FirebaseAuth } from '../firebase/config';
import { startLoadingNotes } from '../store/journal/thunks';

export const useCheckAuth = () => {
  const { status } = useSelector((state) => state.auth); //usamos el useSelector para obtener algo del estado de redux del store de la parte del auth
  const dispatch = useDispatch(); //nuestro dispatch para dispachar acciones del redux

  useEffect(() => {
    //cuando el estado de la autenticacion cambie, esto no lo ofrece firebase
    // funciones propias de firebase aqui le digo que cuando cambie la autenticacion hara algo
    onAuthStateChanged(FirebaseAuth, async (user) => {
      // este calback nos devuelve informacion del usuario autenticado pero como primer parametro le tenemos que enviar nuestra configuracio que tenemos en firebase
      if (!user) return dispatch(logout());

      const { uid, email, displayName, photoURL } = user;

      dispatch(login({ uid, email, displayName, photoURL }));
      // despues de desestructurar el usario que obtuvimos lo guardamos en nuestro redux
      dispatch(startLoadingNotes());
      // este ultimo nos ayuda a guardar las notas en nuestro firestore
    });
    //toda esta funcion devuelve un observador y no son mas que funciones que esta emitiendo valores, se vuelve y vuelve a disparar
  }, []);

  return {
    status,
  };
};
```

#### useForm.js

```js
import { useEffect, useMemo, useState } from 'react';

export const useForm = (initialForm = {}, formValidations = {}) => {
  // nuestro custom hook para manejar nuestro formulario
  const [formState, setFormState] = useState(initialForm);
  const [formValidation, setFormValidation] = useState({});

  useEffect(() => {
    // cada vez que cambia algo del formState ejecutamos la funcion de abajo
    createValidatiors();
  }, [formState]);

  useEffect(() => {
    // cada vez que cambia el initialForm se lo doy a mi estado de formulario
    setFormState(initialForm);
  }, [initialForm]);

  const createValidatiors = () => {
    const formCheckedValues = {};

    for (const formField of Object.keys(formValidations)) {
      //gracias al of Object.keys(form..) aqui estoy obteniendo las claves de ese objeto y las estoy almacenando en la variable, clave como displayName, password, email
      const [funct, errorMenssage] = formValidations[formField];
      // console.log(formValidations['displayName']); //y aqui desestructuramos la  funcion y el mensaje de error por cada valor del objeto que envian al formValidations como propiedad

      // recuerden que del formvalidations recibo un objeto que tiene el errorMenssage y una funcion que valida el texto que ingreso al input para ver si cumple

      formCheckedValues[`${formField}Valid`] = funct(formState[formField])
        ? //y por cada valor estoy creando un nuevo valor con el nombre mas Valid ejemplo, emailValid, y gracias a la funcion recibe un argumento y ese argumento se valida y devuelve true o false
          // y en formState[formField] esta el valor del estado, el del formulario, si es true es null o si no es el mensaje de error
          null
        : errorMenssage;
    }

    setFormValidation(formCheckedValues);
    //y en formCheckedValues tenemos los null o los mensajes de error, como un objeto: emailValid: null o mensaje de error si no cumple la validacion y asi con todos
  };

  const isFormValid = useMemo(() => {
    for (const formValue of Object.keys(formValidation)) {
      // aqui lo mismo de arriba si el formulario es valido tiene que ser true entonces hago una validacioon por cada uno de los valores si no es null entonces no es valido el formulario por eso retorno false
      if (formValidation[formValue] !== null) return false;
    }
    // pero si es null todo entonces no hay errores y es valido el formulario
    return true;
  }, [formValidation]);

  const onInputChanges = (event) => {
    // cambiamos el input que tenga el name que queremos si tiene el name email ese es el input que cambiaremos con el target value
    setFormState({
      ...formState,
      [event.target.name]: event.target.value,
    });
  };

  const onResetForm = () => {
    setFormState({
      email: '',
      password: '',
      displayName: '',
    });
  };

  return {
    ...formState, //envio todas las propiedades de formState
    formState,
    onInputChanges,
    onResetForm,

    ...formValidation, //todas las validations
    isFormValid, // true o false
  };
};
```

### journal

Todo lo relacionado con la pagina principal journal

#### components

Nuestros componentes

##### ImageGallery.jsx

```jsx
import React from 'react';
import { ImageList, ImageListItem } from '@mui/material';

export const ImageGallery = ({ images }) => {
  // recibimos las imagenes y las mostramos con estos componentes que vienen de material ui
  if (!images) return;

  return (
    <ImageList sx={{ width: '100%', height: 500 }} cols={4} rowHeight={200}>
      {images.map((image) => (
        // map para recorrer el arreglo y poner cada una
        <ImageListItem key={image}>
          <img
            src={`${image}?w=164&h=164&fit=crop&auto=format`}
            srcSet={`${image}?w=164&h=164&fit=crop&auto=format&dpr=2 2x`}
            alt='Imagen de la nota'
            loading='lazy'
          />
        </ImageListItem>
      ))}
    </ImageList>
  );
};
```

##### Navbar.jsx

```jsx
import { AppBar, IconButton, Toolbar, Grid, Typography } from '@mui/material';
import { MenuOutlined, LogoutOutlined } from '@mui/icons-material';
import { useDispatch } from 'react-redux';
import { startLogout } from '../../store/auth';

export const Navbar = ({ drawerWidth }) => {
  const distpach = useDispatch();

  const onLogout = () => {
    // al darle click hacemos un logout
    distpach(startLogout());
  };

  return (
    // estilo y componentes propios de material
    <AppBar
      position='fixed'
      sx={{
        width: { sm: `calc(100% - ${drawerWidth}px )` },
        ml: { sm: `${drawerWidth}px` },
      }}
    >
      <Toolbar>
        <IconButton
          color='inherit'
          edge='start'
          sx={{ mr: 2, display: { sm: 'none' } }}
        >
          <MenuOutlined />
        </IconButton>

        <Grid
          container
          direction='row'
          justifyContent='space-between'
          alignItems='center'
        >
          <Typography variant='h6' noWrap component='div'>
            JournalApp
          </Typography>

          <IconButton onClick={onLogout} color='error'>
            <LogoutOutlined />
          </IconButton>
        </Grid>
      </Toolbar>
    </AppBar>
  );
};
```

##### SideBar.jsx

```jsx
import { Box, Divider, Drawer, List, Toolbar, Typography } from '@mui/material';
import { useSelector } from 'react-redux';
import { SideBarItem } from './SideBarItem';

export const SideBar = ({ drawerWidth }) => {
  // necesitamos el nombre del auth y tambien las notas para crear por cada una, una tarjetita
  const { displayName } = useSelector((status) => status.auth);
  const { notes } = useSelector((status) => status.journal);

  return (
    <Box
      component='nav'
      sx={{ width: { sm: drawerWidth }, flexShrink: { sm: 0 } }}
    >
      <Drawer
        variant='permanent'
        open
        sx={{
          display: { xs: 'block' },
          '& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth },
        }}
      >
        <Toolbar>
          <Typography variant='h6' noWrap component='div'>
            {displayName}
          </Typography>
        </Toolbar>
        <Divider />

        <List>
          {/* por codanota creamos un item de estos enviandoles las notas */}
          {notes.map((note) => (
            <SideBarItem key={note.id} note={note} {...note} />
          ))}
        </List>
      </Drawer>
    </Box>
  );
};
```

##### SideBarItem.jsx

```jsx
import { useMemo } from 'react';
import { TurnedInNot } from '@mui/icons-material';
import {
  Grid,
  ListItem,
  ListItemButton,
  ListItemIcon,
  ListItemText,
} from '@mui/material';
import { useDispatch } from 'react-redux';
import { setActiveNote } from '../../store/journal/journalSlices';

export const SideBarItem = ({ title, body, note }) => {
  const dispatch = useDispatch();

  const newTitle = useMemo(() => {
    //con esto corto el titulo si es demasiado grande con substring y le agrego unos puntos y si es pequeño se queda normal
    return title.length > 17 ? title.substring(0, 17) + '...' : title;
  }, [title]);

  const activeNote = () => {
    // activamos la nota que recibimos
    dispatch(setActiveNote(note));
  };

  return (
    // y creamos la tarjetita
    <ListItem disablePadding onClick={activeNote}>
      <ListItemButton>
        <ListItemIcon>
          <TurnedInNot />
        </ListItemIcon>

        <Grid container>
          <ListItemText primary={newTitle} />
          <ListItemText secondary={body} />
        </Grid>
      </ListItemButton>
    </ListItem>
  );
};
```

#### layout

Cascaron del estilo

##### JournalLayout.jsx

```jsx
import { Box, Toolbar } from '@mui/material';
import { Navbar, SideBar } from '../components';

const drawerWidth = 240; //para que tenga el control del width

export const JournalLayout = ({ children }) => {
  return (
    <Box
      sx={{ display: 'flex' }}
      className='animate__animated animate__fadeIn animate__faster'
    >
      {/* nuestro Layout donde tenemos el NavBar y el SideBar */}
      <Navbar drawerWidth={drawerWidth} />

      <SideBar drawerWidth={drawerWidth} />

      <Box component='main' sx={{ flexGrow: 1, p: 3 }}>
        {/* esta sera la etiqueta main por eso le pongo component main y ahi tendre el children */}

        <Toolbar />
        {children}
      </Box>
    </Box>
  );
};
```

#### pages

Nuestras paginas que ocupan nuestra pagina completa

##### JournalPage.jsx

```jsx
import { IconButton } from '@mui/material';
import { AddOutlined } from '@mui/icons-material';
import { JournalLayout } from '../layout/JournalLayout';
import { NoteView, NothingSelectedView } from '../views';
import { useDispatch, useSelector } from 'react-redux';
import { startNewNote } from '../../store/journal/thunks';

export const JournalPage = () => {
  // lo que ya conocemos de redux para traer nuestro estado y para hacer dispatch
  const { isSaving, active } = useSelector((state) => state.journal);
  const dispatch = useDispatch();

  const onClickNewNote = () => {
    // al darle click en ese boton creamos una nueva nota
    dispatch(startNewNote());
  };
  return (
    <>
      <JournalLayout>
        {/* esto es propio de material ui aunque este Layout es creado por mi*/}

        {/* <Typography>JournalPage</Typography>   //este elemento por defecto es un parrafo */}
        {/* <Typography component='h1'>JournalPage</Typography> //ahora esto es un h1, no cambia de tamaño pero para el html es un h1 */}
        {/* <Typography variant='h1'>JournalPage</Typography> */}
        {/* //con variant si le cambia el estilo que material ui le puso por defecto al h1 */}
        {/* <Typography>
          Nulla et voluptate ea ipsum sint commodo veniam tempor nulla qui.
        </Typography> */}

        {active !== null ? <NoteView /> : <NothingSelectedView />}
        {/* le digo que si tenemos una nota mostramos esa pantalla y si esta null mostramos la otra */}

        <IconButton
          onClick={onClickNewNote}
          disabled={isSaving}
          size='large'
          sx={{
            color: 'white',
            backgroundColor: 'error.main',
            ':hover': { backgroundColor: 'error.main', opacity: 0.9 },
            position: 'fixed',
            right: 50,
            bottom: 50,
          }}
        >
          <AddOutlined />
        </IconButton>
      </JournalLayout>
    </>
  );
};
```

#### routes

Rutas relacionadas con el journal

##### JournalRoutes.jsx

```jsx
import { Routes, Route, Navigate } from 'react-router-dom';
import { JournalPage } from '../pages/JournalPage';

export const JournalRoutes = () => {
  return (
    <Routes>
      {/* mi ruta principal el Journal page y si pongo cualquier cosa lo envio al mismo lugar */}
      <Route path='/' element={<JournalPage />} />

      <Route path='/*' element={<Navigate to='/' />} />
    </Routes>
  );
};
```

#### views

Nuestras vistas en este caso la parte que no tiene el navbar ni el sidebar, son partes que no ocupan por completo la pagina

##### NoteView.jsx

```jsx
import { Button, Grid, IconButton, TextField, Typography } from '@mui/material';
import {
  DeleteOutline,
  SaveOutlined,
  UploadOutlined,
} from '@mui/icons-material';
import { ImageGallery } from '../components';
import { useForm } from '../../hooks/useForm';
import { useDispatch, useSelector } from 'react-redux';
import { useEffect, useMemo, useRef } from 'react';
import { setActiveNote } from '../../store/journal/journalSlices';
import {
  startDeletingNote,
  startSaveNote,
  startUploadingFiles,
} from '../../store/journal/thunks';
import Swal from 'sweetalert2';

export const NoteView = () => {
  const dispatch = useDispatch();

  const {
    active: note,
    messageSaved,
    isSaving,
  } = useSelector((state) => state.journal); //los dos puntos es para darle un nombre
  const { body, title, date, onInputChanges, formState } = useForm(note); // nuestro hook para manejar formularios

  const dateString = useMemo(() => {
    // esto es para que sea nuestra fecha mas leigle y se memoriza y solo cambia cuando cambie la date
    const newDate = new Date(date);
    return newDate.toUTCString();
  }, [date]);

  const inputFileRef = useRef(); //ahora el input que se lo ponga mantedra la referencia a ese input

  const onSaveNote = () => {
    // creamos una nueva nota
    dispatch(startSaveNote());
  };

  const onFileInputChange = ({ target }) => {
    //en un input file el target.files estan todos las imagenes
    if (target.files === 0) return;

    // enviamos a nuestra action el arreglo de urls
    dispatch(startUploadingFiles(target.files));
  };

  useEffect(() => {
    dispatch(setActiveNote(formState));
  }, [formState]); //le decimos que al momento en el que cambie el stado y cualquier valor de el se activara este efecto

  useEffect(() => {
    // si usamos el dispatch de startSaveNote creamos un messageSaved entonces validamos si hay un mensaje y si hay un mensaje es porque se guardo la nota o se le dio al click de guardar
    // entonces mostramos esas alertas super wapas con la libreria sweetalert2
    if (messageSaved.length > 1) {
      Swal.fire('Nota Actualizada', messageSaved, 'success');
    }
  }, [messageSaved]);

  const onDelete = () => {
    // si le damos click eliminamos la nota
    dispatch(startDeletingNote());
  };

  return (
    <Grid
      className='animate__animated animate__fadeIn animate__faster'
      container
      direction='row'
      justifyContent='space-between'
      alignItems='center'
      sx={{ mb: 1 }}
    >
      <Grid item>
        <Typography fontSize={39} fontWeight='light'>
          {dateString}
        </Typography>
      </Grid>

      {/* como este input no se puede estilar lo ocultamos */}
      <input
        ref={inputFileRef} //para guardar la referencia
        type='file'
        multiple //este es para que deje seleccionar multiples imagenes
        onChange={onFileInputChange}
        style={{ display: 'none' }}
      />

      <IconButton
        color='primary'
        disabled={isSaving}
        onClick={() => inputFileRef.current.click()}
        // como tenemos una referencia el punto current y simulamos el click de esa referencia al darle click
      >
        <UploadOutlined />
      </IconButton>

      <Grid item>
        <Button
          disabled={isSaving}
          onClick={onSaveNote}
          color='primary'
          sx={{ padding: 2 }}
        >
          <SaveOutlined sx={{ fontSize: 30, mr: 1 }} />
          Guardar
        </Button>
      </Grid>

      <Grid container>
        <TextField
          type='text'
          variant='filled'
          fullWidth
          placeholder='Ingrese un titulo'
          label='Titulo'
          sx={{ border: 'none', mb: 1 }}
          name='title'
          value={title}
          onChange={onInputChanges}
        />

        <TextField
          type='text'
          variant='filled'
          fullWidth
          multiline
          placeholder='¿Qué pasó hoy?'
          sx={{ border: 'none', mb: 1 }}
          minRows={4}
          name='body'
          value={body}
          onChange={onInputChanges}
        />
      </Grid>

      <Grid container justifyContent={'end'}>
        <Button onClick={onDelete} sx={{ mt: 2 }} color='error'>
          <DeleteOutline />
          Borrar
        </Button>
      </Grid>

      <ImageGallery images={note.imageUrls} />
    </Grid>
  );
};
```

##### NothingSelectedView.jsx

```jsx
import { Grid, Typography } from '@mui/material';
import { StarOutline } from '@mui/icons-material';

export const NothingSelectedView = () => {
  // full diseño con material ui
  return (
    <Grid
      className='animate__animated animate__fadeIn animate__faster'
      container
      spacing={0}
      direction='column'
      alignItems='center'
      justifyContent='center'
      sx={{
        minHeight: 'calc(100vh - 110px)',
        backgroundColor: 'primary.main',
        borderRadius: 2,
      }}
    >
      <Grid item xs={12}>
        <StarOutline sx={{ fontSize: 100, color: 'white' }} />
      </Grid>
      <Grid item xs={12}>
        <Typography variant='h5' color='white'>
          Selecciona o crea una nota
        </Typography>
      </Grid>
    </Grid>
  );
};
```

### router

Nuestra configuracion general de las rutas

#### AppRouter.jsx

```jsx
import { Routes, Route, Navigate } from 'react-router-dom';
import { AuthRoutes } from '../auth/routes/AuthRoutes';
import { JournalRoutes } from '../journal/routes/JournalRoutes';

import { CheckingAuth } from '../ui';
import { useCheckAuth } from '../hooks/useCheckAuth';

export const AppRoute = () => {
  // este es un hook creado por mi que hace muchas cosas y me devuelve el status que tengo en redux
  const { status } = useCheckAuth();

  if (status === 'checking') {
    //el status va cambiando
    // si esto se cumple retorno una pantalla de carga creada gracias a Material ui
    return <CheckingAuth />;
  }

  return (
    <Routes>
      {/* aqui digo que si estoy autenticado muestro mis rutas de jounal si no el auth */}
      {/* si estoy autenticado ni si quiera existen la ruta de auth */}
      {status === 'authenticated' ? (
        <Route path='/*' element={<JournalRoutes />} />
      ) : (
        <Route path='/auth/*' element={<AuthRoutes />} />
      )}

      {/* si el usuario no esta en ninguna de las rutas de arriba lo enviamos al login */}
      <Route path='/*' element={<Navigate to='/auth/login' />} />
    </Routes>
  );
};
```

### store

Donde tenemos nuestro store de nuestro redux

#### auth

Donde estan nuestros slices y thunks relacionados con el auth

##### authSlice.js

```js
import { createSlice } from '@reduxjs/toolkit';

export const authSlice = createSlice({
  name: 'auth',
  initialState: {
    // nuestro estado de auth
    status: 'checking', // 'checking', 'not-authenticated', 'authenticated'
    uid: null,
    email: null,
    displayName: null,
    photoURL: null,
    errorMessage: null,
  },
  reducers: {
    // nuestros reducers que al final se crean como actions, primer argumento nuestro stado y el payload que le enviamos en las actions
    login: (state, { payload }) => {
      // no importa mutar gracias a redux toolkit y asignamos lo que queramos, en este recibimos todo el usuario y lo guardamos en el redux
      state.status = 'authenticated';
      state.uid = payload.uid;
      state.email = payload.email;
      state.displayName = payload.displayName;
      state.photoURL = payload.photoURL;
      state.errorMessage = null;
    },
    logout: (state, { payload }) => {
      // con logout le quitamos todos los valores
      state.status = 'not-authenticated';
      state.uid = null;
      state.email = null;
      state.displayName = null;
      state.photoURL = null;
      state.errorMessage = payload?.errorMessage;
      // si es un logout a veces puede venir un errorMessage
    },
    checkingCredentials: (state) => {
      // para chekear las credenciales simplemente le cambiamos el status
      state.status = 'checking';
    },
  },
});

export const { login, logout, checkingCredentials } = authSlice.actions;
```

##### thunks.js

```js
import { checkingCredentials, login, logout } from '.';
import {
  loginWithEmailPassword,
  logoutFirebase,
  registerUserWithEmailPassword,
  singInWithGoogle,
} from '../../firebase/providers';
import { clearNotesLogout } from '../journal/journalSlices';

// nuestros thunks que nos ayudan a ejecutar codigo asincrono, una action que regresa otra funcion
export const checkingAuthtetication = (email, password) => {
  // el primer argumento el dispatch para ejecutar aciones de nuestro reducer
  return async (dispath) => {
    dispath(checkingCredentials());
    // simplemente ponemos nuestro status en cheking
  };
};

export const startGoogleSingIn = () => {
  return async (dispath) => {
    dispath(checkingCredentials());
    // en result guardo la respuesta de esta funcioon que devuelve el usurio y la propiedad ok en true si todo sale bien y si hay un error devuelve ok en false y el mensaje de error
    const result = await singInWithGoogle();

    if (!result.ok) return dispath(logout(result)); // y enviamos el mensaje de error al logout
    dispath(login(result)); // si todo sale bien enviamos el usuario
  };
};

export const startCreatingUserWithEmailPassword = ({
  // tambien podemos recibir argumentos en nuestros thunks
  email,
  password,
  displayName,
}) => {
  return async (dispath) => {
    dispath(checkingCredentials());

    // de igual manera que en google nos registramos si todo sale bien del lado de firebase obtenemos el usuario si no el error
    const { ok, uid, photoURL, errorMessage } =
      await registerUserWithEmailPassword({
        email,
        password,
        displayName,
      });
    if (!ok) return dispath(logout({ errorMessage }));

    // podemos enviar el objeto completo o desestructurado
    dispath(login({ uid, displayName, email, photoURL }));
  };
};

export const startLoginWithEmailPassword = ({ email, password }) => {
  return async (dispath) => {
    dispath(checkingCredentials());
    // de igual manera para registrarnos como arriba pero esta vez enviamos el email y password para logearnos, si todo bien user si no error
    const result = await loginWithEmailPassword({
      email,
      password,
    });

    if (!result.ok) return dispath(logout(result));
    dispath(login(result));
  };
};

export const startLogout = () => {
  return async (dispath) => {
    // simplemente cierra la secion
    await logoutFirebase();

    // y limpiamos nuestras notas en el journal y limpiamos nuestro user con el logout
    dispath(clearNotesLogout());
    dispath(logout());
  };
};
```

#### journal

De igual manera relacionados con el journal

##### journalSlice.js

```js
import { createSlice } from '@reduxjs/toolkit';

export const journalSlice = createSlice({
  name: 'journal',
  initialState: {
    isSaving: false,
    messageSaved: '',
    notes: [],
    active: null,
    // active: {        //asi es como luce la nota activa
    //   id: '12mar',
    //   title: '',
    //   body: '',
    //   date: 123,
    //   imageUrls: [],
    // },
  },
  reducers: {
    savingNewNote: (state) => {
      // solo cambiamos nuestros estados para manejar el disabled de algunos botones
      state.isSaving = true;
    },
    addNewEmptyNote: (state, action) => {
      // simplemente insertamos la nota que recibimos en el payload
      state.notes.push(action.payload);
      // y como ya se guardo ponemos en false
      state.isSaving = false;
    },
    setActiveNote: (state, action) => {
      // aqui ponemos en nuestra activa la nota que estemos recibiendo
      state.active = action.payload;
      state.messageSaved = '';
    },
    setNotes: (state, action) => {
      // establecemos nuestro arreglo de notas
      state.notes = action.payload;
    },
    setSaving: (state) => {
      // solo cambiamos nuestro estado de isSaving
      state.isSaving = true;
      state.messageSaved = '';
    },
    updateNote: (state, action) => {
      state.isSaving = false;
      // recibimos una nota y hacemos un map con los que tenemos y si el id de la nota que enviaron coicide con el nuevo pues retornamos la nueva nota
      state.notes = state.notes.map((note) => {
        if (note.id === action.payload.id) {
          return action.payload;
        }
        // si no coicide solo retornamos la nota que se esta iterando
        return note;
      });

      state.messageSaved = `Nota actualizada correctamente Mar`;
    },
    setPhotosToActiveNote: (state, action) => {
      // actualizamos las imageUrls de nuestra nota activa, anteriormente ya esta en la nota, creamos una copia de las que tenemos y ponemos las que recibimos en el payload
      state.active.imageUrls = [...state.active.imageUrls, ...action.payload];
      state.isSaving = false;
    },
    clearNotesLogout: (state) => {
      // simplemente limpiamos nuestras notas y nuestro state
      state.isSaving = false;
      state.messageSaved = '';
      state.notes = [];
      state.active = null;
    },
    deleteNoteById: (state, action) => {
      // quitamos la nota activa y filtramos todas las notas que no tengan el id que enviamos eso la elimina del arreglo
      state.active = null;
      state.notes = state.notes.filter((note) => note.id !== action.payload);
    },
  },
});

export const {
  addNewEmptyNote,
  clearNotesLogout,
  deleteNoteById,
  savingNewNote,
  setActiveNote,
  setNotes,
  setPhotosToActiveNote,
  setSaving,
  updateNote,
} = journalSlice.actions;
```

##### thunks.js

```jsx
import { collection, deleteDoc, doc, setDoc } from 'firebase/firestore/lite';
import { FirebaseStore } from '../../firebase/config';
import {
  addNewEmptyNote,
  deleteNoteById,
  savingNewNote,
  setActiveNote,
  setNotes,
  setPhotosToActiveNote,
  setSaving,
  updateNote,
} from './journalSlices';
import { fileUpload, loadNotes } from '../../helpers';

export const startNewNote = () => {
  return async (dispatch, getState) => {
    // console.log(getState());   //recordemos que nuestro segundo argumento de un thunk es el estado ahi estan todos los estados

    const newNote = {
      title: '',
      body: '',
      date: new Date().getTime(),
      imageUrls: [],
    };

    dispatch(savingNewNote());
    const { uid } = getState().auth; //del slice auth ahi puedo obtener los valores en este caso el uid, necesario para guardar una nota

    const newDoc = doc(collection(FirebaseStore, `${uid}/journal/notes`));
    //aqui creamos una nueva coleccion en nuestro firebase el primer argumento es el nuestra configuracion y el segundo la direccion, en este caso le digo que cree una collecion con con el uid del usuario, y un par de direcciones mas

    // para almacenar el documento mandamos nuestra configuracion de arriba y el objeto que queremos guardar, no importa que este vacio despues lo actualizamos con los nuevos valores
    await setDoc(newDoc, newNote);

    newNote.id = newDoc.id; //aqui estoy dando el id que ya crea el newDoc en firebase crea un id

    dispatch(addNewEmptyNote(newNote)); // enviamos la nueva nota al arreglo
    dispatch(setActiveNote(newNote)); // y ponemos esta nota como nota activa
  };
};

export const startLoadingNotes = () => {
  return async (dispatch, getState) => {
    const { uid } = getState().auth;

    // enviamos el uid del usuarioo y esta funcion devuelve el arreglo de las notas
    const notes = await loadNotes(uid);
    // enviamos el arreglo de nota sque tenemos en firebase a nuestro store
    dispatch(setNotes(notes));
  };
};

export const startSaveNote = () => {
  // esto es cuando guardo la nota, ya tendre una nota activa
  return async (dispatch, getState) => {
    dispatch(setSaving());
    const { uid } = getState().auth;
    const { active: note } = getState().journal;
    // del journal traigo la nota activa, y le cambie el nombre a note solamente

    const noteToFireStore = { ...note };
    delete noteToFireStore.id; //del objeto nuevo le elimine el id para firestore

    const docRef = doc(FirebaseStore, `${uid}/journal/notes/${note.id}`); //esto solo es la referencia a la url para llegar a la nota que queremos
    await setDoc(docRef, noteToFireStore, { merge: true });
    // el primer argumetno nuestra referencia, el segundo lo que le queremos enviar y el tercero es como para unir, si hay campos del objeto aqui que no tiene lo que enviamos simplemete los une, todo esto del objeto

    // tambien actualizamos nuestra nota en el store
    dispatch(updateNote(note));
  };
};

export const startUploadingFiles = (files = []) => {
  // el thunk para guardar nuestras imagenes
  return async (dispatch) => {
    dispatch(setSaving());

    const fileUploadPromises = [];
    for (const file of files) {
      // recordemos que en file se guarda cada valor que este en files

      fileUploadPromises.push(fileUpload(file));
      // esta funcion nos devuelve la imagen ya subida en cloudinary le enviamos la imagen y esta la sube a ese servicio pero solo una
      // estas son promesas como no hay un await simplemente regresa las promesas no la imagen, entonces simplemente almacenamos las promesas en el arreglo
    }

    // y con esta linea podemos ejecutar todas las promesas y nos devuelve el arreglo con lo que devolvia la promesa
    const photosUrl = await Promise.all(fileUploadPromises);
    dispatch(setPhotosToActiveNote(photosUrl)); //y enviamos nuestro arreglo de photosUrls
  };
};

export const startDeletingNote = () => {
  return async (dispatch, getState) => {
    const { uid } = getState().auth;
    const { active: note } = getState().journal;
    // para eliminar la nota necesitamos el uid del usuario y la nota actual

    // hacemos la referencia al documentoo que queremos eliminar
    const docRef = doc(FirebaseStore, `${uid}/journal/notes/${note.id}`);

    // y simplemente lo eliminamos
    await deleteDoc(docRef);

    // y tambien lo eliminamos de nuestro store
    dispatch(deleteNoteById(note.id));
  };
};
```

#### store.js

```js
import { configureStore } from '@reduxjs/toolkit';
import { authSlice } from './auth';
import { journalSlice } from './journal';

export const store = configureStore({
  // mi estore con mis reducer
  reducer: {
    auth: authSlice.reducer,
    journal: journalSlice.reducer,
  },
});
```

### theme

Nuestro tema relacionado con meterial ui

#### AppTheme.jsx

```jsx
import { ThemeProvider } from '@emotion/react';
import { CssBaseline } from '@mui/material';
import { purpleTheme } from '.';

export const AppTheme = ({ children }) => {
  return (
    <ThemeProvider theme={purpleTheme}>
      {/* como thema nuestra configuracion del theme y siempre tenemos que provver con esto  */}
      <CssBaseline />
      {/* esto es necesario para material ui */}
      {children}
    </ThemeProvider>
  );
};
```

#### purpleTheme.js

```jsx
import { createTheme } from '@mui/material';
import { red } from '@mui/material/colors';

export const purpleTheme = createTheme({
  // asi creamos la paleta de colores de nuestro tema
  palette: {
    primary: {
      main: '#262254',
    },
    secondary: {
      main: '#543884',
    },
    error: {
      main: red.A400, //de material ya tenemos unos colores
    },
  },
});
```

### ui

Nuestra interfas de usuario

#### componentes

Nuestros componentes de la interface de usuario

##### CheckingAuth.jsx

```jsx
import { CircularProgress, Grid } from '@mui/material';

export const CheckingAuth = () => {
  return (
    // esto es propio de material ui para darle estilo y tanta cosa
    <Grid
      container
      spacing={0}
      direction='column'
      alignItems='center'
      justifyContent='center'
      sx={{ minHeight: '100vh', backgroundColor: 'primary.main', padding: 4 }} //sx es como el atributo styles para poner cualquier estilo pero nos ayuda a reconocer el color del theme que colocamos
    >
      <Grid container direction='row' justifyContent='center'>
        <CircularProgress color='warning' />
        {/* esto es un circulo de progreso que ya trae material ui */}
      </Grid>
    </Grid>
  );
};
```

### JournalApp.jsx

```jsx
import { AppRoute } from './router/AppRoute';
import { AppTheme } from './theme';

export const JournalApp = () => {
  return (
    <AppTheme>
      {/* AppTheme es nuestro tema que necesitamos para configurar material ui de igual manera lo mas arriba posible para que todos tengan acceso a el  */}
      <AppRoute />
    </AppTheme>
  );
};
```

### main.jsx

```jsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import './styles.css';
import { JournalApp } from './JournalApp';
import { Provider } from 'react-redux';
import { store } from './store';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    {/* ponemos nuestro store lo mas alto posible, en general es lo mas alto que debe de tener la aplicacion */}
    <Provider store={store}>
      {/* y tambien el browserRouter para la configuracion de las rutas en el navegador */}
      <BrowserRouter>
        <JournalApp />
      </BrowserRouter>
    </Provider>
  </React.StrictMode>
);
```
