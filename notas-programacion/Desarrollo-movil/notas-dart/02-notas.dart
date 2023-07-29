//Repaso de Dart, atencion al 100%

//un tipo de dato Dynamic puede regresar cualquier tipo de dato

void primerosPasos() {
  //void no regresa nada
  var myName = 'Sebastian'; //var cualquier tipo
  String love = 'Marcela'; //string tipo
  final int numm = 12; //tipo de dato, no se puede cambiar el valor por final
  late final int numm2; //deja despues inicializarla "Late"
  const int numm3 =
      11; //const es en proceso de construccion, entonces cuando estamos creando la aplicacion y sabesmos que no cambiara se recomienda const

  numm2 = 24;
  print(
      'mi nombre es: $myName y mi amor: $love, $numm, $numm2, $numm3'); //concatenar
  //cuando sono solo una variable se puede hacer asi

  print(
      'suma ${love.toUpperCase()}'); // cuando tenemos que poner mas procesos van las llaves
}

void variables() {
  final String pokemon =
      'Charmander'; //si sabemos que no cambiara su valor dejemos final
  final int hss = 12;
  bool? isLove; //el signo "?" dice que puede ser null
  final bool isLove2 = true;
  final List<String> cualidades = <String>[
    'linda',
    'inteligentes'
  ]; //lista || arrays, tambien se puede poner el tipo de dato ahi

  //los tipos de datos dynamic aceptan null
  dynamic error =
      'hola'; //no dice que es de tipo String si no se queda tipo dynamic

  //asi ponemos un string multilinea
  print("""
    $pokemon
    $hss
    $isLove
    $isLove2
    $cualidades
    $error
  """);
}

void variables2() {
  final Map<String, dynamic> pokemon = {
    //esto es un mapa, clave valor
    //el tipado string de un lado y objeto de otro porque tiene muchos tipos de datos, ya que todo es un objeto lo infiere asi, pero tambien puede ser dynamic
    'name': 'Charmander',
    'hp': 12,
    'isLove': true,
    'sprits': <String>['amor', 'linda'], //tipado
    'objet': {1: 'uno', 2: 'dos'} //un mapa con muchos tipos de datos
  };
  print(
      'Mi pokemon ${pokemon['name']}'); //asi llamamos alguna clave con corchtes
  print(pokemon['objet'][2]); //asi puedo ver el numero dos
}

void variables3() {
  final List<int> numbers = [1, 2, 3, 4, 4, 5, 6, 7, 7, 8];
  print(numbers);
  print(numbers.length); //propiedades de las listas, cuantos elementos
  print(numbers.first); //el primer elemento
  print(numbers.last); //el ultimo elemento
  print(
      numbers.reversed); //al contrario pero devuelve en parentesis no corchetes

  final Iterable<int> reversNumbers = numbers
      .reversed; //es un iterable, lo que significa que esta ordenado y sabe cuantos elementos tiene
  //se caracteriza por los "()"
  print(reversNumbers.toList()); //lo convierte en lista
  print(reversNumbers.toSet()); //lo convierte en set
  //el set se caracteriza por "{}" y no puede tener valores duplicados si los tiene los elimina
  print(numbers.toSet().toList()); //asi podriamos eliminar duplicados

  final num5 = numbers.where((int numeros) {
    //numeros tendra todos los elementos de nuestra lista uno por uno y evaluara lo que pongamos abajo
    //tambien se puede especificar el tipo de dato
    return numeros > 5;
  });
  final num55 = numbers.where((int numeros) =>
      numeros < 5); //funiones flecha lo mismo que hice anteriormente
  print('numeros $num5 $num55'); //el where regresa un iterable tambien
}

String hola() {
  //esta funcion se llama solamente asi: hola();
  return 'Hola Mundo';
}

String hola2() => 'Hola mundo';   //asi son las funciones de flecha, pero no se le puede poner cuerpo solamente el retorno
