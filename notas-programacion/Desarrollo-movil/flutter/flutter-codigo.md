# Codigo de flutter

## Hola mundo  
* lib/main.dart 
```dart
mport 'package:flutter/material.dart'; //ctrl + . veremos todo lo que se imoporto

void main() {
  runApp(
      const MyApp()); //toda app de flutter en su main tiene una ejecucion de un widget principal, runApp espera resivir un widget
      //aqui tambien se pone const 
}

class MyApp extends StatelessWidget {
  //'StatelessWidgets ya esta en material.dart'
  const MyApp({super.key});   //este constructor ayuda para ponerle un key ya que con eso podemos identificar nuestros widgets

  @override
  Widget build(Object context) {
    return const MaterialApp(   //como es un ejemplo con informacion estatica, no cambiara se pone const
    //nos ayuda para que cuando flutter tenga que volver a construir esta pieza ya este toda construida y que no cambiara
      debugShowCheckedModeBanner: false,    //esto nos quita la marca de 'debug' que aparece arriba de la aplicacion
      home: Scaffold(   //este da una interface predefinida algo simple
        body: Center(child: Text('Me gusta mi novia')),
      ) //este Texto tambien es un widget, Center es otro widget que centra lo que tenga su hijo
    );
  }
}
```

lib/presentation/screens/counter_screen.dart

MaterialApp puede cambiar muchas veces con la imagen entonces hacemos diferentes archivos por las pantallas
```dart         
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Me gusta mi novia de nuevo')),
    );
  }
}
```
Y ya solo lo llamamos 

lib/main.dart
```dart
Widget build(Object context) {
    return const MaterialApp(   
      debugShowCheckedModeBanner: false,
      home: CounterScreen()     //recuerda importar
    );
  }
```



## Counter app

lib/main.dart
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(   
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(   //esto es el tema resive un ThemeData 
        useMaterial3: true,  //le decimos que el estilo de material3 estara activado
        colorSchemeSeed: Colors.green  //para cambiar el color del todo el tema o algo asi veo
        //el Color podriamos configurar el color nosotros con rgb o asi, pero si le ponemos colors ya solo ponemos el color y el hara la paleta de colores
      ),
      home: const CounterScreen()   //se recomienda que el children sea el ultimo argumento que se resiva porque igual todos son por nombre
    );
  }
}
```


lib/presentation/screens/counter_screen.dart
```dart
class CounterScreen extends StatefulWidget {
  //cambiaremos a Statuful Widget para poder usar un estado
  const CounterScreen({super.key}); //esto no cambio

  @override
  State<CounterScreen> createState() =>
      _CounterScreenState(); //este es un nuevo metodo
  //esta es una creacion del estado, y esta invoca la otra clase que nos creo aqui abajo
}

class _CounterScreenState extends State<CounterScreen> {
  int clickCounter =
      0; //antes con stateless no podia hacer esto pero con Stateful si puedo los estados

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //tiene un body
        //le tuve que quitar el const al Scaffold por el floatingActionButton
        appBar: AppBar(
          title: const Center(child: Text('Contador')),
          // leading: IconButton(   //este resive un Widget
          //   //esto pone un icono en el lado izquierdo
          //   icon: const Icon(Icons.refresh_rounded),
          //   onPressed: () {
          //     //al presionar
          //     setState(() {   //recargar la pagina
          //       clickCounter = 0;
          //     });
          //   },
          // ),
          //pero si queremos ponerlo al lado derecho es:
          actions: [
            //este es un arreglo de widgets entonces podemos poner muchos botones
            IconButton(
                onPressed: () {
                  setState(() {
                    clickCounter = 0;
                  });
                },
                icon: const Icon(Icons.refresh_rounded)),
          ],
        ),
        body: Center(
          //entonces solamente se lo pose al boddy ya que me lo pedia
          //recordemos que centrara mediante el tamaño del padre
          child: Column(
            //creamos una columna
            mainAxisAlignment: MainAxisAlignment
                .center, //si dejo el cursor arriba dice que espera algo de tipo 'MainAxisAlignment' y ponemos center para que lo centre en la pantalla, como el flexbox
            children: [
              Text(
                clickCounter < 0
                    ? '0'
                    : '$clickCounter', //esto espera un string asi que lo puse asi o puede ser .toString
                style:
                    const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
              ),
              //como argumento por nombre se le puede poner el style, dentro del TextStyle se le pueden poner las propiedades, tamaño de letra y el grosor
              //con fontWight si dejamos el cursor arriba nos dice que espera algo de tipo FontWeight por eso ponemos eso
              Text(
                clickCounter == 1 ? 'Click' : 'Clicks',
                style: const TextStyle(fontSize: 25),
              )
            ], //cada argumento sera un valor de la columna solo una columna
          ),
        ),
        floatingActionButton: Column(
          //lo puse en una columna porque necesito poner mas botones
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              //el Scaffold ya tiene esta opcion de botones que es floatinghActionButton
              // shape: const StadiumBorder(), //este shape es para poner redondo el boton
              onPressed: () {
                //al presionar
                //se le pasa la accion primero
                clickCounter++; //para que aumente en uno
                //pero solo asi no se ve el cambio porque no se a renderizado o actualizado
                setState(
                    () {}); //esto actualiza, y puedo poner la instruccion de arriba adentro de esta funcion o solo dejarlo asi
              },
              child: const Icon(
                  Icons.plus_one), //child resive otro widget, Icon es un widget
            ),
            const SizedBox(   //este es otro elemento de la columna como ven puede ser otro widget, este sirve para poner un espacio o una cajita transparente
              height: 20,
            ),
            FloatingActionButton( //aqui simplemente pusimos el otro boton
                onPressed: () {
                  clickCounter < 0 ? clickCounter = 0 : clickCounter--;   //para que no pase de 0
                  setState(() {});
                },
                child: const Icon(Icons.exposure_minus_1_outlined)),
          ],
        )
      );
  }
}

