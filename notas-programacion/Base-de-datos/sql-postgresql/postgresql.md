# PostgreSQL

Desactiva el auto commit de la db para evitar errores

## Terminologia SQL

- DLL (Data Definition Language): Create, Alter, Drop, Truncate
- DML (Data Manipulation Language): Insert, Delete, Update
- TCL (Transaction Control Language): Commit, Rollback
- DQL (Data Query Language): Select

## Estructura general

Asi como normalmente se deberian de hacer las sentencias

- `SELECT`, \*, campos, alias, funciones
- `WHERE`, condicion, and, or, in, like
- `GROUP BY`, campo agrupador, ALL
- `HAVING`, condicion
- `ORDER BY`, exprecion, ASC, DESC
- `LIMIT`, valor, ALL
- `OFFSET`, punto de inicio

## Comenzando en PgAdmin

- `ctrl + e` para abrir sql
- `ctrl + w` para cerrar el sql

## SQL

### Create table

```sql
CREATE TABLE users (
	name VARCHAR(10) UNIQUE	/* asi creamos una tabla, el nombre de la columna despues el tipo y con UNIQUE le digo que sera unico el nombre no estar duplicado otra
	cosa es que no termina en coma si termina en coma espera otra instruccion */
);
```

### Insert

Puedo poner mas datos y mas columanas, pero si pongo la columan 1 tengo que pooner el mismo valor, siguiendo el orden que puse arriba

```sql
INSERT INTO users
	(name)  --si no pongo la columna igual pueden insertarse pero cuidado con el orden porque los valores insertados seguiran el orden que tenga la tabla
VALUES  --importantee solo me dejo con comilla simple
	('Marce'),
	('Sofia'),
	('Cris');

```

### Update

```sql
UPDATE users --tabla
SET
    name = 'Mar' --el nuevo valor
WHERE
    name = 'Marce' --donde lo quiero cambiar
```

### Selct

```sql
SELECT * FROM users;    --busca todos los registros de la tabla users

SELECT * FROM users LIMIT 3;  --para que tenga un limite de los registros que devuelve

SELECT * FROM users LIMIT 2 OFFSET 2;   --offset nos ayuda para saltar dos, entonces si devuelve 1 y 2 ahora devuelve 3 y 4
```

### Where

```sql
SELECT * FROM users WHERE name = 'Mar';		--aqui podemos usar where para decir que me muestre todas donde el nombre sea Mar
SELECT * FROM users WHERE (name) LIKE 'Mar%'; --este LIKE y el signo de porcentaje nos ayuda como una expresion regular le digo que por lo menos tenga esas primeras litras y despues no me importa lo que venga
SELECT * FROM users WHERE (name) LIKE '%cela'; --al comienzo tambien puede estar
SELECT * FROM users WHERE (name) LIKE '%a%'; --tambien si tienen una letra a y asi podemos hacer las convinaciones que queremos
SELECT * FROM users WHERE (name) LIKE '_arcela'; --asi tambien le decimos que solamente esperamos un caracter con el guion bajo

--recordar que en el where tambien podemos poner operadores logicos
WHERE followers > 4600		--recordar que tambien se pueden poner estos operadores
WHERE followers >= 4600
WHERE followers <= 4600 --y asi
```

### Delete

```sql
DELETE FROM users WHERE (name) LIKE 'Marcela%';	--asi tambien podemo eliminar siempre intentar poner el where
DELETE FROM users WHERE (name) = 'Mar';
DELETE FROM users;		--esto elimina todos los registros cuidado
```

### Drop table / Truncate table

```sql
DROP TABLE users;	--esto elimina una tabla

TRUNCATE TABLE users; 	--esto lo que hace es que borra todos sus registros pero deja la tabla, es lo mismo que DELETE pero en DELETE nos da la posibilidad de hacer un where
```

### Funciones de agregacion

Son funciones que ya trae sql para ayudarnos

```sql
SELECT max(id) FROM users	--aqui utilizamos el max y espera una expresion en este caso le dije que me seleccionara el id maximo de la tabla users

DELETE FROM users WHERE id = ( SELECT max(id) FROM users )	--tambien puedo ejecutar un subquery
```

### Operadores de strings

#### UPPER / LOWER / CONCAT

```sql
--estas funciones no estan afectando a la base de datos por que es un select otra cosa seria se fuera un update
SELECT id, UPPER(name) from users	--este es para que todo lo que nos regrese lo pase a mayusculas
SELECT id, UPPER(name), name from users	--incluso asi podemos ver tambien la columna sin modificar (name)
--Solo que hay algo, como es una funcion el nombre de la columna aparece commo upper si queremos poner un alias a la culumna es de la siguiente manera
SELECT --el as se puede poner en cualquier coulmna
	id,
	UPPER(name) AS nombrecolum,
	LOWER(name) AS nombrecolum,	--en minuscula
	LENGTH(name), --para contar los caracteres
	name,
	(12 * 2) AS calculo,	--tambien se pueden poner calculos o cosas y esto crea una columna
	CONCAT(id, ' ', UPPER(name)),  --asi tambien podemos concatenenar
	(id || ' ' ||  name) AS Concator	--asi tambien podemos unir cadenas
FROM users
```

