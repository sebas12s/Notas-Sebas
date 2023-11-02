# Firebase

Un lugar para crear base de datos no relacionales y algunas otras cosas mas, es de pago pero lo que ofrece gratis basta para pruebas

## Implementacion

`yarn add firebase` solamente necesitamos instalar esto

[Firebase](https://firebase.google.com/)

- Creamos un nuevo proyecto
- Decidimos si queremos con google analytics
- Despues lo conectamos en `IOS`, `Android` o `Web`
- En Web creamos una nueva app
- Activamos si gustamos el firebase hosting
- Y colocas la configuracion que te pone ahi, en este ejemplo es la siguiente:

```js
import { initializeApp } from 'firebase/app';

const firebaseConfig = {
  apiKey: 'AIzaSyAV2D-mJqPPoooa7gCp8RIo_OK2mJD6C-4',
  authDomain: 'quantum-weft-400420.firebaseapp.com',
  projectId: 'quantum-weft-400420',
  storageBucket: 'quantum-weft-400420.appspot.com',
  messagingSenderId: '49329543352',
  appId: '1:49329543352:web:7dea4d419f440a232cfc4d',
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
```

- Esta es la configuracion principal

## Authentication

Firebase nos ofrece mucha facilidad para tener una autenticacion en nuestro app

- Ingresamos a `Authentication`
- Despues a Sing-in Method y seleccionamos los metodos que queremos
- Y activamos, con google nos pide nuestro correo
- Y eso seria todo ya en el codigo podriamos ingresar y todo
- Mas informacion en `Notas/notas-programacion/Desarrollo-web/noras-react/React/JournalApp` en esa documentacion esta explicado como aplicarlo

## Firestore database

La base de datos no relacional

- Ingresamos a `Cloud Firestore` o `Firestore Database`
- Despues en location ingresamos la mas cerca de nuestro lugar
- Lo dejamos en production mode
- Ahi ya podemos guardar nuestra data
- Pero en reglas/rules debemos de configurar algo si deseamos

```js
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;	//le digo que si esta auth me deje agregar a mi firestore
    }
  }
}
```

- Mas informacion en `Notas/notas-programacion/Desarrollo-web/noras-react/React/JournalApp` en esa documentacion esta explicado como aplicarlo
