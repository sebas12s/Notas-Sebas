
import 'dart:async';
import 'dart:io'; //asi se importan paquetes de dart
import 'dart:math';

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
  Persona.nombre() {

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

  //por el constructor ya no se envia asi
  // persona..nombre = 'Sebastian'
  //       ..edad = 17; //operador en cascada asi tambien lo podeoms poner mucho mas facil
        //..amor = 'Marcela';   //la puse privada asi que no se puede llamar

  print(persona.toString());  //tambien podemos cambiar los metodos que ya traen, como en persona al llamar este metodo lo puedo editar en mi clase

  print(persona.amor);  //asi llamamos el get
  persona.amor = 'Marcela'; //aqui tambien estoy haciendo el set no importa que tengan el mismo valor
}

