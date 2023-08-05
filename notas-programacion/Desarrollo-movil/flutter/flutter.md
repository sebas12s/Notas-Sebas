# Flutter 
## Creacion
Ctrl + shift + p -> Flutter: new proyect -> application 

la segunda opcion no tiene comentarios que ayudan al desarrollo

## Terminos 
* Screen: en desarrollo web si tenemos algo que cubre toda la pantalla se la llama pagina pero en movil se le llama screen

## Carpetas
* .dart_tool: paquetes y configuraciones de dar
* .idea: para otro editor de codigo
* Android: codigo para android, si queremos una configuracion y trabajaremos en android ahi iremos
* ios: lo mismo 
* lib: todo el codigo fuente personalizado por nosotros
    * presentation o src: aqui ira todos nuestro witgets todo lo visual que hemos creado
        * screens: las pantallas 
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

## file sistems
Flutter acepta muchos

## Widgets
Son como los componentes de React pero se llaman widgets aqui

Un widget es cualquier cosa que sea un "Stateless Widget" son como las piezas de lego que se generar muy rapido, este no mantiene su estado por si mismo

Todos los widgets se crean de un Stateless Widget o Stateful Widget

* Stateless Widget: Es una pieza de lego que se construye muy rápido y 
no mantiene el estado por si mismo. Flutter sabe 
cuando se de be de volver a dibujar, es recomendado 
que en lugar de crear funciones y métodos que 
retornan Widget, es mejor crear Clases que extiendan 
de estos StatelesWidgets. 
* Stateful Widget: Es similar al stateless en cuanto a que es un Widget, 
pero este permite mantener un estado interno y ciclo 
de vida como su inicialización y destrucción. Muchos 
lo tachan de que jamás se deben de usar pero eso no 
es cierto, los stateful básicamente son el corazón de 
cualquier animación que suceda.

### Scaffold
Un diseño predeterminado basico 
* Implementa un diseño básico de 
material, y da las bases para colocar un 
menú lateral, snack-bars, appbars, 
bottom sheets y más elementos.

los screens en los archivos llevaran sus scaffold
