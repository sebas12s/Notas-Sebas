//para crear un archivo y verlo graficamente nos vamos a new y creamos un wpf app .net freework en vs
//en .xaml para crear cosas graficamente

//para crearlo normal es en cosole app .net core  o frework

//para crear una aplicacion de consola solo asi aparece 

using System;   //esta es la estructura basica de c sharp 
//system es un namespacce ya definido por c sharp tiene unas instrucciones que podemos ejecutar


namespace helloWorld {  //nosotros tambien podemos crear namespace      siempre se usa el nombre del archivo en el que estamos trabajando
    class Program {
        static void Main(string[] args) {
            Console.WriteLine("hello world");  
        }
    }
}

string name = "Sebastian Perez de Leon";        // se declaran las variables con el tipo de variable y despues el nombre 
Console.WriteLine($"Este es mi nombre: {name}");        //esta es una forma de concadenar 
Console.WriteLine("Este es mi nombre: " + name);        //esta es otra 

//ahorita usaremos un nuevo proyecto en vs con wpf  nos metemos en uno que diga .net y este nos permite crear presentaciones graficas
//esto nos ayuda a crear mas con label cajitas y asi 

//veremos namespaces
//un namespaces tiene que ser unico en todo tu codigo de c sharp, cada namespace tiene que ser significativo para tu programa
//es como ponerle titulos a tus comandos, ejemplo si una serie de comando lo que hace es validar una respuesta del cliente podemos ponerle respuesta 

//clases: plantillas para crear entidades
//metodos: una manera de ejecutar las funciones, 
//statement: donde imprimimos un dato donde podemos poner una variable y asi

//tipos de datos
// int, bool, float, double, char string  long uint         long numeros enteros grandes            uint numeros enteros positivos grandes

//casteo implicito cuando un valor lo meteras en un tipo de dato mas grande como un int a un long       
//casteo explicito este se hace manualmente el anterior lo hace c sharp pero este no manual

string fullUserName = Console.ReadLine();   //este readline hace que puedan ingresar algun dato en este ejemplo lo guarda en la variable
var fullname = Console.ReadLine();          //con solo poner var es como decir una variable sin importar el tipo

Console.WriteLine("input the first number");        //pedimos un numero pero es un integer
numero = Convert.ToInt32(Console.ReadLine());       //entonce para que numero sea un numero entero hacemos el convert. y despues le decimos a que queremos convertirlo y lo ponemos en medio de los parentesis

string information = height + name + "hola \n como estan";        //se puede concatenar en variables y ese \n hace un salto de linea  

//se puede multiplicar un entero con un float siempre y cuando nuestra variable que recibe la multiplicacion sea tambien float
float numeross = 1029.2f;       //un numero float tiene que llevar la f al final

//nunca hay que perder informacion

//% este operador saca el modulo

bool a = true;      //asi se crean las variables booleanas
// &&, ||, !, ^
bool result = value && value2 || value3;         //asi se puede poner los operadores tambien
bool resultt = !value;          //este operador nos devuelve lo contrario 
bool resulttt = value ^ value2;         //esto mira si son diferentes

// != no igual a 
//>=        mayor o igual 
//<=      menor o igual
bool result0 = value == value2;       //el operador en este caso es de tipo booleano

float numerosss = float.Parse();     //todo lo que esta en los parentesis se convertira en float asi se puede hacer con otros tipos de datos

string[] pokemon;     //asi se declaran los arrays
float[] array2;

pokemon = new string[]{"pikachu", "charmander", "charizar"};       //asi se puede agregar valores a los arrays        
array2 = new float[]{1.3f, 1.6f, 3.5f};          //asi un array de float recordar la f
arrays = new int[10]{};        //asi le decimos que tendra 10 espacios
int index = array.IndexOf(userName, userToSearch);          //index tendra el index del array para eso es el index el primer parametro es donde buscara y el segundo que buscara en este caso hay un nombre en esa variable
                                                            //si regresa -1 es por que no encontro ni uno 

for (int i = 0; i < pokemon.length; i++) {      //el ciclo for es igual 
    Console.WriteLine(pokemon[i]);              //este seria un ejemplo para un array
}

pokemon[2] = "greninja";        //esta es una manera de cambiar algun elemento de nuestros arrays

