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
```dart
Widget build(Object context) {
    return const MaterialApp(   
      debugShowCheckedModeBanner: false,
      home: CounterScreen()     //recuerda importar
    );
  }
```