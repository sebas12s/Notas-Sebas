# PostgreSQL

Desactiva el auto commit de la db para evitar errores

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
