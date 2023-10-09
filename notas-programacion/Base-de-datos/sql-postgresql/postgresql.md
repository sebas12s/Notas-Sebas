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
