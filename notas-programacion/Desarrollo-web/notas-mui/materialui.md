# Material UI

## Instalacion

Instalamos material en nuestro proyecto

- `yarn add @mui/material @emotion/react @emotion/styled`

Ponemos las fonts en este caso por html

```html
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
  rel="stylesheet"
  href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;600;700&display=swap"
/>
```

Tambien podemos instalar los iconos

- `yarn add @mui/icons-material`

Para poder usarla en react podemos crear una carpeta de theme para tener todo ordenado

En un archivo ahi podemos proveer nuestro tema que siempre tenemos que tener un tema, y tener todos nuestros componentes hijos, ahi deberia de ir app pero como lo hicimos en un componente aparte entonces solo lo dejamos como un higher-order component (HOC) para que despues solamente encerremos la app

```tsx
import { ThemeProvider } from '@emotion/react';
import { CssBaseline } from '@mui/material';
import { purpleTheme } from '.';

export const AppTheme = ({ children }: any) => {
  return (
    // algo importante es el theme siempre le tenemos que poner uno
    <ThemeProvider theme={purpleTheme}>
      <CssBaseline />
      {children}
    </ThemeProvider>
  );
};
```

cuando creamos un theme ya esta hecho solo reescribimos lo que queramos cambiar

```ts
import { createTheme } from '@mui/material';
import { red } from '@mui/material/colors'; //aqui tiene varios colores ya predefinido con diferentes tonalidades tambien

//esto es solo un ejemplo de un theme
export const purpleTheme = createTheme({
  palette: {
    primary: {
      main: '#262254',
    },
    secondary: {
      main: '#543884',
    },
    error: {
      main: red.A400,
    },
  },
});
```

Y ya en este caso el AppTheme lo usamos en nuestra app encerrando todas nuestras paginas no en el main asi no se llena de tanto