#### SUBSTRING / POSITION

```sql
SELECT
	name,
	SUBSTRING(name, 0, 5),	--nos ayuda a cortar el string, le digo desde la posicion 0 hasta la 5 en este caso
	POSITION( 'E' in name ) --esta funcion nos da la posicion desde 1 y nos devuelve el numero de donde este, in la columna
FROM
	users
```

Un ejemplo para separar el nombre y el apellido

```sql
SELECT
	name,
	SUBSTRING(name, 0, POSITION( ' ' in name )) AS FirstName,
	SUBSTRING(name, POSITION( ' ' in name ) + 1) AS LastName  --esto comienza a cortar desde el espacio entonces nos devuelve el espacio para evitar eso le sumo 1
FROM
	users
```

Actualizar datos:

```sql
UPDATE users
SET
	first_name = SUBSTRING(name, 0, POSITION( ' ' in name )),
	last_name = SUBSTRING(name, POSITION( ' ' in name ) + 1);
--no le pongo where porque quiero que se actualice en todos lados
```

### BETWEEN

```sql
SELECT
    first_name,
    last_name,
    followers
FROM
    users
WHERE
    -- followers > 4400 AND followers < 4700		--se puede poner el AND y todos esos
    followers BETWEEN 4400 AND 4700		--esto es lo mismo que la linea de arriba pero mejor
ORDER BY  --le digo que ordene por, lo followers descendentes tambien esta ascendentes (ASC)
	followers DESC
```

### Funciones agregadas

```sql
SELECT
	--solo si es necesario colocar alias
    COUNT(*) AS totalre_gistros, --esto cuenta cuantos registros tenemos
	MIN(followers) AS min_followers, --esto nos devuelve cual es el minimo de esa columna
	MAX(followers) AS max_followers, --esto nos devuelve cual es el maximo de esa columna
	AVG(followers) AS avg_followers, --esto saca el promedio suma todo y divide por el total
	ROUND(AVG(followers)) AS avg_followers,	--esto es para redondearlo o quitarle los decimales
	SUM(followers) / COUNT(*) AS promedio_manual --esto es otra forma de sacar el promedio sin la funcion
FROM
    users
```

### GROUP BY

No podemos poner una funcion de agregacion y una columna sin un GROUP BY

```sql
--para conocer cuantas personas cumplen con esos datos
--aunque con group by se puede agrupar por medio el que le pongamos
SELECT COUNT(*), followers
from users
WHERE followers = 4 or followers = 4999
GROUP BY followers		--con esto le digo que me muestre agrupadas mediante los followers entonces si 4 followers cumplen con eso lo separa a la otra condicion

--tambien puedo hacer esto que cuente cuantos hay en en cada followeres mediante el grupo by
SELECT COUNT(*), followers
from users
WHERE followers BETWEEN 4000 and 4800
GROUP BY followers
ORDER BY followers DESC
```

---

Ejercicio con group by, el ejercicio era extraer los dominios de los correos electronicos y contar cuantos tenian cada uno, y mostrar los que tuvieran mas de un dominio igual

```sql
SELECT
    COUNT(*),
    SUBSTRING(email, POSITION('@' in email) + 1 ) AS dominio	--extraigo el dominio
FROM
    users
GROUP BY SUBSTRING(email, POSITION('@' in email) + 1 )	--con el count de arriba cuento todos y lo agrupo por dominio, por eso pongo toda esta funcion, muy importante no por email si no el dominio
HAVING COUNT(*) > 1 	--y ya le pongo que esten arriba de uno
```

### HAVING

Esta va muy de la mano con GRUOP BY

```sql
SELECT
	COUNT(*),
	country
FROM
	users
GROUP BY country
HAVING COUNT(*) > 5		--le digo que me comience a agrupar o mostrar desde que el count sea mayor a 5
ORDER BY COUNT(*) DESC
```

### DISTINCT

```sql
SELECT DISTINCT country from users	--esto me trae solo una vez todos los paises en este caso, los distintos
```

### Subquerys

Son querys que se ejecutan dentro de un query y se pueden poner donde quieras

Tener presente que pueden llegar a ser muy ineficientes ya que funciona como un ciclo, el query principal ejecutara por cada dato que tenga el subquery entonces si tenemos un millon de datos eso seria muy lento

### Relaciones

Existen estas relaciones en las bases de datos

- Uno a uno - One to one
- Uno a muchos - One to many
- Relaciones a si mismas - Self Joining relationships
- Muchos a muchos - Many to many

Muchos a muchos la particularidad que tiene es que tienen una tabla intermedia

En estas relaciones viene un tema importante que es el de las llaves

### Keys - LLaves

Se puede trabajar sin llaves pero no es para nada recomendado

Hay diferentes tipos de keys:

- Primary key: identifica un registro de forma unica. usa un id idenpendiente controlado por nosotros los creadores de la tabla
- Super key: es un conjunto de atributos que se pueden identificar como forma unica
- Canditate key: son un conjunto de atributos que se identifican como unicos pero no es el primary key, son los canditos
- Foreing key: es la llave primaria de otra tabla, tienen que ser del mismo tipo y de la misma longitud
- Composite key: cuando una llave primaria consta de mas de un atributo
- Alternate key
- Artificial key
