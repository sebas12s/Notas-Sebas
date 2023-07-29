
import 'dart:async';
import 'dart:io'; //asi se importan paquetes de dart
import 'dart:math';

// import 'package:http/http.dart' as http;   el as es un alias ahi se almacena todo lo que tendra para usar sus cosas

//primer hola mundo 
main() {  //siempre tiene que tener un metodo main
  print('Hola mi vida');
}

//Tipado de datos

variables() {
  var a = 10;   //hay que evitar esto pero es para inicializar una variable
  //asume que es un int por el tipo de dato es un comodin para decir cualquier tipo 
  dynamic b = 12; //asi tambien se puede

  int c = 123; //entero
  double d = 34.3; // decimal

  int? s = null; //le decimos que puede ser nulo con el signo de interrogacion

  //si sumamos un int con un double el resultado sera double 

  String m = 'Me gustas';
  String mm = 'O\'Coner'; //asi se puede escapar un caracter para ponerlo
  String mmm = "O'Coner"; //asi tambien se puede poner si quiero poner una comilla dentro

  String sdd = '''
  se puede poner asi tambien mucho texto
  mucho texto Marcela $m 
  '''; //y asi se pueden concatenar las variables
  String sm = '$m $mmm';  //asi tambien se pueden poner variables

  bool sjl = true;
  bool sjll = !sjl; //asi digo que es lo contrario de la anterior variable
  print( sjll! ); //asi al final le estamos diciendo que no resivira un null siempre resivira un valor 


  //listas
  var nombres = ['sebas', 'marcela', 'te amo']; //asi se puede hacer con var

  List<String> nombres2 = ['sebas', 'marcela', 'te amo']; //pero asi es la forma correcta de hacerlo
  //usa que es de tipo generico por eso podemos que tipo de dato tendra
  //Antes se hacian de la siguiente manera pero ya no se hacen
  //List<dynamic> nombres3 = new List();  //pero ya no se hacen asi 


  //sets
  //son como los arreglos pero tienen una diferencia
  var nombres4 = { 'sebas', 'marcela', 'te amo' }; //se hacen con llaves pero no es un objeto 
  Set<String> nombres5 = { 'sebas', 'marcela', 'te amo' }; //la forma correcta
  //y cual es el valor??
  nombres2.add('mucho'); //el add es un metodo para agregar un dato
  nombres2.add('mucho');
  //con una list se pueden poner muchas veces
  nombres4.add('mucho');
  nombres4.add('mucho');
  //pero con ser solo una vez pueden estar los valores

  //algo si queremos quitar todos los duplicados es combertirlo en set y despues a list
  var nombreSet = nombres2.toSet();
  print(nombreSet.toList()); //elimina todos los duplicados


  // Maps
  //se puede hacer con var pero ya no lo haremos asi
  Map<String, dynamic> waifus = {   //tenemos que poner que tipo de dato tendran la clave y despues el valor por que es string y int sera dynamyc
    'onePiece': 'Boa',
    'naruto': 'Hinata',
    'cantidad': 3,
  };
  print(waifus['naruto']);  //para llamar algo en especifico se hace asi no nombre.algo si no con corchetes

  
  //se puede hacer tambien un map de la siguiente manera
  Map<String, dynamic> waifus2 = new Map();
  waifus2.addAll({
    'onePiece': 'Boa',
    'naruto': 'Hinata',
    'cantidad': 3,  //una observacion se pone coma al final
  }); //asi le ingresamos datos al map

  waifus2.addAll( waifus ); 
}

constantes() {
  var a = 10;
  //estas dos sirven para definir variables que no cambiaran
  const b = 10;
  final c = 10;

  //con const y final se puede asignar el tipo asi
  final String d = 'Me gusta mi novia';

  late final String e;  //late sirve para que despus inicializar la variable
  e = 'Marcela hermosa';


  //uno de los cambios que se ven seria el siguiente
  final List<String> personasFinal = ['mar', 'sebas'];
  const List<String> personasConst = ['mar', 'sebas'];
  List<String> personasConst2 = const['mar', 'sebas'];  //asi tambien deja

  personasFinal.add('novia');
  personasConst.add('novia'); //lo que pasa que en este arreglo no deja modificar pero en final si deja   

}


