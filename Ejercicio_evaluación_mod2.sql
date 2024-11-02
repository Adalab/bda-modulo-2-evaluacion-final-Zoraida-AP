/* EJERCICIO 1: Seleccionamos todos los nombres de las pelíclas sin que aparezcan duplicados

-En este caso no es necesario usar la funcion DISTINCT para evitar duplicados, debido al uso de PK única, ya que identifica de manera única cada registro en una tabla.
 */

SELECT title AS Títulos
FROM film;

/*Podemos comprobar tambien con una query que no existen títulos repetidos.
-Usamos COUNT(title) para contar el número de veces que aparece cada título en la tabla y HAVING para Filtra el resultado que nos devolverá el GROUP BY y mostrar solo los títulos que aparecen más de una vez*/

SELECT title, COUNT(title) AS títulos_repetidos
FROM film
GROUP BY title
HAVING títulos_repetidos > 1;

/* EJERCICIO 2: Mostramos los nombres de todas las películas que tengan una clasificación "PG-13"

-Filtramos películas con clasificación "PG-13" usando la claúsula WHERE que nos permite especificar esta condicion.
*/

SELECT title AS Títulos, rating AS Clasificación
FROM film
WHERE rating = "PG-13";

/*EJERCICIO 3: Encuentra el título y descripción de todas las películas que contengan la palabra "amazing" en su descripción.

-Utilizamos el operador LIKE y el patrón '%amazing%' para  buscar cualquier cadena de texto que incluya la palabra "amazing".
-Así, la consulta devolverá todas las películas que contengan "amazing" en cualquier parte de su descripción. 
*/

SELECT title AS Títulos, description AS Descripción
FROM film
WHERE description LIKE '%amazing%';

/* EJERCICIO 4: Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos

-Utilizamos la clausula WHERE para establecer la condicion de que la duración de la película sea mayor de 120 minutos.
*/

SELECT title AS Títulos, length AS Duración
FROM film
WHERE  length > 120;

/* EJERCICIO 5: Recupera los nombres de todos los actores.

-Usamos la funcion CONCAT para combinar las columnas de 'first_name' y 'last_name' y que nos devuelva el nombre completo del actor/actriz.
-Utilizamos ORDER BY para ordenar el resultado alfabeticamente en orden ascendente.
*/

SELECT CONCAT(first_name, " ",  last_name) AS Nombre_actor
FROM actor
ORDER BY Nombre_actor ASC; 

/* EJERCICIO 6: Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

- Usamos la funcion CONCAT para combinar las columnas de 'first_name' y 'last_name' para unirlas en una cola columna.
- Utilizamos las claúsulas WHERE y LIKE para filtra los resultados y que solo se devuelva aquellos actores cuyo apellido sea exactamente "Gibson" 
*/

SELECT CONCAT(first_name," ",  last_name) AS Nombre_actor
FROM actor
WHERE last_name LIKE "Gibson"
ORDER BY Nombre_actor ASC; 

/* EJERCICIO 7: Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

- Usamos  funcion CONCAT para combinar combinar nombre y apellido y que nos lo muestre en una cola columna.
- Usamos las claúslas WHERE y BETWEEN para filtrar actores cuyos actor_id estén entre 10 y 20.
- Con ORDER BY ordenamos los resultados de menos a mayor actor_id 
 */

SELECT CONCAT(first_name," ",  last_name) AS Nombre_actor, actor_id
FROM actor
WHERE actor_id BETWEEN 10 AND 20
ORDER BY actor_id ASC;

/* EJERCICIO 8: Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

-  Con  las claúslas WHERE y NOT LIKE , junto al operador AND , para filtrar los títulos de las películas excluyendo ambas clasificaciones: "R" y "PG-13". 
*/

SELECT title AS Títulos, rating AS Clasificación
FROM film
WHERE rating NOT LIKE "R" AND rating NOT LIKE "PG-13"; 

-- Otra forma de hacerlo sería usando símbolos en lugar de la claúsula NOT LIKE: 

SELECT title AS Títulos, rating AS Clasificación
FROM film
WHERE rating <> "R" AND rating <>"PG-13";

/* EJERCICIO 9: Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

- Con COUNT contamos las veces aparece cada clasificación en la tabla.
- con GROUP BY agrupamos los resultados según la columna Clasificación. Cada grupo corresponde a una clasificación, y para cada grupo, se mostrará el total de películas que pertenecen a esa clasificación.
*/

SELECT COUNT(rating) AS Cantidad_total, rating AS Clasificación
FROM film
GROUP BY Clasificación; 

