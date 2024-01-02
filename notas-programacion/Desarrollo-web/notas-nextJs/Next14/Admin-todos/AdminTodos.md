# Admin Todos

Un dashboar donde incluye ya base de datos y otras funcionalidades de next

- [Admin Todos](#admin-todos)
- [postgres](#postgres)
- [prisma](#prisma)
  - [migrations](#migrations)
  - [schema.prisma](#schemaprisma)
- [public](#public)
- [src](#src)
  - [app](#app)
    - [api](#api)
      - [auth](#auth)
        - [\[...nextauth\]](#nextauth)
          - [route.ts](#routets)
      - [hello](#hello)
        - [route.ts](#routets-1)
      - [seed](#seed)
        - [route.ts](#routets-2)
      - [todos](#todos)
        - [\[id\]](#id)
          - [route.ts](#routets-3)
        - [route.ts](#routets-4)
    - [auth](#auth-1)
      - [actions](#actions)
        - [auth-actions.ts](#auth-actionsts)
      - [components](#components)
        - [AuthProvider.tsx](#authprovidertsx)
    - [dashboard](#dashboard)
      - [cart](#cart)
        - [page.tsx](#pagetsx)
      - [cookies](#cookies)
        - [page.tsx](#pagetsx-1)
      - [products](#products)
        - [page.tsx](#pagetsx-2)
      - [profile](#profile)
        - [page.tsx](#pagetsx-3)
      - [rest-todos](#rest-todos)
        - [page.tsx](#pagetsx-4)
      - [server-todos](#server-todos)
        - [page.tsx](#pagetsx-5)
      - [layout.tsx](#layouttsx)
      - [page.tsx](#pagetsx-6)
    - [globals.css](#globalscss)
    - [layout.tsx](#layouttsx-1)
    - [page.tsx](#pagetsx-7)
  - [components](#components-1)
    - [LogouthButton.tsx](#logouthbuttontsx)
    - [Sidebar.tsx](#sidebartsx)
    - [SidebarItem.tsx](#sidebaritemtsx)
    - [TabBar.tsx](#tabbartsx)
    - [TopMenu.tsx](#topmenutsx)
    - [WidgetItem.tsx](#widgetitemtsx)
  - [lib](#lib)
    - [prisma.ts](#prismats)
  - [products](#products-1)
    - [components](#components-2)
      - [ProductCard.tsx](#productcardtsx)
      - [Star.tsx](#startsx)
    - [data](#data)
      - [products.ts](#productsts)
  - [shopping-cart](#shopping-cart)
    - [actions](#actions-1)
      - [actions.ts](#actionsts)
    - [components](#components-3)
      - [ItemCart.tsx](#itemcarttsx)
  - [todos](#todos-1)
    - [actions](#actions-2)
      - [todo-actions.ts](#todo-actionsts)
    - [components](#components-4)
      - [NewTodo.tsx](#newtodotsx)
      - [TodoItem.module.css](#todoitemmodulecss)
      - [TodoItem.tsx](#todoitemtsx)
      - [TodosGrid.tsx](#todosgridtsx)
    - [helpers](#helpers)
      - [todo.ts](#todots)
- [.env](#env)
- [docker-compose.yml](#docker-composeyml)
- [next.config.js](#nextconfigjs)
- [package.json](#packagejson)
- [tailwind.config.ts](#tailwindconfigts)

# postgres

Mi carpeta donde se almacena mi base de datos esta ahi por que en mi imagen de docker asi lo especifique

# prisma

Donde esta contenido todo lo de prisma

## migrations

Mis migraciones de prisma a sql

## schema.prisma

Todo mi codigo prisma, como mi generador del client, mi base de datos y mis modelos

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

// un model es como una tabla
model Todo {
  // con el @id le digo que sera esta columna un id y que por defecto sera un uuid
  id          String   @id @default(uuid())
  // creo mis columans y la
  //al create le digo que por defecto sera la hora en la que se cree
  //y el ultimo que por defecto sera la fecha
  description String
  complete    Boolean  @default(false)
  createAt    DateTime @default(now())
  updateAt    DateTime @updatedAt

  // esta es una relacion con User
  // aqui completo la relacion diciendo que solo tendra un user
  // las referencias ahi pongo la columan que quiero que traiga de la otra tabla, en este caso el id
  // mi campo donde lo almacenare sera esa columna userId
  User   User   @relation(fields: [userId], references: [id])
  userId String //esta es la creacion de la columna userId

  // esta nueva relacion como tenemos todos puede dar error por que no esta relacionados a ningun user entonces podemos purgar la tabla
}

// NextAuth.js
model Account {
  id                       String  @id @default(uuid())
  userId                   String
  type                     String
  provider                 String
  providerAccountId        String
  refresh_token_expires_in Int?
  refresh_token            String? @db.Text
  access_token             String? @db.Text
  expires_at               Int?
  token_type               String?
  scope                    String?
  id_token                 String? @db.Text
  session_state            String?

  user User @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@unique([provider, providerAccountId])
}

model Session {
  id           String   @id @default(uuid())
  sessionToken String   @unique
  userId       String
  expires      DateTime
  user         User     @relation(fields: [userId], references: [id], onDelete: Cascade)
}

model User {
  id            String    @id @default(uuid())
  name          String?
  email         String?   @unique
  password      String?
  roles         String[]  @default(["user"])
  isActive      Boolean   @default(true)
  emailVerified DateTime?
  image         String?
  accounts      Account[]
  sessions      Session[]

  todos Todo[] //aqui hago una relacion de uno a muchos, le digo que un user tendra muchos todos
}

model VerificationToken {
  identifier String
  token      String   @unique
  expires    DateTime

  @@unique([identifier, token])
}

```

# public

Mis archivos estaticos, img etc

# src

## app

### api

Mi RESTfull API

#### auth

##### [...nextauth]

Sintaxis especial de carpetas para que todo lo que entre al endpoint de apit auth pase por aqui y vaya al route

###### route.ts

```ts
import prisma from '@/lib/prisma';
import { PrismaAdapter } from '@auth/prisma-adapter';
import NextAuth, { NextAuthOptions } from 'next-auth';
import GithubProvider from 'next-auth/providers/github';
import GoogleProvider from 'next-auth/providers/google';
import CredentialsProvider from 'next-auth/providers/credentials';
import { signInEmailPassword } from '@/app/auth/actions/auth-actions';

// aqui simplemente voy haciendo mis proveedores de mi autenticacion
export const authOptions: NextAuthOptions = {
  // simplemenete asi, puedo poner mi Adaptador a prisma y se puede a varias base de datos
  adapter: PrismaAdapter(prisma),

  providers: [
    // este orden es el que seguiran al aparecer en la pagina para poder autenticar
    // primero github el boton para autenticar por github y despues google
    GithubProvider({
      clientId: process.env.GITHUB_ID ?? '',
      clientSecret: process.env.GITHUB_SECRET ?? '',
    }),
    // es de la misma manera hacerlo por google
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID ?? '',
      clientSecret: process.env.GOOGLE_CLIENT_SECRET ?? '',
    }),

    // esto es para que aparezca para que se pueda logear con email y password
    CredentialsProvider({
      // el nombre
      name: 'Credentials',
      // esto es para crear los inputs
      credentials: {
        email: {
          label: 'Email',
          type: 'email',
          placeholder: 'mar@gmail.com',
        },
        password: { label: 'Password', type: 'password', placeholder: 'mar12' },
      },
      async authorize(credentials, req) {
        // esta manera no es recomendada por que si no esta el correo de una vez lo crea, es mejor tener un formulario de creacion
        const user = signInEmailPassword(
          // en las credentials tengo las credentials de arriba y las envio a mi funcion para crear
          // si tiene usuario pues lo almacena pero si no tiene regresa un null
          credentials!.email,
          credentials!.password
        );

        if (user) {
          return user;
        } else {
          return null;
        }
      },
    }),
  ],

  session: {
    // aqui configure que la session este manejada con la estrategia json web token o algo asi
    strategy: 'jwt',
  },

  callbacks: {
    // estos callbacks se ejecutan despues de pasar la autenticacion del usuario
    // ahorita hice estos callbacks para que a mi session le agregara unos campos
    async signIn({ account, user, credentials, email, profile }) {
      return true;
      // return false   //con este return le digo que estoy negando la autenticacion, y puedo negarla dependiendo del user, email y asi si no cumplen con algo
    },

    // en este orden se ejecutan primero el json web token y despues la session
    async jwt({ token, account, user, profile, session }) {
      // yo estoy iniciando sesion con jwt entonces mi token contiene todos mis datos de mi session

      // en dbUser almaceno el usuario que inicio sesion
      const dbUser = await prisma.user.findUnique({
        // con el signo de exclamacion le digo que si vendra, como forzado
        where: { email: token.email! },
      });

      if (dbUser?.isActive === false) {
        // esto no dejaria entrar al usuario
        throw new Error('Usuario no esta activo');
      }

      token.roles = dbUser?.roles;
      token.id = dbUser?.id!;

      // entonces ahorita ya tiene mas informacion el token
      return token;
    },

    async session({ session, token, user }) {
      if (session && session.user) {
        // aqui si existe una session y el user le agrego estos nuevos campos a mi session, datos que los agregue al token
        session.user.roles = token.roles;
        session.user.id = token.id;
      }

      return session;
    },
  },
};

// aqui simplemente les paso mis opciones de autenticacion a NextAuth
const handler = NextAuth(authOptions);

// con esto le digo que usare handler para peticiones GET y para peticiones POST
export { handler as GET, handler as POST };
```

#### hello

##### route.ts

```ts
import { NextResponse, NextRequest } from 'next/server';

export async function GET(request: Request) {
  // un simple ejemplo de un endpoint
  return NextResponse.json({
    hola: 'Mar',
  });
}
```

#### seed

Nuestro seed, recordemos que es nuestra data como para comenzar, nuestra semilla

##### route.ts

```ts
import prisma from '@/lib/prisma'; //este prisma es el prismaClient que configuramos en esta direccion recordar, que es lo recomendado por next esa configuracion
// el prima client nos ayuda a crear traer y todo eso de la base de datos, en si todas las querys
import { NextResponse, NextRequest } from 'next/server';
import bcrypt from 'bcryptjs';

export async function GET(request: Request) {
  // primero eliminamos todo para crear nuestro seed
  await prisma.todo.deleteMany(); // delete * from todo, es lo mismo que eso eliminar todo
  await prisma.user.deleteMany(); // delete * from user,
  // ahora como hicimos una relacion no funciona el viejo seed ahora creamos uno

  const user = await prisma.user.create({
    data: {
      email: 'mar@gmail.com',
      password: bcrypt.hashSync('12'),
      roles: ['admin', 'client'],
      // para nuestro seed creamos el usuario y como es una relacion podemos crear de una vez los todos que estaran conectados a el usuario
      todos: {
        create: [
          {
            description: 'Amar a Marcela',
            complete: true,
          },
          {
            description: 'Besar a Marcela',
          },
          {
            description: 'Abrazar a Marcela',
          },
          {
            description: 'Mar',
          },
        ],
      },
    },
  });

  // await prisma.todo.deleteMany({ where: {} });   //asi podemos ponerle el where

  // aqui almaceno en una variable lo que creo en prisma
  // prisma es mi prisma client para poder hacer cosas, y le digo que en mi model todo cree algo y en data le pongo que crear
  // const todo = await prisma.todo.create({
  //   data: {
  //     description: 'Ser novio de la chica mas hermosa',
  //     complete: true,
  //   },
  // });
  // con esto hacemos una insercion

  // asi podemos crear muchos, ya recibe en data un arreglo
  // const todos = await prisma.todo.createMany({
  //   data: [
  //     {
  //       description: 'Amar a Marcela',
  //       complete: true,
  //     },
  //     {
  //       description: 'Besar a Marcela',
  //     },
  //     {
  //       description: 'Abrazar a Marcela',
  //     },
  //     {
  //       description: 'Mar',
  //     },
  //   ],
  // });

  return NextResponse.json(user);
}
```

#### todos

##### [id]

###### route.ts

```ts
import prisma from '@/lib/prisma';
import * as yup from 'yup';
import { NextResponse, NextRequest } from 'next/server';

interface Segments {
  params: {
    id: string;
  };
}

export async function GET(request: Request, segments: Segments) {
  // aqui en el segundo argumetno podemos obtener los params en este caso que estamos haciendo con las rutas
  const id = segments.params.id;

  //   y asi podemos buscar por el id que manden en la url
  // url: http://localhost:3000/api/todos/id

  // aqui busco el todo con ese id
  const todo = await prisma.todo.findUnique({
    where: { id: id },
  });

  //   si es null entonces no encontro algo y envio esta respuesta
  //   if (todo === null) {     esta es otra manera de hacerlo
  if (!todo) {
    return NextResponse.json({ message: 'El Id no existe' }, { status: 404 });
  }
  return NextResponse.json(todo);
}

// mi esquema de validacion , explicado en el route del todos
const putSchema = yup.object({
  description: yup.string().optional(),
  complete: yup.boolean().optional(),
});

export async function PUT(request: Request, segments: Segments) {
  // recordemos que el put es para actualizar entonces le enviamos un body
  try {
    const id = segments.params.id;
    // obtenemos el id y lo que enviaron del body
    const { description, complete } = await putSchema.validate(
      await request.json()
    );

    const todo = await prisma.todo.findUnique({
      where: { id: id },
    });

    if (!todo) {
      return NextResponse.json({ message: 'El Id no existe' }, { status: 404 });
    }

    const updateTodo = await prisma.todo.update({
      // para acutualizarlo le ponemos cual y la data, recordemos que es igual que decir
      // description: description
      where: { id: id },
      data: { description, complete },
    });
    return NextResponse.json(updateTodo);
  } catch (error) {
    return NextResponse.json(error, { status: 400 });
  }
}
```

##### route.ts

Mi endpoint de todos

```ts
import prisma from '@/lib/prisma';
import * as yup from 'yup'; // con esto importo todo y lo almacene todo en esa tipo variable yup
import { NextResponse, NextRequest } from 'next/server';
import { getServerSession } from 'next-auth';
import { authOptions } from '../auth/[...nextauth]/route';

export async function GET(request: Request) {
  // esto nos ayuda a obtener los querys de las urls que estan despues del signo ?
  const { searchParams } = new URL(request.url); //aqui estraigo el searchParams de la url del request que tenemos

  //const take = Number(searchParams.get('take') ?? '10');   //puedo hacer esto para convertir a numero los searchParams para evitar poner el mas
  const take = searchParams.get('take') ?? '1'; //aqui le digo que el query que quiero es el take y almeceno lo almaceno en la variable
  const skip = searchParams.get('skip') ?? '1';

  //   isNaN devuelve un true si no es un numero o no se puede convertir en numero y devuelve false si es un numero
  // el + antes de alguna cadena de texto o un numero de string convierte el numero en string a un numero normal
  if (isNaN(+take)) {
    return NextResponse.json(
      { message: 'Take tiene que ser un numero' },
      { status: 400 }
    );
  }
  if (isNaN(+skip)) {
    return NextResponse.json(
      { message: 'Skip tiene que ser un numero' },
      { status: 400 }
    );
  }

  // asi podemos obtener todos, siempre pueden recibir mas argumentos, buscar en la documentacion
  const todos = await prisma.todo.findMany({
    // con el skip le digo que se skipee esa cantidad de datos si pongo un 4 entonces comenzaria a mostrar desde el 5 es el paginate
    // el take es cuantos datos quiero recibir
    take: +take,
    skip: +skip,
  });
  //   entonces la url es asi usando lo que usamos aqui :
  // http://localhost:3000/api/todos?skip=2&take=4

  if (todos.length < 1) {
    const todo = await prisma.todo.findMany();
    return NextResponse.json(todo);
  }

  console.log(todos);
  return NextResponse.json(todos);
}

// esto es un objeto de validacion si no comple con lo siguiente dara error, usamos el yup.object para crearlo
// y ponemos las propiedades qeu aceptaremos y que seran, un string y requerido o opcional y por defecto le podemos poner eso y muchas otras cosas
const postSchema = yup.object({
  description: yup.string().required(),
  complete: yup.boolean().optional().default(false),
});

export async function POST(request: Request) {
  // aqui obtenemos la session de NextAuth.js
  const session = await getServerSession(authOptions);

  if (!session) {
    return NextResponse.json('No user', { status: 401 });
  }

  try {
    // en el request.json() es lo que envian como en json del body
    // y ya usamos nuestro objeto y validamos si lo que envien en el body ya que lo que envian
    //   si esto no cumple dara un error por eso lo podemos hacer con un try catch
    const { description, complete } = await postSchema.validate(
      await request.json()
    );
    // desestructuramos por si envian mas de una propiedad asi solo usamos las que necesitamos

    const todo = await prisma.todo.create({
      // le digo que si o si tendra una session con los signos de exclamacion
      // aqui creo un todo ya con el userId del que obtuve de mi session
      data: { description, complete, userId: session!.user!.id },
    });

    return NextResponse.json(todo);
  } catch (error) {
    return NextResponse.json(error, { status: 400 });
  }
}

export async function DELETE(reques: Request) {
  // primero obtengo y valido si tengo un usuario
  const session = await getServerSession(authOptions);

  if (!session) {
    return NextResponse.json('No user', { status: 401 });
  }

  try {
    const todos = await prisma.todo.deleteMany({
      where: {
        // y elimino todos los que tengan complete en true y el userId sean el que en ese momento este logueado
        complete: true,
        userId: session.user?.id,
      },
    });
    return NextResponse.json(todos);
  } catch (error) {
    return NextResponse.json(error, { status: 400 });
  }
}
```

### auth

#### actions

Mis funciones del servidor, server actions de auth

##### auth-actions.ts

```ts
import prisma from '@/lib/prisma';

// npm i bcryptjs
// npm i --save-dev @types/bcryptjs
import bcrypt from 'bcryptjs';

export const signInEmailPassword = async (email: string, password: string) => {
  if (!email || !password) return null; //si no envian algo retornamos null

  // si enviaron algo lo buscamoso en la base de datos
  const user = await prisma.user.findUnique({ where: { email: email } });

  if (!user) {
    // arriba obtuve el usuario y si no existe lo creo
    const dbUser = await createUser(email, password);
    // y esto retorna un usuario completo
    return dbUser;
  }

  if (!bcrypt.compareSync(password, user.password!)) {
    // aqui le digo que si no hacen match el password que recibimos, con el de la base de datos y si no hacen match retornamos un null
    return null;
  }

  // y al final si esta el usuario en la base de datos solo lo regreso
  return user;
};

const createUser = async (email: string, password: string) => {
  // para crear un usuario
  const user = await prisma.user.create({
    data: {
      email: email,
      // con esto encripto el password
      password: bcrypt.hashSync(password),
      // aqui con split estoy cortando por la @ y lo hago un arreglo entonces tomo la primera posicion que es todo lo que este antes de la @
      name: email.split('@')[0],
    },
  });
  return user;
};
```

#### components

##### AuthProvider.tsx

```tsx
'use client';

import { SessionProvider } from 'next-auth/react';

interface Props {
  children: React.ReactNode;
}

export const AuthProvider = ({ children }: Props) => {
  // esto es necesario para obtener nuestra sesion del lado del cliente,
  //y tenemos que poner esto lo mas alto posible de la aplicacion, en este caso el primer layout
  return <SessionProvider>{children}</SessionProvider>;
};
```

### dashboard

#### cart

##### page.tsx

```tsx
import { WidgetItem } from '@/components/WidgetItem';
import { products, type Product } from '@/products/data/products';
import { getCookieCart } from '@/shopping-cart/actions/actions';
import { ItemCard } from '@/shopping-cart/components/ItemCart';
import { cookies } from 'next/headers';

export const metadata = {
  title: 'Productos en carrito',
  description: 'Productos en carrito',
};

interface ProductsInCart {
  product: Product;
  quantity: number;
}

const getProductsInCart = (cart: {
  [id: string]: number;
}): ProductsInCart[] => {
  const productsInCart: ProductsInCart[] = [];

  for (const id of Object.keys(cart)) {
    // con este for of recorro el objeto y almaceno en la variable la clave (key) del objeto cart
    const product = products.find((prod) => prod.id === id);
    // y qui almaceno el producto que coicida con el id, y si coiciden y existe hago el push al arreglo
    if (product) {
      // entonces como estamos leyendo las cookies si existe el producto que leemos en las cookies en nuestro arreglo de productos, lo almacenamos a nuestra variable
      productsInCart.push({ product: product, quantity: cart[id] });
      // recordar que es clave valor, la clave es el id y el valor es la cantidad que almacena por eso le pongo en quantity el valor
    }
  }

  return productsInCart;
};

export default function CartPage() {
  // esta ya viene de next para obtener las cookies
  const cookiesStore = cookies();
  // aqui simplemente con un get y lo paso a un objeto, si no hay nada pues que convierta el string '{}'
  const cart = JSON.parse(cookiesStore.get('cart')?.value ?? '{}');
  // y aqui le envio el arreglo de mis cookies, recordemos que tiene el id del producto y la cantidad de cuantos tiene
  const productsInCart = getProductsInCart(cart);

  // esta es una funcoin desconocida
  const totalToPay = productsInCart.reduce(
    (prev, current) => current.product.price * current.quantity + prev,
    0
  );

  return (
    <div>
      <h1 className='text-5xl'>Productos en el carrito</h1>
      <hr className='mb-2' />

      <div className='flex flex-col sm:flex-row gap-2 w-full'>
        <div className='flex flex-col sm:w-8/12 gap-2 w-full'>
          {/* la funcion nos devolvio el producto y la cantidad de cuantos tenemos en las cookies*/}
          {productsInCart.map(({ product, quantity }) => (
            <ItemCard key={product.id} product={product} quantity={quantity} />
          ))}
        </div>

        <div className='flex flex-col w-full sm:w-4/12'>
          <WidgetItem title='Total a Pagar'>
            <div className='mt-2 flex justify-center gap-4'>
              <h3 className='text-3xl font-bold text-gray-700'>
                {/* toFixed es para poner decimales */}$
                {(totalToPay * 1.15).toFixed(2)}
              </h3>
            </div>
            <span className='font-bold text-center text-gray-500'>
              Impuesto 15%: ${(totalToPay * 0.15).toFixed(2)}
            </span>
          </WidgetItem>
        </div>
      </div>
    </div>
  );
}
```

#### cookies

##### page.tsx

```tsx
import { cookies } from 'next/headers';
import { TabBar } from '@/components/TabBar';

export const metadata = {
  title: 'Cookies Page',
  description: 'Cookies Page',
};

export default function CookiesPage() {
  const cookieStore = cookies();
  const cookieTab = cookieStore.get('selectedTab')?.value ?? '1';
  // arriba pido el value por qeu obtiene la clave y el valor etonces quiro el value y le digo que si es udefineded que sea el 1
  return (
    <div className='grid grid-cols-1 sm:grid-cols-2 gap-3'>
      <div className='flex flex-col'>
        <span className='text-3xl'>Tabs</span>
        <TabBar currentTab={+cookieTab} />
        {/* recuerden que poner el + al inicio lo vuelve un numero */}
      </div>
    </div>
  );
}
```

#### products

##### page.tsx

```tsx
import { ProductCard } from '@/products/components/ProductCard';
import { products } from '@/products/data/products';

export default function ProductsPage() {
  return (
    <div className='grid grid-cols-1 sm:grid-cols-3 gap-2'>
      *
      {/* obtengo mi arreglo de productos que es equivalente como si lo obtuviera de una base de datos y lo envio a mi componente */}
      {products.map((product) => (
        <ProductCard key={product.id} {...product} />
      ))}
    </div>
  );
}
```

#### profile

##### page.tsx

```tsx
'use client';

import { useSession } from 'next-auth/react';
export default function ProfilePage() {
  // asi de simple podemos obtener la data del lado del cliente,
  // con los dos puntos renombro la variable
  const { data: session } = useSession();

  return (
    <div>
      <h1>Hello Page</h1>
      <hr />

      <div className='flex flex-col'>
        <span>{session?.user?.name}</span>
        <span>{session?.user?.email}</span>
        <span>{session?.user?.image}</span>
        <span>{session?.user?.id}</span>
        {/* recordar que con el join unimos un arreglo con lo que le pongamos ahi */}
        <span>{session?.user?.roles?.join(', ')}</span>
      </div>
    </div>
  );
}
```

#### rest-todos

##### page.tsx

```tsx
//estas dos lineas hacen que la cache se maneje diferente en otras palabras que se vuelva a recargar

export const dynamic = 'force-dynamic';
export const revalidate = 0;

import { authOptions } from '@/app/api/auth/[...nextauth]/route';
import prisma from '@/lib/prisma';
import { NewTodo } from '@/todos/components/NewTodo';
import { TodosGrid } from '@/todos/components/TodosGrid';
import { getServerSession } from 'next-auth';

export const metadata = {
  title: 'Rest Todos',
  description: 'SEO Title',
};

export default async function RestTodosPage() {
  // esta es una manera de obtenerlo mediante un server component, nuestra session de nextAuth.js
  const session = await getServerSession(authOptions);

  // como es un componente del servidor podemos pedir directamente a la base de datos
  const todos = await prisma.todo.findMany({
    // aqui pregunto que me traiga solamente los que el userId sean igual al id de la session
    where: { userId: session!.user!.id },
    // aqui le digo que me lo ordene por la descripcion ascendente
    orderBy: { description: 'asc' },
  });

  // asi pedimos datos desde el lado del cliente pero como este es un componente del servidor entonces podemos pedir a la base de datos directamente
  // useEffect(() => {
  //   fetch('/api/todos')
  //     .then((res) => res.json())
  //     .then((data) => console.log(data));
  // }, []);

  return (
    <div>
      <div className='w-full px-3 mx-5 mb-5'>
        <NewTodo />
      </div>

      <TodosGrid todos={todos} />
    </div>
  );
}
```

#### server-todos

##### page.tsx

```tsx
export const dynamic = 'force-dynamic';
export const revalidate = 0;

import { authOptions } from '@/app/api/auth/[...nextauth]/route';
import prisma from '@/lib/prisma';
import { NewTodo } from '@/todos/components/NewTodo';
import { TodosGrid } from '@/todos/components/TodosGrid';
import { getServerSession } from 'next-auth';

export const metadata = {
  title: 'Rest Todos',
  description: 'SEO Title',
};

export default async function ServerTodosPage() {
  // esta es una manera de obtenerlo mediante un server component la session de nextAuth.js
  const session = await getServerSession(authOptions);

  const todos = await prisma.todo.findMany({
    // aqui pregunto que me traiga solamente los que el userId sean igual al id de la session
    where: { userId: session!.user!.id },
    orderBy: { description: 'asc' },
  });

  return (
    <>
      <span className='text-3xl mb-10 text-gray-900s'>Server-Action</span>
      <div className='w-full px-3 mx-5 mb-5'>
        <NewTodo />
      </div>

      <TodosGrid todos={todos} />
    </>
  );
}
```

#### layout.tsx

```tsx
// Admin Dashboard https://tailwindcomponents.com/component/dashboard-12
import { Sidebar } from '@/components/Sidebar';
import { TopMenu } from '@/components/TopMenu';

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <>
      <Sidebar />
      <div className='ml-auto mb-6 lg:w-[75%] xl:w-[80%] 2xl:w-[85%] min-h-screen'>
        <TopMenu />
        <div className='px-6 pt-6 bg-white p-2 m-2 pb-5 rounded'>
          {/* recordemos que los layouts aunque no los llameos en el children entraran todos los pages que esten en su nivel o mas abajo */}
          {children}
        </div>
      </div>
    </>
  );
}
```

#### page.tsx

```tsx
import { WidgetItem } from '@/components/WidgetItem';
import { authOptions } from '../api/auth/[...nextauth]/route';
import { getServerSession } from 'next-auth';

import { redirect } from 'next/navigation';

export default async function DashboardPage() {
  // asi podemos obtener el usuario y les mandamos nuestras authOptions que las tenemos en nuestro route de auth,
  // siempre para obtenerlas tenemos que enviarlas
  const session = await getServerSession(authOptions);

  if (!session) {
    // con esto hago como una proteccion de rutas desde mi page
    // si no tengo session entonces lo redirijo al signin
    // este endpoint es especial para poder logearse
    redirect('/api/auth/signin');
  }

  return (
    <div className='grid gap-6 grid-cols-1'>
      {/* mi WidgetItem que recibe un children y un titulo */}
      <WidgetItem title='Usuario conectado Server Side'>
        <div className='flex flex-col'>
          <span>{session.user?.name}</span>
          <span>{session.user?.email}</span>
          <span>{session.user?.image}</span>

          <div>{JSON.stringify(session)}</div>
        </div>
      </WidgetItem>
    </div>
  );
}
```

### globals.css

Nuestros estilos globales en este caso solamente estan nuestras configuraciones de tailwind

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### layout.tsx

Mi layout principal

```tsx
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';
import { AuthProvider } from './auth/components/AuthProvider';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  // mi metadata dinamica
  title: 'Create Next App',
  description: 'Generated by create next app',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    // mi AuthProvider que nos pide el auth.js para poder obtener los valores de nuestra session
    // lo mas algo posible por esto esta aqui
    <AuthProvider>
      <html lang='en'>
        <body className={inter.className}>{children}</body>
      </html>
    </AuthProvider>
  );
}
```

### page.tsx

```tsx
import { redirect } from 'next/navigation';

export default function HomePage() {
  // simplemente lo enviamos a nuestra pagina principal
  redirect('/dashboard');
}
```

## components

### LogouthButton.tsx

```tsx
'use client';

import { CiLogout } from 'react-icons/ci';
import { useSession, signIn, signOut } from 'next-auth/react';

export const LogouthButton = () => {
  // boton de logout de mi sidebar

  // de useSession que con eso obtengo mi session de next auth tambien puedo obtener el estado en el que esta o auth o no auth...
  const { data: session, status } = useSession();

  // dependiendo del estado muestro diferentes botones
  if (status === 'loading') {
    return (
      <button className='px-4 py-3 flex items-center space-x-4 rounded-md text-gray-600 group'>
        <CiLogout />
        <span className='group-hover:text-gray-700'>Espere...</span>
      </button>
    );
  }
  if (status === 'unauthenticated') {
    return (
      <button
        // esto ya no lo da nextAuth.js para hacer algunas aciones en este caso me envia para logearme
        onClick={() => signIn()}
        className='px-4 py-3 flex items-center space-x-4 rounded-md text-gray-600 group'
      >
        <CiLogout />
        <span className='group-hover:text-gray-700'>Login</span>
      </button>
    );
  }

  return (
    <button
      // esto ya no lo da next auth, esto me quita el logout
      onClick={() => signOut()}
      className='px-4 py-3 flex items-center space-x-4 rounded-md text-gray-600 group'
    >
      <CiLogout />
      <span className='group-hover:text-gray-700'>Logout</span>
    </button>
  );
};
```

### Sidebar.tsx

```tsx
import Image from 'next/image';
import Link from 'next/link';
import {
  IoCheckboxOutline,
  IoCalendarOutline,
  IoListOutline,
  IoCafeOutline,
  IoShirtOutline,
  IoPersonOutline,
} from 'react-icons/io5';
import { SidebarItem } from './SidebarItem';
import { authOptions } from '@/app/api/auth/[...nextauth]/route';
import { getServerSession } from 'next-auth';

import { redirect } from 'next/navigation';
import { LogouthButton } from './LogouthButton';

// para hacer mas facil mis elementos del sidebar
const sidebarItem = [
  {
    href: '/dashboard',
    text: 'Dashboard',
    icon: <IoCalendarOutline size={20} />,
  },
  {
    href: '/dashboard/rest-todos',
    text: 'Rest Todos',
    icon: <IoCheckboxOutline size={20} />,
  },
  {
    href: '/dashboard/server-todos',
    text: 'Server Actions',
    icon: <IoListOutline size={20} />,
  },
  {
    href: '/dashboard/cookies',
    text: 'Cookies',
    icon: <IoCafeOutline size={20} />,
  },
  {
    href: '/dashboard/products',
    text: 'Productos',
    icon: <IoShirtOutline size={20} />,
  },
  {
    href: '/dashboard/profile',
    text: 'Profile',
    icon: <IoPersonOutline size={20} />,
  },
];

export const Sidebar = async () => {
  // de nuevo digo esto es para tomarlo del lado del servidor, para tomar la session
  const session = await getServerSession(authOptions);

  if (!session) {
    // si no tengo session lo redirijo a el signin
    redirect('/api/auth/signin');
  }

  return (
    <aside className='ml-[-100%] fixed z-10 top-0 pb-3 px-6 w-full flex flex-col justify-between h-screen border-r bg-white transition duration-300 md:w-4/12 lg:ml-0 lg:w-[25%] xl:w-[20%] 2xl:w-[15%]'>
      <div>
        <div className='-mx-6 px-6 py-4'>
          <Link href='/dashboard' title='home'>
            <Image
              src='https://tailus.io/sources/blocks/stats-cards/preview/images/logo.svg'
              className='w-32'
              alt='tailus logo'
              width={100}
              height={100}
            />
          </Link>
        </div>

        <div className='mt-8 text-center'>
          <Image
            src={
              // aqui le digo qeu si tengo una imagen que use la que tengo en session si no esa quemada que esta
              session.user?.image
                ? session.user.image
                : 'https://tailus.io/sources/blocks/stats-cards/preview/images/second_user.webp'
            }
            alt=''
            width={100}
            height={100}
            className='w-10 h-10 m-auto rounded-full object-cover lg:w-28 lg:h-28'
          />
          <h5 className='hidden mt-4 text-xl font-semibold text-gray-600 lg:block'>
            {session.user?.name}
          </h5>
          <span className='hidden text-gray-400 lg:block'>
            {/* esto como es un arreglo uno cada valor con una coma y un espacio */}
            {session.user?.roles?.join(', ')}
          </span>
        </div>

        <ul className='space-y-2 tracking-wide mt-8'>
          {sidebarItem.map((item) => (
            <SidebarItem
              key={item.href}
              text={item.text}
              href={item.href}
              icon={item.icon}
            />
          ))}
        </ul>
      </div>

      <div className='px-6 -mx-6 pt-4 flex justify-between items-center border-t'>
        <LogouthButton />
      </div>
    </aside>
  );
};
```

### SidebarItem.tsx

```tsx
'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import React from 'react';

interface Props {
  text: string;
  href: string;
  icon: React.ReactNode;
  // el React.ReactNode le digo que sera un elemento de react
}

export const SidebarItem = ({ text, href, icon }: Props) => {
  // para obtener el path
  const path = usePathname();

  return (
    <>
      <li>
        <Link
          href={href}
          className={
            // una clase especial si esta activa la pagina en el sidebar
            href === path
              ? 'relative px-4 py-3 flex items-center space-x-4 rounded-md text-white bg-gradient-to-r from-sky-600 to-cyan-400'
              : 'px-4 py-3 flex items-center space-x-4 rounded-md text-gray-600 group hover:text-white hover:bg-gradient-to-r hover:from-sky-500 hover:to-cyan-300'
          }
        >
          {icon}
          <span className='-mr-1 font-medium'>{text}</span>
        </Link>
      </li>
    </>
  );
};
```

### TabBar.tsx

```tsx
'use client';

// esta es una libreria para manejar las cookies de manera facil
import { setCookie, getCookie } from 'cookies-next';
import { useRouter } from 'next/navigation';
import { useState } from 'react';

// https://tailwindcomponents.com/component/radio-buttons-1

interface Props {
  currentTab?: number;
  tabOptions?: number[];
}

export const TabBar = ({
  currentTab = 1,
  tabOptions = [1, 2, 3, 4, 5],
}: Props) => {
  // el use router es para poder hacer funciones como la de abajo
  const route = useRouter();
  const [selected, setSelected] = useState(currentTab);

  const onTabSelected = (tab: number) => {
    // con las cookies ya no necesiaramos el useState
    // en el tab esta el numero al que le de click, si esta en el input 3 y le di click ahi ese sera el tab
    setSelected(tab);
    // primero lo establezco a mi state y despues lo guardo en mis cookies

    // el primer argumento es el nombre y el segundo la data, recordadr tienen que ser string, y tiene un tercer argumento para poner otras opciones
    setCookie('selectedTab', tab.toString());
    // esto es para refrescar solo esta ruta, sin refrescar lo demas
    route.refresh();
  };

  return (
    <div
      className={`grid w-full space-x-2 rounded-xl bg-gray-200 p-2
        ${'grid-cols-' + tabOptions.length}
    `}
    >
      {/* aqui creo un div con estos inputs y label dependiendo del arreglo que recibo en las props, donde solo son de numeros */}
      {tabOptions.map((tab) => (
        <div key={tab}>
          <input
            // sera ckeck si el tab (algun numero del arreglo) sea igual a mi estado
            checked={tab === selected}
            // cuando ponemos un checked nos obliga a poner un onChange para poder cambiarlo pero como lo estoy haciendo abajo no hay problema ponerlo asi
            onChange={() => {}}
            type='radio'
            id={tab.toString()}
            className='peer hidden'
          />
          <label
            // al darle click hago toda la logica lo pongo en mi state y lo creo en mis cookies
            onClick={() => onTabSelected(tab)}
            className='transition-all block cursor-pointer select-none rounded-xl p-2 text-center peer-checked:bg-blue-500 peer-checked:font-bold peer-checked:text-white'
          >
            {tab}
          </label>
        </div>
      ))}
    </div>
  );
};
```

### TopMenu.tsx

```tsx
import { cookies } from 'next/headers';
import Link from 'next/link';
import React from 'react';
import {
  CiChat1,
  CiMenuBurger,
  CiSearch,
  CiShoppingBasket,
} from 'react-icons/ci';

export const TopMenu = () => {
  const cookieStore = cookies();
  // aqui obtengo mi cookie cart y lo paso a un objeto
  const cart = JSON.parse(cookieStore.get('cart')?.value ?? '{}');

  const getTotalCount = (): number => {
    let items = 0;
    // veamos aqui en con el Object.values obtengo los valores de algun objeto, y con el forEach le digo que recorra cada uno de ellos y se los vaya sumando al items
    Object.values(cart).forEach((value) => {
      // y le pongo que value sera number
      items += value as number;
    });

    // esta funcion suma todos los items que tiene nuestra cookies y solo devuelve un numero
    return items;
  };

  return (
    <div className='sticky z-10 top-0 h-16 border-b bg-white lg:py-2.5'>
      <div className='px-6 flex items-center justify-between space-x-4'>
        <h5 hidden className='text-2xl text-gray-600 font-medium lg:block'>
          Dashboard
        </h5>
        <button className='w-12 h-16 -mr-2 border-r lg:hidden'>
          <CiMenuBurger size={30} />
        </button>
        <div className='flex space-x-2'>
          <div hidden className='md:block'>
            <div className='relative flex items-center text-gray-400 focus-within:text-cyan-400'>
              <span className='absolute left-4 h-6 flex items-center pr-3 border-r border-gray-300'>
                <CiSearch />
              </span>
              <input
                type='search'
                name='leadingIcon'
                id='leadingIcon'
                placeholder='Search here'
                className='w-full pl-14 pr-4 py-2.5 rounded-xl text-sm text-gray-600 outline-none border border-gray-300 focus:border-cyan-300 transition'
              />
            </div>
          </div>

          <button className='flex items-center justify-center w-10 h-10 rounded-xl border bg-gray-100 focus:bg-gray-100 active:bg-gray-200 md:hidden'>
            <CiSearch />
          </button>
          <button className='flex items-center justify-center w-10 h-10 rounded-xl border bg-gray-100 focus:bg-gray-100 active:bg-gray-200'>
            <CiChat1 size={25} />
          </button>

          <Link
            href={'/dashboard/cart'}
            className='p-2 flex items-center justify-center h-10 rounded-xl border bg-gray-100 focus:bg-gray-100 active:bg-gray-200'
          >
            <span className='text-sm mr-2 text-blue-800 font-bold'>
              {/* aqui solamente ponemos el numero de la suma de todo */}
              {getTotalCount()}
            </span>
            <CiShoppingBasket size={25} />
          </Link>
        </div>
      </div>
    </div>
  );
};
```

### WidgetItem.tsx

```tsx
import React from 'react';

interface Props {
  title?: string;
  children?: React.ReactNode;
}

export const WidgetItem = ({ children, title }: Props) => {
  return (
    <div className='md:col-span-2 lg:col-span-1'>
      <div className='h-full py-8 px-6 space-y-6 rounded-xl border border-gray-200 bg-white'>
        <div>
          <h5 className='text-xl text-gray-600 text-center'>{title}</h5>
          <div className='mt-2 flex justify-center gap-4 flex-col'>
            {children}
          </div>
        </div>
      </div>
    </div>
  );
};
```

## lib

### prisma.ts

Nuestro generador de prisma como lo recomienda next

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

## products

### components

#### ProductCard.tsx

```tsx
'use client';

// https://tailwindcomponents.com/component/e-commerce-product-card

import Image from 'next/image';
import { IoAddCircleOutline, IoTrashOutline } from 'react-icons/io5';
import type { Product } from '../data/products';
import { Star } from './Star';
import {
  addProductToCart,
  removeProduct,
} from '@/shopping-cart/actions/actions';
import { useRouter } from 'next/navigation';

export const ProductCard = ({ id, image, name, price, rating }: Product) => {
  const router = useRouter();

  const onAddToCart = () => {
    // esto simplemente crea un producto o agrega uno y el de abajo elimina todo el producto
    addProductToCart(id);
    // recordemos que este refresca la ruta ne la que estamos solo cambiando estos estados no los demas
    router.refresh();
  };

  const onRemoveCart = () => {
    removeProduct(id);
    router.refresh();
  };
  return (
    <div className='bg-white shadow rounded-lg max-w-sm dark:bg-gray-800 dark:border-gray-100'>
      {/* Product Image */}
      <div className='p-2'>
        <Image
          width={500}
          height={500}
          className='rounded'
          src={image}
          alt='product image'
        />
      </div>

      {/* Title */}
      <div className='px-5 pb-5'>
        <a href='#'>
          <h3 className='text-gray-900 font-semibold text-xl tracking-tight dark:text-white'>
            {name}
          </h3>
        </a>
        <div className='flex items-center mt-2.5 mb-5'>
          {/* Stars */}
          {/* con esto creo un nuevo array y adentro le doy la longitud y lo lleno con el fill con el valor 0 y ya puedo hacer el map dependiendo del numero de estrellas */}
          {Array(rating)
            .fill(0)
            .map((x, i) => (
              <Star key={i} />
            ))}

          {/* Rating Number */}
          <span className='bg-blue-100 text-blue-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800 ml-3'>
            {rating}
          </span>
        </div>

        {/* Price and Add to Cart */}
        <div className='flex items-center justify-between'>
          <span className='text-3xl font-bold text-gray-900 dark:text-white'>
            ${price}
          </span>

          <div className='flex'>
            <button
              onClick={onAddToCart}
              className='text-white mr-2 bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800'
            >
              <IoAddCircleOutline size={25} />
            </button>
            <button
              onClick={onRemoveCart}
              className='text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800'
            >
              <IoTrashOutline size={20} />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};
```

#### Star.tsx

```tsx
import React from 'react';

export const Star = () => {
  // una simple estrella
  return (
    <svg
      className='w-5 h-5 text-yellow-300'
      fill='currentColor'
      viewBox='0 0 20 20'
      xmlns='http://www.w3.org/2000/svg'
    >
      <path d='M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z'></path>
    </svg>
  );
};
```

### data

Donde guarde mi data de mis productos, no use una base de datos solo use un simple array

#### products.ts

```ts
export interface Product {
  id: string;
  name: string;
  price: number;
  rating: number;
  image: string;
}

export const products: Product[] = [
  {
    id: 'UUID-ABC-1',
    name: 'Teslo Hoodie',
    price: 15,
    rating: 5,
    image: '/images/products/1623735-00-A_0_2000.jpg',
  },
  {
    id: 'UUID-ABC-2',
    name: 'Teslo Cap',
    price: 25,
    rating: 3,
    image: '/images/products/1657916-00-A_1.jpg',
  },
  {
    id: 'UUID-ABC-3',
    name: 'Let the sunshine',
    price: 36,
    rating: 2,
    image: '/images/products/1700280-00-A_1.jpg',
  },
  {
    id: 'UUID-ABC-4',
    name: 'Cybertruck Hoodie',
    price: 45,
    rating: 5,
    image: '/images/products/1742702-00-A_0_2000.jpg',
  },
];
```

## shopping-cart

### actions

Mis server actions, mis funciones del lado del servidor

#### actions.ts

```ts
import { getCookie, hasCookie, setCookie } from 'cookies-next';

export const getCookieCart = (): { [id: string]: number } => {
  // le digo que devolvera un objeto con un id que sera string como clave y el valor sera un number

  if (hasCookie('cart')) {
    // este hasCookie nos dice si existe esa cookie entonces si es asi la almaceno en la variable
    const cookieCart = JSON.parse((getCookie('cart') as string) ?? '{}');
    // aqui le digo que lo pase a un objeto por eso el jsonParse con el as le digo que sera un string y si no hay nada '??' que sea un objeto
    return cookieCart;
  }

  return {};
};

export const addProductToCart = (id: string) => {
  // Aqui obtengo el objeto de nuestra cookie
  const cookieCart = getCookieCart();

  // recordemos que este objeto solamente apunta a un numero entonces le pregunto si existe con la clave del id entre al if
  if (cookieCart[id]) {
    // y si existe puede ser que haya un 4 en esa posicion, recordemos que con corchetes es lo mismo que en un objeto le pongamos 'cookieCart.id'
    // y si existe pues le sumamos 1 al valor que esta ahi
    cookieCart[id] = cookieCart[id] + 1;
  } else {
    cookieCart[id] = 1;
  }
  // y establecemos el nuevo valor a nuestras cookies
  setCookie('cart', JSON.stringify(cookieCart));
};

export const removeProduct = (id: string) => {
  const cookieCart = getCookieCart();
  // aqui elimino todo el producto de mi objeto gracias al delete
  delete cookieCart[id];
  // y la establezco como siempre a nuestras cookies
  setCookie('cart', JSON.stringify(cookieCart));
};

export const removeOneProduct = (id: string) => {
  const cookieCart = getCookieCart();

  if (cookieCart[id] && cookieCart[id] > 0) {
    // aqui voy eliminando una por una mientras exista y sea mayor a 0
    cookieCart[id] -= 1;
  }

  if (cookieCart[id] <= 0) {
    delete cookieCart[id];
  }

  setCookie('cart', JSON.stringify(cookieCart));
};
```

### components

#### ItemCart.tsx

```tsx
'use client';

import Image from 'next/image';

import type { Product } from '@/products/data/products';
import { IoAddCircleOutline, IoRemove } from 'react-icons/io5';
import { addProductToCart, removeOneProduct } from '../actions/actions';

import { useRouter } from 'next/navigation';

interface Props {
  product: Product;
  quantity: number;
}

export const ItemCard = ({ product, quantity }: Props) => {
  // mi router para hacer refresh de la ruta en la que estamos abajo
  const router = useRouter();

  function onAddToCart() {
    // usamos nuestras acciones
    addProductToCart(product.id);
    router.refresh();
  }

  function onRemoveItem() {
    removeOneProduct(product.id);
    router.refresh();
  }

  return (
    <div className='flex items-center shadow rounded-lg w-full bg-gray-800 border-gray-100'>
      {/* Product Image */}
      <div className='p-2'>
        <Image
          width={200}
          height={200}
          className='rounded'
          src={product.image}
          alt={product.name}
        />
      </div>

      {/* Title */}
      <div className='px-5 pb-5 w-full flex flex-col mt-2'>
        <a href='#'>
          <h3 className='font-semibold text-xl tracking-tight text-white'>
            {product.name}
            <small className='text-sm'>${product.price.toFixed(2)}</small>
          </h3>
        </a>

        {/* Price and Add to Cart */}
        <div className='flex flex-col items-start justify-between'>
          <span className='text-gray-900 dark:text-white'>
            Cantidad: {quantity}
          </span>
          <span className='font-bold text-white'>
            Total: ${(product.price * quantity).toFixed(2)}
          </span>
        </div>
      </div>

      <div className='flex p-5 items-center justify-center'>
        <button
          onClick={onAddToCart}
          className='text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800'
        >
          <IoAddCircleOutline size={25} />
        </button>
        <span className='text-2xl text-white mx-10'>{quantity}</span>
        <button
          onClick={onRemoveItem}
          className='text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800'
        >
          <IoRemove size={25} />
        </button>
      </div>
    </div>
  );
};
```

## todos

### actions

Mis server actions

#### todo-actions.ts

```ts
'use server';

import prisma from '@/lib/prisma';
import { Todo } from '@prisma/client';
import { revalidatePath } from 'next/cache';

export const toggleTodo = async (
  id: string,
  complete: boolean
): Promise<Todo> => {
  // esto es un server actions nos ahorra literal todo el restfull api y podemos llamar solamente la funcion en el cliente como cualquier otra

  // con esto busco el todo con el id que enviaron, y le cambio el complete a lo que me enviaron
  const todo = await prisma.todo.findFirst({
    where: { id: id },
  });

  if (!todo) {
    throw new Error('EL id no existe');
  }

  const updatedTodo = prisma.todo.update({
    where: {
      id: id,
    },
    data: {
      complete: complete,
    },
  });

  // esto nos ayuda como el refresh del router, esto cambia solamente lo que cambie pero solo en la ruta que pongamos
  revalidatePath('/dashboard/server-todo');
  return updatedTodo;
};

export const createTodo = async (description: string, userId: string) => {
  // le quitamos el tipado para que regrese una promesa que regresa el todo o un objeto con el message error
  try {
    const todo = await prisma.todo.create({
      // para crearlo necesitamos el userId entonces lo obtenemos desde las props
      data: { description, userId },
    });

    revalidatePath('/dashboard/server-todo');
    return todo;
  } catch (error) {
    return {
      message: 'Error al crear el Todo',
    };
  }
};

export const deleteCompleted = async (): Promise<void> => {
  // elimino todos los todos que esten en true
  await prisma.todo.deleteMany({
    where: {
      complete: true,
    },
  });
  revalidatePath('/dashboard/server-todo');
};
```

### components

#### NewTodo.tsx

```tsx
'use client';

import { FormEvent, useState } from 'react';
import { IoTrashOutline } from 'react-icons/io5';
import * as todosApi from '@/todos/helpers/todo';
import { useRouter } from 'next/navigation';
import { createTodo, deleteCompleted } from '../actions/todo-actions';

export const NewTodo = () => {
  const [description, setDescription] = useState('');
  const route = useRouter(); //es importante usar el next navigation

  const onSubmit = async (event: FormEvent) => {
    event.preventDefault();

    // await createTodo(description);

    // aqui creamos mediante una server action,
    //pero para este ejemplo mejor usaremos cuando no usamos el server action si no los fetch normales con nuestra api
    await todosApi.createTodo(description);

    setDescription('');
    route.refresh();
  };

  // const deleteCompleted = async () => {
  //   await todosApi.deleteTodos();
  //   route.refresh();
  // };
  return (
    <form onSubmit={onSubmit} className='flex w-full'>
      <input
        onChange={(event) => {
          setDescription(event.target.value);
        }}
        value={description}
        type='text'
        className='w-6/12 -ml-10 pl-3 pr-3 py-2 rounded-lg border-2 border-gray-200 outline-none focus:border-sky-500 transition-all'
        placeholder='¿Qué necesita ser hecho?'
      />

      <button
        type='submit'
        className='flex items-center justify-center rounded ml-2 bg-sky-500 p-2 text-white hover:bg-sky-700 transition-all'
      >
        Crear
      </button>

      <span className='flex flex-1'></span>

      <button
        onClick={() => deleteCompleted()}
        type='button'
        className='flex items-center justify-center rounded ml-2 bg-red-400 p-2 text-white hover:bg-red-700 transition-all'
      >
        <IoTrashOutline />
        <span className='m-1'>Eliminar completados</span>
      </button>
    </form>
  );
};
```

#### TodoItem.module.css

se le debe de poner el .module para los archivos de css

```css
.todoDone {
  /* con el apply puedo poner clases de tailwind y todas estaran en la clase todoDone */
  @apply line-through bg-blue-50 rounded-lg shadow-sm p-5 border-dashed border border-blue-500 flex flex-col sm:flex-row justify-between items-center gap-2 sm:gap-0;
}

.todoPending {
  @apply bg-red-50 rounded-lg shadow-sm p-5 border-dashed border border-red-500 flex flex-col sm:flex-row justify-between items-center gap-2 sm:gap-0;
}
```

#### TodoItem.tsx

```tsx
'use client';

import { startTransition, useOptimistic } from 'react';
import { Todo } from '@prisma/client';
import style from './TodoItem.module.css';
import { IoCheckboxOutline, IoSquareOutline } from 'react-icons/io5';

interface Props {
  todo: Todo;
  toggleTodo: (id: string, complete: boolean) => Promise<Todo | void>;
}

export const TodoItem = ({ todo, toggleTodo }: Props) => {
  // este es como un useStete, entonces mi estado inicial es mi todo
  const [todoOp, toggleTodoOp] = useOptimistic(
    todo,
    // como segundo argumento es un callback que como primer argumentos es el estado actual, y el segundo el argumento que resivimos en la funcion para cambiarlo en este caso el toggle
    (stateTodo, newCompleteValue: boolean) => ({
      // y pues aqui creamos un nuevo estado copiando el que teniamos y cambiamos el complete con el que enviemos
      // esto pues hace el cambio de true a false
      ...stateTodo,
      complete: newCompleteValue,
    })
  );

  const onToggleTodo = async () => {
    // aqui ya puedo usar mi funcion para cambiar algo que le este diciendo y el argumento que estoy enviando es el segundo argumento que pusimos en el callback
    startTransition(() => toggleTodoOp(!todoOp.complete)); //react nos hace que usemos un startTransition y ahi podamos usar la accion para cambiar el estado
    // aqui como quiero que cambie lo que tenia al contrario el complete pongo el !
    await toggleTodo(todoOp.id, !todoOp.complete);
  };

  return (
    <div className={todoOp.complete ? style.todoDone : style.todoPending}>
      <div className='flex flex-col sm:flex-row justify-start items-center gap-4'>
        <div
          // aqui usamos nuestro todoOp para que los cambios al darle click sean instantaneos ya que estaremos cambiando como un useState y son muy rapidos y no tiene que esperar a la base de datos para cambiar el estado
          // pero de igual manera cambio la base de datos
          onClick={() => onToggleTodo()}
          className={`
            flex p-2 rounded-md cursor-pointer
            hover:bg-opacity-60
            ${todoOp.complete ? 'bg-blue-100' : 'bg-red-100'}
         `}
        >
          {todoOp.complete ? (
            <IoCheckboxOutline size={30} />
          ) : (
            <IoSquareOutline size={30} />
          )}
        </div>

        <div className='text-center sm:text-left'>{todoOp.description}</div>
      </div>
    </div>
  );
};
```

#### TodosGrid.tsx

```tsx
'use client';

import { Todo } from '@prisma/client';
import { TodoItem } from './TodoItem';
import { useRouter } from 'next/navigation';
import { toggleTodo } from '../actions/todo-actions';

// import * as todosApi from '@/todos/helpers/todo';

interface Props {
  todos?: Todo[];
}

export const TodosGrid = ({ todos = [] }: Props) => {
  // const router = useRouter();

  // const toggleTodo = async (id: string, complete: boolean) => {
  //   await todosApi.updateTodo(id, complete);

  //   router.refresh(); //esto hace el refresh pero solamente de la ruta actual, y actualiza lo que tenga que actualizar en este caso si esta completado o no
  // };
  return (
    <div className='grid grid-cols-1 sm:grid-cols-3 gap-2'>
      {todos.map((todo) => (
        // aqui solamente le enviamos nuestro server action y ya nos ahorramos por completo toda la peticion a la api y eso
        <TodoItem key={todo.id} todo={todo} toggleTodo={toggleTodo} />
      ))}
    </div>
  );
};
```

### helpers

Mis pedasos de codigo que utilizo en otro ladoo

#### todo.ts

```ts
import { Todo } from '@prisma/client';

export const updateTodo = async (
  id: string,
  complete: boolean
): Promise<Todo> => {
  // una funcion para actualizar el todo
  const body = {
    complete: complete,
  };
  const todo = await fetch(`/api/todos/${id}`, {
    // como es una peticion del lado del cliente no tenemos que especificar el localhost ya que tomara el puerto en el que esta en este caso el localhost3000
    method: 'PUT', //el metodo
    body: JSON.stringify(body), // nuestro body que le queremos enviar como se lo enviariamos en el json
    headers: {
      // esto es importante para que funcione
      'Content-Type': 'application/json',
    },
    // y cuando todo esto se resuelve lo transformamos en json y todo esto se alamcena en la variable todo
  }).then((res) => res.json());

  return todo;
};

export const createTodo = async (description: string): Promise<Todo> => {
  // esto es lo que se necesita hacer para crear un nuevo todo, gracias a nuestra api que creamos
  const body = {
    description: description,
  };

  // cuando hacemos esta peticion la informacion del usuario ya va por las cookies, recordar que siempre fiaja por las peticiones fetch
  const todo = await fetch('/api/todos', {
    method: 'POST',
    body: JSON.stringify(body),
    headers: {
      'Content-Type': 'application/json',
    },
  }).then((res) => res.json());

  return todo;
};

export const deleteTodos = async (): Promise<Todo> => {
  // y para eliminarlo, como funciona cada cosa esta en el RESTfull api
  const todo = await fetch('/api/todos', {
    method: 'DELETE',
  }).then((res) => res.json());
  return todo;
};
```

# .env

Mis variables de entorno, para mi base de datos con prisma y para las autenticaciones con auth.js

```bash
# Environment variables declared in this file are automatically made available to Prisma.
# See the documentation for more detail: https://pris.ly/d/prisma-schema#accessing-environment-variables-from-the-schema

# Prisma supports the native connection string format for PostgreSQL, MySQL, SQLite, SQL Server, MongoDB and CockroachDB.
# See the documentation for all the connection string options: https://pris.ly/d/connection-strings

DATABASE_URL="postgresql://sebasmar:sebasmar@localhost:5432/next-db"

#  https://generate-secret.vercel.app/32
#  Aqui pide que cumpla unos requicitos para nuestro NextAuth_Secret y podemos conseguir uno en el de arriba
NEXTAUTH_SECRET=fa3b57cb625e9b5407cecafff5c845de

#Para configurar cualquier proveedor se necesita los siguiente, el id si lo puede ver el cliente pero el segundo secret nunca sale de nuestro servidor
GITHUB_ID=4d3384d3d4fd66044057

# esto es para que autorice a nuestro backend para poder autenticar con github en este caso
GITHUB_SECRET=f48bde205df2a74113f7f86a81292386b89e2fe3


GOOGLE_CLIENT_ID=277370642438-1mtibevlgsk56cfeedaivo2neml8e23m.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=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

```

# docker-compose.yml

Mi archivo para crear una imagen de docker

```yml
# este archivo son instrucciones de como quiero subir mis imagenes
version: '3' # para indicar que tipo de version es
#aqui son importantes las tabulacioness
services: #me creo un nuevo servisio que se llamara todosDB
  todosDB:
    image: postgres:15.3 #usare la imagen de postgres:13.5
    container_name: todos-db #nombre del contenedor
    restart: always # por si reinicio mi computadora o la apago que siempre se levante mi imagen
    ports:
      - 5432:5432 # aqui le digo que quiero conectar el puerto 5432 de la compu con el puerto 5432 del contenedor, ya que las imagenes son una burbuja aislada y solo con puertos se pueden acceder a ellas
    environment: # podemos configurar nuestras variables de entorno aqui configuramos nuestro user y password
      - POSTGRES_USER=sebasmar
      - POSTGRES_PASSWORD=sebasmar
      - POSTGRES_DB=next-db # con esto le damos nombre a nuestra db
    volumes: #estoy creando una carpeta en donde esta este archivo y lo conectare con esos archivos donde es nuestra data, si destruyo la imagen y la vuelvo a montan ahi estara la base de datos en esta carpeta que pusimos
      - ./postgres:/var/lib/postgresql/data

      # Para levantar la imagen: docker compose up -d
      # la de es para que este arriba la imagen incluso si cerramos la terminal

      # con el gitignore ignoramos la carpeta de postgres
```

# next.config.js

Mis configuraciones de next, en este caso solo configure lugares de donde queria obtener imagenes

```js
/** @type {import('next').NextConfig} */
const nextConfig = {
  // para poder aceptar algunos lugares las imagenes
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'tailus.io',
      },
      {
        protocol: 'https',
        hostname: 'avatars.githubusercontent.com',
      },
      {
        protocol: 'https',
        hostname: 'lh3.googleusercontent.com',
      },
    ],
  },
};

module.exports = nextConfig;
```

# package.json

Todas mis dependencias usadas en este proyecto

```json
{
  "name": "admin-todos",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "@auth/prisma-adapter": "^1.0.8",
    "@prisma/client": "^5.6.0",
    "bcryptjs": "^2.4.3",
    "cookies-next": "^4.1.0",
    "next": "14.0.2",
    "next-auth": "^4.24.5",
    "react": "^18",
    "react-dom": "^18",
    "react-icons": "^4.12.0",
    "yup": "^1.3.2"
  },
  "devDependencies": {
    "@types/bcryptjs": "^2.4.6",
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "autoprefixer": "^10.0.1",
    "eslint": "^8",
    "eslint-config-next": "14.0.2",
    "postcss": "^8",
    "prisma": "^5.6.0",
    "tailwindcss": "^3.3.0",
    "typescript": "^5"
  }
}
```

# tailwind.config.ts

Mis configuraciones de tailwind, lo unico que modifique fue donde queria que aplicara los estilos, en que carpetas aplicar lo estilos

```ts
import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
    './src/todos/**/*.{js,ts,jsx,tsx,mdx}',
    './src/products/**/*.{js,ts,jsx,tsx,mdx}',
    './src/**/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'gradient-conic':
          'conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))',
      },
    },
  },
  plugins: [],
};
export default config;
```
