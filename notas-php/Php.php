<html>  <!--php puede funcinar perfectamente en una estructura de html-->
  <head>
    <title>PHP Test</title>
  </head>
  <body>
    <?php echo '<p>Hello World</p>'; ?> <!--pero si o si tenemos que usar la etiqueta de php-->
</html>


<?php   //o solo podemos crear la etiqueta para comenzar a escribir codigo 

$variable = 8;  //asi declaramos una variable siempre con el valor del dollar
                //el punto y coma es muy importante

print_r()   //muestra información sobre una variable 
function waifus(){  //la forma de hacer una funcion es igual que en js 
}
$variablee = array(); //asi se declara un array 
$socio = array("onepiece" => "boa", "naruto" => "hinata");  //esto es un array asociativo esas tres primeras partes son un elemnto del array en este caso 0 y 1
//se podria decir clave y valor 


//digamos que necesitamos traer una clase de otro archivo tambien como en los demas lenguajes la tenemos que llamar
require_once('nombreDelArchivo.php');   //asi podemos llamar el otro nombre de los archivos  
class Person {  //asi se crea una clase en php
  public $license;  //estas son las variables
  public $driver;

  public function __construct($license, $driver) {    //asi se crea el metodo constructor para la clase
                                                      //esas variables solo son parametros que les podemos dar a la clase 
    $this->license = $license;    //como en otros lenguajes se usa this para decir que es de esa clase
    $this->driver = $driver;
  }
  
  public function printData(){    //asi se crean los metodos que puede tener la clase 

  }
}

//en php digamos que tenemos una clase llamada Person entonces para crear una instancia de esa clase o crear un objeto de esa clase hacemos lo siguiente
$person = new Person();

//para crear herencias se tienen que llamar los archivos como lo hicimos anteriormente
class Student extends Person {   //asi hacemos la herencia de las clases student tendra todo lo que tenia Person
  public function __construct($license, $driver) {    //tambien necesita su metodo constructor
    parent::__construct($license, $driver)    //aqui le estamos pasando a los atributos que tiene la clase padre

  }
}

?>  <!--no es obligatorio poner el cierre-->





