# Prisma con next y postgreSQL

[Documentacion oficial de vercel](https://vercel.com/guides/nextjs-prisma-postgres)

Ejecutamos el siguiente comando en el proyecto

- `npx prisma init`
  Esto ya hace muchas cosas por nosotros

Esto crea ya un archivo `.env` y ahi tenemos nuestra variable de entorno con la configuracion

Esto pone por defecto:

```
DATABASE_URL="postgresql://johndoe:randompassword@localhost:5432/mydb?schema=public"
```

por defecto pone base de datos postgresql, despues es el usuario y la contraseña que tengamos en la base de datos, y ya lo ultimo es nuestro nombre de la base de datos

Ejemplo

```
DATABASE_URL="postgresql://sebasmar:sebasmar@localhost:5432/next-db"
```

En el archivo que creo en la carpeta Prisma, la estructura basica

```prisma
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator client {
  // aqui detecto que usara el prisma client js
  provider = "prisma-client-js"
}

datasource db {
  // aqui ponemos nuestra db y nuestra url del archivo env
  provider = "postgresql"
  url      = env("DATABASE_URL")
}
```

Despues creamos un model que es como una tabla en el mismo archio

```prisma
// un model es como una tabla
model Todo {
  // con el @id le digo que sera esta columna un id y que por defecto sera un uuid
  id          String   @id @default(uuid())
  // creo mis columans y la al create le digo que por defecto sera la hora en la que se cree y el ultimo que por defecto sera la fecha
  description String
  complete    Boolean  @default(false)
  createAt    DateTime @default(now())
  updateAt    DateTime @updatedAt
}
```

Y tenemos que hacer la migracion de prisma a sql, con el siguiente comando

```
npx prisma migrate dev
```

el `dev` puede ser cualquier nombre

Cada vez que hagamos cambios a la base de datos, tendremos que hacer las migraciones

Y ya con eso ya creamos nuestra primera tabla en postgresql

Ahora tenemos que generar el cliente de prisma para poder manipular nuestra base de datos

para eso se ejecuta el siguiete comando

```
npx prisma generate
```

Ya esto nos da unos comandos para comenzar a usar prisma pero en la documentacion de next nos dicen que hagamos de la siguiente manera

/lib/prisma.ts

```ts
import { PrismaClient } from '@prisma/client';

let prisma: PrismaClient;

if (process.env.NODE_ENV === 'production') {
  prisma = new PrismaClient();
} else {
  if (!(global as any).prisma) {
    (global as any).prisma = new PrismaClient();
  }
  prisma = (global as any).prisma;
}

export default prisma;
```

Como estamos en ts para hacerlo rapido lo puse como any esos globals y ya con esto estamos listo para poder usar prisma
