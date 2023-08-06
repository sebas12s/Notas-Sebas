//!= en programacion asi dices que algo no es algo, ejemplo    a != b    dice que a no es igual a b pero esto es en JS <> asi se puede escribir en otros lenguajes de programacion

alert("te amo boa");	//alert es una funcion de js para mostrar un mensaje en pantalla
						//pero nos lo tira en una pequena pestana donde le podemos dar a aceptar
						//todo texto va en comillas por que asi decimos que es de tipo string (texto)

var a = 1;	//asi declaramos una variable y de una vez les asignamos un valor
var b; 	//asi declaramos una variable sin asignarle un valor
var 
let //esta tambien es una declaracion de variables pero tienen unos cambios
//uno puede ser que los let solo se trabajan en un hambiente se puede decir en un for solo ahi se trabaja afuera del for ya no existe pero con var si existe afuera
const b = 12; //y las constantes si o si teinen que tener un valor


alert("el valor de a es: " + a);	//asi agregamos una variable a un texto con el +  (concadenar variables con texto)
									//una vez agregamos una variable a texto la varible se convierte en texto


var c = prompt("cuantos animes haz visto");	//esta opcion (prompt) es para hacer una pregunta salta como una pestana pequena como en alert pero aqui te deja que el usuario ingrese algo
											//aunque esta opcion almacena texto ya si ingresa numeros quedara como texto no numero			
var d = confirm("te gustan las waifus?");	//esta opcion (confirm) es como un alert pero aqui te deja aceptar o cancelar	

var e = parseInt(c);	//esta opcion (parseInt) lo que hace que el texto de numero que ingresamos en c se convierta en numero entero
var f = parseFloat(c);	//esta opcion (parseFloat) nos permite pasar texto a numero con puntos decimales 
						//tambien podemos pasar de numero entero a numero decimal con estas opciones y numeros decimales a numeros enteros

var g = parseInt(c+a);	//importante esta no es una suma, cuando asignamos se lee de derecha a izquierda 	

//se pueden poner etiquetas de html en js pero tienen que estar entre comillas o no las reconoce aunque solo es un dato no es recomendable
//en js == dos es para comparar y = uno es para asignar


var h = confirm("Estaba viendo a hinata\nY recorde lo hermosa que era");	//este (\n) en linea de texto es como saltar una linea como que le da enter

if (true) {		//esta es la sintaxis simple de if

}
else {

}
//

if (true) {		//este es cuando queremos que evalue otra condicion en el si no (else)

}
else if (true) {

}
else {	//asi podemos seguir creando muchos else if 

}

//hay bloques de codigo que estan adentro de las llaves por eso if no termina en punto y coma

console.log("mirate one piece besto shonen");	//esto deja en la consola un mensaje es una opcion que tiene js, pero este mensaje no lo ven solo se mira desde la consola
//console.log es un truco para ver como esta un objeto por dentro 

document.write("tus animes vistos son: " + c );		 //document es un objeto y ese objeto es todo el archivo que tenemos aqui y write lo que hace es escribir en el momento que lo invocamos		
//los parentesis siempre aparecen cuando hay que invocar una funcion y entonces write es una funcion del objeto document
//cuando las funciones son partes de un objeto se llaman metodos
//el objeto no siempre tendra funciones y si no es funcion la que acompana al objeto no se pone parentesis
//cuado una variable es parte de un objeto se le llama atributo o propiedad
//depurar es el proceso de arreglar un proceso dentro de un codigo


//un poco de explicacion, document es donde esta lo que creamos con html eso es document
//las pestanas en js se le llama window (ventanas)
//y todo el navegador se llama en js davigator



//1
//para llegar al canvas necesitamos llegar primero a la etiqueta y despues al lienzo o donde podemos dibujar o poner los puntos
//aqui vamos a asignar primero la etiqueta y despues el lienzo
var d = document.getElementById("boa");	//primero document donde esta el canvas en si recordar que documnt es la hoja donde tenemos todo lo que creamos
									//como por ID diferenciamos al canvas ponemos el get que significa en espanol (obtener el elemento por su ID)		
									//adentro de los parentesis ponemos el nombre del ID que le asignamos
									//entonces estamos diciendo que en la d tenemos ya canvas pero todavia nos hace falta llegar al lienzo o area del dibujo
var lienzo = d.getContext("2d"); 	//recordar que las funciones llevan parentesis y aqui estamos diciendo que lienzo sera d (que es la etiquita canvas) y el get es una funcion del objeto canvas
									//el get decimos que es como el area que nos va permitir dibujar y ahi le asignamos si en 2d o 3d
lienzo.beginPath();		//aqui estamos diciendo que la hoja donde vamos a dibujar (lienzo) y el .begin.. es para decir que ahi iniciara nuestra primera linea en otras palabras donde ponemos el lapiz en la hoja
lienzo.strokeStyle = "red"; 	//asi le damos el color a la linea
lienzo.moveTo(100,100);	//este es un metodo o funcion del canvas que nos dice para donde ira la linea
lienzo.lineTo(200,200);	//con esta funcion nos sirve para trazar una linea entonces la linea ya esta hecha
						//entonces hay que dibujarla con el estilo que escogimos
lienzo.stroke();		//con esto decimos que vamos a dibujar la linea con el color que le dijimos
lienzo.closePath();		//y con esto decimos que estamos terminando el trazo o levantando el lapiz
//para que las funciones sean invocodas necesitan los parentesis por eso llevan aunque no les asignemos nada, o si no seria un atributo o una propiedad

function dibujarLinea(color, xin, yin, xfin, yfin) {	//las funciones nos ayudan a no tener que repetir una y otra vez el mismo codigo o parecido entonces las creamos nosotros
							//en los parentesis pondremos lo que le vamos a cambiar o las cosas diferentes que tendra 
							//en los parentesis estas poniendo los paramentro que tendra 
							//en en las llaves es lo que se va a repetir cada vez que la funcion sea llamada
							//lo que en realidad estas haciendo en los parametros es declarar variables pero solo funcionan en la funcion
	lienzo.beginPath();
	lienzo.strokeStyle = color;		//lo que hacemos es cambiar las metodos que seran diferentes por las variables
	lienzo.moveTo(xin, yin);
	lienzo.lineTo(xfin, yfin);
	lienzo.stroke();
	lienzo.closePath();
}
//JS primero lee el codigo y las funciones las guarda en su memeria y ya despues de leer hace lo que este fuera de las funciones

