    create database holamundo;     --asi creamos una base de datos 
show databases;     --con este comando podemos ver cuales son las bases de datos que sql esta gestionando


use holamundo;          --aunqeu creemos la tabla no sabe que base de datos usar y por eso ponemos este comando para que sepa que base de datos usar    
CREATE TABLE animales (     --asi creamos una tabla
    id int,        --aqui adentro comenzamos a poner las columnas que tendra nuestra tabla, primero le colocamos el nombre de la columna despues los tipos de datos que tendra
    tipo varchar(255),      --en los parentesis agregamos hasta que tan largo queremos que sea la cadena de texto 
    estado varchar(255),
    --arriba le colocamos un id pero tenemos uqe hacer por aparte que sea una primary key
    PRIMARY KEY (id)        --asi se pone para que sea la primary key adentro del parentesis va el nombre de la columna
);      --despues de darle al use ya podemos hacer la peticion, crear la tabla que si no te recuerdas es seleccionando y dandole al rayito
--para insertar datos 
INSERT INTO animales (tipo, estado) VALUES ("chanchito", "feliz");   --para insertar datos ponemos primero el nombre de la tabla y depues las columnas en las que queremos insertarlas y despues sus valores

--el siguiente comando es para modificar una columna 
ALTER TABLE animales MODIFY COLUMM id int auto_increment;   --aqui le estamos diciendo que en la tabla animales que modifique la columna id y le decimos auto increment pero siempre le tenemos que decir que tipo de dato es

SHOW CREATE TABLE animales;     --con esto obtenemos el comando que se utiliza para crear esta tabla
--la tabla que nos sale la tenemos que copiar ahi esta como de nuevo la tabla, nos la devuelve en string solo le quitamos las comillas simples
CREATE TABLE `animales` (           --asi se deberia de ver la tabla bien bien estructurada
  `id` int NOT NULL AUTO_INCREMENT,         --nos agrega que no puede ser nulo y de una vez el auto_increment para no estarlo agregando despues 
  `tipo` varchar(255) DEFAULT NULL,         --nos dice que por defecto tendra un valor nulo 
  `estado` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)           --aqui le borramos este texto que estaba pero por que vamos comenzando 

--para insertar solo seguimos poniendo lo que pusimos arriba 
--para mostrar la tabla se ejecuta lo siguiente
SELECT * FROM animales;     --primero ponemos las columnas que queremos mostrar despues la tabla
SELECT * FROM animales WHERE id = 1;        --aqui le dijimos que nos mostrara todas las columnas donde el id sea 1
SELECT * FROM animales WHERE estado = "feliz" AND tipo = "chanchito";      --tambien asi con otra columna, tambien se puede consultar la peticion con mas de una agregando el and 

UPDATE animales SET estado = "feliz" WHERE id = "5";    --aqui le dije en la tabla animales vamos a actualizar la columna estado a feliz solo donde tenga el id 5

DELETE from animales WHERE tipo = "chanchito";      --le estamos diciendo que borraremos en la tabla animales donde este el tipo chanchito
--si solo ejecutamos esto nos manda un error y es como un meme que hacer delete from sin el where lo que busca en el where es un id 
DELETE from animales WHERE id = 1;      --estonces la forma correcta de hacerlo es con el id
--el error 1175 siempre que sea delete o update siempre es con id

SELECT DISTINCT MostRecentAuditType     --esto busca si hay muchos del mismo tipo solo busca uno entonces si hay 2 solo te tira uno 
FROM dbo.FactoryTCCC;

CREATE TABLE user (
	id int not null auto_increment,
    name varchar(50) not null,
    edad int not null,
    email varchar(100) not null,        --en este ejemplo le pusimos diferente cosas a las demas columnas 
    primary key (id)
);