```

Construccion de una clase para nuestros botones
```dart
class CustomButton extends StatelessWidget {
  //creamos una clase para los botones ya que se estaban repitiendo mucho
  final IconData
      icon; //dejando el cursor arriba podemos ver que es de tipo IconData
  final VoidCallback onPressed;   //ctrl + click pude llegar hasta donde esta definido este argumento y pude ver de que tipo era

  const CustomButton({    //el constructor simplemente le estamos diciendo que seran por nombre y resivira eso
    super.key,    // esto como lo habia dicho es para identificar nuestros widgets
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(    //porque cambiamos esto lo ponemos asi, quitamos desde este float el icono
      // shape: const StadiumBorder(),   //para hacerlo redondo
      // enableFeedback: true,   //hace como un sonidito al clickear
      // elevation: 20,    //como la sombra
      onPressed: onPressed,
      // onPressed: () {},    //pero si le mandamos el onPressed tiene el efecto de click
      // onPressed: null,    //si le mandamos null se desabilitan 
      child: Icon(icon),
    );
  }
}
```
Como la llamamos
```dart
CustomButton(   //aqui solamente mandamos a llamar a nuestra clase y ponemos los argumentos que pedia
  icon: Icons.exposure_minus_1_outlined,
  onPressed: () {
    setState(() {
      clickCounter <= 0 ? clickCounter = 0 : clickCounter--;
    });
  },
),
```


## App mensage

lib/main.dart
```dart
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me gusta mucho Marcela',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 6).themeMarce(),    //esto esperea un dato de themeData, nuestra clase, para obtener el tema ponemos nuestro metodo
      //resivimos un numero para seleccionar nuestro tema
      home: const ChatScreen(), 
    );
  }
}
```


lib/presentation/screens/chat/chat_screen.dart
```dart
class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {super.key}); //cuando ponemos screen normalmente pondre un Scaffold

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //el appBar que ya conocemos
        leading: const Padding(
          //el leading es un espacio que esta antes del titulo, este lo encerramos en un padding, que es el espacio de la imagen con la caja por adentro
          padding: EdgeInsets.all(
              4.0), //aqui le damos el padding, resive un tipo de dato EdgeInsets con el .all decimos que de los cuatro lados
          // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),   //asi tambien de diferentes lados
          child: CircleAvatar(
            //de hijo le pusimos este avatar circular como para la imagen
            backgroundImage: NetworkImage(
                'https://'), //un backgoundimage por internet
          ),
        ),
        title: const Text('Mi amor Marcela'),
        centerTitle: false, //este argumento es para centrar el titulo
      ),
      // body:
      //     Container(), //el boddy es todo lo que podemos ver en la pagina y si no tuvieramos appbar tambien ocuparia ese espacio
      //el container es como un div en la web le podemos cambiar el tamaño el color y todo eso
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  //esta como es una clase privada no necesitamos el key
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //este widget sirve para guardar los espacios como de los botones de abajo y asi, entonces deja el espacio y no permite trabajar en ese espacio guardado
      // left: false,    //asi con right y los demas por si no queremos guardar los espacios
      child: Padding(
        // lo envolvemos en un padding
        padding: const EdgeInsets.symmetric(
            horizontal:
                12), 
        child: Column(
          //de hijo le dimos la columna para poder trabajar la parte de los mensajes y la parte para enviar los mensajes
          children: [
            Expanded(
              //el expanded se expande a todo el espacio que tenga, en este ejemplo solo le dimos un color
              // child: Container( 
              //   color: Colors.green     //ya solo le dimos un color
              // )
              child: ListView.builder(
                //un listview con un constructor con nombre, builder explico que podemos tener mil elementos pero solo lo que se mostran estaran
                itemCount: 10,    //  pero con este item count me limita los elementos que me muestra abajo
                itemBuilder: (context, index) {   //el index ahi guarda los numeros de 0 a infinito
                  return Text('hoola $index');    //esto me retornaba muchoss elementos en si eran infinitos
                },
              ),
            ),
            const Text('hola')    //esta es la otra parte de la columna
          ],
        ),
      ),
    );
  }
}
```


lib/config/theme.dart
```dart
const Color _customColor =
    Color(0xFF0A8B60); //se pone 0xFF antes de las letras para los colores
