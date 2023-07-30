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

String hola2() =>
    'Hola mundo'; //asi son las funciones de flecha, pero no se le puede poner cuerpo solamente el retorno

int suma(int a, int b) => a + b;
int resta(int a, [int? b]) {
  //como es opcional le decimos que puede ser null con '?'
  b = b ?? 0; //aqui le estoy diciendo que si b es null se le asigne ese valor
  // b ??= 3;  //es la misma linea de arriba
  return a - b;
}

int multiplicacion(int a, [int b = 0]) =>
    a *
    b; //los parametros entre corchetes son opcionales pero no puede ser null entonces le damos un valor por defecto

//cuando hacemos las funciones como la suma, le estamos diciendo que son obligatorios y posicionales, en ese orden tienen que ir
//existen parametros por nombre que no importa el orden

String amor({required String hombre, String? mujer}) {
  //hacerlo con llaves los hacemos opcionales y los hacemos para llamarlos por nombre, pero para serlo requerido ponemos la palabra required
  return 'Amor: $hombre y $mujer';
}

void funciones() {
  print(hola());
  print(hola2());
  print(suma(12, 14)); //asi llamariamos la funcion

  amor(
      mujer: 'Marcela',
      hombre: 'Sebastian'); //asi se llama por nombre, no importa el orden
}

// Clases
// moldes para crear objetos

class Pokemon {
  //mayusculas, camelCase

  String name;
  String type;

  //constructor, la funcion que se llamara cuando creo un objeto
  // Pokemon(String name, String type) {  //hacerlo asi me da error ya que no se esta inicializando al momento de crearlo
  //   this.name = name;
  //   this.type = type;
  // }

  // Pokemon(String name, String type)
  //     : this.name = name,     //para que no nos de el error de antes ponemos dos puntos y ahi asignamos
  //       this.type = type;

  // Pokemon(this.name, this.type);    //asi tambien de una vez le asigna los valores

  Pokemon(
      { //asi tambien podemos hacerlo por nombre
      required this.name,
      required this.type});

  //nosotros podemos sobreescribir cualquier metodo, como el toString()
  // pero al modificar algun metodo del padre o ya creados tenemos que poner la palabra reservada override
  @override
  String toString() {
    return '$name, $type';
  }
}

void clasess() {
  final Pokemon pikachu = new Pokemon(
      name: 'Pikachu',
      type: 'Electro'); //podemos poner que la variable es del tipo Pokemon
  print(pikachu.name);
  print(pikachu.type);

  print(pikachu); //al dejarlo solo asi es lo mismo que invocar el .toString()
}

// name constructors

class Waifus {
  String name;
  String anime;
  bool top10;

  Waifus(
      {required this.name,
      required this.anime,
      required this.top10}); //un constructor normal   indica por el mismo nombre de la clase

  Waifus.fromJson(
      Map<String, dynamic>
          json) //con el punto y el nombre creo otro constructor
      : this.name = json['name'] ??
            'no name found', //aqui le estoy diciendo que del mapa resivire el nombre y eso y si vivene null pongo lo que esta del otro lado
        this.anime = json['anime'] ?? 'no anime found', //eso se refiere el '??'
        this.top10 = json['top10'] ?? 'no found';

  @override
  String toString() {
    return 'name: $name, anime: $anime, top10: ${top10 ? 'SI' : 'no:('}'; //condicion ternaria
  }
}

void constructores() {
  final Map<String, dynamic> formJson = {
    'name': 'Hinata',
    'anime': 'Naruto',
    'top10': true
  };

  final boa = new Waifus(
      name: 'Boa',
      anime: 'One Piece',
      top10: true); //crea una instancia de la clase waifus, asi se dice
  final hinata = new Waifus.fromJson(
      formJson); //esto es un constructor con nombre, asi tengo dos maneras de construir un objeto

  print('Waifus: $boa, $hinata');
}

class Area {
  double
      _lado; //al poner el '_' decimos que es privado, solo sera visible en esta clase

  Area({required double lado})
      : assert(lado >= 0,
            'tiene que ser mayor a 0'), //estos asserts son condiciones que le ponemos a nuestros constructores si se cumple sigue ejecutando si no tira error
        //el segundo argumento es el mensaje de error, pueden haber muchos assert
        _lado =
            lado; //el constructor resive un valor y se lo asignamos a la variable privada

  double get cArea =>
      _lado *
      _lado; //un get es para simular una propiedad y devuelve algo, al llamarse no se ponen los parentesis ya que es una propiedad

  calcular() =>
      _lado * _lado; //este es un metodo, una funcion interna de las clases

  set lado(double value) {
    //set es para cambiar algo, en este caso cambiamos el lado esto no devuelve ningun valor
    print('cambio del value: $value');
    if (value < 0)
      throw 'value > 0'; //aqui throw si se cumple tira el error y termian la ejecucion
    _lado = value;
  }
}

void constructoresNombre() {
  final cuadrado = new Area(lado: -10);
  // cuadrado.lado = 5;   //asi se llamaria el set

  print('Area: ${cuadrado.cArea}');
}

enum PlantType {
  nuclear,
  wind,
  water
} //para hacer un tipo de dato ahora abajo type puede tener estas tres opciones

abstract class EnergyPlant {
  //las clases abstractas no se pueden instanciar solo sirven para crear otras clases
  double energy;
  final PlantType type;

  EnergyPlant({required this.energy, required this.type});

  void consumeEnergy(
      double
          amount); //no le estoy diciendo que hacer con el dato en este metodo eso lo haria con la otra clase
}

//extends
class WindPlant extends EnergyPlant {
  //un ejemplo en una funciono pedimos de argumento una clase y podemos poner la clase abstracta entonces aceptaria todas las clases que se extenderian
  //extendemos traemos todas sus funcionalidades
  WindPlant({required double initialEnergy}) //aqui creamos un constructor
      : super(
            energy: initialEnergy,
            type: PlantType
                .wind); //y llamamos el constructor del padre y le enviamos al informacion que necesita ese constructor

  @override //el override porque estamos cambiando el metodo del padre
  void consumeEnergy(double amount) {
    //tiene que llamarse igual como en el padre ya solo le ponemos lo que queremos hacer con ese metodo
    //en el padre solo decimos que propiedades tendra y como se llamara aqui ya le ponemos las funcionalidades
    energy -= amount;
  }
}

//implements
//este hace lo mismo pero es para hacerlo mas especifico, si no el extens extiende todo pero este mas especifico con lo que queremos extender
class NuclearPlant implements EnergyPlant {
  @override
  double energy;

  @override
  final PlantType type = PlantType.nuclear;

  NuclearPlant({required this.energy});

  @override
  void consumeEnergy(double amount) {
    energy -= (amount * 0.5); //el 50% de amount
  }
}

void abs() {
  final windPlant =
      new WindPlant(initialEnergy: 100); //y asi la podriamos usarr
  windPlant.consumeEnergy(10);
  print(windPlant);
}


//mixins 
//es darles funcionalidades especiales a las clases que se extienden no todas si no algunas