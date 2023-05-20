import './App.css';     //asi podemos importar el archivo de css de nuestra aplicacion para que todo tenga estilo
import React from 'react';  //lo primero que nos encontraremos sera esto para importar react
//en App.js hay una funcion por defecto pero aqui se llama componente entonces el que creamos se debe exportar en otros lados de ser necesario

import '.....';   //para que el estilo se ponga en nuestro archivo debemos de importarlo 

import './App.css';
import { useState } from 'react'; //asi importamos useState un hucks
        
function App() {    
  return (  //aqui creamos un nuevo componente que testimonio y para mostrarlo borramos todo lo que estaba adentro de app en el archivo principal y solo pusimos asi
            //pero recuerda que para poner un componente tienes que importarlo
    <div className="App">
      <Testimonio />    
    </div>
  );    //en react normalmente se trabaja que ciertos componentes redericen a otros componentes como ahora con app esta renderizando a nuestro componente testimonio
}

export default App; //en todos los componentes si los queremos llamar o importar en otros lados tenemos que exportarlos en el mismo archivo
//pero no solo asi se pueden hacer exportacion hay dos formas de hacerlo 
//la otra forma se llama exportacion nombrada
export function App() { } //asi se puede hacer tambien poniendole antes de crear el componente
import { Testimonio } from '.....';   //lo que pasa aqui es que tenemos que decirle que de todas las opciones posibles que se pudieron exportar de este archivo queremos esa en especifico por que para eso es la exportacion nombrada para exportar muchas 


function Testimonio(props) {   //vamos a comenzar a usar props en react se tienen que poner la palabra props
  return(
    <div className='contenedor-testimonio'>
      <img 
        className='imagen-testimonio' 
        src={require(`../img/image-${props.imagen}.jpg`)}     //para agregar una imagen en este caso con js por las llaves necesitamos usar el require
                                                              //aqui usamos algo muy poderoso las comillas invertidas para poder ingresar codigo de js adentro de cadenas de texto asi podemos ingresar el props para cambiar de imagen 
        alt='Foto de izumi'
      />
      <div className='contendero-texto-testimonio'>
        <p className='nombre-testimonio'><strong>{props.nombre}</strong></p>   {/*recuerda que usamos las llaves y asi usando la palabra que definimos arriba props podemos cambiar las propiedades en este caso es el nombre*/}
        <p className='cargo-testimonio'>{props.cargo}</p>   {/*para pasar los props se hacen donde se crea el componente en este caso en app*/}
        <Testimonio 
          nombre=''
          pais=''         //y asi se pueden ir poniendo con el mismo nombre que le dijimos o pusimos con la palabra props
        />
        <p className='texto-testimonio'>Izumi Nase (名瀬 泉 Nase Izumi) is one of the secondary characters of the Kyoukai no Kanata series. She is the head of the Nase Clan as well as the older sister of Mitsuki and Hiroomi Nase. Izumi is a very beautiful young woman with neck-length black hair that is seen let down while it hangs on the right side and purple eyes.</p>
      </div>
    </div>
  );
}

import logo from '../img/logo-onepiece.png';    //asi tambien podemos importar imagenes
<img src={logo} />    //ya se pone como una variable


function Boton({ texto, texto2 }) {   //esto es una manera diferente de hacerlo sin tener que poner la palabra props 
  return(     //normal mente se trabaja con esta sintaxis
    <button>
      {texto}   {/*y ya solo se pone asi*/}
    </button>
  );
}

//operadores ternarios
<button 
      className={esBotonClic ? 'boton-clic' : 'boton-reiniciar'}    /*aqui le estoy diciendo que si es boton clic que ponga la primera clase si no que ponga la segunda
    pero lo que pregunta es si es verdadero haga esto si es falso haga lo segundo*/
      onClick={manejarClic}>    {/*este manejarClic es una funcion que viene como propiedad estas funciones se crean en el componente que esta creando este componente en este caso seria en app*/}
</button>

{/*
<Boton 
          texto='Click'
          esBotonClic={true}          asi le pasamos el parametro 
          manejarClic={manejarClic} /> */}
          

const [numClics, setNumClics] = useState(0);  
//primero es una variable y el segundo es una funcion a todos les agregamos un valor 0 incial
//le damos su valor inicial que en este caso es 0
//la primera es una variable y la segunda es una funcion como dije, 

//otra explicacion es que cuando craemos esto le asignamos un estado al componente en el que estemos y tenemos una funcion para actualizar ese estado

const manejarClic = () => {
  setNumClics(numClics + 1);  //llamamos a la funcion y le sumamos cada vez que haga clic
}

const reiniciarClic = () => {
  setNumClics(0);   //pero aqui no volvi a sobreescribir la variable solo llame la funcion y me dio eso
}


//ya entendi el hook de useStete
//como decia el primer parametro del array es una constante donde almacena un valor y la segunda es la funcion que se usa para cambiar ese valor
//entonces al hacer estas funciones de abajo le decimos que cambie el valor a 0 o le aumente 1


const Boton = ({ children }) => {   //con esta palabra de children podemos poner contenido adentro de las etiquetas tambien

  const esOperador = (valor) => {
    return isNaN(valor) && (valor != '.') && (valor !='=');   //isNaN es una funcion para ver si una cadena de caracteres no es un numero entonces si esto se cumple devuelve true y es verdadero la condicional de abajo
  };

  return (
    <div
      className={`boton-contenedor ${esOperador(children) ? 'operador' : ''}`.trimEnd()}  //aqui le dijimos que si en la funcion es true si operador regresara esa clase si no regresara una cadena de caracteres vacia y con el metodo trim eliminamos espacios de este caso del final
    >
      {children} 
    </div>  //la palabra children no es obligatoria que sea esa pues xd
  );
}
<Boton>1</Boton>    //ya se pone asi






