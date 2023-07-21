

//primer hola mundo 
import 'dart:web_audio';
import 'dart:io'; //asi se importan paquetes de dart
import 'dart:math';

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
fun(){
  saludar4(nombre: 'Sebastian', edad: 12);    //y asi se llaman los de nombre no por orden
  //tambien se puede poner argumentos por orden obligatorios y por nombre combinarlos
}