//listas esto si es algo nuevo
using System.Collections.Generic;       //tenemos que poner esto al comienzo para que deje crear listass
List<string> nombreLista = new List<string>();      //primero declaramos que vamos a utilizar una lista despues definimos de que tipo sera despues le ponemos su nombre despues le decimos que sera una nueva lista
//aparece como dos veces pero le estamos diciendo que me cree una copia de esa lista y contendra string 
nombreLista.add("algo que quieras agregar"); //asi puedes agregar algo a las listas

for (int i = 0; i < nombreLista.Count; i++) {         //este count contara los elementos de la lista 
    Console.WriteLine(nombreLista[i]);          //asi mismo recorre los elementos de la lista en este caso 1     
}

nombreLista.Remove("lo que queremos remover");      //con esto eliminamos algo\
nombreLista.RemoveAt(0);        //se podria decir que por el rango 
nombreLista.RemoveRange();      //tambien se puede eliminar por rango 
nombreLista.Clear();        //este limpia la lista los remueve todos los elementos
nombreLista.Append();        //agrega un valor al final es como que estuvieramos haciendo push
nombreLista.ForEach();          //el foreach que recorre y asi
nombreLista.FirstOrDefault();       //nos devulve el elemento por default o el primer elemento que esta en la lista

//metodos formas para resolver algo y tenerlo para cuando vuelva a aparecer el error
//como las funciones las declaramos y las podemos mandar a llamar a cualquier momento

//recordemos que al principio usamos System entonces es como que si pudieramos usar cosas de esa clase se podria decir el siguiente es uno de esos

Random rnd = new Random();      //aqui le estamos diciendo que rondom rnd es la variable sea un nuevo random 
Console.WriteLine($"{rnd.Next(1, 10)}");        //rnd es random     next nos ayuda a temer el siguiente valor entonces le dice que el siguiente numero sea del 1 al 10
//hay metodos que podemos crear o metodos que ya viene de c sharp o alguna clase
//metodos 
//veremos algunos que ya estan en c sharp de string

string SchoolClone = School.Clone().ToString();         //clone crea un clon exacto de esa variable pero es necesario convertirlo a string por eso toString 
Console.WriteLine(School.Contains("Pla"));      //retorna true si el string contiene los caracteres que hayamos puesto ahi
Console.WriteLine(School.EndsWith("zi"));       //parecido al anterior pero revisa si esta al final
Console.WriteLine(School.StartsWith("Pl"));         //lo mismo que anterior pero al comienzo
Console.WriteLine(School.Equals(SchoolClone));          //retorna true si es igual si no false
Console.WriteLine(School.IndexOf("a"));             //ingresa el index del caracter donde se encuentra 
Console.WriteLine(ClassTopic.ToLower());         //convierte todo el string a minusculas
Console.WriteLine(ClassTopic.ToUpper());        //convierte todo el string a mayusculas
Console.WriteLine(School.Insert(6, " es educación online efectiva"));       //ingresa un nuevo string en la posicion en la que le senalemos
Console.WriteLine(ClassTopic.LastIndexOf("s"));    //este regresa la ultima vez que se puso ese caracter te regresa la posicion
Console.WriteLine(ClassTopic.Remove(6));        //elimina el caracter de la posicion que pongo
Console.WriteLine(ClassTopic.Replace("s", "z"));        //este cambia el primer valor por el segundo
string[] split = ClassTopic.Split(new char[] { 's' });		        //este es extrano pero este separa el string por trozos en el parametro donde pusimos la s ahi ponemos la senal que queremos que se separe
		
        Console.WriteLine(split[0]);
        Console.WriteLine(split[1]);
        Console.WriteLine(split[2]);
Console.WriteLine(ClassTopic.Substring(2,10));      //devuelve los string que se mantienen en esas posiciones
School.ToCharArray();           //convierte el string en un arreglo de caracteres uno por uno
Console.WriteLine(TextWithSpaces.Trim());       //elimina los espacios si tienen al comienzo y al final del string



//crear mis propios metodos
//primero los metodos se crean en las clases no adentro de otros metodos
public void IntegerAddition(int a, int b)       //aqui cramos un metodo que sume dos numero por eso le agregamos dos paramtros enteros
	{           //este es el cuerpo o bloque del metodo 
		int Addition = a + b;           //aqui hicimos la suma normal
		Console.WriteLine("El resultado es " + Addition);
	}
    //para llamar nuestro metodos lo hacemos en el metodo main 