var lineas = 30;
var l = 0;
var yi = 0
var xf = 0; 

dibujarLinea("#f34", 300, 22, 200, 50);		//lo que hacemos aqui es, llamar la funcion y colocar los parametros que le vamos a cambiar en el orden que los pusimos tambien
dibujarLinea("#297", 33, 220, 300, 10);		//asi podemos creaer las lineas que queramos ya solo cambiando lo que es necesario cambiar para eso sirve una funcion

//todas las nuevas palabras se declaran como variables
while (l < lineas) {	//este es el ciclo while funciona con una pregunta al comienzo
	l = l + 1;			//l es el contador
	l++;				//asi tambien se puede hacer para sumar 1 
	yi = yi + 10;		//con esto hacemos la cuenta para que vaya haciendo la cuenta y vaya sumando 10 en 10 con ayuda del contador
	xf = xf + 10;
	dibujarLinea("#298", 0, yi, xf, 300);	//aqui con la funcion ya sabe que espacio funcina para que espacio solo cambiamos el espacio con las nuevas variables en las que llevamos la suma de 10 en 10
}
dibujarLinea("#298", 0, 0, 0, 300);		//ya esto es para poner lineas al contorno de lo que dibujamos
dibujarLinea("298", 0, 300, 300, 300);


for (l = 0; l < lineas; 1++) {		//este es el ciclo for que funciona con una variable de tipo numerico decimos que l comienza con 0 y despues hacemos la condicion y despues le decimos que vaya sumando 1 en cada repeticion

}
for (var i = 0; i < Things.length; i++) {	//se puede declarar una variable en donde sea
	Things[i]
}

do {	//y asi se hace el do while es otro ciclo pero con la condicion de ultimo

} while (l < lineas);


//eventos son acciones que ocurren en momentos que queramos o lo necesitemos al darle clic o escribir en el teclado o hasta cambiar de perstana esos son los eventos
//eventos son funciones que se disparan cuando algo ocurre


//2
var texto = document.getElementById(texto_lineas);	//aqui volvemos a llamar el id de lo que queremos modificar de html
var botonjs = document.getElementById(boton);		
botonjs.addEventListener("click", dibujoPorClick);		//esto es anadirle al boton una funcion que este escuchando para ver cuando ocurre un evento, y si el evento ocurre haga una accion
													//botonjs es la variable donde pusimos el boton de html
								//hay muchos eventos que se le pueden dar a un boton por ejemplo cuando pasamos el mause en el boton, tambien cuando se va del boton es un evento hay muchos tipos de evento por eso debemos ser exactos con que evento queremos que reaccione
								//siempre que ponemos funciones las ponemos con (), pero aqui no por que no queremoso que la funcion se dispare de una vez queremos que se dispare cuando se de click
								//por que cuando le ponemos parentesis le decimos que se ejecute ahi la funcion pero aqui solo le estamos diciendo que esa es la funcion y que la ejecute cuando le de click o cuando ocurra el evento

function dibujoPorClick () {			//volvemos a crear una funcion 
	var x = parseInt(texto.value);		//aqui seguiremos como que si haya funcionado
										//como es un input lo que escribimos en un texto entonces lo pasamos a numero entero
								//value nos dice que es lo que tiene adentro o lo que ingresaron ya que es un input
	alert(texto.value);			//tambien solo se puede poner asi sin variable 
}
//hay una cosa, no me funciono el addEventListener en si es esa palabra que no funcino y no se por que 




//variables
//cuando uno declara varibles adentro de una funcion solo se mantienen con vida adentro de esas llaves entonces si declaras afuera se mantienen con vida todo el programa

//1.2
var ancho = d.width;	//le estamos diciendo que nos traiga wl width de canvas (canvas es d lo llamamos asi anteriormente)



//en document esta cualquier cosa para detectar, un ejemplo queremos detectar las teclas del teclado eso esta en document recordar que document es todo el documento donde trabajamos
document.addEventListener("keydown", dibujarTeclado);	//con esto estamos diciendo que al precionar esta tecla, con keydaw se llama al precionar
												//aqui dije como anteriormente al precionar una tecla realice esa funcion
												//aqui si funciono con el keydown 

function dibujarTeclado (evento) {	//en si las funciones no llevan parametros a menos que vayamos a cambiar algo de adentro
									//pero si le ponemos una variable se almacena lo que ocurrio en la funcion o en este ejemplo que tecla fue precionada
									//en otras palabras si ponemos una varible ahi guarda todas las acciones que hizo esa funcion
}								
document.addEventListener("keyup");	//este up sirve para saber cuando deja de oprimir la tecla es mejor por que si le hacemos con keydown la podemos dejar oprimida y nos ejecutaria muchas veces el codigo
//una buena practica de desarrolo puede ser esta que la primera letra es miniscula y las demas al inciar son mayusculas

//Para saber que letra estan oprimiendo se puede usar un console.log y poner la variable en la que esta pasando todo el evento
//cada letra tiene un codigo interno tipo texto aunque tambien tiene uno de numeros

//arriba = up
//abajo = down
//izquierda = left
//derecha = right

//puedo diferenciar las teclas con code, keycode o key pero es recomendable trabajar con keycode

//se pueden crear objeatos que contenga mas variables
//es una buena practica tener todos los numeros en variables ya que se mira mal que esten sueltos
//una buena practica es colocar las varibles que no cambiaran en mucho tiempo en mayusculas (constantes)


var teclas = {		//Asi se puede crear un objeto que contenga variables adentro con un bloque de codigo recordar un par de cosa
					//este bloque si lleva punto y coma
					//esta es una sola linea por eso se divide en comas pero es solo una linea
	UP: 38,
	DOWN: 40,
	LEFT: 37,
	RIGHT: 39
};


console.log(teclas);
document.addEventListener("keyup", dibujarTeclado);
function dibujarTeclado(evento) {
	if (evento.keyCode == teclas.UP) {		//Recordar que asi llamamos la variable por que la creamos en un objeto y ponemos el objeto. y el nombre de la variable
											//recordar algo evento.keyCode que tiene? tiene que tecla es oprimida evento es la accion que ocurre entonces que accion ocurre en este caso que codigo de tecla esta ocurriendo y lo comparamos con el numero o la variable que pusimos que era el numero de la flecha arriba
		console.log("vamos pa arriba");		//asi se puede saber que tecla se oprime y podemos poner todas las teclas que necesitemoso pero en esto solo dejare esta
	}

	switch(evento.keyCode) {		//asi es la sintaxis de case aunque aqui se llama switch
									//se pone lo que compara y despues lo que se compara
		case teclas.DOWN:
			console.log("abajo");
		break;
		case teclas.LEFT:
			console.log("izquierda");
		break;
		case teclas.RIGHT:
			console.log("derecha");
		break;
		default:  	//este es como el else de if la accion que se ejecutara al no precionar ninguna el break no es necesario pero na
		break;
	}
}