/* EJERCICIO 10: Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

 - Concatenamos el nombre y apellido con CONCAT para que nos los muestre en una sola columna.
 - Usamos COUNT(r.rental_id) para contar el número de alquileres asociados a cada cliente, utilizando el rental_id de la tabla rental como referencia.
 - Hacemos un INNER JOIN entre customer y rental para combinar ambas tablas y contar las películas alquiladas por cada cliente. 
 - Con GROUP BY agrupamos los resultados por el nombre completo del cliente y su ID, lo que permite que la cuenta de alquileres se realice para cada cliente de forma individual.
 */

SELECT CONCAT(c.first_name," ",  c.last_name) AS Cliente, c.customer_id AS Id_cliente, COUNT(r.rental_id) AS Total_películas_alquiladas
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
GROUP BY Cliente, Id_cliente;

/* EJERCICIO 11: Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
  - Usamos COUNT con r.rental_id para contar el número de alquileres asociados a cada categoría.
  - A continuación , hemos hecho tres INNER JOIN: 
		- Entre las tablas category y film_category para conectar cada categoría con las películas que pertenecen a ella.
        - Entre film_category e inventory para acceder a los detalles sobre el inventario de cada película.
        - Y entre las tablas inventory y rental para contar los alquileres de las películas disponibles en el inventario.
- Por último, usamos el operador GROUP BY  para agrupar los resultados por  nombre de  categoría, por lo que nos monstrará la cuenta de alquileres para cada categoría de forma individual.
*/

SELECT c.name AS Categoría, COUNT(r.rental_id) AS Total_Alquileres
FROM category AS c
INNER JOIN film_category AS fc ON c.category_id = fc.category_id
INNER JOIN inventory AS i ON fc.film_id = i.film_id 
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY c.name;

/*EJERCICIO 12: Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

- Hemos utilizado la función de agregado AVG() para calcular el promedio de la columna length, que representa la duración de las películas en minutos.
- Usamos GROUP BY para agrupar los resultados por clasificación, por lo que el cálculo del promedio de duración se realizará por cada grupo de clasificación.
*/

SELECT rating AS Clasificación, AVG(length) AS Duración_media
FROM film 
GROUP BY rating;

/* EJERCICIO 13: Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

- Realizamos una unión INNER JOIN con la tabla film_actor para conectar los actores con las películas en las que han actuado, utilizando actor_id como clave para la unión.
- Hacemos otra unión INNER JOIN con la tabla film, la cual nos permite acceder a los detalles de las películas, utilizando film_id como clave para conectar ambas tablas.
- Utilizamos la clausula WHERE para establecer la condicion de que el título sea "Indian Love"
- Con ORDER BY ordenamos el resultado por nombre en orden alfabético 
*/

SELECT a.first_name AS Nombre, a.last_name AS Apellido
FROM actor AS a
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON fa.film_id = f.film_id
WHERE f.title = "Indian Love"
ORDER BY Nombre ASC;

/* EJERCICIO 14: Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

- Aplicamos un filtro WHERE, junto al operador LIKE, para buscar solo aquellas películas cuya descricpción contenga la palabra "dog" o "cat".
	- Usamos % en nuestro patrón para indicar que la palabra puede estar precedida o seguida de cualquier otra cadena de caracteres.
    - Usamos el operador lógico OR para indicar que queremos resultados que cumplan al menos una de las condiciones especificadas.
    */

SELECT title AS Título
FROM film
WHERE description LIKE "%dog%" OR description LIKE "%cat%";

/*  EJERCICIO 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
 
- Realizamos un LEFT JOIN entre actor y film_actor, para que se muestren todos los registros de la tabla actor y solo aquellos registros de film_actor que tengan un actor_id coincidente. Si un actor no tiene coincidencias en film_actor, los campos provenientes de esta tabla aparecerán como NULL
- Filtramos el resultado con WHERE para incluir solo aquellos actores para los cuales no existe un registro correspondiente en film_actor, identificando así los actores que no han aparecido en ninguna película.
- Utilizamos GROUP BY para agrupar los resultados por el Nombre_actor y  evitar duplicados en el resultado final.
*/

SELECT CONCAT(a.first_name, " ", a.last_name) AS Nombre_actor
FROM actor AS a
LEFT JOIN film_actor AS fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL
GROUP BY Nombre_actor;

/* En este caso, a consulta no nos devuelve ningún nombre, lo que quiere decir que no hay ningún actor/actriz que no aparezca en ninguna película. 
Para comprobarlo, realizamos un LEFT JOIN, para unir al nombre del actor las id de las películas en film actor, de manera que podemos ver que realmente no hay ningún valor de IDpelícula NULL para ningún actor.
*/

