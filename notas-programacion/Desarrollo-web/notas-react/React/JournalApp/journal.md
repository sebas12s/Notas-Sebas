# JournalApp

- [JournalApp](#journalapp)
  - [src](#src)
    - [assets](#assets)
    - [auth](#auth)
      - [layout](#layout)
        - [AuthLayout.jsx](#authlayoutjsx)
      - [pages](#pages)
        - [LoginPages.jsx\`](#loginpagesjsx)
        - [RegisterPage.jsx](#registerpagejsx)
      - [routes](#routes)
        - [AuthRoutes.jsx](#authroutesjsx)
    - [firebase](#firebase)
      - [config.js](#configjs)
      - [providers.js](#providersjs)
    - [helpers](#helpers)
      - [fileUpload.js](#fileuploadjs)
      - [loadNotes,js](#loadnotesjs)
    - [hooks](#hooks)
      - [useCheckAuth.js](#usecheckauthjs)
      - [useForm.js\`](#useformjs)
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

#### pages

Paginas que ocupan la pagina completa

##### LoginPages.jsx`

##### RegisterPage.jsx

#### routes

Nuestras rutas relacionadas con el auth

##### AuthRoutes.jsx

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

### helpers

Pedazos de codigo que extraemos de otros componentes o funciones para que no se haga tan grandes y sean mas leibles

#### fileUpload.js

#### loadNotes,js

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

#### useForm.js`

### journal

Todo lo relacionado con la pagina principal journal

#### components

Nuestros componentes

##### ImageGallery.jsx

##### Navbar.jsx

##### SideBar.jsx

##### SideBarItem.jsx

#### layout

Cascaron del estilo

##### JournalLayout.jsx

#### pages

Nuestras paginas que ocupan nuestra pagina completa

##### JournalPage.jsx

#### routes

Rutas relacionadas con el journal

##### JournalRoutes.jsx

#### views

Nuestras vistas en este caso la parte que no tiene el navbar ni el sidebar, son partes que no ocupan por completo la pagina

##### NoteView.jsx

##### NothingSelectedView.jsx

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