//calculadora 
//componentes
//logo
import React from 'react';

const Logo = ({ logo, alt }) => {
  return(
    <div className='logo-contenedor'>
      <img 
        src={logo}
        className='logo'
        alt={alt}
      />
    </div>
  );
};

export default Logo;

//boton
import React from 'react';
import '../style/Boton.css';

const Boton = ({ children, manejarClic }) => {

  const esOperador = (valor) => {
    return isNaN(valor) && (valor != '.') && (valor !='=');
  };

  return (
    <div
      className={`boton-contenedor ${esOperador(children) ? 'operador' : ''}`.trimEnd()}
      onClick={() => manejarClic(children)}   //el onClilc espera una funcion pero la funcion manejarClic regresa un string asi que le ponemos eso al comienzo, como una funcion anonima que regresa el valor que desde un principio regresaba pero ahora si es una funcion
    >
      {children}
    </div>
  );
};

export default Boton;

//Pantalla
import React from 'react';
import '../style/Pantalla.css';

const Pantalla = ({ input }) => {
  return (
    <div className='input'>
      {input}
    </div>
  );
};  

export default Pantalla;

//botonClear
import React from 'react';
import '../style/BotonClear.css';

const BotonClear = ({ children, manejarClear }) => {
  return (
    <div 
      className='boton-clear' 
      onClick={manejarClear}    //aqui simplemente llamo a la funcion que cree en el componente
    >
        {children}
    </div>
  );
};

export default BotonClear;

//app.js
import './App.css';
import LogoOnePiece from './img/logo-onepiece.png';
import Logo from './components/Logo.jsx';
import Boton from './components/Boton.jsx';
import Pantalla from './components/Pantalla.jsx';
import BotonClear from './components/BotonClear.jsx';
import { useState } from 'react';
import { evaluate } from 'mathjs';    //simplemente asi se llama 

function App() {

  const [input, setInput] = useState('');

  const agregarInput = valor => {   //asi se puede crear tambien una funcion flecha mas facil
    setInput(input + valor)   
  };

  const calcularResultado = () => {
    if (input) {  //una cadena de caracteres si esta vacia sera falsa entonces solo al poner asi estamos evaluando si es verdadero o falso ya que estamos evaluando si hay valores para operar
      setInput(evaluate(input));    //esta funcion evaluate lo conseguimos en una libreria que se llama mathjs entonces la importamos arriba y tambien la tenemos que descargar en la computadora
    //aqui le dije que esta funcion regresara el resultado de la operacion del string de lo que contenga input y esta funcion se llama al darle clic al igual
    } else {
      alert('ingrese valores');
    }
  };

  return (
    <div className='App'>
      <Logo 
        logo={LogoOnePiece}
        alt='logo'
      />
      <div className='contenedor-calculadora'>
        <Pantalla 
          input={input}   //aqui le estoy diciendo que se mostrara el valor actual del estado input que este caso es hinata xd
        />
        <div className='fila'>
          <Boton manejarClic={agregarInput}>1</Boton> {/*aqui le estoy dando como parametro la funcion que tiene arriba, le damos como acceso a la funcion dandola como parametro*/}
          <Boton manejarClic={agregarInput}>2</Boton> {/*le envio la funcion entonces en el componente boton al darle clic llamara esta funcion :0*/}
          <Boton manejarClic={agregarInput}>3</Boton>
          <Boton manejarClic={agregarInput}>+</Boton>
        </div>
        <div className='fila'>
          <Boton manejarClic={agregarInput}>4</Boton>
          <Boton manejarClic={agregarInput}>5</Boton>
          <Boton manejarClic={agregarInput}>6</Boton>
          <Boton manejarClic={agregarInput}>-</Boton>
        </div>
        <div className='fila'>
          <Boton manejarClic={agregarInput}>7</Boton>
          <Boton manejarClic={agregarInput}>8</Boton>
          <Boton manejarClic={agregarInput}>9</Boton>
          <Boton manejarClic={agregarInput}>*</Boton>
        </div>
        <div className='fila'>
          <Boton manejarClic={calcularResultado}>=</Boton>
          <Boton manejarClic={agregarInput}>0</Boton>
          <Boton manejarClic={agregarInput}>.</Boton>
          <Boton manejarClic={agregarInput}>/</Boton>
        </div>
        <div className='fila'>
          <BotonClear manejarClear={() => setInput('')}>Clear</BotonClear>  {/*aqui estoy creando tambien una funcion anonima como lo hice antes ya solo llamo al darle click en el componente*/}
        </div>
      </div>
    </div>
  );
}

export default App;
//aqui esta la explicacion de nuevas funcionalidades



//icons de react
npm install react-icons --save //asi se pueden instalar los icons de react
//busca en la documentacion el icono que quieras buscar
import { AiOutlineCloseCircle } from 'react-icons/ai'; //lo importamos
<AiOutlineCloseCircle />  //y lo ponemos como un componente  
















///algo muy importante
//un componente solo puede generar una etiqueta se podria decir
const Fragmentos = () => {
  return (
    <div></div> //no puede llevar dos div aqui afuera pero react deja hacer esto
    <></> //etiquetas vacias o fragmentos   
  );
}