operadores() {
  // + - * /
  // recordar que la division es con una variable tipo double

  double mar = 10 % 3;  //restultado 1 este es lo que queda de la division

  int mad = 10 ~/ 3;  //esto es una division normal pero devuelve solo el entero

  mar = -mar; //esto es la negacion de la expresion

  mar++;  //esto es para ir aumentando en 1 en 1
  mar--;  //igual pero ir restando
  mar += 2;  //igual pero ir aumentando en 2 en 2
  mar -= 4; 
  mar *= 4; 
  mar /= 4; 

  //operador de asignacion 
  int? bss;
  bss ??= 12; //solamente se le asigna si no tiene valor o es null

  String res = bss > 25 ? 'bss es mayor a 25' : 'es menor'; //se puecen hacer en la misma linea la condicoin 

  int d = bss ?? 10;  //le estoy diciendo que si bss es null asigne el otro valor
  //se pueden poner mas ?? 

  //mas operadores
    /*
      >  Mayor que
      <  Menor que
      >= Mayor o igual que
      <= Menor o igual que

      == Revisa si dos objetos son iguales
      != Revisa si dos objetos son diferentes 
  */

  int sdff = 12;
  String noms = 'Marce';
  print(sdff is String);  //esto devuelve false estoy preguntando si es tipo string esa variable
  print(sdff !is String); //estoy diciendo si sdff es diferente a un entero
}




control() {
  stdout.write('te gusto');   //con la libreria io podemos mostrar un mensaje en consola
  String? respuesta = stdin.readLineSync(); //esta funcion sirve para leer en consola, se pone que puede ser null por que realmente puede ser null

  //stdout.writeln('tu respuesta es: ' + respuesta); //para concatenar
  stdout.writeln('tu respuesta es: $respuesta'); //otra manera pero esta vez si me dejo
}

ifelse() {

  int edad = int.parse( stdin.readLineSync() ?? '0' );  //sabemos que los dos "??" son por si es null la expresion anterior sera lo que este despues y el parse es para pasar a numeros todo lo que este adentro

  if (true) {   //if else

  } else if (false) {

  } else {

  };


  for (int i = 0; i < 10; i++) {    //ciclo for
    
  }

  print('sumas: ${ 2 + 2 }'); //todo lo que este adentro de esas llaves puede ser codigo de dart


  List<String> waifus = ['Hinata', 'Boa', 'Mitzuki'];

  for (String nombres in waifus) {    //recorre un array y guarda por cada objeto el nombre o el valor que tengamos en esa variable
    print(nombres);   
  }

  while (true) {  //ciclo while
    
  }
}


dowhiles() {
  do {
    
  } while (false);

  // continue -- break

  for (var i = 0; i < 10; i++) {
    
    if (i == 5) {
      continue;   //lo que hace es que no sigue el ciclo si no se pasa a la siguiente iteracion del ciclo si hay codigo abajo no lo pasa solo pasa a la siguiente iteracion
    }

    if (i == 7) {
      break;    //con esto de una vez se sale del ciclo
    }
  }

  //se pueden poner label a los ciclos 

  nombrelabel:    //esto sirve para hacer un brake si tenemos muchos ciclos anidados 
  for (int i = 0; i < 10; i++) {
    if (i == 5) {
      break nombrelabel;    //y asi le digo a que ciclo quiero hacer break
    }
  }


  int rnd = Random().nextInt(7);  //esto es para generar un numero aleatorio se tiene que importar de math y la propiedad del final le dice hasta el maximo que saldra pero nunca saldra ese numero sera del 0 al 6

  switch (false) {    //case
    case 'si':
      
      break;
    case 'si':
    
      break;
    default:
      print(rnd);
  }
}

funcioness() {    //en si esta es una funcion 
  //la funcion main es la primera que se ejecuta por eso esa es la primera funcion 

  print('');  //tambien es una funcion por los parentesis
  //las nuevas funciones se crean afuera
}
//main normalmente se pone void 
void saludar(){ //como no resegresa nada se pone void
//si regresara un string o int se le pone o dynamic
  print('hola Marcela');
}
String saludar2() {//esta si regresa un string
  return 'Hola mi marcela';
}

//argumentos de la funcion

//hay dos tipos de argumento como los obligatorios y no
//posicionales son los que tienen un orden 

void saludar3( String mensaje, [ String nombre = 'Insertar nombre', int? edad ] ) {
  print('$mensaje $nombre');
}

//que paso aqui, los argumentos se pasan el tipo y el nombre, adentro de los corchetes van los argumentos opcionales
// le di un valor por defecto a nombre, y el int le dije que puede ser null para que cuando lo llame no lo envie 

//por nombre, son los que estan dentro de un corchete

void saludar4({    
  String? mensaje, 
  required String nombre, //required es para hacerlo requerido
  int? edad }) {    //normalmente se posicionan asi los de nombre
  print('$mensaje $nombre');    
}
//lo que paso aqui es, que si estan dentro de llaves eso se combierte por nombre
//por nombre, normalmente no son obligatorios y no se pueden poner obligatorios asi que lo minimo que podemos hacer es ponerles valores por defecto
fun(){
  saludar4(nombre: 'Sebastian', edad: 12);    //y asi se llaman los de nombre no por orden
  //tambien se puede poner argumentos por orden obligatorios y por nombre combinarlos
}



