# Extension Snippets

- [Pagina principal](https://code.visualstudio.com/api/working-with-extensions/publishing-extension)

## Pasos para crear una extension de snippets

- Instalar `npm install --global yo generator-code` y `npm install -g @vscode/vsces`
- En la carpeta que queramos iniciar el proyecto ejecutar `yo code`
- Elegir la opcion que desee, (Code Snippets)
- Languaje id se refiere a que lenguaje queremos hacer snippets

El package.json:

```json
{
  //simplemente informacion de la app
  "name": "bullseye-snippets-demo",
  "displayName": "Bullseye-Snippets-demo",
  //este nombre tiene que ser el mismo de el Id de la publicacion en el marketPlace de vscode
  "publisher": "SebastianSnippetsDemo",
  "description": "",
  "version": "0.0.1",
  "engines": {
    "vscode": "^1.86.0"
  },
  "categories": ["Snippets"],
  "contributes": {
    // lo que puede soportar, como para snippets el lenguaje y es
    "snippets": [
      {
        "language": "javascript",
        // este es el path del archivo donde estan almacenados los snippets
        "path": "./snippets/snippets.code-snippets"
      },
      //asi se le puede agregar mas lenguajes
      {}
    ]
  }
}
```

Ejemplo simple sobre un snippet

```json
{
    "sebasextension": {
        "prefix": "!sebasxtension"
        "body": [
            "console.log('Hello Sebastian Snippets Demo')"
        ]
    }
}
```

## Publicacion simple

- Pagina principal: [Marketplace](https://marketplace.visualstudio.com/vscode)
- En publish extension creamos una "publisher"
- Y ahi podemos crear una extension, recordar que el Id tiene que ser el mismo que esta en el `pachage.json` como publisher
- En el directorio se tiene que crear un archivo `vsix` eso sera lo que se publicara
- Ejecutamos para crearlo: `vsce package`
- Podemos arrastrar el archivo a la nueva creacion de extension o ejecutar: `vsce publish`
