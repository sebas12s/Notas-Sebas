# NextAuth.js

Nos ayuda para la autenticacion, no es propio de next pero se acopla muy bien a el

[Documentacion](https://authjs.dev/)

## Pasos a seguir

- Get Started
- Setup with OAuth
- Instalamos `npm install next-auth`
- Tenemos que hacer nuestra configuracion de nuestro endpoint
- Entonces en app creamos lo siguiente:
- app/api/auth/\[...nextauth]/route.ts
  - con esto le digo que cualquier ruta que venga despues de api/auth pasara por ahi nextauth
- En la documentacion no esta actualizado asi que cambiaremos despues el contenido del archivo
- y configuramos nuestro route.ts

```ts
import NextAuth, { NextAuthOptions } from 'next-auth';
import GithubProvider from 'next-auth/providers/github';

// aqui simplemente voy haciendo mis proveedores de mi autenticacion
export const authOptions: NextAuthOptions = {
  providers: [
    GithubProvider({
      clientId: process.env.GITHUB_ID ?? '',
      clientSecret: process.env.GITHUB_SECRET ?? '',
    }),
  ],
};

// aqui simplemente les paso mis opciones de autenticacion a NextAuth
const handler = NextAuth(authOptions);

// con esto le digo que usare handler para peticiones GET y para peticiones POST
export { handler as GET, handler as POST };
```

- Despues configuramos nuestras variables de entorno

```bash
#  https://generate-secret.vercel.app/32
#  Aqui pide que cumpla unos requicitos para nuestro NextAuth_Secret y podemos conseguir uno en el de arriba
NEXTAUTH_SECRET=fa3b57cb625e9b5407cecafff5c845de
GITHUB_ID=
GITHUB_SECRET=
```

- configuramos nuestros providers [Documentacin](https://next-auth.js.org/providers/)

## Configuracion con github

- Para configurar con github seguimos lo siguiente:
  - settings
  - Developer Settings
  - OAth Apps
  - Register new app
  - Le ponemos cualquier nombre
  - En el homepage URL podemos poner cualquiera pero es obligatorio
  - Authorization callback URL, esto nos dice que cuando sucesa la autenticacion a donde lo voy a redireccionar?
  - entonces ahi ponemos un enlace que esta en la documentacion:
  - `http://localhost:3000/api/auth/callback/:provider`
  - En este caso ponemos github si usamos otro ponemos ahi el otro
  - `http://localhost:3000/api/auth/callback/github`
  - despues de esto nos da el client id y el secret y ahi los copiamos y los ponemos en nuestra app
  - Y de ultimo le damos en update application
  - con esto ya podemos autenticarnos y podemos probar en el siguiente endpoint:
  - `http://localhost:3000/api/auth/signin`

## configuracion con google

- Para configurar con google hacemos lo siguiente
  - Vamos al siguiente enlace para configurar nuestro outh
  - `https://console.cloud.google.com/apis/credentials`
  - Creamos un nuevo proyecto
  - le ponemos cualquier nombre que querramos
  - Despues en el proyecto, creamos credenciales
  - OAuht client ID
  - Creamos nuestra interface que le aparece al usuario
  - External es cualquier persona con una cuenta de google
  - Configuramos el nombre de la app, nuestro correo
  - Al final tambien ponemos nuestro correo y eso estaria, aunque hay mas metodos de seguirdad por si te interesa
  - Siguiente, en los scopes lo podemos dejar asi y despues todo siguiente y volvemos a las credentiales
  - Despues en las credentiales ponemos que tipo de aplicacion es
  - Le podemos cambiar el nombre
  - en Authorized redirect URIs es importante como anteriormente a donde queremos que nos redirija
  - de nuevo es `http://localhost:3000/api/auth/callback/google`
  - Y lo creamos y ahi estan el client id y el client secret

Ejemplo completo en las notas de next14/Admin-todos

## Adaptadores con base de datos

Deja adaptar con diferentes base de datos
[Documentacion](https://authjs.dev/getting-started/adapters)

### Prisma

- Instalamos lo siguiente:
- `npm install @prisma/client @auth/prisma-adapter npm install prisma --save-dev`

```ts
export const authOptions: NextAuthOptions = {
  // simplemenete asi
  adapter: PrismaAdapter(prisma),

  providers: [
```

- Asi ponemos nuestro adapter, `prisma` es nuestro PrismaClient, podemos ver en la documentacion [PrismaAdapter](https://authjs.dev/reference/adapter/prisma)
- Despues creamos nuestros modelos para almacenar nuestros usuarios
- Despues hacemos la migracion `npx prisma migrate dev`
- Despues actualizamos nuestro Prisma client `npx prisma generate`
- En algunas ocaciones da un error que falta un campo en el model Account: `refresh_token_expires_in Int?` y se lo ponemos y eso puede solucionar el problema

- Tambien podemos agregar datos al usuario un ejemplo un rol, lo agregamos primero al model del user

- Y para que auth.js lo tome como informacion del usuario de session vamos al router del endpoint
- y despues configuramos algunos callbacks, informacion en las notas next14/AdminTodos
