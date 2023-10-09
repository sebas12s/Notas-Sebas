# Mongoose ORM

Mongoose es un orm, es un modulo que podemos usar mas no trae mongodb entonces ya deberiamos de tener mongodb corriendo en la computadora y descargado

## Coneccion

Coneccion basica a la base de datos con mongoose, se puede crear un archivo solo para las conecciones

```js
const mongoose = require('mongoose');

//con esto nos conectamos con un usuario, contraseña y asi todo lo que podriamos conectar pero tambien solo podemos hacer con el localhost ya que esa estamos usando
mongoose
  .connect('mongodb://127.0.0.1:27017/mywebstore')
  .catch((err) => console.log(err)); //asi tambien se pueden manejar los errores
//primero escribimos el protocolo al cual nos vamos a conectar mongodb://
//la direccion en donde esta el computador localhost / 127.0.0.1 es lo mismo esta es la direccion ipe a la que me quiero conectar
//despues se coloca con el puerto :27017
//despues se coloca el nombre de la base de datos, si no esta creada se creara solo se ingrese un dato

mongoose.connection.once('open', () => {
  //la diferencia entre once y on es que once solo una vez se ejecutara
  //estos son eventos de mongoose, aqui le dije que cuando conectara y con el on que ejecutara el evento open, ejecutara una funcion, hay mas eventos en la documentacion
  console.log('Esta conectada');
});

mongoose.connection.on('error', (err) => {
  console.log(err);
});
```

## Models

Para llevar un orden podemos crear una carpeta models para tener ahi todos los modelos

Estos son los esquemas que necesitamos para crear un modelo, como la platilla, el archivo se puede colocar en mayuscula

```js
const { Schema, model } = require('mongoose');
//schema es una clase por eso la inicializamos con new

const productSchema = new Schema({
  name: {
    type: String,
    unique: true, //con esto le digo que esta propiedad tiene que ser unica, no pueden haber dos documentos con el mismo name
    required: true, //que es requerido
  },
  description: String,
  price: {
    //asi tambien se puede poner el tipo y como es un objeto se le pueden poner mas propiedades
    type: String,
    default: 0, //tambien le podemos pasar un valor por defecto
  },
});

//este model ya es el que podemos usar para crear eliminar y asi datos, es como ya la tabla, el primer argumento es el nombre del modelo/tabla y el segundo el esquema
module.exports = model('Product', productSchema);
```

## SaveDocuments

Asi podemos guardar un nuevo documento en la base de datos

```js
require('./conections'); //con esta linea ya obtengo todo lo de ese archivo
const modelProduct = require('./models/Products'); //tambien el modelo, este como si tiene una exportacion lo guardo en una variable

const newProduct = new modelProduct({
  //asi se crearia un nuevo documento
  name: 'laptop',
  description: 'very good',
  price: 121212,
});

//en el tutorial usaba callbacks pero ya no acepta un callback asi que podemos usar el then porque es una promesa
newProduct
  .save() //le estoy diciendo que si se guardo bien el documento que me lo muestre en consola si no me muestre el error
  .then((document) => {
    console.log(document);
  })
  .catch((err) => {
    console.log(err);
  });
```

Otra manera de usarlo con async await es:

```js
const main = async () => {
  const newProduct = new modelProduct({
    name: 'laptop',
    description: 'very good',
    price: 121212,
  });

  const saveProduct = await newProduct.save();
  console.log(saveProduct);
};

main();
```

Otra manera de manejar esa promesa:

```js
const main = async () => {
  const newProduct = new modelProduct({
    name: 'laptop',
    description: 'very good',
    price: 121212,
  });

  return await newProduct.save();
};

main() //como retorna el dato le digo que si todo sale bien lo almacene en esa variable y lo muestre en consola igual con el error
  .then((saveProduct) => console.log(saveProduct))
  .catch((err) => console.log(err));
```

### Save2

Hay una forma de crear nuevos documentos mas faciles que es:

```js
require('./conections');
const modelProduct = require('./models/Products');

const main = async () => {
  modelProduct.create({
    name: 'marce',
    description: 'Beautiful',
    price: 121212,
  });
};

main();
```

## Find

```js
require('./conections');
const modelProduct = require('./models/Products');

const main = async () => {
  const findProducts = await modelProduct.find(); //esto nos lista todos los productos de la base de datos, el find
  const findProducts = await modelProduct.find({ clave: 'valor' }); //tambien nos puede hacer la busqueda que cumpla con la condicion
  const findOneProducts = await modelProduct.findOne({ clave: 'valor' }); //esto nos lista solo un producto que cumpla con lo puesto
  console.log(findProducts);
};

main();
```

## Update

```js
require('./conections');
const modelProduct = require('./models/Products');

const main = async () => {
  const data = await modelProduct.updateOne(
    //como sabemos el primero es para buscarlo y el segundo es lo que queremos modificar
    { name: 'marce' },
    { name: 'Marcela bella' }
  );
  console.log(data);
};

main();
```

```js
const main = async () => {
  const data = await modelProduct.findOneAndUpdate(
    //asi tambien podemos buscar y actualizar
    { name: 'marce' },
    { name: 'Marcela bella' }
  );
  console.log(data);
};
```

Asi hay muchas funciones es de ir probando y tambien esta la de eliminar

## Delete

```js
require('./conections');
const modelProduct = require('./models/Products');

const main = async () => {
  const data = await modelProduct.deleteMany({ name: 'laptop' });
  //esta es para eliminar tambien hay para eliminar solo uno y asi
  console.log(data);
};

main();
```

Para controlar con id hay metodos especiales