String capitalizar( String texto ) {  //esta funcion simplemente agarra un texto y lo pasa a mayusaculas
  texto = texto.toUpperCase();
  return texto; //tambien estas dos lineas pueden ser return texto.toUpperCase();
}
smcg() {
  String nombre  = 'sebas';
  String nombre2 = capitalizar(nombre);

  print( nombre );     //este es el nombre en minuscula
  print( nombre2 );    //este en mayuscula pero con variables obtiene un nuevo espacio en memoria asi que todavia esta en otro espacio en memoria en minusculas
}


Map<String, String> capitalizarMapa( Map<String, String> mapa ) { //le estamos diciendo que retornara un mapa y su argumento sera tambien un mapa

  // Romprer la referencia
  mapa = { ...mapa };   //con esto rompemos referencias quiere decir que creamos un nuevo espacio en memoria y le esparsimos los argumentos que tenia mapa
  //por que???  por que con los mapas, listas, objetos, clases son mandadas como referencia, eso quiere decir que usan el mismo valor en memoria entonces si hacemos un cambio a algo cambia en todo

  mapa['nombre'] = mapa['nombre']?.toUpperCase() ?? 'No hay nombre';  //el primer '?' es para decirle que puede o no haber valor y '??' si no tiene que sea ese valor por defecto

  return mapa;
}

fmcg2() {
  Map<String, String> persona = {   //este es el mapa que enviamos en la funcion
    'nombre': 'Tony Stark'
  };

  Map<String, String> persona2 = capitalizarMapa( persona );


  print( persona ); //en minuscula porque rompimos la referencia
  print( persona2 );  //en mayusculas por nuestra funcion
}


//funciones flecha
int sumarFlecha( int a, int b ) => a + b;   //cuando solo tiene un return se puede poner lo que se devolvera asi

//otro ejemplo de las funciones flecha
flecha() {
  List<int> listado = [1,2,3,4,5,6,7,7,8,8,8,9,9,10,10];
  //var nuevoListado = listado.where((element) => false);    //list tiene un metodo que es este where, son funciones pero cuando estan dentro de un objeto se llaman metodos
  //si dejamos el cursor arriba del where podemos ver que retorna, hay que mandar una funcion que retorne un bool
  //y que sera iterable...    esto quiere decir que puede tener mas funciones pero es un tipo de dato, mapa, string etc
  var nuevoListado = listado.where((numero) {   //numero tendra uno por uno el valor del array, y le estoy diciendo que el nuevo listado sera la condicon que estoy devolviendo, numero mayor a 4
    return numero > 5;      
  }); //pero esto es una funcion normal ahora flecha
  
  var nuevoListado2 = listado.where((numero) => numero > 4 ); //lo mismo pero con flecha
}

//en el curso hay temas como
//callbacks funciones dentro de otra funcion
//Queue   funcion para recorrer un array

//numeraciones
main3() {
  Audio volumen = Audio.bajo;//tipo de dato Audio y ya podemos dar un valor al Audio
  
  switch( volumen ) {
    case Audio.bajo : print('Volumen bajo'); break; //una forma de hacerlo en una linea
    case Audio.medio: print('Volumen medio'); break;
    case Audio.alto : print('Volumen alto'); break;
  }
}
//el enum se crea afuera de la funcion
enum Audio { //las numeraciones se hacen asi para saber que tipo de datos puede ser una variable en este caso
      //usa camelCase, 'AudioCarro' siempre en mayuscula la primera
  bajo, 
  medio,
  alto
}


//tema importante future
future(){
  Future timeout; //si dejamos el cursor nos aparece, puede resolver cualquier tipo de dato entonces cuando se resuelve puede retornar un entero un objeto un mapa etc por eso hay una <T>
  Future timeout2 = Future.delayed( Duration(seconds: 3), () {  //hice una funcion anonima, tambien puedo poner otra funcion pero lo que le dije aqui es que despues de 3 segundo se ejecutara la funcion
    print('3 segundos despues');
  });

  Future<String> timeout3 = Future.delayed( Duration(seconds: 3), () {  
    print('3 segundos despues');
    return 'retorno'; //porque retorno un String tambien se lo ponemos arriba, pero se dice, resuelve un string
  });

  timeout3.then((texto) => print(texto)); //then es despues que se resuelve el future, texto es el valor que se resolvio o retorno y hasta que se resulva se hace el then
  timeout3.then(print); //asi tambien se puede hacer en las funciones, el primer argumento (esta vez el unico) que se envia sera el primer argumento de la otra funcion que ponemos en este caso el print
}

future2() {
  File texto = new File( Directory.current.path + '' ); 
  //el Directory... es una clase de Dart.io tambien File, pero ese es para saber el path de donde se esta ejecutnado el archivo
  //File es para leer un archivo y adentro ponemos la direccion Path si falta para llegar al archivo puedo concatenar 

  Future<String> f = texto.readAsString();  //este readAsString resuelve un future, por eso sera mas lento o se puede ejecutar despues de cosas que tengamos abajo
  String ff = texto.readAsStringSync(); //este Sync no resuelve un future si no un string por eso este si lo hace de manera ordenada, se ejecuta primero esto y despues lo de abajo
  f.then(print);
}


