# Prisma

- [Prisma](#prisma)
  - [Install](#install)
  - [Codigo](#codigo)
    - [Carpetas](#carpetas)

Es un orm en otras palabras es algo que nos ayuda a crear bases de datos con el codigo de js en este caso no con sql, ya esto lo convierte en sql pero nosotros escribimos en js

## Install

[documentacion](https://www.prisma.io/docs/getting-started/quickstart)

Ya teniamos un proyecto por eso solamente haremos lo siguiente

- `npm install prisma -D`
- `npx prisma init --datasource-provider sqlite`, aqui va la base de datos

## Codigo

prisma/schema.prisma

```prisma
generator client {    //prisma, con esto dice que usara codigo de js
  provider = "prisma-client-js"
}

datasource db {     //y la base de datos que usaremos
  provider = "sqlite"
  url      = env("DATABASE_URL")
}

model Task {    //para crear una tabla, y el nombre
  id Int @id @default(autoincrement())    //id sera int, '@id' sera un identificador unico, y se ira incrementando
  title String
  description String?   //no es requerido
  createAt DateTime @default(now())   //con now le decimos que sera la fecha en la que se guardo
}
```

Para crearlo es: `npx prisma migrate dev --name init` esto ya nos crea nuevas carpetas

### Carpetas

Migrations es el codigo en sql

con sqlite la base de datos esta en el archivo dev.db es la base de datos literal, con extensiones se ve lindo

ya para abrir la base de datos le damos click derecho a la base de datos, open with y con la extension

con `npx prisma studio` nos abre una linda interface tambien para ver los datos