//miren este ejemplo
var d = document.getElementById("boa");		//traemos al canvas
var p = d.getContext("2d");					//le decimos que si es 2d o 3d
dibujarLinea("#923", 100, 100, 234, 199, p);	//entonces dicho lo de abajo solo definimos el parametro tambien que p es donde se puede dibujar

function dibujarLinea(color, xinicial, yinicial, xfinal, yfinal, lienzo) {	//como antes no definimos donde dibujar que seria lienzo la ponemos como una variable de la funcion como se puede cambiar cualquier cosa por variables
	lienzo.beginPath();
	lienzo.strokeStyle = color;	//como podemos decirle el color
	lienzo.lineWidth = 2;		//aqui se le puede decir el borde (2px)
	lienzo.moveTo(xinicial, yinicial);
	lienzo.lineTo(xfinal, yfinal);
	lienzo.stroke();
	lienzo.closePath();
}


function dibujarTeclado(evento) {	//este es un ejemplo para dibujar lineas con las teclas
	var colorr = "#923";
	var movimiento = 10;	//asignamos un valor por que se estara sumando
	
	switch(evento.keyCode) {	
		case teclas.UP: 	//con esto decimos que si evento.keyCode es igual a teclas up que es 38
			dibujarLinea(colorr, x, y, x, y - movimiento, p);	//dibujamos la linea y le ponemos todos los parametros de la funcion
																//restamos por que estamos en el centro entonces tenemos que ir para arriba tenemos que restarle a y si queremos para abajo le sumamos a y, si a la derecha sumamos a x si a la izquierda restamos a x
			y = y - movimiento;		//aqui hacemos que y tenga el nuevo valor y se quede guardado
		break
		case teclas.DOWN:
			dibujarLinea(colorr, x, y, x, y + movimiento, p);		//lo mismo para las demas
			y = y + movimiento;
		break;
		case teclas.LEFT:
			dibujarLinea(colorr, x, y, x - movimiento, y, p);
			x = x - movimiento;
		break;
		case teclas.RIGHT:
			dibujarLinea(colorr, x, y, x + movimiento, y, p);
			x = x + movimiento;
		break;
	}

}



// js devuelve los numeros aleatorios asi, de 0.00000001 o 0.999999999 pero nunca es un numero entero por que asi es como que fuera procentaje


Math //es una objeto estatica que nos permite hacer funciones matematicas complejas en js

Math.floor();	//lo que hace este es quitarle el decimal pero le sube un entero
Math.ceil();	//lo que hace este es quitarle el decimal pero lo deja en el numero entero que esta
parseInt(); 	//recordar que este lo que hacia es quitarle el decimal pero no aproxima
Math.random();	//este no lleva ningun numero, y este es el que nos devuelve un numero aleatorio pero en 0. nunca en un entero


function aleatoriosasdf(min, maxi) {
	var resultado;
	resultado = math.floor(math.random() * (mixi - min + 1)) + min;		//esta es una operacion para que me devuelva en numeros enteros el numero random pero con el minimo y maximo de lo que declaremos en la funcion
	return resultado;		//return es algo que nos devuelve un numero o algo que pongamos aqui nos lo devuelve al momento de ejecutar la funcion
}

var z;

for (var i = 0; i < 10; i++) {		
	z = aleatorio(1, 20);
	document.write(z + ", ");	//asi se dejo un espacio en cada numero aleatorio
}


//es una buena practica que la definicion completa de un objeto la letra inicial lleve mayuscula
//deficiones completas de un objeto se le llama clases 
var imagen = new Image();
//tener muy en cuenta que las imagenes al ser cargadas tarda un rato, y antes las tenemos que cargar si no cargan no se puede mostrar


var mapa = "tile.png";		//aqui solo definimos que mapa seria al url de la imagen 

var imagen = new Image();	//esto lleva la mayuscula de la buena practica, image es un objeto es la clase image entonces estamos creando un nuevo objeto y lo estamos guardando en la variable
							//estamos creando una como etiqueta img 
imagen.src = mapa;			//para poder cargar nuestra fuente de la imagen tenemos que pasarle la url con el atributo src que es una variable en el atributo image que definimos antes
							//ya cuando le pasamos por src ahi en ese momento se carga la imagen antes no se puede agregar si no esta cargada

imagen.addEventListener("load", dibujar);	//aqui estamos diciendo que cargue con el load y que ejecute la funcion dibujar
											//recordar que siempre tenemos que cargar la imagen

function dibujar() {
	papel.drawImage(imagen, 0, 0);		//aqui estamos diciendo que le agregaremos la imagne al papel que es el canvas
										//lo primero que le pasamos es la imagen donde ya esta cargada por completo despues donde comenzara a cargar
}


//canvas siempre dibuja despues de nuestra ultima capa nunca atras  
//entonces si no se dibuja es por que cargo las imagenes y despues el mapa y el mapa cubrio todo 

var vaca = new Image();		//aqui pusimos otra imagen 
vaca.src = "vaca.png";
vaca.addEventListener("load", dibujarVacas);
function dibujarVacas() {
	papel.drawImage(vaca, 10, 10);
}


var vaca = {		//estamos dandole a una variable que sea como un objeto
					//le estamos diciendo que la variable vaca tendra esas dos mas, ejemplo    vaca.cargarOK   aqui le estamos diciendo que cambie o lo que le pongamos al cargar que esta adentro de vaca
					//se llama definicion de json
	url: "vaca.png", 	//json se separa con coma por que es solo una linea de codigo
	cargarOK: false
}

//aqui pondre un ejemplo

var s = document.getElementById("boa");
var papel = s.getContext("2d");

var vaca = {
	url: "vaca.png",
	cargarOK: false		
}

var fondo = {
	url: "tile.png",
	cargarOK: false			//le estamos diciendo que esto comenzara en falso 
}