//Async y await
main4() async { //por el await se pone el async
  String path = Directory.current.path + '/04_tipos_nocomunes/assets/personas.txt';
  String texto = await leerArchivo(path);   //si queremos que se resuelva el future y que pare hasta que se complete ponemos el await pero es necesario que en la funcion que estemos le pongamos el Async
  print(texto);
  print('Fin del main');
}

Future<String> leerArchivo( String path) async { //esta es una funcion que retorna un future, 
  //el async lo que dice es que una funcion regresara un future si o si retornara eso, aunque pongamos que retorne un simple texto
  File file = new File( path );
  return file.readAsString();
} 

//cath error

main5() {
  Future<String> timeout = Future.delayed( Duration(seconds: 3), () {
    if ( 1 == 1 ) {
      throw 'Auxilio!, explotó esta cosa';    //con throw hacemos que haya un error
    }
    return 'Retorno del future';
  });

  timeout.then( print )
         .catchError( (error) => print(error) );  //simplemente le decimos que si hay un error, que haga algo en este caso una funcion pero este solo es el print pero pueden ser muchas cosas, como cancelar usuario y asi
}



//Streams
strms() {
  // final streamController = StreamController();  //asi se crea, es tipo StreamController por eso le puse solo final para que se ponga por defecto el tipo
  // streamController.stream.listen((dato) { //el listen obligatorio necesita una funcion para ejecutar cuando se resiva un valor, entonces solo se ejecutara cuando resiva informacion
  //   print('Despegando! $dato'); //solo le decimos como reaccionara cuando resiva informacion 
  // });

  //comente porque lo usare de otra manera

  //el typado puede ser como es ahorita dynamic o le podemos dar typados
  //final streamController = StreamController();
  //StreamController<String> streamController = StreamController(); se puede hacer asi o 
  final streamController = new StreamController<String>();
  streamController.stream.listen(
    (dato) => print('Despegando! $dato'),     //este es el primer argumento la funcion obligatoria
    onError: (error) => print('El error es: $error'),
    cancelOnError: false,      //si tenemos en false no se cancel asi hay un error si no que en la siguiente se tira apollo 13, pero si esta en true si se cancel y no llega a apollo 13
    onDone: () => print('') //sabemos que no solo un print se puede enviar si no otras cosas y esto es para cuando se cierre se enviara esto
  );
  //que pasa cuando tenemos dos listen, ya que asi normalmente solo es de una suscripcion solo uno lo puede escuchar
  //lo que hay que hacer es: final streamController = new StreamController<String>.broadcast(); a esa linea

  streamController.sink.add('Apollo 11'); //con esto agrego esto al inicio del stream
  //ejemplo simple de stream
  //codigo asincrono y secuencial, este ultimo es mas rapido que el codigo asincrono y un ejemplo de codigo asincrono son los futures y streams

  streamController.sink.add('Apollo 12');
  streamController.sink.addError('Tenemos un problema');//asi enviamos un error, entonces tenemos que poner un manejo de errores predefinido en el streamController
  streamController.sink.add('Apollo 13');   

  streamController.sink.close();    //normalmente cuando sabemos que ya no se enviara informacion lo cerramos, pero esto tambien un ejemplo es cuando se sale de la aplicacion o algo asi se cierra
  //ya no se puede enviar otro apollo en este ejemplo

}


//se ponen las clases en otro archivo y solamente se importan 
//import 'clases/persona.dart';
class Persona {   //asi seria su estructura de la clase

  // Campos o propiedades

  //propiedades privadas y publicas, por defecto todas son publicas
  String? nombre; //lo ponemos si es nulleable
  int? edad;
  String _amor = 'Sofia Marcela Cruz Galindo';    //asi se pone privada, en si solo se puede usar en esta clase afuera no

  //Get y sets
  //podemos tener muchos get y set
  //veamos esto, son metodos que sirven para simular que tenemos una propiedad
  String get amor {   // al llamar este get solamente se pondria asi, persona.amor y ya retornaria nuestra propiedad
    return _amor.toUpperCase();   //no solamente se tienen que retornar una propiedad pueden hacer muchas cosas
  }
  //tambien se puede hacer una funcion de flecha
  String get amor2 => _amor.toLowerCase();

  set amor( String texto ) {  //esto solamente sirve para cambiar algo no para retornar algo
    _amor = texto;
  }
  set amor2( String texto ) => _amor = texto; //funcio flecha