SELECT CONCAT(a.first_name, " ", a.last_name) AS Nombre_actor, fa.film_id AS iD_Película
FROM actor AS a
LEFT JOIN film_actor AS fa ON a.actor_id = fa.actor_id;

-- Otra forma para comprobarlo, es comparar el número de actores que hay tanto en la tabla actor como la tabla film_actor y ver que ambos coinciden.

SELECT COUNT(DISTINCT actor_id)
FROM film_actor;

SELECT COUNT(DISTINCT actor_id)
FROM actor;

/* EJERCICIO 16: Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

- Usamos la cláusula WHERE y BETWEEN para filtrar solo aquellas películas cuyo campo año de lanzmiento esté entre 2005 y 2010, ambos inclusive.
*/


SELECT title AS Título
FROM film 
WHERE release_year BETWEEN 2005 AND 2010; 


/* EJERCIO 17: Encuentra el título de todas las películas que son de la misma categoría que "Family".

- Hacemos dos INNER JOIN:
	- Uno entre film y film_category para conectar cada película (film_id) con su categoría.
    - Entre film_category y category, de manera que cada película puede relacionarse con el nombre de su categoría
- Filtramos el resultado con WHERE para seleccionar solo las películas cuya categoría sea "Family
*/

SELECT f.title AS Título
FROM film AS f
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = "Family"; 

/* EJERCICIO 18: Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

- Hacemos un INNER JOIN entre actor y film_actor para identificar las películas en las que ha participado cada actor.
- Con GROUP BY agrupamos los resultados por nombre y apellido de los actores, de modo que cada grupo representa un actor diferente.
- Usamos HAVING para filtrar los grupos resultantes, mostrando solo los actores que han actuado en más de 10 películas, usando la función COUNT para contar las apariciones.
- Con ORDER BY ordenamos alfabéticamente los nombres de los actores en orden ascendente.
*/

SELECT a.first_name AS Nombre, a.last_name AS Apellido
FROM actor AS a
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY Nombre, Apellido
HAVING COUNT(fa.actor_id) > 10
ORDER BY Nombre ASC; 

/* EJERCICIO 19: Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

- Usamos la cláusula WHERE para filtrar películas que cumplen dos condiciones:
		- rating = 'R': La clasificación de la película es "R".
        - length > 120: La duración de la película es superior a 120 minutos.
- El operador AND asegura que ambas condiciones se cumplan simultáneamente para que la película sea incluida en el resultado.
*/

SELECT title AS Títulos
FROM film
WHERE rating = 'R' AND length > 120;

/* EJERCICIO 20: Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.

- Usamos la función AVG() para calcular la duración promedio de las películas en esa categoría.
- Hacemos dos INNER JOIN:
	- Uno entre category con film_category, para unir el nombre de la categoría con su ID.
    - Otro entre film_category con la tabla film, para relacionar cada película con sus detalles, como la duración.
- Agrupamos con GROUP BY los resultados por categoría.
- Con HAVING filtramos los resultados por categorías cuyo promedio de duración supera los 120 minutos.
*/

SELECT c.name AS Nombre_categoría, AVG(f.length) AS Duración_media
FROM category AS c
INNER JOIN film_category AS fc ON c.category_id = fc.category_id
INNER JOIN film AS f ON fc.film_id = f.film_id
GROUP BY Nombre_categoría
HAVING AVG(f.length) > 120;

/* EJERCICIO 21: Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

-Utilizamos CONCAT para unir el nombre (first_name) y apellido (last_name) del actor 
- Con COUNT() contamos cuántas películas  ha realizado cada actor.
- Usamos un INNER JOIN para las tablas actor y film_actor,  para relacionar cada actor con las películas en las que ha actuado mediante actor_id.
- Con GROUP BY agrupamos los resultados por cada actor para poder contar sus apariciones en películas.
- Filtramos con HAVING para incluir solo aquellos actores que han actuado en al menos 5 películas.
- CON ORDER BY ordenamos el resultado alfabéticamente por el nombre completo del actor
*/

SELECT CONCAT(a.first_name, " ", a.last_name) AS Nombre_actor, COUNT(fa.film_id) AS Cantidad_películas
FROM actor AS a
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY Nombre_actor 
HAVING COUNT(fa.actor_id) >= 5
ORDER BY Nombre_actor ASC; 

/* EJERCICIO 22: Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.

-Realizamos primero una subconsulta para buscar primero todas los rental_id con duración superior a 5 dias.
*/ 

SELECT rental_id 
FROM rental
WHERE  return_date - rental_date > 5;

