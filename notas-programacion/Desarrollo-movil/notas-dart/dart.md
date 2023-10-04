# Dart

- [Dart](#dart)
  - [Palabras reservadas](#palabras-reservadas)
  - [Peticiones HTTP](#peticiones-http)
  - [Mapear un json](#mapear-un-json)

## Palabras reservadas

abstract continue FALSE new this
as default final null throw
assert deferred finally operator TRUE
async do for part try
async* dynamic get rethrow typedef
await else if return var
break enum implements set void
case export import static while
catch external in super with
class extends is switch yield
const factory library sync* yield\*
required late

## Peticiones HTTP

se necesita un paquete esta es la direccion para los paquetes de dart
[Link](https://pub.dev/)

solo ponemos la dependencia en http y lo descarga

```yaml
dev_dependencies:
  lints: ^2.0.0
  test: ^1.21.0
  http: ^1.1.0
```

Se recomienda que las importanciones sean primero las de dart despues la de terceros y despues las que creamos nosotros

Esta parte la copiare aqui porque la creacion de esto necesita algunas descargas

```dart
void main(List<String> arguments) {

  final url = Uri.parse('https://reqres.in/api/users?page=2');

  http.get(url).then((res) => print(res));
}
```

Ya importado el http, el get lo que envia es un future entonces podemos hacer todas las funciones,
y mas arriba nos muestra como almacenar una url

```dart
final url = Uri.parse('https://reqres.in/api/users?page=2');

  http.get(url).then((res) {
    final body = jsonDecode(res.body);
    print(body);
    print(body['page']);
    print(body['per_page']);
    print(body['data'][2]['id']);       //asi ya estariamos haciendo peticiones, puedes ver la url que queria obtener con eso
  });
```

Asi hacemos una muestra de lo que queremos, el link es solo de relleno pero es un json y para mostrarlo hacemos todo esto, tambien hay que importar Dart:Convert

## Mapear un json

hay una super pagina que ayuda hacer eso para mapear un json
[Link](https://app.quicktype.io/)
para recorrer mejor un json

Ya solo ponemos el lenguaje y el nombre de la clase y copiemos y pegamos

En la misma pagina copiamos al lado izquierdo nuestro json y lo pegamos

Las dos lineas son las dos funciones que nos serviran

asi seria con la ayuda de la pagina

```dart
http.get(url).then((res) {
    final resReq = reqRespuestaFromJson(res.body);

    // print(body['page']);
    print(resReq.page);
    // print(body['per_page']);
    print(resReq.perPage);
    // print(body['data'][2]['id']);
    print(resReq.data[2].id);
  });
```

la clase de persona se recomienda que la hagan en otro archivo

En el ejemplo podemos ver un orden para que todo vaya mejor con los archivos