  //Construsctores
  //son los metodos que se crean cuando creamos una nueva instancia de la clase
  //un constructor valido seria el siguiente
  Personas( String nombre, int edad ) {   //colocamos los valores que le queremos dar como propiedades
    //aqui adentro le daria las instrucciones que quiero que se ejecuten cuando creo una instancia
    //normalmente queremos inicializar los valores, no como lo hicimos abajo uno por uno

    this.nombre = nombre;   //con el this le digo que la propiedad de esta clase sera igual al nombre que resivo en los argumentos
    this.edad = edad;

  }
  //aunque podemos hacer tambien de la siguiente manera mas rapido
  Persona(this.nombre, {this.edad = 17}); //se pueden usar los corchetes y las llaves tambien aqui

  //constructores con nombre
  Persona.nombre(String nombre) {  //puede resivir argumetos normalmente
    this.nombre = nombre;   //y aqui las acciones
  }

  //metodos

}


//clases en Dart
//cuando tenemos objetos es bueno usar clases
clasess() {
  //hay que crear una instancia de la clase, asi se conoce para cuando creamos una variable de una clase
  Persona persona = new Persona('Sebastian', edad: 18);  //aqui ya le pasamos el valor que definimos en el constructor
  //Le decimos que es de tipo persona la variable y una nueva persona
  // persona.nombre = 'Sebastian'; //asi se le colocan los campos
  // persona.edad = 17;
  // persona.amor = 'Marcela'; //esto es muy largo se puede hacer tambien asi
  Persona persona2 = new Persona.nombre('Marcela');   //asi se llama un constructor con nombre

  //por el constructor ya no se envia asi
  // persona..nombre = 'Sebastian'
  //       ..edad = 17; //operador en cascada asi tambien lo podeoms poner mucho mas facil
        //..amor = 'Marcela';   //la puse privada asi que no se puede llamar

  print(persona.toString());  //tambien podemos cambiar los metodos que ya traen, como en persona al llamar este metodo lo puedo editar en mi clase

  print(persona.amor);  //asi llamamos el get
  persona.amor = 'Marcela'; //aqui tambien estoy haciendo el set no importa que tengan el mismo valor
}


//propiedades finales inmutables
class Cuadrado {
  final int lado;   //para hacer que no se muten despues podemos ponerlas asi
  final int area;
  // Error
  // Cuadrado( int lado, int area ) {   //el constructor no me deja asi me marca error
  //   this.lado = lado;
  //   this.area = area;
  // }

  // Cuadrado( this.lado, this.area );    //de esta manera si me lo acepta pero no es la apropiada

  Cuadrado( int lado ):   //despues de estos dos puntos podemos poner todo el codigo que queramos para el constructor, pero para mejor vista el damos enter
    this.lado = lado,
    this.area = lado * lado;    //asi pongo el area mediante el lado que me mandaron
}

main444(List<String> args) {
  final cuadrado = new Cuadrado(10);    //con el lado simplemente ya calculamos el area
  // cuadrado.lado = 20;    //no me deja hacer o cambiar mientras no sea el constructor porque es un final
}


//constructores constantes
class Location {
  final double lat;
  final double lng;
  const Location( this.lat, this.lng );//este es el constructor
}
main422() {
  final sanFrancisco1 = new Location(18.2323, 39.9000);
  final sanFrancisco2 = new Location(18.2323, 39.9001);
  final sanFrancisco3 = new Location(18.2323, 39.9001);

  // print( sanFrancisco1 == sanFrancisco2 ); // False
  // print( sanFrancisco2 == sanFrancisco3 ); // False  como apunta a diferentes espacios en memoria aunque tengan los mismos valores son diferentes esto es cuando no son const

  const sanFrancisco4 = const Location(18.2323, 39.9000);
  const sanFrancisco5 = const Location(18.2323, 39.9001);
  const sanFrancisco6 = const Location(18.2323, 39.9001);
  const berlin = const Location(18.2323, 39.9001);

  // print( sanFrancisco4 == sanFrancisco5 ); // False
  print( sanFrancisco5 == sanFrancisco6 ); // true    pero cuando son const y tienen el mismo valor apuntan al mismo valor en memoria por eso da true
  print( berlin == sanFrancisco6 ); // true

}


//constructores Factory
class Rectangulo {
  int? base;
  int? altura;
  int? area;
  String? tipo; // cuadrado base = altura, rectangulo base != altura

  factory Rectangulo(int base, int altura) {  //un factory tiene que regresar una nueva instancia de la clase, o una ya creada
    
    if ( base == altura ) {     //si es igual sera un cuadrado, esto es lo que nos permite factory poder enviar el constructor que mejor se acomple
      return Rectangulo.cuadrado(base);   //el factory nos dice que tenemos que retornar una nueva instancia 
    } else {
      return Rectangulo.rectangulo(base, altura);   //solo puede enviar una nueva instancia y los constructores con nombre la crean ya 
    }
  }
  Rectangulo.cuadrado( int base  ) {    //creamos dos constructores con nombres
    this.base   = base;
    this.altura = base;
    this.area   = base * base;
    this.tipo   = 'Cuadrado';
  }
  Rectangulo.rectangulo( int base, int altura ) {
    this.base   = base;
    this.altura = altura;
    this.area   = base * altura;
    this.tipo   = 'Rectángulo';
  }
}
maisn(List<String> args) {
  final figura = new Rectangulo(10, 15);  //aqui lo envio y ya gracias al factory ve que el cosntructor que se acopla mejor es el del rectangulo
}


