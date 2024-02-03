# C# get y set

## get

el get en un interface es cuando queremos hacer logica cuando estamos obteniendo un valor, en el caso de usarla es cuando estamos enviando un valor

```c#
public class Ejemplo
{
    private int _numero;

    // Propiedad con bloques get y set personalizados
    public int Numero
    {
        get
        {
            // Lógica para obtener el valor
            return _numero;
        }
        set
        {
            // Lógica para establecer el valor
            _numero = value;
        }
    }
}
```

Como ven estamos enviando

## set

set es cuando queremso hacer logica cuando recibimos un valor, digamos que si viene un numero mayor a 18 poner un mesaje que es mayor de edad

### ejemplo

```c#
class Program
{
    static void Main(string[] args)
    {
        Ejemplo ejemplo = new Ejemplo();

        // Usando set para establecer el valor
        ejemplo.Numero = 10;

        // Usando get para obtener el valor
        int valor = ejemplo.Numero; // Devuelve 10
    }
}
```

el cliente le hace la peticion al controller
el controller al model
y el model es la conexion a la base de datos

La firma de un metodo es el nombre, el tipo y lo argumentos
esto es lo que define un metodo

```c#
GetLeadFormConfiguration((int)formId, apiKey, clientId);
```

esto se le llama castear una variable
