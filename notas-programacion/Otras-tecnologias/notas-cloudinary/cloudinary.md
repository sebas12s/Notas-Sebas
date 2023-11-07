# Cloudinary

es un lugar para alojar imagenes en la nube, para crear un lugar debemos de ir a `settings>upload>upload presets>add upload preset` ahi le ponemos si queremos que tenga una autenticacion en otras palabras si sea privada o si la ponemos publica todos vamos a poder ingresar imagenes

## API

Para ingresar imagenes podemos hacerlo por una api [Documentacion](https://cloudinary.com/documentation/image_upload_api_reference)

`https://api.cloudinary.com/v1_1/:cloud_name/:action`

## Prueba en postman

Usamos postman para subir una imagen
`https://api.cloudinary.com/v1_1/sebas-mar/upload` en sebas-mar va nuestro cloud name y solo ponemos el upload ahora en las herrramientas de postman nos vamos a body>form-data y creamos una key `file` y le cambiamos el valor a file y ponemos ahi nuestra imagen
Despues otra key `upload_preset` y ponemos nuestra carpeta que creamos anteriormente y asi es como subimos con postman una imagen

Los nombres de file y upload son importante y tienen que ser esos
