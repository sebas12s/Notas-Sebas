#esto es para hacer comentarios
numero = 2 # solo con el nombre se declara la variable

print("me gustan las waifus")    #esto muestra un mensaje en pantalla
waifus = input("cuantas waifus tienes: ")   #esto es para recibir un daro se puede poner solo asi o con texto 
#aqui el texto que ingresamos es texto asi que para pasarlo a numero entero usamos lo siguiente
waifus = int(waifus)    #aqui ya se convirtio en numero entero
waifus = float(waifus)  #esto seria un nuemro real

# este es un ejemplo pero se usa una manera que no conocia el array 
frase = input("ingrese una frase: ")
posicion1 = int(input("primera posicion para hacer el corte: "))
posicion2 = int(input("posicion final para hacer el corte: "))
corte = frase[posicion1:posicion2]  #esto es donde no sabia que se podia hacer asi el array 
print(corte)


class Person:       #asi se define una clase
    name = ""       #declaracion de variables
    def walk():         #asi definimso una funcion

name = str      #asi se le puede decir que tipo de dato es en este caso es string   
id = int
array = []      #estamos diciendo que esto sera un tipo array


#digamos que tenemos un clase person para crear una instacia de esa clase en otras palabras crear un nuevo objeto se hace de la siguiente manera
persona = Person()

#para importar clases de diferentes archivos hacemos lo siguiente
from car import Car     #car es el archivo donde esta la clase Car 
car = Car()     #para crear un nuevo objeto solo ponemos el nombre del objeto y la clase con el metodo constructor que este metodo ya lo crea por defecto
car.atributo = ""       #asi le damos valor a los atributos 
print(vars(car))        #asi pintara todas los atributos del objeto car

#clases en python
class Account:
    id = int
    name = str
    document = str
    def __init__(self, name):   #con esto creamos un metodo constructor
        self.name = name    #el self funciona como el this para decir que de esta clase llamamos la variable

#cuando creamos un nuevo objeto al darle new y si uno de nuestros atributos que le pasamos es otra clase solo ponemos new entonces lo ceramos ahi mismo

from "" import ""       #para hacer herencia se necesita tambien llamar a la clase
class student(Account):     #en los parentesis se pone la clase padre
    lastName = str
    def __init__(self, name, lastName):     #como siempre se crea el constructor con los valores que tenga el padre y ya despues si queremos mas 
        super.__init__(name)    #asi le damos valores a los atributos que estan en la clase padre
        self.lastName = lastName    #ya el self es para decir que que de esta clase queremos sobreescribir

# a las clases heredaras se les llama familia entonces se podria decir que tengo una familia de car y asi
# entonces como vimos es una buena practica que aunque no deriven de ningun atributo pero puedan conectarse por familias entonces ahi si podriamos hacer una herencia