//propiedade y metodos 'static'
class Herramientas {
  static const List<String> listado = ['Martillo', 'Llave Inglesa', 'Desarmador'];    //en las clases tambien se pueden poner propiedades como listas
  //lo ponemos const para que no podamos modificar la propiedad
  //final puede funcionar con las propiedades primitivas como int String Bool etc.
  //cuando tienen static normalmente se usan para lectura, entonces no tenemos que crear una nueva instancia de la clase

  static void imprimirListado() => listado.forEach(print);// lo mismo pasa con los metodos solo pueden ser llamados sin inicializar
}
mainss() {
  
  //final herr = new Herramientas();
  //herr.  //no esta la propiedad por que las props static forman parte de la clase no de las instancias

  // Herramientas.listado.add('Tenazas');   //no se puede modificar porque es const
  //si fuera final no const si podemos usar sus metodos para anadir y todo eso
  // Herramientas.listado.forEach(print);   //para imprimir el listado podemos hacer un forEach y asi pero como podemos ver podemos acceder a el sin crear una nueva instancia
  Herramientas.imprimirListado();   //aqui solo llamamos un metodo
}


//patron Singleton
//lo que hace el patron singleton es que aunque hagamos nuevas instancias regresen el mismo espacio en memoria, entonces si le cambiamos algo cambiara en todos

class MiServicio {    //una clase normal

//aqui comienza el Singleton
  static final MiServicio _singleton = new MiServicio._internal();  //esto es una propiedad privada, recordemos que una propiedad static se queda el mismo espacio en memoria, entonces aqui ya todo lo que se guarde se guardar en el mismo espacio en memoria
  //esta propiedad (la puedo llamar con un .) lo que hace es crear una nueva instancia de esta misma

  factory MiServicio() {    //creamos el factory porque cuando creen esta instancia se enviara la nueva instancia pero como esta arriba en privada la envio aqui y esta misma tiene el mismo espacio en memoria
    return _singleton;
  }

  MiServicio._internal();   //primero tenemos que crear un constructor privado
  //MiServicio._();   //tambien se puede poner asi o con nombre

  String url = 'https://abc';   //las propiedades normales
  String key = 'ABC123';
}

maisdn() {
  final spotifyService1 = new MiServicio();
  spotifyService1.url = 'https://api.spotify.com';

  final spotifyService2 = new MiServicio();
  spotifyService2.url = 'https://api.spotify.com/v2';   //como apuntan al mismo espacio cambia tambien en el servicio 2

  print( spotifyService1 == spotifyService2 ); // Falso?  //sin el singleton esto seria falso porque apuntan a diferentes espacios en memorias
}


//extends
class Vehiculo {    //creamos una clase con una propiedad y dos metodos 
  bool encedido = false;

  void encender() {   //como no regresa nada es un void este metodo
    encedido = true;
    print('Vehículo encendido');
  }

  void apagar() {
    encedido = false;
    print('Vehículo apagado');
  }
}

class Carro extends Vehiculo {    //para darle todas las propiedades y metodos y todo lo que tenga ponemos un extends y la otra clase
    int kilometraje = 0;    //solo ponemos lo que queramoms que tenga y no tiene la clase extendida
}


//clases abastractas
//usamos el mismo ejemplo de arriba
//cuando son abastractas no es posible crear instancias simplemente son como el cascaron para darles todas las propiedades o metodos a los hijos que la extiendan

abstract class Vehiculo2 {
  bool encedido = false;

  void encender() {
    encedido = true;
    print('Vehículo encendido');
  }

  void apagar() {
    encedido = false;
    print('Vehículo apagado');
  }

  bool revisarMotor();    //cuando son abstractas simplemenet se puede generar el metodo asi aunque no lo definamos por completo aunque hay que definirlo despues con el hijo
}

class Carro2 extends Vehiculo2 {
    int kilometraje = 0;

    @override     //override sirve para decir que cambiaremos un metodo del padre, en este caso Vehiculo2
    bool revisarMotor() {   //y ya aqui definimos como seria el metodo
      print('Motor OK!');
      return true;
    }
}


//super constructor
class Persona3 {

  String nombre;
  int edad;

  Persona3(this.nombre, this.edad);   //recordemos que al poner asi el this decimos que seran tambien las propiedades esas que envian en la clase

  void imprimirNombre() => print('Nombre: $nombre, Edad: $edad');
}

class Cliente extends Persona3 {

  String? direccion;
  List ordenes = [];