//para acceder a ulr o a otro tambien se puede hacer con corchetes no solo con punto
fonto["url"];	//de esta manera
fondo.name = "Sebastian";	//tambien aunque no tengan la propiedad name se crea al hacer esto
delete fondo.name;		//y asi se borra la proppiedad
Object.freeze(fondo);	//asi congelamos un objeto para que no cambies los valores y no le puedan agregar mas propiedades

var cantidad = aleatorio(5, 15);	//declaramos que cantidad sera un numero aleatorio entre 5 y 15

fondo.imagen = new Image();
fondo.imagen.src = fondo.url;
fondo.imagen.addEventListener("load", cargarFondo);

vaca.objeto = new Image();
vaca.objeto.src = vaca.url;
vaca.objeto.addEventListener("load", cargarVacas);

function cargarFondo() {
	fondo.cargarOK = true;		//aqui le decimos que es verdadero	
								//solo le cambiamos el valor o algo asi
								//aqui le decimos hasta que cargue el fondo que dibuje la imagen la funcion que esta abajo
								//recordar que las funciones no importan donde esten siempre se leen al comienzo y se guardan en la nube entonces las podemos invocar cuado queramos
	dibujar();
}

function buscarElementosQuimicoss(simbolo) {
	let simbolosQuimicos = {			//esto normalmente se haria con un case pero mas rapido podria ser con un objeto donde ya tiene todos los elementos y solo lo buscamos por su simbolo
		"Al" : "Aluminio",
		"S" : "Azufre",
		"Cl" : "Cloro"
	}
	simbolosQuimicos.hasOwnProperty("H");	//esto revisa si existe la propiedad
	return simbolosQuimicos[simbolo];		//se usa corchetes cuando usamos una variable para buscar
}


function cargarVacas() {
	vaca.cargarOK = true;
	dibujar();
}

function dibujar() {
	if (fondo.cargarOK == true) {				//aqui podemos quitar el true por que if solo le importa si es verdadero para ejecutar lo que esta adentro de las llaves
		papel.drawImage(fondo.imagen, 0, 0);	//aqui drawImage espera la variable tipo imagen o la nueva imagen pero esa no esta en la url esta en la variable fondo.imagen6232
	}											//aqui solo una funcion dibujar pero hacemos esto para dibujar primero el fondo y que las vacas que son mas pequenas no salgan atras del mapa, por eso cuando ya cargo el mapa se dibuja y cuando ya cargo la vaca se dibuja otra vez el mapa primero que la vaca
	if (fondo.cargarOK) {
		for (var v = 0; v < cantidad; v++) {	//aqui le ponemos el numero hasta que se repetira pero con cantidad que es un numero aleatorio que senalamos anterior
												//esto es para cargar una vaca aleatoriamente pero antes se hace la funcion para aleatorio y la funcion de cargar la imagen 
		var x = aleatorio(0, 420);		//aqui solo le ponemos esos dos numero aleatorios a esa variable y ya la cambiamos en el papel donde la vayamos a pintar 
		var y = aleatorio(0, 420);
		papel.drawImage(vaca.objeto, x, y);
		}
	}				//explicare que hice aqui primero se guardan todas las funciones despues se van ejecuntando una a una con el addeventlistener le decimos que cargue la funcion cargar fondo en esa cargar fondo le cambiamos a que sea la variables de cargarOK sea true ya cuando es true el decimos que dibuje la funcion dibujar y en esa funcion le preguntamos si ya cargo para dibujar y si ya cargo ya dibuja donde nosotros queramos
}

if (fondo.cargarOK) {
		for (var v = 0; v < cantidad; v++) {	
		var x = aleatorio(0, 5);		
		var y = aleatorio(0, 5);
		x = x * 80;				//veamos un numero aleatorio entre 0 y 5 multiplicado 80 nos dara menos de 500 el tamano de nuestro canvas pero lo ponemos asi para que tengan un espacio entre cada uno como en cajitas
		y = y * 80;				//tambien funciona con numero entre 0 y 7 multiplicado 60 solo hacer las multiplicaciones y que de menos de 500
		papel.drawImage(vaca.objeto, x, y);
		}
	}	


//aqui termina el ejemplo


//el modulo sirve para saber cuando hay residuo o subra numeros en una divicion ejemplo 3 / 2 sobra un 1 ese uno no lo obtiene mod cuando el numero no es divisible


for (var i = 1; i <= 100; i++) {
	var divisible = false;		//recordar que podemos darle una variable que sea falso y verdadero

	if (i % 3 == 0) {			//el modulo se hace con eso de "%" si i es divisible dentro de 3 y de igual a 0
		document.write("fizz");
		divisible = true;
	}

	if (i % 5 == 0) {
		document.write("buzz");
		divisible = true;
	}

	if (!divisible) {			//con el signo "!" decimos si no es verdadero o si no es eso
		document.write(i);
	}
	document.write("<br>");		//recordar que podemos poner etiquetas de html en js pero en comillas

	if (i % 3 != 0 && i % 5 != 0) {		//veamos aqui estamos diciendo que si i dividido 3 no da 0 y (las dos "&&" son como conectores logicos el y ) y si i dividido 5 no da residuo 0 hacer la accion

	}
}

// "!=" quiere decir si eso diferente a lo que estamos comparando

	if (esDivisible(i,3)) {			//y solo la colocamos
		document.write("fizz");
		divisible = true;
	}

function esDivisible (num, divisor) {		//aqui solo creamos una clase que nos ahorra estar comparando del divisor
	if (num % divisor == 0) {
		return true;		//cuando una funcion llega a return ya se acaba la funcion ya no se ejecuta mas
	}
	else {
		return false;
	}
}

//ahora vamos a ver clases

var iss = new Image();		//hay funciones que se disparan al momento que yo hago una nueva imagen en este caso eso pasa gracias a las clases pero antes tenemos que construir eso

