# App REST API Simple

```js
const express = require("express");
const morgan = require("morgan");

const app = express();

let products = [
  {
    id: 1,
    name: "Laptop",
    price: 3000,
  },
];

app.use(morgan("dev"));
app.use(express.json());

app.get("/products", (req, res) => {
  res.json(products);
});

app.post("/products", (req, res) => {
  const newProducts = { id: products.length + 1, ...req.body };
  products.push(newProducts);
  res.json(newProducts);
});

app.get("/products/:id", (req, res) => {
  console.log(req.params.id);
  //este find es de los arreglos, por cada arreglo se esta almacenando en la variable de la funcion y por cada variable hace algo y le digo que retorne el valor que cumpla con la condicion
  const productFind = products.find((product) => {
    return product.id === parseInt(req.params.id); //aqui me puede mostrar un error pero es porque el params es un string
  });

  if (!productFind)
    //esto es si no hay producto
    return res.status(404).json({ message: "No existe el producto" });

  res.json(productFind);
});

app.delete("/products/:id", (req, res) => {
  const productFind = products.find((product) => {
    return product.id === parseInt(req.params.id);
  });

  if (!productFind)
    return res.status(404).json({ message: "No existe el producto" });

  products = products.find((product) => {
    //este find nos devuelve los valores que cumplan con la condicion entonces en esta funcion le estoy diciendo que en el mimsmo arreglo me devuelva todos los que no hayamos eliminado
    product !== parseInt(req.params.id);
  });

  res.status(204);
});

app.put("/products/:id", (req, res) => {
  const newData = req.body;

  const productFind = products.find((product) => {
    return product.id === parseInt(req.params.id);
  });

  if (!productFind)
    return res.status(404).json({ message: "No existe el producto" });

  products = products.map(
    (product) =>
      //por cada producto mira si el producto es igual al que le enviamos en la url y si es igual
      product.id === parseInt(req.params.id)
        ? { ...product, ...newData } //si es igual crea un nuevo producto, objeto, y pone todos las propiedades y cambia solamente las que enviemos en el body, la variable de arriba
        : //esta sintaxis si coomo nueva propiedad le pasamos una que ya esta en producto lo actualiza
          product //si no pues solamente envia de nuevo el producto
  );

  res.json({
    message: "Producto actualizado",
  });
});

app.listen(3000, () => {
  console.log("Escuchando en el puerto 3000");
});
```
