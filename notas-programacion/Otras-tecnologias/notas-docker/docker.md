# Docker

## Curso de next no docker

Enseña de manera rapida como crear una imagen de docker, que es esto, la idea es empaquetar nuestra app de produccion es como un caset de juego, donde sea que descarguemos esa imagen sigue funcionando y es el mismo juego donde sea, esa es la idea de una imagen de docker

Pasos:

- Creamos un `.dockerignore` funciona como el gitignore
  En este ejemplo pusos esos no son necesarios estos

```
Dockerfile
.dockerignore
node_modules
npm-debug.log
README.md
.next
.git
```

- creamos un archivo `dockerfile` sin extencion y son las instruccion para construir la imagen

Creacion de una imagen basica

```dockerfile
FROM node:18-alpine
# esta primera linea le digo que cree como un sistema operativo y quue venga node ya instalado ya que docker es de linux, version 18 de node y la version de linux alpine
WORKDIR /app
# en la imagen de node tenemos el directorio de app entonces le digo que trabaje ahi
COPY package.json /
# copio el package.json en la raiz que es el /app
RUN npm install
# instalamos los modulos de node
COPY . /
# copiamos todo el proyecto solo pongo un punto porque tengo todo el proyecto en esa direccion y lo copio de nuevo en la raiz que es app
RUN npm run build
# hacemos el build
EXPOSE 3000
# exponemos el puerto 3000 al levantar la imagen, entonces le digo que es el unico puerto que se puede conectar con la imagen
CMD [ "npm", "start" ]
# ponemos el comando con el cual vamos a inicializar el servidor
```

- Y construimos la imagen y para eso ejecutamos el siguiente comando
- `docker build -t nombre_image .`
- la t es para ponerle un tag y el . es donde esta el dockerfile como esta en esa direccion solo ponemos el .

Para levantar la imagen hacemos lo siguiente ya con la imagen creada

- ejecutamos el siguiente comando:
- `docker container run -p 3000:3000 nombre_image`
- la p es para indicar el puerto y le digo que mi puerto 3000 se conecte al puero 3000 de la imagen
- con esto ya esta listo para correr en el puerto 3000
- `docker container run -dp 3000:3000 nombre_image` si colocamos la d aunque cerremos la terminal puede seguir corriendo ya en docker desktop podemos cerrarlo

### Creacion de docker recomendada por next

En la documentacion se puede ver pero este es el link directo del dockerfile [Link](https://github.com/vercel/next.js/blob/canary/examples/with-docker/Dockerfile)

```dockerfile
FROM node:18-alpine AS base

# Install dependencies only when needed
FROM base AS deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
RUN \
    if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
    elif [ -f package-lock.json ]; then npm ci; \
    elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && pnpm i --frozen-lockfile; \
    else echo "Lockfile not found." && exit 1; \
    fi


# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry during the build.
# ENV NEXT_TELEMETRY_DISABLED 1

RUN yarn build

# If using npm comment out above and use below instead
# RUN npm run build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app

ENV NODE_ENV production
# Uncomment the following line in case you want to disable telemetry during runtime.
# ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public

# Set the correct permission for prerender cache
RUN mkdir .next
RUN chown nextjs:nodejs .next

# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT 3000
# set hostname to localhost
ENV HOSTNAME "0.0.0.0"

CMD ["node", "server.js"]

```

Tambien en el `next.config.js` se recomienda esta configuracion

```js
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
};

module.exports = nextConfig;
```

Agregamos el output que es recomendado cuando creamos imagenes

[Documentacin de todo](https://github.com/vercel/next.js/tree/canary/examples/with-docker)

Y asi es menos pesada la imagen ya podemos ejecutar los comandos anteriores
