const express = require("express") //asi llamamos la libreria pero antes la tenemos que instalar
//la importe a mi proyecto
const app = express()
app.listen() //lo minimo es mostrarle donde tiene que estar escuchando las peticiones del cliente


var express = require("express");	//tenemos que crear una variable que almacene la libreria
									//require es una opcion que no existe por defecto en el js del fronted pero si en el js backend que se usa con el nodejs
									//y require busca las librerias que estan instaladas en la compu y las guarda en esta variable
var app2 = express();	//significa que vamos a crear una aplicacion con la instancia express es como invocar una funcion 
						//este expres de la funcion es el mismo express de arriba es como que en esa variable este toda la libreria y despues le digamos que la app tiene esa libreria
						//traigo a toda la libreria con require y despues lo metemos a una variable de nostros 
app2.get("/", inicio);		//como ya sabemos el get es la url, una diagonal quiere decir home el principio entonces depues decimos que se ejecutara y aqui dijimos que se ejecutara la funcion inicio 
app2.get("/cursos", cursos);		//como esta puedo crear mas url pero tengo que crear la funcion
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