  Cliente(int edadActual, String nombreActual):   //como nuestra clase que extendimos necesita argumentos entonces, hacemos un constructor donde resiva esos argumentos
    super(nombreActual, edadActual);  // y con la palabra super se la enviamos al padre o lo que nos pedia

  @override //esta palabra como dijimos se usa cuando cambiemos el metodo del padre
  void imprimirNombre() {
    super.imprimirNombre(); //si queremos llamar algo del padre podemos poner la palabra super, y esta llama el imprimir nombre del padre
      print('Cliente: $nombre ($edad)'); 
    }
}
mainssd(List<String> args) {

  final pedro = new Cliente(33, 'Pedro');   //aqui se los enviamos 

  pedro.imprimirNombre(); //y sigue teniendo el metodo
}


//mixins
mixin Logger {    //cualquier clase que hagamos pueden ser un mixin
//los mixin no pueden ser instanciados son como las clases abstractas pero tienen otras cualidades
//estos mixin no pueden crear constructores
//solo estan para transferir metodos o propiedades a otras clases

  void imprimir( String texto ) {
    final hoy = DateTime.now();   //con esto obtengo la fecha exacta de hoy 
    print('$hoy :::: $texto');
  }
}


abstract class Astro with Logger {    //para dar sus propiedades y metodos es con with no con extends

  String? nombre;

  Astro() {
    imprimir('-- Init del Astro --');   //podemos ver que este si tiene un constructor
  }

  void existo() {
    imprimir('-- Soy un ser celestial y existo --');
  }
}
class Asteroide extends Astro with Logger {   //se le pueden extender los dos primero las clases y despues los mixis
//creo que este with esta de mas ya que astro ya lo tiene

  String? nombre;
  Asteroide( this.nombre ) {
    imprimir('Soy $nombre');
  }
}
mainsdsf() {
  final ceres = new Asteroide('Ceres');
}


//documentacion
doubledoc(){
  double numero = 3.1416;   //cuando creamos asi podemos decir que estamos creando una instancia de la clase double, entonces la variable tiene todos los metodos y propiedades de la clase double
  double infinito = double.infinity; // aqui mismo usamos las mismas propiedades del double sin inicializarlo
  print('$numero.sign');    //esto puede funcionar ya que sign es una propiedad del double y en la documentacion podemos ver eso
  //podemos encontrar mucho mas de sus metodos en su documentacion https://api.dart.dev/stable/2.4.1/dart-core/double-class.html

   print('isFinite: ${ numero.isFinite } :: $numero');    //si es finito  true
  print('isFinite: ${ infinito.isFinite } :: $infinito');   //false

  print('abs: ${ numero.abs() } :: $numero');   //valor absoluto :: 3.1416
  print('ceil: ${ numero.ceil() } :: $numero');   //retorna el numero entero mayor que este :: 4
  
  // print('ceil: ${ infinito.ceil() } :: $numero');  //este es infinito entonces un numero despues da error

  print('ceilToDouble: ${ numero.ceilToDouble() } :: $numero'); //asi lo mismo que el ceil pero devuelve un double
  
  print('round: ${ numero.round() } :: $numero');   //este lo redondea y redondea con el punto de decimal 
  print('round: ${ numero.roundToDouble() } :: $numero');   //lo mismo pero devuelve un double
  
  print('clamp: ${ numero.clamp(1, 3) } :: $numero');  //este devuelve un numero que este en el limite, y el que tienes entonces si tengo 5 dara 3 si tenemos 2.32 dara ese mismo valor porque esta entre el menor y el mayor
}

stringdoc() {
  String nombre = 'Sebastian';
  String apellido = 'Perez';
  String nombreCompleto = '$nombre $apellido';

  print('Length: ${ nombreCompleto.length } ');   //nos dice cuantos caracteres tiene
  print('Contains F: ${ nombreCompleto.contains('S', 0) } '); //la primera le decimos si contiene esa letra y el 0 le estoy diciendo que comience a buscar de la posicion 0, devuelve true
  print('EndsWith a: ${ nombreCompleto.endsWith('a') } ');  //le estoy diciendo si termina en. False

  print('PadLeft: ${ nombreCompleto.padLeft(20,'.') }');    //si nuestro nombre es de 16 y le decimos que tiene que ser de 20 pone el punto 4 veces si tenemos dos puntos los pone 4 veces y si tenemos 4 puntos los pone 4 veces tambien
  print('PadRight: ${ nombreCompleto.padRight(20,'.') }');  //lo mismo pero del otro lado

  print('Operador []: ${ nombreCompleto[10] }');    //extraemos la letra por la posicion
  print('Operador *: ${ nombreCompleto * 2 }');   //duplica el valor del string
  print('Operador *: ${ '*' * 10 }');   //tambien se puede multiplicar asi, se multiplico el arterisco

  print('ReplaceAll: ${ nombreCompleto.replaceAll(RegExp(r'e'), 'a') }'); // remplaza todas las e por a
  print('SubString: ${ nombreCompleto.substring(0, 5) }');    //acorta el string
  print('indexOf F: ${ nombreCompleto.indexOf('b') }'); // nos dice en que posicion esta 

  print('Split: ${ nombreCompleto.split(' ') }'); // Le estoy diciendo que corte la palabra donde encuentre el espacio, o puede ser cualquier otra cosa, pero se elimina ese espacio
 
  print('Capitalizar: ${ nombreCompleto[ nombreCompleto.length - 1].toUpperCase() }');  //aqui capitalice la ultima letra del nombre  
}

