//desde 0 creare estas notas 
//en c# se pueden crear tres tipos de aplicaciones, consola, escritorio y web

//toda aplicacion de c# por lo menos debe de estar adentro de una clase
//c# distingue entre mayusculas y minusculas asi que tener mucho cuidado con eso
//c# va construido por bloques que se miran con {}

//en c# hay clases propias que nosotros creamos y las predefinidas que se conocen como bibliotecas de clases o API
using System;
//identificadores serian todos los nombres de las clases de los namespace de las variables y asi
//en c# solo se pueden usar letras numeros y guiones bajos solamente, siempre deben de comenzar por una letra o guion bajo no por un numero y no se tiene que utilizar palabras claves o palabras reservadas
namespace PrimeraAplicacion //es como separar el codigo a uno nuevo entonces en otro namespace no importa si ponemos el mismo nombre de alguna clase ya que esta separado como que si fueran diferentes carpetas
{
    class Program       //dos veces no se puede poner el mismo nombre de la clase solo que se coloque en otro namepace
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello Word!!");  //console es una clase predefinida que viene con el lenguaje
            System.Console.WriteLine("hola");   //asi tammbien se puede poner por si no queremos usar el using de la primera linea

            //hay muchos tipos de variables buscar en google para mas informacion 
            //utf16 esto es un gran mundo pero es una codificacion de los caracteres 
            //las variables se recomiendan si esta compuesta por varias palabras que comiece por mayuscula esto se conoce como CamelCase
            int edad;   //asi se crea una variable
            int edad2 = 18; //asi se inicializa
            edad = 22;  //tambien se puede hacer asi

            //uno de los operadores ademas de los conocidos es "%" residuo de una division
            edad--;
            edad++; //ya conozco estos que van incrementando el valor pero hay otro
            edad+=3;    //esto incrementa 3 ademas de 1 
            Console.WriteLine(edad++);  //esto primero escribe la edad y despues le suma
            Console.WriteLine(++edad);  //entonces podemos ponerlo como prefijo para que primero se sume y despues se escriba
            Console.WriteLine(5/2); //esto devuelve un valor entero por que ve que los dos valores son enteros asi que en el resultado devuelve entero
            Console.WriteLine(5.0/2.0); //ya si lo convertimos a decimal tambien el resultado devolvera decimal
            Console.WriteLine(9%4); //como lo dije antes esto devuelve el residuo asi que en este caso devuelve 1
            Console.WriteLine("hola " + edad + "feliz noche");  //la concatenacion de strigs
            Console.WriteLine($"hola {edad} feliz noche");  //esta es otra forma mas eficiente

            int edad1;
            int edad2;
            int edad3; 
            edad1 = edad2 = edad3 = 27d;    //c# permite darles el mismo valor a muchas variables al mismo tiempo de esta manera

            var edadPersona = 27;   //con la palabra var le estamos diciendo que el programa decida al momento de darle un valor de que tipo sera un tipo comodin
            edadPersona = "hola";   //esto no se permite hacer darle otro tipo valor a la misma variable
            var nombrePersona;
            nombrePersona = "Sebastian";    //esto tampoco se permite solo crearla con var y despues darle el valor

            //conversiones explicitas o casting
            double temperatura = 3.4;
            int temperatura2;
            temperatura2 = temperatura;     //esto da error ya que son de diferentes tipos de datos
            temperatura2 = (int) temperatura;   //mas si lo podemos convertir a entero antes y ya poderle dar ese valor, pero no aproxima los numeros 

            //conversiones implicitas 
            int habitantes = 1000;
            long habitantes2021 = habitantes;   //estas conversiones si deja por que solamente son de diferente capacidad entonces si puede almacenar
            float peso = 233.23F;   //las variables tipo float deben de llevar la f al final siempre mayuscula

            Console.ReadLine(); //una entrada de texto como se conoce, pero recordar que lo que nos devuleve es un texto
            int numero3 = Console.ReadLine();   //esto dara error por que devuelve texto
            int numero4 = int.Parse(Console.readline());    //entonces con el int.Parse se convierte en numero entero asi mismo se puede hacer con float.Parse y asi con los demas tipos de datos
            Console.WriteLine("El resultado es: " + (numero3 + numero4));   //asi se puede hacer la suma de una vez 

            const int VALOR = 3; //asi se declaran las constantes como buena practica se ponen en mayusculas las constantes
            Console.WriteLine("El valor es: ", VALOR);  //tambien se puede poner el valor como segundo parametro en wl WriteLine pero esto no muestra nada
            Console.WriteLine("EL valor es: {0}", VALOR); //aqui le estoy diciendo que agarre el valor 0 como en un array

            Math.Pow(3, 2);     //las de math es una funcion o algo asi para hacer calculos matematicos este Pow es para hacer una potencia primero la base y despues el exponente, los dos datos tienen que ser double 

            //metodos
            //todos los metodos iran dentro de una clase
            //en c# la palabra metodo y funcion son lo mismo    
            int sumaNumeros(int num1, int num2) { //tenemos que especificar que tipo de dato devolvera al principio del metodo
                                //recordar que puede llevar parametros y se tiene que especificar el tipo de dato de los parametros
                return resultado;   //el return es para decir que devolvera el metodo
            }
            void sumaNumeross() {       //un metodo que no devuelve nada se le pone la palabra reservada void

            }
        }
    }
}       //como nosotros creamos namespace para definir clases asi tambien viene las predefinidas en este caso el namespace de console es System por eso ponemos la primera linea de codigo