class Pakiman {
	constructor(nombre, vida, ataque) {		//asi es como construimos una funcion se podria decir 
								//aqui ya definimos el primer parametro que es el nombre 
		tipo = "tierra";	//si queremos agregar variables tiene que ir adentro del constructor pero si solo las agregamos asi estara mal
		this.tipo = "tierra";	//es un indicador de la instancia de donde estoy o instancia de la clase 
								//asi es la forma correcta de crear una variable se podria decir
		this.nombre = nombre;	//y lo guardamos en la variable nombre pero con this
								//this se refiere a las variables dentro de la clase solo a ellas
		this.vida = vida;		//aqui solo creamos mas variables y recordar que es con this 
		this.ataque = ataque;	//decimos que el ataque que definimos afuera con el new Pakiman sera la variable ataque aqui adentro
								//las variables las podemos nombrar como queramos aunque no pueden llevar el mismo nombre aqui las puse para entender aunque no hay problema por el this

		hablar(); {		//dentro de las clases no se tiene que escribir function por que se entiende que todo lo que esta adentro de una es una funcion
			alert(this.nombre);		//al invocar la funcion (cualquiera de las que tenemos abajo) sss.hablar deberia de mostrar el alert
			//recordar que para llamar una funcion se hace asi sss.hablar();	con el parentesis
		}
		mostrar(); {
		document.write("<p>");
		document.body.appendChild(this.imagen);		//lo que estoy haciendo aqui es agregar una funcion a html o una etiqueta se podria decir
													//esto es un poco complicado todavia no lo entiendo muy bien pero agregamos una etiqueta en el boddy de html
		document.write("<strong>" + this.nombre + "</strong>" + "<br>");	//y comenzamos a poner los datos
		document.write("Tipo: " + this.tipo + "<br>");
		document.write("Vida: " + this.vida + "<br>");
		document.write("Ataque: " + this.ataque + "<br>");
		document.write("</p>");
		}
	}
}
var sss = new Pakiman("cerdiss", 300, 30);	//aqui creamos una nueva instancia en la variable sss entonces llamamos lo que este construido en la clase
											//aqui ya le definimos el primer parametro que era el nombre :3
var pollo = new Pakiman("pollo", 200, 22);	//y asi podemos definir tantas clases como queramos mientras llenen esos espacios

//algo extra pero el this tambien funciona con funciones pero quiere decir las variables que estan adentro pero si hay variables con el mismo nombre que hay afuera las que estan adentro de la funcion si se le coloca this
console.log(sss, pollo);	//algo extra es que en el console.log tambien se puede separar por comas cada variable o lo que queramos ver

sss.hablar();	//aqui nos tirara el alert con el nombre 
				//y asi funcionan las funciones en las clases


//existen arrays o algo asi que son variables con mas cajitas
var cajitas = [];	//asi cramos un array o cajita en blanco
					//la forma estandar de llamar estas es sub 		cajitas sub 0 cajita sub 1 y asi
cajitas[0] = "hola";	//asi les puedo dar valores a la variable pero con cajitas diferentes
cajitas[1] = "me gusta";
cajitas[2] = "boa";
cajitas["nombre"] = "Boa Hancock";	//no solo puede ser con numeros tambien con texto
									//despues si llamamos esta caja aparecera boa y la llamamos con comillas por que asi la declare pero no es obligatorio
									//esta no aparecera si llamamos a solas las cajitas si no hay que llamarla especificamente 
//entonces ahorita si hago un console.log a cajitas me aparecera el nombre y las llaves con cada uno de lo que defini
numerosss = cajitas.length; //con este .length nos deja saber la cantidad de posiciones que tiene el array
cajitas.push("tambien a hinata");	//este push sirve para agregar un nuevo valor pero este se pone hasta de ultimo
									//recordar que si no tiene ningun valor solo comienza a agregar desde 0 despues 1... `
cajitas.pop();	//esto elimina el ultimo elemento del array
let cajita = cajitas.pop();		//tambien puede devolver el elemento que elimino
cajitas.shift();		//esto tambien elimina pero el primer elemento
cajitas.unshift("nuevo valor");		//y este es para agregar uno al principio del array				

var imagenes = [];
imagenes["cerdis"] = "cerdo.png";	//un ejemplo aqui definimos a cada uno tuviera su imagen entonces pusimos sus url en diferentes cajitas
//aunque esto es igual que hacer una variable con mas valores por dentro es igual


//ejemplo
var imagenes = [];
imagenes["vaquitor"] = "vaca.png";
class Pakiman {
	constructor(n, v, a, t) {
		this.imagen = new Imag();
		this.nombre = n;

		this.imagen.src = imagenes[this.nombre];	//explicare que pasa aqui, this.imagen es un nueva imagen aqui en this.imagen.src ponemos la url y la url esta en imagen["vaquitor"] entonces por eso ponemos imagen[this.nombre] por que en esa variable esta el nombre del personaje eso quiere decir que tambien en el nombre esta su url
	}
}
var vaquitor = new Pakiman("vaquitor", 500, 30, "espiritu");

var colecion = [];			//aqui agregamos mi coleccion de pakimanes 
colecion.push(cer);			//recordar que el push agrega uno al ultimo ya si no tiene pues este agrega
colecion.push( new Pakiman("vaquitor", 500, 30, "espiritu") );		//aqui pusimos las variables que tienen adentro el new pakiman pero podemos poner aqui mismo la clase
colecion.push(vaquitor);	//como el mismo vaquitor podemos ponerlo de una vez 


for (var s in colecion) {		//este es un ciclo especial para las colecciones solo se repite las veces que tenga la coleccion 
	console.log(coleccion[s]);
}

for (var s of colecion) {		//la verdad no se si funciona el of pero es una opcion que nos muetra de una vez lo que tiene adentro cada coleccion el in lo que nos muestra son el indice el 0 1 2 y hasta cuantas tengamos
								//efectivamente el in es para ver el indice y el of es para ver el obejeto que contiene
}								

//3
//algo importante podemos hacer las clases en diferentes archivos de js bien podemos mandar toda la clase a otro archivo que si seguira funcioonando pero pero tenemos que podener el archivo en el html


//cuando un objeto tiene multipliples valores es mejor crear una clase 

//parseInt se usa para convertir algo a numero entero y Math.floor y Math.ceil estos ya esperan un numero para editar 

// en js cuando ya todo el documento termina de cargar ocurre un evento que se llama onLoud e indica que al pagina ya cargo y internamente se cierra "close"
//por eso cuando volvemos a llamar el document.write despues de la carga del documento se genera un evento open solo se le da priorida en lo que colocamos en el evento document.write

//document.write es una mala practica


resultado.innerHTML = "soy un cajero probre no tengo dinero :(";	//innerHTML no es una funcion entonces no lleva parentesis es una propiedad o variable por eso le damos igual como si le estuvieramos asignando algo
//este innerHTML se puede usar para cambiar texto del html por que con eso podemos llamar primero a un elemento de html y despues con el inner podemos preguntarle que tiene adentro como que es algo para saber que tiene adentro la etiqueta asi mismo lo modemos cambiar

