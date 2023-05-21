class Java {        //en java es necesario que el nombre de la clase se llame como el nombre del archivo
    public static void main(String[] args) {
        System.out.println("hola");     //con esto podemos imprimir un mensaje en pantalla
        ArrayList<Double> start;        //esto es un array especial de java 
    }
}

Person person = new Person();   //asi declaramos un nuevo objeto en java le estamos diciendo que todos los atributos los tendra esa tipo variable
// en person aunque no hayan metodos siempre por defecto nos genera un metodo constructor al crear un nuevo obejto
//al colocar esto ya el objeto tiene un espacio en memoria en otras palabra es creado
person.atributo = "nombre del vengativo";       //asi se le puede ir dando valores a los atributos si tenemos 

void nombreDelMetodo() {
    //aqui pondria que hace el metodo creado
}

//digamos que tengo una clase car y le quiero construir su metodo constructor, aunque venga por defecto
public Car(String license, Account driver) {    //esto es un nuevo metodo en este caso es el metodo constructor por que tienen el mismo nombre que la clase
                                                //esto son los parametros que puede resivir y account es un objeto entonces estoy creando un objeto tipo account (en este caso no tengo la clase account pero hago la idea que si xd)
                                                //se acostumbra que el nombre de los parametros sea el mismo al nombre de las variables que se refiere
    this.license = license;     //entonces para darles valores se usa el this solamente para decirle que es de esa clase 
    //entonces con el this tengo accesos a todos los atributos de la clase en la que estoy y a los metodos


}

//el nombre de la clase es el mismo que de loss archivos por que tendremos muchos archivos para cada diferente clase

String name;        //asi se declaran las variables
Integer id;

class Car3 extends Car {        //asi se aplica la herencia le estamos diciendo que car3 sera hijo de car entonces me traera todos los atributos y metodos
    String mochila;
    private String gym;     //se le puede poner esto a las varaibles que se asignen en una clase            
                            //esto se refiere al encatsulamiento privar cosas o esconder cosass
    public Car3(String license, Account driver, String mochila){         //pero me pide un metodo constructor igual al padre entonces lo creo y ademas de eso le agregue un nuevo parametro
        super(license, driver);     //con esta linea le estamos pasando los dos parametros a la clase super es como cuando inicializamos un objeto y tenemos que pasar parametros es asi, no commo esta dos lineas abajo
        this.mochila = mochila;     //this como siempre se refiere a estos
        super.license = license;    //y super a los atributos de la clase padre que ahoora pertenecen tambien aqui
    }
}