const List<Color> _colorTheme = [   //nuestro arreglo de colores
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  final int selectedColor;    //inicialisamos un argumento
  AppTheme({this.selectedColor = 0})  
      : assert(selectedColor >= 0 && selectedColor <= _colorTheme.length - 1,   //las assert para ponerle una condicion al argumento
            'El numero ingresado tiene que estar entre 0 y ${ _colorTheme.length }'); //despues de la coma va el mensaje que queremos poner
  ThemeData themeMarce() {    //nuestro metodo para obtener nuestro tema ya que aqui lo retornamos
    return ThemeData(
      useMaterial3: true,   
      colorSchemeSeed: _colorTheme[selectedColor],  //seleccionamos el color que tendra y ya los pusimos en nuestro arreglo
      // brightness: Brightness.dark,    //esto pone el modo oscuro 
    );
  }
}
```

### Segunda parte

lib/presentation/widgets/chat/my_menssage_bubble.dart
```dart
class MyMenssageBobble extends StatelessWidget {
  const MyMenssageBobble({super.key});

  @override
  Widget build(BuildContext context) {
    final colorsM = Theme.of(context).colorScheme;    //esto significa, busca el tema dentro del contexto, y traemos el colorScheem
    //entonces en esta variable estan todos los colores definidos en el tema basados en el seed que creamos

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,   //como estaran alineadas, a la derecha
      children: [
        Container(
            // width: ,   //se pueden poner width y heihgt
            // height: ,
            decoration: BoxDecoration(    //la decoracicon de esta columna
                color: colorsM.primary, borderRadius: BorderRadius.circular(20)),   //borderRadius, le puse un circular, 
                //de colores ponemos nuestra variale y ahi estan todos los colores
            child: const Padding(   
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Me gusta mucho mi Novia',
                  style: TextStyle(color: Colors.white)),   //el estilo del texto, un color white
            )),
        const SizedBox(   
          height: 10,   //para que tenga un espacio entre los mensajes
        )
      ],
    );
  }
}
```

lib/presentation/widgets/chat/her_menssage_bubble.dart
```dart
class HerMenssageBobble extends StatelessWidget {
  const HerMenssageBobble({super.key});

