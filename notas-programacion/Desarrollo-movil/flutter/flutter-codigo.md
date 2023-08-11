# Codigo de flutter

## Hola mundo  
* lib/main.dart 
```dart
mport 'package:flutter/material.dart'; //ctrl + . veremos todo lo que se imoporto

void main() {
  runApp(
      const MyApp()); //toda app de flutter en su main tiene una ejecucion de un widget principal, runApp espera resivir un widget
      //aqui tambien se pone const 
}

class MyApp extends StatelessWidget {
  //'StatelessWidgets ya esta en material.dart'
  const MyApp({super.key});   //este constructor ayuda para ponerle un key ya que con eso podemos identificar nuestros widgets

  @override
  Widget build(Object context) {
    return const MaterialApp(   //como es un ejemplo con informacion estatica, no cambiara se pone const
    //nos ayuda para que cuando flutter tenga que volver a construir esta pieza ya este toda construida y que no cambiara
      debugShowCheckedModeBanner: false,    //esto nos quita la marca de 'debug' que aparece arriba de la aplicacion
      home: Scaffold(   //este da una interface predefinida algo simple
        body: Center(child: Text('Me gusta mi novia')),
      ) //este Texto tambien es un widget, Center es otro widget que centra lo que tenga su hijo
    );
  }
}
```

lib/presentation/screens/counter_screen.dart

MaterialApp puede cambiar muchas veces con la imagen entonces hacemos diferentes archivos por las pantallas
```dart         
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Me gusta mi novia de nuevo')),
    );
  }
}
```
Y ya solo lo llamamos 

lib/main.dart
```dart
Widget build(Object context) {
    return const MaterialApp(   
      debugShowCheckedModeBanner: false,
      home: CounterScreen()     //recuerda importar
    );
  }
```



Counter app

lib/main.dart
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(   
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(   //esto es el tema resive un ThemeData 
        useMaterial3: true,  //le decimos que el estilo de material3 estara activado
        colorSchemeSeed: Colors.green  //para cambiar el color del todo el tema o algo asi veo
        //el Color podriamos configurar el color nosotros con rgb o asi, pero si le ponemos colors ya solo ponemos el color y el hara la paleta de colores
      ),
      home: const CounterScreen()   //se recomienda que el children sea el ultimo argumento que se resiva porque igual todos son por nombre
    );
  }
}
```


lib/presentation/screens/counter_screen.dart
```dart
class CounterScreen extends StatefulWidget {
  //cambiaremos a Statuful Widget para poder usar un estado
  const CounterScreen({super.key}); //esto no cambio

  @override
  State<CounterScreen> createState() =>
      _CounterScreenState(); //este es un nuevo metodo
  //esta es una creacion del estado, y esta invoca la otra clase que nos creo aqui abajo
}

class _CounterScreenState extends State<CounterScreen> {
  int clickCounter =
      0; //antes con stateless no podia hacer esto pero con Stateful si puedo los estados

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //tiene un body
        //le tuve que quitar el const al Scaffold por el floatingActionButton
        appBar: AppBar(
          title: const Center(child: Text('Contador')),
          // leading: IconButton(   //este resive un Widget
          //   //esto pone un icono en el lado izquierdo
          //   icon: const Icon(Icons.refresh_rounded),
          //   onPressed: () {
          //     //al presionar
          //     setState(() {   //recargar la pagina
          //       clickCounter = 0;
          //     });
          //   },
          // ),
          //pero si queremos ponerlo al lado derecho es:
          actions: [
            //este es un arreglo de widgets entonces podemos poner muchos botones
            IconButton(
                onPressed: () {
                  setState(() {
                    clickCounter = 0;
                  });
                },
                icon: const Icon(Icons.refresh_rounded)),
          ],
        ),
        body: Center(
          //entonces solamente se lo pose al boddy ya que me lo pedia
          //recordemos que centrara mediante el tamaño del padre
          child: Column(
            //creamos una columna
            mainAxisAlignment: MainAxisAlignment
                .center, //si dejo el cursor arriba dice que espera algo de tipo 'MainAxisAlignment' y ponemos center para que lo centre en la pantalla, como el flexbox
            children: [
              Text(
                clickCounter < 0
                    ? '0'
                    : '$clickCounter', //esto espera un string asi que lo puse asi o puede ser .toString
                style:
                    const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
              ),
              //como argumento por nombre se le puede poner el style, dentro del TextStyle se le pueden poner las propiedades, tamaño de letra y el grosor
              //con fontWight si dejamos el cursor arriba nos dice que espera algo de tipo FontWeight por eso ponemos eso
              Text(
                clickCounter == 1 ? 'Click' : 'Clicks',
                style: const TextStyle(fontSize: 25),
              )
            ], //cada argumento sera un valor de la columna solo una columna
          ),
        ),
        floatingActionButton: Column(
          //lo puse en una columna porque necesito poner mas botones
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              //el Scaffold ya tiene esta opcion de botones que es floatinghActionButton
              // shape: const StadiumBorder(), //este shape es para poner redondo el boton
              onPressed: () {
                //al presionar
                //se le pasa la accion primero
                clickCounter++; //para que aumente en uno
                //pero solo asi no se ve el cambio porque no se a renderizado o actualizado
                setState(
                    () {}); //esto actualiza, y puedo poner la instruccion de arriba adentro de esta funcion o solo dejarlo asi
              },
              child: const Icon(
                  Icons.plus_one), //child resive otro widget, Icon es un widget
            ),
            const SizedBox(   //este es otro elemento de la columna como ven puede ser otro widget, este sirve para poner un espacio o una cajita transparente
              height: 20,
            ),
            FloatingActionButton( //aqui simplemente pusimos el otro boton
                onPressed: () {
                  clickCounter < 0 ? clickCounter = 0 : clickCounter--;   //para que no pase de 0
                  setState(() {});
                },
                child: const Icon(Icons.exposure_minus_1_outlined)),
          ],
        )
      );
  }
}

```

Construccion de una clase para nuestros botones
```dart
class CustomButton extends StatelessWidget {
  //creamos una clase para los botones ya que se estaban repitiendo mucho
  final IconData
      icon; //dejando el cursor arriba podemos ver que es de tipo IconData
  final VoidCallback onPressed;   //ctrl + click pude llegar hasta donde esta definido este argumento y pude ver de que tipo era

  const CustomButton({    //el constructor simplemente le estamos diciendo que seran por nombre y resivira eso
    super.key,    // esto como lo habia dicho es para identificar nuestros widgets
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(    //porque cambiamos esto lo ponemos asi, quitamos desde este float el icono
      // shape: const StadiumBorder(),   //para hacerlo redondo
      // enableFeedback: true,   //hace como un sonidito al clickear
      // elevation: 20,    //como la sombra
      onPressed: onPressed,
      // onPressed: () {},    //pero si le mandamos el onPressed tiene el efecto de click
      // onPressed: null,    //si le mandamos null se desabilitan 
      child: Icon(icon),
    );
  }
}
```
Como la llamamos
```dart
CustomButton(   //aqui solamente mandamos a llamar a nuestra clase y ponemos los argumentos que pedia
  icon: Icons.exposure_minus_1_outlined,
  onPressed: () {
    setState(() {
      clickCounter <= 0 ? clickCounter = 0 : clickCounter--;
    });
  },
),
```