Program Resultado = new Program();      //program es el nombre de la class o el nombre del archivo se podria decir  
//program es la clase del programa o donde esta el metodo 
//es como decir que esa variable que es resultado se podra usar todos los metodos que estan en esa clase
Resultado.IntegerAddition(3,6);         //ya despues se puede hacer normal el method        este method no retorna ningun valor 






//orientado a objetoss

//cuando tiene la palabra void es por que no retorna nada
//cuando tiene la palabra return regresa algo 
	public int IntegerMultiplication(int a, int b)
	{
		int Multiplication = a * b;
		return Multiplication;          //esto es lo que retorna
	} 
    public static void Main()
	{
		int result = MyProgram.IntegerMultiplication(12,2);	        //cpmo retonra um valor lo tenemos que guardar en una variable
		Console.WriteLine("El resultado de la multiplicación es " + result);        //pero en este caso no se tiene que hacer el new program()
	}

public class Casa       //esta es una clase y todas las que vaya creando asi son clases 
{
    public string Color;

    public void Venta()
    {
        Console.WriteLine("se vendio" + color + " vendida")
    }

    //constructor por defecto
    public Casa(string color2){         //el nombre del constructor se aconseja que sea el mismo que el nombre de la clases
                                        //le estoy diciendo que necesita resivir un parametro de tipo string y lo guardara en esa variable
        Color = color2;     //le estoy diciendo que el atributo color tendra como valor el color que resivimos en el parametro
    }
}

namespace helloWorld {  //haremos que estamos en la clase principal y aqui podemos llamar la clase casa
    class Program {
        static void Main(string[] args) {
            Casa casa1 = new Casa();       //aqui ya estamos creando un objeto de la clase casa
            //se inicializa el objeto para eso se hace la linea de arriba
            casa1.Color = "verde";      //aqui le agregamos un atributo al objeto
            casa1.Venta();          //aqui invocamos el comportamiento o metodo 
            Casa casa2 = new Casa("rojo");  //aqui le pase el parametro que me pedia 
            casa2.Venta();      //y solo volvi a invocar el metodo de venta
        }
    }
}





//if    
if (true)       //asi es la sintaxis
{
    
} else 
{

} else if () 
{

}

//switch 
switch(expression) 
{
  case x:

    break;
  case y:

    break;      //esto es obligatorio para decirle al programa que ahi termina el codigo 
  default:          //default algo por si no hay alguno que coicidan 

    break;
}

//for 
for (int i = 0; i < 3; i++)
{
    Console.Write(i);
}
for (int i = 0; i < 30; i = i + 10)      //esto sera en 10 en 10
{
    Console.Write(i);
}

//while
while (Frio == true)        //sintaxis
{
    Sudadera = true;
}

//do while
int x = 10;
do              //sintaxis
{
    Console.WriteLine("Impresión: " + x);
    x++;
} while (x < 10);

  

Int? //Cuando es así no importa que sea null 
speciesStock.QuantityInStock = (sumQuantityIn ?? 0)  - (sumQuantityOut ?? 0);      //le estoy diciendo que si es null sea 0
variable++;
variable += variable;




//operador aritmetico - * / +
//operadores racionales < > = >=
//operadores logicos || && or


if (item.Rating == "Green")
    {
        int addYears = serviceProviderAssigment.AuditType.Oid == 3 && serviceProviderAssigment.Factory.FactoryTCCC.MostRecentRating == "Red" ? 1 : 3;       //aqui le dijo que si era esa validacion que puso sera 1 y si no sera 3
        newAssessmentsPerformed.AfupNextAuditDate = DateTime.Now.AddYears(addYears);
        
    }
    else if (item.Rating == "Yellow")
    {
        int addMonths = 3;
        newAssessmentsPerformed.AfupNextAuditDate = DateTime.Now.AddMonths(addMonths); //este dateetime le agrega 3 meses o arriba que le agrega 1 año
    }
    else if (item.Rating == "Orange")
    {
        int addMonths = 3;
        if (serviceProviderAssigment.AuditType.Oid == 3)
            addMonths = 6;

        newAssessmentsPerformed.AfupNextAuditDate = DateTime.Now.AddMonths(addMonths);
    }
    else
    {
        newAssessmentsPerformed.AfupNextAuditDate = DateTime.Now.AddMonths(6);
    }