//4
var resultado = document.getElementById("resultado");	//resultado es el div que tenemos en hmtl entonces lo llamamos con getele..
if (dinero > 0) {
		resultado.innerHTML = "soy un cajero probre no tengo dinero :(";	//aqui es donde usamos el resultado que es el div que tiene y le agregamos el innerHTML entonces le decimos que al div le agregamos eso que en este caso es texto
	}
	else {
		for(var e of entregado) {
			resultado.innerHTML = resultado.innerHTML + e.cantidad + " billetes de $ " + e.valor + "<br>";
			resultado.innerHTML += e.cantidad + " billetes de $ " + e.valor + "<br>";	//este truco es para decir que la cantidad mas la misma cantidad es igual a lo siguiete
			dinero = dinero - (bi.valor * papeles);
			dinero -= (bi.valor * papeles);	//tambien se puede hacer con el signo menos
		}
	}




//hay dos mundos en los que vive el programador
//el backend y fronted
//las bases de datos mas conocidas son: mySQL y mongoDB
//es el backend el que se conecta a las bases de datos los lenguajes mas conocidos son: node JS es una forma de programar js del lado del servidor
//en el lado del servidor tiene que haber algo que procese python hp y asi muchas cosas, al final del dia el servidor es un software que agarra la url que colocas y te ensena eso
//los servidores de htpp es el puerto 80 pero se puede editar y es importante
//el fronted puede ser como html css y js que son lo que mira el comerciante o algo asi
//se le llama stck cuando hay un grupo de tecnologias
//hay muchos metodos para conectarme de html y js al backend estos son 4: GET, POST, AJAX Y Sockets
//GET es poner en la url como variables ponen un signo de interrogacion y ponen las variables como autos=ferrari&marca=ferrari jasja algo asi
//POST es enviar variables como formularios a traves de cambiar la url pero no colocar los datos en la url como en GET que coloca si no colocar los datos por debajo (heders http) algo asi 
//pero hay casos que cambian cosas pero sin cambiar la url este se llama AJAX si en una contrasena si es la correcta de una vez te la muestra sin cambiar la url

//los sockets son para intercambiar datos en tiempo real un ejemplo es en los juegos en linea 

//127.0.0.1 	esto no lo entendi muy bien pero este ruta o algo asi quiere decir tu ordenador eso significa que es el tuyo
//127.0.0.1:8080 	este es un puerto que casi nunca se usa para poder conectar nuetro propio servidor local

//instalamos nodejs y lo corremos en ejecutador y para enetrar solo ponemos node
//para salir de nodejs solo oprimes ctrl + c dos veces 

//el signp de dolar funciona como indicador que es una termial 
//ahorita instalaremos express la libreria que usaremos para crear aplicaciones se instala en ejecutador y la podemos buscar en la pagina "npm"
//aqui instale la libreria global usando " -g" al final del codigo de isntalacion pero no es recomendable es mejor instalarla de manera local

var express = require("express");	//tenemos que crear una variable que almacene la libreria
									//require es una opcion que no existe por defecto en el js del fronted pero si en el js backend que se usa con el nodejs
									//y require busca las librerias que estan instaladas en la compu y las guarda en esta variable
var app = express();	//significa que vamos a crear una aplicacion con la instancia express es como invocar una funcion 
						//este expres de la funcion es el mismo express de arriba es como que en esa variable este toda la libreria y despues le digamos que la app tiene esa libreria
						//traigo a toda la libreria con require y despues lo metemos a una variable de nostros 
app.get("/", inicio);		//como ya sabemos el get es la url, una diagonal quiere decir home el principio entonces depues decimos que se ejecutara y aqui dijimos que se ejecutara la funcion inicio 
app.get("/cursos", cursos);		//como esta puedo crear mas url pero tengo que crear la funcion
							//aqui estamos hablando de la url un ejemplo es como en platzi cuando ponen platzi/js.com o algo asi despues de ese diagonal se crea el js y eso es lo que se ejecuta 
function inicio(req, res) {		//con esto estamos listos para programar lo que saldra en esta funcion 
								//req es como peticion lo que el navegador esta pidiendo al servidor que es nodejs y res es el resultado lo que le servidor le quiere mandar al navegador
	resultado.send("este es el incio y me gusta boa");		//este send es como el document.write
															//aqui adentro puedo colocar todo el css html y asi puedo colocar lo que quiera
} 
app.listen(8989); 	//y ya por ultimo ponemos a correr el servidor corre en un puerto especifico y usa el metodo listen

//para abrir esto en el ejecutador ya cuando este en la carpeta donde esta  documento ponemos "node " y el nombre del archivo js
//como dije es una mala practica instalar la libreria de manera global asi que la instalamos en la carperta que este con el archivo
//despues instalar la libreria y abrir el archivo nos vamos a los numeros que significan que es nuesto ordenador el 127... y ponemos el pueto que pusimos en el codigo (esto es en chrome)

//ya si queremos que un amigo en la misma red ingrese solo le decimos que ponga nuestra red local y el puerto que en este caso es 8686

//en la programacion normal mente se trabaja por milisegundos y un segundo son 1000 milisegundos

var jf = require("johnny-five");		//asi se traen librerias en js 
circuito.on("ready", prender);	//como se prende un circuito en js pero para esto necesitas muchas cosas solo lo pongo por la sintaxis
//mas informacion en la carpeta de arduino 

function ondear() {
	setTimeout(ondear, 1000);	//esta funcion hace que se ejecute una funcion cada cierto tiempo ahorita se ejecutara cada segundo
}

//en js el 0 es false y cualquier otro numero es true cualquier numero que no sea 0 es true

//tablas de verdad
//y				= and		= &&	= *
//o				= or		= ||	= +
//no			= not		= !		= ~				//es negar si es 1 se vuelve 0 y si es 0 se vuelve 1
//o exclusiva	= xor		= ^		= (+)			//solo es 1 si uno es verdadaro y el otro es falso 

try {		//no estoy muy seguro pero este funciona asi, se ejecuta un pedaso de codigo o el codigo y si da error pasa al catch entonces si da error hace la accion que este en el catch
	nonExistentFunction();
  } 
catch (error) {
	console.error(error);
	// expected output: ReferenceError: nonExistentFunction is not defined
	// Note - error messages will vary depending on browser
  }
 //5
 let inputsawa = document.getElementById("sawa").checked	//con esto podemos saber si el input esta seleccionado o no 
 if (inputsawa.checked) 	//tambien se puede asi pero le quitariamos antes el checked
 if (inputsawa == true) {
	alert("me gustas mucho")
 }

 let one = document.createElement("p")	//aqui estamos creando un p en el html
 one.innerHTML = "me gusta yamato"	//y esto como ya sabemos modifica el contenido del aetiqueta 