--mas formas de usar select
select * from user limit 1;     --limite haya uno 
select * from user where edad > 15;     --donde la edad sea mayor a 15, solo eso me devolvera
select * from user where edad >= 15;       --tambien se puede hacer con >= asi que nos muestra los mauores e igualse
select * from user where edad > 15 and email = "layla@gmail.com";   --tambien se puede hacer con and
select * from user where edad > 15 or email = "layla@gmail.com";     --tambien se puede con or
select * from user where email != "layla@gmail.com";        --esta es la negacion, me devuelve todos los que no tengan ese email
select * from user where edad between 15 and 30;        --aqui dijo que me mostrara los que estan entre 15 a 30 
select * from user where email like "%gmail%";          --le dije que busquemos entre la columna email los datos que tengan esa cadena de texto los signos de porcentaje nos dice que no le importa nada con que comienza o con que termina 
select * from user order by edad asc;       --con order by le estamos diciendo que ordene los resultados de edad en forma asendente ese es el asc
select * from user order by edad desc;        --este es en forma descendente   
select min(edad) as menor from user;    --en medio de la funcion tenemos que pasar el nombre de la columna  despues le ponemos el sobrenombre que queremos que tenga lo hacemos con as despues ponemos la tabla
select max(edad) as mayor from user;      --lo mismo pero con el mayor 
select id, name from user;      --mostrabamos todas las tablas pero tambien solo podemos poner las columnas que queramos
select id, name as nombre from user;       --aqui le cambiamos el sobrenombre por como aparece no sale name si no nombre 
select id, name as nombre, edad as raul from user;      --cuando le queremos cambiar a mas de uno

--la union de dos tablas
create table products (
	id int not null auto_increment,
    name varchar(50) not null,
    create_by int not null,     --esta sera la llave forania
    marca varchar(50) not null,
    primary key(id), 
    foreign key(create_by) references user(id)    --le dijimos que esa columna sera la llave forania, despues le dijimos de que tabla es y adendtro de los parentesis la columna que estabamos haciendo referenccia
);

rename table products to produc;    --asi cambiamos de nombre las tablas

insert into product (name, create_by, marca)
values
	("ipad", 1, "apple"),
    ("iphone", 1, "apple"),
    ("watch", 2, "apple"),
    ("macbook", 1, "apple"),
    ("imac", 3, "apple"),
    ("ipad mini", 2, "apple");    --asi podemos agregar datos sin tener que poner mas veces el insert into 

--left join
--en palabras no buenas: nos muestra toda la tabla de la izquierda y lo que queramos ver de la tabla de la derecha mientras este en la izquierda si no esta en la tabla izquierda no lo muestra
select u.id, u.email from user u;       --como estamos trabajando con dos tablas le asignamos un alias a la tabla user la u puede ser cualquier otra cosa
select u.id, u.email p.name from user u left join product p;    --el siguiente paso es hacer el left join ponemos el nombre de la tabla y despues un alias y ya la podemos mostrar al comienzo
select u.id, u.email, p.name from user u left join product p on u.id = p.create_by;  --el siguiente paso le dijimos que juntaremos el id del usuario que sea igual al create_by qeu es el mismo id del ususario pero lo pusimos en la otra tabla como llave forania
-- aqui le dijimos que nos trajiera todos lo que pedimos de la tabla de la izquierda y de la derecha solo los productos que esten asociados con el id que pusimos

--right join 
--es lo mismo pero ahora toma primero la tabla de la derecha 
select u.id, u.email, p.name from user u right join product p on u.id = p.create_by;  --lo mismo pero muestra todo de la deracha y solo lo que coicida en la izquierda

--inner join 
select u.id, u.email, p.name from user u inner join product p on u.id = p.create_by;  --lo mismo pero este solo nos muestra lo que esta en medio o lo que tiene igual a la tabla

--producto carteciano 
--es juntar los registros de dos tablas asi
-- 1-1 1-2 1-3 1-4
-- 2-1 2-2 2-3 2-4      y asi 
select u.id, u.name, p.id, p.name from user u cross join product p;     --como explique esto mostrara 1 con 1 con 2 y asi todos lso archivos que le hayamos puesto


--group by 
select count(id), marca from product group by marca;    --le pusimos el count a la columna id y mostramos tambien la marca y despues le pusimos que agrupara por marca entonces nos mostrara cuantos id hay por la marca
-- en el count ponemos por quien vamos a hacer referencia en este ejemplo al id 
select count(u.id), u.name from product p left join user u on u.id = p.create_by group by p.create_by;
--esto solo nos mostro los que habia creado cada usuario 
--la 



-- cuando ya tenemos una tabla para poder entrar a su codigo se hace de la siguiente manera
--escrup table as       doble click en la tabla         insert to       new query

ALTER TABLE NombreTabla
ALTER COLUMN NombreColumna varchar(6)       --asi se puede editar el tipo de dato que es la columna