# Flutter 
## Creacion
Ctrl + shift + p -> Flutter: new proyect -> application 

la segunda opcion no tiene comentarios que ayudan al desarrollo

## Terminos 
* Screen: en desarrollo web si tenemos algo que cubre toda la pantalla se la llama pagina pero en movil se le llama screen
* Builder: algo que se va a construir en tiempo de ejecucion

## snepets

* importm = material de dart
* stls = un widget StatelessWidget 


## Carpet   
* .dart_tool: paquetes y configuraciones de dar
* .idea: para otro editor de codigo
* Android: codigo para android, si queremos una configuracion y trabajaremos en android ahi iremos
* ios: lo mismo 
* lib: todo el codigo fuente personalizado por nosotros
    * presentation o src: aqui ira todos nuestro witgets todo lo visual que hemos creado, todo lo que el usuario ve
        * screens: las pantallas 
        * widgets: pequeños widgets personalizados
    * config: aqui iran las configuraciones
        * theme: pusimos los temas hasta aqui
* linux: lo mismo 
* macos: lo mismo
* test: para hacer el testing de la app
* web: lo mismo
* windows: lo mismo
* .gitgnore: los archivos que no se envian a git
* .metadata: como explicaciones del archivo
* analysis_options: para cambiar algunas configuraciones
* hello_world: para .idea
* pubspec: para ver versiones del proyecto y de las nuevas
* pubspec.yamal: un espacio hace mucho la diferencia en este lenguaje aqui si vendremos mucho

## Codigo
Nota importante los print no deberian de ir a produccion

ctrl + space = todos los metodos que tienen las clases

Cuando ya miras que hay mucha identacion es mejor separar tu codigo

Cuando no sepamos de que tipo es, vayamos al widget principal ctrl + click y eso nos llevara a la definicion y despues volvemos hacer lo mismo en el argumento que queremos saber

## file sistems
Flutter acepta muchos

## Widgets
Son como los componentes de React pero se llaman widgets aqui

Un widget es cualquier cosa que sea un "Stateless Widget" son como las piezas de lego que se generar muy rapido, este no mantiene su estado por si mismo

Hay widgets que solo resiven un hijo pero hay tambien bastantes que resiven mas de uno

Todos los widgets se crean de un Stateless Widget o Stateful Widget

* Stateless Widget: Es una pieza de lego que se construye muy rápido y 
no mantiene el estado por si mismo. Flutter sabe 
cuando se de be de volver a dibujar, es recomendado 
que en lugar de crear funciones y métodos que 
retornan Widget, es mejor crear Clases que extiendan 
de estos StatelesWidgets. 
* Stateless Widget no puede tener un estado, hay metodos pero no son como de Stateless
 
---

* Stateful Widget: Es similar al stateless en cuanto a que es un Widget, 
pero este permite mantener un estado interno y ciclo 
de vida como su inicialización y destrucción. Muchos 
lo tachan de que jamás se deben de usar pero eso no 
es cierto, los stateful básicamente son el corazón de 
cualquier animación que suceda.
* Estos si permiten que hayan estados cambiar estados y eso, se tiene que tratar de no usar por el peso pero si se pueden usar

### Scaffold
Un diseño predeterminado basico 
* Implementa un diseño básico de 
material, y da las bases para colocar un 
menú lateral, snack-bars, appbars, 
bottom sheets y más elementos.

los screens en los archivos llevaran sus scaffold

## theme 
es como queremos que se vea todo por defecto, color estilo y todo eso