//este solo es un ejemplo pero para que entendamos
 let sectionMensajes = document.getElementById("mensajes")		//aqui llamamos donde queremos escribir o poner lo que creamos aqui con createElement

    let parrafo = document.createElement("p")   //esto es para crear un elemento en html
    parrafo.innerHTML = "Tu mascota ataco con " + ataqueJugador + ", la mascota del enemigo ataco con " + ataqueEnemi + "  🎉"
 //le decimos que el parrafo que creamos tenga escrito esto 
    sectionMensajes.appendChild(parrafo)	//y aqui le decimos que con appendChild entre a esa seccion que tenemos en js y cree lo que creamos que en este ejemplo es un parrafo


	location.reload() //nos dice en que localizacion estamos se puede decir donde esta la url o algo asi
	//el .reload es una funcion de esta location donde lo que hace es recargar la pagina

	let botonFuego = document.getElementById("boton-fuego")
    botonFuego.disabled = true		//esta es una forma de desactivar un boton o lo que queramos del html o lo que se pueda mas detalles en el ejemplo de mokepon

	let esconderSect = document.getElementById("selec-ataque") //aqui estamos llamando una seccion completa 
    esconderSect.style.display = "none" //aqui a la seccion le cambiamos el estilo se podria decir asi con el display none lo ocultamos


let imagenDeCharmander = new Image()	//asi es como puedo crear una nueva imagen 
imagenDeCharmander.src = "../imagenes/pngwing.com (2).png" //aqui le doy su src
lienzo.drawImage(		//aqui cree un canvas y el lienzo es donde le dije que es 2d
 						//esta drawImage es para cargar una imagen se podria decir primero le pase el parametro de la imagen
	imagenDeCharmander,
	20, //direccion x
	40, //direccion y
	100, //ancho
	100, //alto
)


//funciones para mover pero antes necesitamos un par de cosas podes ir a ver al archivo
function pintarPersonaje() {
    lienzo.clearRect(0, 0, mapa.width, mapa.height) //esto es para limpiar el canvas entonces le damos de donde queremos limpiar y hasta donde tiene que llegar
    lienzo.drawImage(
        charmander.mapaFoto,
        charmander.x, //direccion x
        charmander.y, //direccion y
        charmander.ancho, //ancho
        charmander.alto, //alto
    )
}
function moverDerecha() {
    charmander.x += +5  //aqui solo le decimos que de posicion x avance 5 mas 
    pintarPersonaje()
}
function moverIzquierda() {
    charmander.x += -5
    pintarPersonaje()
}
function moverAbajo() {
    charmander.y += +5
    pintarPersonaje()
}
function moverArriba() {
    charmander.y += -5
    pintarPersonaje()
}


function sePrecionoUnaTecla(event) {
    console.log(event.key)  //este event.key nos dice que tecla se esta ejecutando pero creo que es importante la funcion de arriba
    switch (event.key) {
        case "ArrowUp": //aqui le decimos si precionan esa tecla que haga esa funcion que en este caso es mover hacia arriba
            moverArriba()
            break       //este brake es importante para cuando entra en alguno ahi termine no siga leyendo las demas lineas de codigo
        case "ArrowDown":
            moverAbajo()
            break
        case "ArrowRight":
            moverDerecha()
            break
        case "ArrowLeft":
            moverIzquierda()
            break
        default:
            break
    }
}
lienzo.drawImage(
	mokeMapa,   //aqui le decimos que imagen tendra
	0,  // en donde comenzara  x
	0, // donde comenzra  y
	mapa.width, //donde terminara x
	mapa.height //donde terminara y
)



if (mascotaJugadorObejeto.velocidadx !== 0 || mascotaJugadorObejeto.velocidady !== 0) {
		//este !== es decir si es diferente a 0 diferenteeee
    }

	window.innerWidth - 20 //window.innerWidth es una herramienta que nos dice cual es el ancho de la pantalla

	clearInterval() //esto detiene el intervalo de lo que hayamos puesto 


	(8080, () => {
		console.log("")
	}) //cuando tenemos una un lugar que tengamos que poner una funcion asi lo podemos hacer sin tener que crear una funcion antes





	//.querySelector('[for="888"]')			esto es como cuando traemos algo con getElementById pero aqui con un query cuando ponemos corchetes es por que es un atributo el que buscamos 

// mira tenemsos comillas simples y comillas dobles es por que no me deja poner dos veces la misma comilla tembien se puede hacer 
// ""/ y copiar asi "/"			no se si era asi o al reves los eslash




// json
const juegos = {
    nombre: "Genshin Impact",
    compañia: "HoYoverse"
}
console.log(JSON.stringify(juegos));         //esto convierte el objeto a formato json
console.log(JSON.parse(juegos));        //con esto es convertirlo de formato json a formato html


class Car {		//esta es una clase 
	constructor(name) {		// y por obligatorio necesita llevar su constructor no es como en otros lenguajes que crea el constructor por defecto
							//puede llevar parametros tambien el constructor
		this.id = 			//la palabra this solo dice que es de esa clase esa variable
		this.name = name
	}
}

class Car2 extends Car {		//asi podemos crear la herencia en javaScript
	constructor(name, lincese) {	//como siempre creamos un constructor que tenga los mismos parametros que el padre y si queremos le podemos agregar mas 
		super(name)		//asi le enviamos lo que queremos enviar a los parametros que estan en la clase padre
		this.lincese = lincese;
	}
}

//recordar que si usamos muchoos archivos debemos de llamarlos a todos en el html y el orden importa mucho

let car = new Car("Sebastian") //y asi se crea un nuevo objeto de la clase car

//arrays dentro de otros arrays
let arrays = [[1,2,3], [5,6,7], [8,7,1]];
arrays[1][2]	//asi llego al 6 primero le el primer arreglo y despues el que esta adentro de el 

console.log(JSON.stringify(arrays));	//esta es una forma de mostrar en consola el array 

//igualdad estricta
console.log(1 == 1);
console.log(1 == '1');	//estas dos nos dara que es verdadero
//pero si queremos comparar tambien el tipo de dato es con igualdad estricta
console.log(1 === 1);	 //esto dara true
console.log(1 === '1');		//pero esto no
//tambien funciona con el de desigualdad
console.log(1 != '1');	//esto es false
console.log(1 !== '1');	//esto es true