/* Ahora buscamos el título de esas películas haciendo un join con la tabla film, usando una subconsulta.
- Hacemos INNER JOIN entre:
	- film e inventory,  mediante film_id, para acceder al inventario de cada película.
	- inventory y rental,  mediante inventory_id, para relacionar el inventario de cada película con sus alquileres específicos.
- La claúsula WHERE r.rental_id IN (...) filtra la consulta para que solo incluya aquellos alquileres que corresponden a rental_id con duración mayor a cinco días, según la subconsulta inicial.
*/

SELECT  DISTINCT f.title AS Títulos 
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IN ( SELECT rental_id 
						FROM rental AS r
						WHERE  return_date - rental_date > 5);
                    
/* EJERCICIO 23:  Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

- Realizamos, en primer lugar, una subconsulta para identificar actores que han participado en películas de la categoría "Horror":
	- Concatenamos con CONCAT() nombre y apellidos de los actores para que nos los muestre en una columna.
    - Realizamos tres INNER JOIN: 
		- Entre actor y film_actor, para conectar actores con sus películas.
        - Entre film y film_category para acceder a la categoría de cada película.
        - Entre film_category  y category para filtrar por la categoría "Horror".ALTER
	- Filtramos con WHERE para restringir la búsqueda a la categoría "Horror".
*/

SELECT CONCAT(a.first_name, " ", a.last_name) AS Nombre_actor
FROM actor AS a
INNER JOIN film_actor AS fa ON  a.actor_id = fa.actor_id  /* conectamos los actores con las películas */ 
INNER JOIN film AS f ON fa.film_id = f.film_id /* para acceder a los detalles las películas */ 
INNER JOIN film_category AS fc ON f.film_id = fc.film_id /* conectamos los actores con las películas */ 
INNER JOIN category AS c ON fc.category_id = c.category_id /* para relacionar las películas con su categoría */ 
WHERE c.name = 'Horror'
ORDER BY Nombre_actor ASC; 

/* Ahora realizamos la consulta principal,  incluyendo nuestra subconsulta anterior para encontrar los nombres de los actores que no han actuado en ninguna pelicula de Horror:
- Volvemos a concatenar los nombres y apellidos de los actores con CONCAT() para que nos los devuelva en una sola columna.
- Con WHERE a.actor_id NOT IN (...) excluimos a los actores que están en la lista obtenida por la subconsulta (es decir, aquellos que han actuado en películas de horror).
 */
SELECT CONCAT(a.first_name, " ", a.last_name) AS Nombre_actor
FROM actor AS a
WHERE a.actor_id NOT IN (SELECT fa.actor_id 
						FROM film_actor AS fa 
						INNER JOIN film AS f ON fa.film_id = f.film_id /* para acceder a los detalles las películas */ 
						INNER JOIN film_category AS fc ON f.film_id = fc.film_id /* conectamos los actores con las películas */ 
						INNER JOIN category AS c ON fc.category_id = c.category_id /* para relacionar las películas con su categoría */ 
						WHERE c.name = 'Horror')
ORDER BY Nombre_Actor ASC;

SELECT fa.actor_id 
FROM film_actor AS fa 
INNER JOIN film AS f ON fa.film_id = f.film_id /* para acceder a los detalles las películas */ 
INNER JOIN film_category AS fc ON f.film_id = fc.film_id /* conectamos los actores con las películas */ 
INNER JOIN category AS c ON fc.category_id = c.category_id /* para relacionar las películas con su categoría */ 
WHERE c.name = 'Horror';

/* EJERCICIO 24.BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.

- Hacemos dos conexiones INNER JOIN: 
	- Una para conectar la tabla film con film_category, que actúa como una tabla intermedia. Esto permite relacionar cada película con su(s) categoría(s) asociadas.
	- Otra para conectar film_category con la tabla category, que contiene los nombres de las categorías. Esto permite filtrar las películas según el nombre de la categoría.
- Con la claúsla WHERE filtramos:
	- Por el nombre de categoria 'Comedy', asegurándonos de que solo se seleccionen las películas que pertenecen a esta categoría.
    - Y por la duración, estableciendo que la duración de las películas seleccionadas debe ser mayor de 180 min.
	- Con el operador AND aseguramos que ambas condiciones se cumplan simultáneamente
*/

SELECT f.title AS Título
FROM film AS f
INNER JOIN film_category AS fc ON f.film_id = fc.film_id /* para relacionar las películas con su categoría */ 
INNER JOIN category AS c ON fc.category_id = c.category_id /* para filtrar las categorias por nombre */ 
WHERE c.name = 'Comedy' AND f.length > 180;

/* EJERCICIO 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.

- Buscamos todas las películas donde haya actuado más de un actor. */

SELECT film_id, COUNT(actor_id)
FROM film_actor
GROUP BY film_id
HAVING COUNT(actor_id) > 1; 





