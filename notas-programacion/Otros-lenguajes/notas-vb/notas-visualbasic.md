# Visual Basic

- [Visual Basic](#visual-basic)
  - [Como crear variables](#como-crear-variables)

## Como crear variables

asi se crea una variable con las palabras reservadas Dim y As y el tipo de dato

su extencion vb

```vb
Sub variables()
    Dim nombre As String
    nombre = "Sebastian Perez de Leon"
    MsgBox nombre
End Sub
```

MsgBox una funcion que muestra una ventana emergente con informacion y despues lo que queremos que muestre

```vb
Sub variables()
    Dim suma, resta As Integer
    suma = 12 + 12
    resta = 12 - 12
    MsgBox resta
    MsgBox suma
End Sub
```

Un pequeño ejemplo de sumas y restas

Alt + 62 = >
Alt + 60 = <

```vb
Sub condicionales()
    Dim numero1, numero2 As Integer
    numero1 = InputBox("ingrese el primer numero")
    numero2 = InputBox("ingrese el segundo numero")

    If numero1 = numero2 Then
        MsgBox "los numeros son iguales"
    Else: End If
    If numero1 > numero2 Then
        MsgBox "El primer numero es mayor que el segundo"
    Else
        MsgBox "El primer numero es menor que el segundo"
    End If
End Sub
```

Asi se hace un if anidado

```vb
nombre = "An...": apellido = "Seb.-.."
```

con los dos puntos le digo que hare otra sentencia en la misma linea

http://localhost/phpmyadmin/
asi se abre en el navegador con el xamp

SELECT nombre, apellido FROM `persona` WHERE id_persona = 1
nuestro primera consulta

```vb
Sub bucle()
 Dim numero As Integer
 numero = 0
 While numero < 10
    MsgBox numero
    numero = numero + 1
 Wend
End Sub
```

Un while en vb

```vb
Private Sub CommandButton1_Click()
    Worksheets("DATOS").Range("A2").EntireRow.Insert
    'row = columna
    'worksheets = hoja de excel
    'range = un rango de celdas
    'entireRow = referencia a toda la fila que estamos seleccionando
    'value = para capturar el valor de ese elemento
    'insert = para insertar
    'textBox = el cuadro de texto
    'comboBox = el cuadro de texto combinado
    'la lista desplegable es como el estado
    Worksheets("DATOS").Range("A2") = TextBox1.Value
    Worksheets("DATOS").Range("B2") = ComboBox1.Value
    Worksheets("DATOS").Range("C2") = TextBox3.Value
End Sub

Private Sub UserForm_Initialize()
    ComboBox1.List = Worksheets("AREAS").Range("A1:A5").Value
End Sub

```

Calculamos si es el usuario

```vb
Private Sub CommandButton1_Click()
    Dim usuario, usuarioG, contrasena, contrasenaG As String
    usuario = TextBox1.Value
    contrasena = TextBox2.Value
    usuarioG = Worksheets("Hoja1").Range("A2")
    contrasenaG = Worksheets("Hoja1").Range("B2")
    If usuario = usuarioG And contrasena = contrasenaG Then
            UserForm1.Hide
            UserForm2.Show
    Else
        MsgBox "Usuario o Contraseña incorrecta"
    End If
End Sub

usuario = emty

    ComboBox1.AddItem "Categoria 1", 0
    ComboBox1.AddItem "Categoria 2", 1
    ComboBox1.AddItem "Categoria 3", 2
    ComboBox1.AddItem "Categoria 4", 3
    ComboBox1.AddItem "Categoria 5", 4
```

Asi ponemos datos tambien a un combo box

```vb
Private Sub CommandButton1_Click()
    Dim usuario, usuarioG, contrasena, contrasenaG, resultado As String

    usuario = TextBox1.Value
    contrasena = TextBox2.Value
    ' usuarioG = Worksheets("Usuarios").Range("A2")
    ' contrasenaG = Worksheets("Usuarios").Range("B2")
    usuarioss = Application.WorksheetFunction.VLookup(TextBox1, Worksheets("Usuarios").Range("A2:A100"), 1, False)
    contrasenass = Application.WorksheetFunction.VLookup(TextBox2, Worksheets("Usuarios").Range("B2:AB100"), 1, False) ' un buscar v


    MsgBox usuarioss
    MsgBox contrasenass
    If usuario = usuarioss And contrasena = contrasenass Then
            UserForm2.Hide
            UserForm1.Show
    Else
        MsgBox "Usuario o Contraseña incorrecta, si no tienes registrate"
        TextBox1 = Empty
        TextBox2 = Empty
    End If
End Sub
```