//operador condicional ternario
function retornarMin(x, y) {
	return x < y ? x : y;	//el signo pregunta nos ayuda a decir si eso es verdadero hara la primera opcion y si es falso hara la segunda opcion despues de los dos puntos
	//tambien se pueden hacer anidados es como un if asi que tambien se puede poner otra condicion despues de los puntos
	return x < y ? x : y > x ? y : x	//algo asi o como se necesite
}

//por que var y let
var palabra = "hola";
var palabra = "adios";
//esto no tira error simplimenete reescribe el valor 
let a = 1;
let a = 2;
//esto tira error no deja reescribir de esta manera

//tambien afuera del ciclo for se puede usar la variable definida por var
//pero con let solo adentro del ciclo
//con let solo se puede usar en el bloque de codigo que definimos
//y var si deja usarla fuera del bloque de codigo

//var crea una variable que se puede usar en el ambito global y let restringe esa variable al bloque de codigo donde fue definida



//funciones flechaa
//normalmente se usan cuando defines funciones que no tienen algun nombre en especifico4
const fecha = function(){	//esta funcion no tiene nombre
	return new Date();
}
const fecha2 = () => new Date();	//asi se puede hacer una funcion flecha solo se pone los parametros y despues lo que retornara
//asi se hace normalmente cuando solo tienen una linea se le quita las llaves
const suma = (a, b) => {		//y se dejan las llaves cuando tienen mas de una linea
	let num = 4;
	return a + b + num;
};

//se le puede poner un valor por defecto por si en las funciones no le puso ese valor tambien funciona para los otro tipos de funciones
const incrementar = (num, valor = 1) => num + valor;	//en este caso si no ingresan el parametro valor se asignara 1 como digo funciona para todo los tipos de funciones con parametros

function miFuncion(...args) {	//la palabra args solo es una variable los tres puntos nos ayudan a lo siguiente
	console.log(args);
	args.reduce();	//este reduce lo que hace es sumar los datos del arrays y devuelve el resultado
}
miFuncion(1,2,3,4);	//para poder agregarle todos los argumentos que queramos pero esto nos devuelve en array los argumentos para eso son los 3 puntos


const numeros = [1, 2, 3];
function suma(x, y, z) {
	return x + y + z;
}

suma(...numeros);	//lo que hacen los tres puntos es descomponer el arreglo entonces lo descompone con el valor 1 valor 2 y valor 3 y asi se le puede dar a la funcion por separado

//sintaxis de desestructuracion
const usuario = {
	nombre : "Sebastian",
	edad : 16
};
var nombre = usario.nombre;	//asi normalmente se daria valores pero hay una manera mas facil
var edad = usuario.edad;

const {nombre, edad} = usuario;	//lo que le estoy diciendo en las llaves son los nombre de las propiedades y despues en el objeto que vaya a buscar
//pero esto crea las variables o constantes con el mismo nombre de las propiedades por que aqui crea una constante con el nombre y le da el valor del objeto con la propiedad con el mismo nombre


//obejtos anidados
const usuarios = {
	sebastian : {
		edad : 16,
		waifu : "Hinata"
	}
};

var {sebastian : {edad, waifu}} = usuarios;	//asi puedo hacerlo cuando estan anidados y tengo que buscar una mas abajo de esto y como decia le da el valor a esas variables que crea
//ya si les queremos dar nombres distintos a las variables se hace de la siguiente manera
var {sebastian : {edad: edadSebastian, waifu: waifuSebastian}} = usuarios;
//para poner las propiedades no tienen que tener un nombre solamente se va guiando por el nombre de la propiedad que ponemos


//con arreglos 
// se le puede dar valores a mas variables de la siguiente manera
var numero1, numero2;
[numero1, numero2] = [1, 3];
//y asi se le pueden dar valor es a mas de una varible pero hay que seguir el orden 
[numero1,,, numero2] = [1, 2, 3, 4, 5, 6];	//aqui le estoy diciendo con las comas que se salte dos valores entonces el valor que se le da al numero2 es 4

//otro ejemplo
var a, b, arr;
[a, b, ...arr] = [1, 2, 3, 4, 5, 6];	//los tres puntos como agrupa y los vuelve un arreglo entonces a la variable arr se le da todo ese arreglo en este caso todo los numeros que sobraban

//pasar objeto como argumento
var nuevoPerfil = {
	nombre: "Hinata",
	edad: 16,
	clan: "Hyuga"
}
const actualizarPerfil = ({nombre, edad, clan}) => {
	console.log(nombre, edad, clan);	
}
actualizarPerfil(nuevoPerfil);		//lo que hicimos aqui fue que le pasamos como argumento un objeto y lo desestructurizamos en los parametros de la funcion y asi creamos variable con los mismos nombres
//entonces buscas que propiedades quieres y las pones en los argumentos de la funcion y ya solo le pasarias el obejeto


//cracion de objetos mamalones jajaja
const crearWaifu = (nombre, anime) => {
	return {
		nombre: nombre,	//el segundo nombre simplemente es el argumento de la funcion y el primer es la propiedda del objeto
		anime: anime
	};
};
crearWaifu("Hinata", "Naruto");		//y asi creariamos un objeto facil con una funcion

//aunque hay una forma de hacerlo mas pequeño
const crearWaifu2 = (nombre, anime) => ({nombre, anime});		//con las llaves le estamos diciendo que retorne un obejto con la propiedad y el argumento del mismo orden

//metodos en js
//si el valor de una propiedad es una funcion se le denomina metodo 
const waifu12 = {
	nombre: "Hinata",
	presentarse() {		//asi podemos creaer metodos que son como funciones pero como propiedades
		return `Hola este es mi nombre ${this.nombre}`
	}		//cuando ponemos this nos referimos al obejeto en el que estamos entonces aqui se muestra el nombre de este obejto 
};

class Libro {
	constructor(autor) {
		this._autor = autor;	//con el guion  bajo es como una tipo regla para decir que el nombre no tiene que cambiar
	}
	//aqui como le cambiamos el nombre a autor para devolverlo se hace un get
	get autor() {	//le decimos que cuando escriban libro.autor aparezca este autor
		return this._autor;
	}
	set autor(nuevoAutor) {		//y este deja que lo acutualicemos como libro.autor = "hinata" ya deja que hagamos esto
		this._autor = nuevoAutor;
	}
}