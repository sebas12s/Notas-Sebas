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
  nombres2.add('mucho'); //el add es una funcion para agregar un dato
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

  
}