  @override
  Widget build(BuildContext context) {
    final colorsM = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
                color: colorsM.secondary,
                borderRadius: BorderRadius.circular(20)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Me gusta mucho mi novio',
                  style: TextStyle(color: Colors.white)),
            )),
        const SizedBox(
          height: 5,
        ),
        _ImageBobble(),     //lo unico nuevo es la imagen
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _ImageBobble extends StatelessWidget {
  //recordar guion bajo solo en esta clase se puede usar

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //el mediaQuery nos da informacion del dispositivo que lo esta ejecutando, el contextex hace referencia al arbol de widgets, en ese arbol estan las diferentes caracteristicas como las dimenciones por eso pedimos el size

    // return Placeholder();     //este placeholder muestra un cuadrado y cuales son las dimenciones que estan siendo asignadas por defecto
    return ClipRRect(
      //este widget nos permite hacer bordes redondeados
      borderRadius:
          BorderRadius.circular(20), //aqui les doy los bordes redondeados
      child: Image.network(
        // y de hijo retornamos una imagen.network   entonces de internet
        'https://yesno.wtf/assets/no/13-755222c98795431aa2e7d453ab1e75a1.gif',
        width: size.width *
            0.6, //la imagen puede tener medida, aqui le estamos diciendo que la medida sera el width que tiene mi dispositivo pero solo el 60%
        height: 150,
        fit: BoxFit
            .cover, //aqui le estoy diciendo que se expanda a las dimenciones que tenga la imagen, como que ocupe el espacio que le estoy dando
        loadingBuilder: (context, child, loadingProgress) {
          //el context el acceso al arbol de los widgets
          //el child es basicamente la imagen que esta arriba
          if (loadingProgress == null) return child;  //le estoy diciendo que si el loading es null entonces ya cargo que envie la imagen

          return Container(   //si no ha cargado entonces retornara este container con las medidas de la imagne para que no hayan saltos
            width: size.width * 0.6,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),   //las mismas medidas y con un texto
            child: const Text('Mi amor esta enviando una imagen'),
          );
        },
      ),
    );
  }
}
```

lib/presentation/screens/chat/chat_screen.dart
```dart
class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return (index % 2 == 0)   //le dije que si era par mostrara los mensajes de ella si no mostrara mis mensajes, con este operador ternario
                      ? const HerMenssageBobble()
                      : const MyMenssageBobble();
                },
              ),
            ),
            //caja de textos de mensajes
            const MenssageFieldBox(),
          ],
        ),
      ),
    );
  }
}
```

lib\presentation\widgets\shared\menssage_field_box.dart
```dart
class MenssageFieldBox extends StatelessWidget {
  const MenssageFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    final textController =
        TextEditingController(); //esto nos funcionara para darles algunas funcionalidades

    final focusNode = FocusNode(); //lo mismo para hacer funcionalidades abajo

    final outlineInputBorder = UnderlineInputBorder(
        //creamos esta variable para reutilizar este mismo codigo
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20));

    final inputDecoration = InputDecoration(
        //podemos crear variables con los widgets para ponerlo mas facil abajo
        //le ponemos la decoracion
        // enabledBorder:      //le estoy poniendo estilo al borde cuando este desactivado
        // OutlineInputBorder(
        //   borderSide: BorderSide(   //para poner borde normal
        //     color: colors.primary
        //   ),
        //   borderRadius: BorderRadius.circular(20)   //para redondears
        // ),
        hintText:
            'End your mensage with a "??"', //esto es como un texto que aparece antes de escribir
        enabledBorder: outlineInputBorder, //ya solo le ponemos la variable
        focusedBorder:
            outlineInputBorder, //esto es cuando esta activado el texto

        filled: true, //esto hace que tenga como un background clarito
        suffixIcon: IconButton(
          //este icono esta a la derecha de la pantalla y le puse un iconButton para poder ponerle una accion
          icon: const Icon(Icons.send_outlined), //el icono
          onPressed: () {
            //y la accion
            final textValue = textController.value
                .text; //no puedo tomar como lo tome abajo entonces para obtener el texto hacemos esto
            textController.clear(); //lo ponemos que se limpie
          },
        ));

    return TextFormField(
      //esto crea un espacio para escribir con el teclado

      // keyboardType: ,      //tipos de teclado, para correos y asi
      focusNode:
          focusNode, //si tiene un focusNode le podemos colocar un elemento de focusNode
      onTapOutside: (event) {   //esto es cuando preciono afuera de la caja de texto
        focusNode.unfocus();  //aqui le estoy diciendo que me quite el foco o quite el teclado
      },
      controller: textController, //igualamos los controles que creamos arriba
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        //esto es cuando se envia ejecuta esto, en value esta el valor que tenia la caja de texto
        textController
            .clear(); //al tener el valor lo limpiamos de la caja de texto
        focusNode
            .requestFocus(); //despues que se limpia mantendre el foco, en este caso el teclado se mantendra activo o seleccionado
      },
      // onChanged: (value) {
      //   esto cuando se va tocando las teclas se va cambiando, en value esta el valor de la caja de texto
      //   print('change: $value');
      // },
    );
  }
}
```