listdoc() {
  List<int> lista = [1,2,3,4,5];
  List<int>? lista2; 
  List<int> lista3 = [3,1,2,15,-10];
  List<String> nombres = ['Tony', 'Peter'];

  print('Length: ${ lista.length }');   //la cantidad de elementos
  print('First: ${ lista[0] }');  //el elemento
  print('First: ${ lista.first }'); //el primer elementos
  print('Last: ${ lista.last }'); //el ultimo

  print('is empty: ${ lista.isEmpty }');    //preguntamos si esta vacia
  print('is empty?: ${ lista2 == null }'); // true  para ver si esta vacia


  print('asMap:  ${ lista.asMap() }');  //para convertirlo en mapa

  Map listaMapa = lista.asMap();  //asi tambien se puede usar lo que tenga lista la almacena en esa variable
  print('ListaMapa: ${ listaMapa[4] }');  //los mapas no tienen last 

  print('indexOf: ${ nombres.indexOf('Peter') }'); // regresa -1 si no encontro pero ahorita si encontro en la posicion 1 Peter

  // int mayor3 = lista.indexWhere( (numero) {    //necesita una funcion para devolver true o false y una condicion y nos regresa la posicion que cumple con la condicion que le pusimos

  //   if ( numero > 3 ) {
  //     return true;
  //   } else {
  //     return false;
  //   }

  // });
  int mayor3 = lista.indexWhere( (numero) => (numero > 3) ? true : false ); //este es el mismo codigo de arriba pero resumido

  print( 'indexWhere mayor 3: $mayor3' ); //nos devuelve el indice que cumple la condicion

  print('Remove: ${ nombres.remove('Tony') }');   //si lo elimina devuelve true, tener cuidado que si elimina el listado original

  lista.shuffle();//para revolver los elementos

  lista3.sort();  //ordena la lista
  print('Sort: $lista3');
  print('Reverse: ${ lista3.reversed.toList() }');//en reversa ordenado, pero lo paso por toList porque esto regresa un iterable no una lista

  nombres.forEach( (nombre) {   //el argumento seran todas las posiciones una por una del listado
    nombre = nombre.toUpperCase();  //aqui solo le damos algo que hacer por cada iteracion
    print(nombre);  //pero no cambia la lista original porque no son por referencia, este solo hace una accion por cada elemento
  });

  final newList = nombres.map( (nombre) => nombre.toUpperCase() ).toList(); //map es como un forEach pero devuelve un iterable por eso el toList pero nombres no cambia solo se almacena un nuevo listado
  print('newList: $newList');
}

mapasdoc() {
  final persona = {
    'nombre'   : 'Marcela',
    'apellido' : 'Cruz',
    'edad'     : 18,
  };

  final direccion = {
    'ciudad': 'Ottawa',
    'pais'  : 'Canadá'
  };

  print('Length: ${ persona.length }');   //nos devuelve cual es el numero de pares de valores
  print('keys: ${ persona.keys }');   //esto devuelve un iterable y asume que es un string por el objeto, nos manda los primeros nombres
  print('values: ${ persona.values }'); //lo mismo para los valores


  persona.addAll( direccion );    //esto hace que a la persona se le agreguen todos los elementos que tiene direccion

  persona.remove('pais');   // para eliminar elimina el par de valores

  // persona.removeWhere( (key, value) {    //para eliminar algo que cumpla alguna condicion, tiene estas dos propiedades
  //   if ( key != 'nombre' ) {   //le estoy diciendo que si es diferente de nombre, eliminada
  //     return true; //si se tiene que eliminar 
  //   } else {
  //     return false;    //si se tiene que mantener
  //   }
  // });

  // persona.removeWhere( (key, value) => (key == 'nombre') ? false : true ); //asi tambien se puede hacer mas pequeña

  persona.forEach( (key, value) {   //dos argumentos key y value, lo mismo por cada par de valores hace algo
    print('key: $key   value: $value'); //este no retorna nada solo hace una accion
  });

  final nuevoMapa = persona.map( (key, value) {   //este si retorna un nuevo mapa, los dos argumentos necesarios
    return MapEntry(key, value.toString().toUpperCase() );    //tiene que retornar un MapEntry    y transformo cada uno de los valores que tenga valor de persona
  }); //pero para modificar se necesita enviar a una nueva instancia o variable

  print('persona map: $nuevoMapa');
}


