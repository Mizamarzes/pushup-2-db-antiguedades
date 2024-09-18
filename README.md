# Reto Base de datos Antiguedades - Juan Diego Contreras J3 - Push Up 

------------------------------------

#### DDL.sql Comandos de creacion de tablas Y DML.sql Comandos de Inserción de datos

## Modelo Conceptual

## ![conceptual_pushup_2_db_antiguedades](C:\Users\Mizamarzes\Downloads\conceptual_pushup_2_db_antiguedades.jpeg)

## Modelo Logico

![logico_pushup_2_db_antiguedades](C:\Users\Mizamarzes\Downloads\logico_pushup_2_db_antiguedades.png)

## Modelo Relacional

![relacional_pushup_2_antiguedades_db](C:\Users\Mizamarzes\Downloads\relacional_pushup_2_antiguedades_db.png)

## Consultas para la Base de Datos del Negocio de Antigüedades

1. Consulta para listar todas las antigüedades disponibles para la venta:

   - "Obtén una lista de todas las piezas antiguas que están actualmente disponibles para la
     venta, incluyendo el nombre de la pieza, su categoría, precio y estado de conservación."

   ```sql
   SELECT
   	a.nombre AS antiguedad,
   	c.nombre AS categoria,
       a.precio,
       ec.nombre AS estado_conservacion,
       a.estado
   FROM antiguedad AS a
   INNER JOIN categoria AS c ON c.id = a.categoria_id
   INNER JOIN estado_conservacion AS ec ON ec.id = a.estado_conservacion_id
   WHERE estado = "En venta";
   
   +-----------------+-----------+----------+---------------------+----------+
   | antiguedad      | categoria | precio   | estado_conservacion | estado   |
   +-----------------+-----------+----------+---------------------+----------+
   | Mesa de Roble   | Muebles   |  5000.00 | Bueno               | En venta |
   | Pintura de Goya | Pinturas  | 12000.00 | Restaurado          | En venta |
   | Anillo de Oro   | Joyería   |  8000.00 | Regular             | En venta |
   +-----------------+-----------+----------+---------------------+----------+
   ```

2. Consulta para buscar antigüedades por categoría y rango de precio:

   - "Busca todas las antigüedades dentro de una categoría específica (por ejemplo, 'Muebles')
     que tengan un precio dentro de un rango determinado (por ejemplo, entre 500 y 2000
     dólares)."

   ```sql
   SELECT
   	a.nombre AS antiguedad,
   	c.nombre AS categoria,
       a.precio,
       ec.nombre AS estado_conservacion,
       a.estado
   FROM antiguedad AS a
   INNER JOIN categoria AS c ON c.id = a.categoria_id
   INNER JOIN estado_conservacion AS ec ON ec.id = a.estado_conservacion_id
   WHERE 
   	c.nombre = "muebles" AND 
       a.estado = "En venta"  AND
   	a.precio >= 5000 AND a.precio <= 10000;
   	
   +---------------+-----------+---------+---------------------+----------+
   | antiguedad    | categoria | precio  | estado_conservacion | estado   |
   +---------------+-----------+---------+---------------------+----------+
   | Mesa de Roble | Muebles   | 5000.00 | Bueno               | En venta |
   +---------------+-----------+---------+---------------------+----------+
   ```

3. Consulta para mostrar el historial de ventas de un cliente específico:

   - "Muestra todas las piezas antiguas que un cliente específico ha vendido, incluyendo la fecha
     de la venta, el precio de venta y el comprador."

   ```sql
   SELECT
   	vendedor.nombre AS vendedor,
       t.fecha,
       comprador.nombre AS comprador,
       p.dinero AS precio_venta,
       ant.nombre AS antiguedad
   FROM transaccion AS t
   INNER JOIN usuario AS vendedor ON vendedor.id = t.vendedor_id 
   INNER JOIN usuario AS comprador ON comprador.id = t.comprador_id
   INNER JOIN antiguedad AS ant ON ant.id = t.antiguedad_id
   INNER JOIN pago AS p ON p.transaccion_id = t.id
   WHERE t.vendedor_id = 2;
   
   +-------------+------------+----------------+--------------+-----------------+
   | vendedor    | fecha      | comprador      | precio_venta | antiguedad      |
   +-------------+------------+----------------+--------------+-----------------+
   | María López | 2024-09-15 | Juan Contreras |      5000.00 | Mesa de Roble   |
   | María López | 2024-09-16 | Carlos Pérez   |     12000.00 | Pintura de Goya |
   +-------------+------------+----------------+--------------+-----------------+
   ```

4. Consulta para obtener el total de ventas realizadas en un periodo de tiempo:

   - "Calcula el total de ventas realizadas en un período específico, por ejemplo, durante el último
     mes."

   ```sql
   SELECT 
   	COUNT(t.id) AS total_ventas
   FROM transaccion AS t
   WHERE t.fecha BETWEEN '2024-09-15' AND '2024-10-01';
   ```

5. Consulta para encontrar los clientes más activos (con más compras realizadas):

   - "Identifica los clientes que han realizado la mayor cantidad de compras en la plataforma."

   ```sql
   SELECT 
       u.nombre AS comprador,
       COUNT(t.id) AS total_compras
   FROM transaccion AS t
   INNER JOIN usuario AS u ON u.id = t.comprador_id
   GROUP BY u.id, u.nombre
   ORDER BY total_compras DESC;
   
   +----------------+---------------+
   | comprador      | total_compras |
   +----------------+---------------+
   | Juan Contreras |             2 |
   | Carlos Pérez   |             1 |
   +----------------+---------------
   ```

6. Consulta para listar las antigüedades más populares por número de visitas o consultas:

   - "Muestra las piezas antiguas que han recibido la mayor cantidad de visitas o consultas por
     parte de los usuarios.

   ```sql
   SELECT 
       ant.nombre AS antiguedad,
       COUNT(t.id) AS numero_transacciones
   FROM transaccion AS t
   INNER JOIN antiguedad AS ant ON ant.id = t.antiguedad_id
   GROUP BY ant.id, ant.nombre
   ORDER BY numero_transacciones DESC;
   
   +-----------------+----------------------+
   | antiguedad      | numero_transacciones |
   +-----------------+----------------------+
   | Mesa de Roble   |                    1 |
   | Pintura de Goya |                    1 |
   | Anillo de Oro   |                    1 |
   +-----------------+----------------------+
   ```

7. Consulta para listar las antigüedades vendidas en un rango de fechas específico:

   - "Obtén una lista de todas las piezas antiguas que se han vendido dentro de un rango de
     fechas específico, incluyendo la información del vendedor y comprador."

   ```sql
   SELECT
   	ant.nombre AS antiguedad,
   	vendedor.nombre AS vendedor,
       comprador.nombre AS comprador,
   	t.fecha,
       p.dinero AS precio_venta
   FROM transaccion AS t
   INNER JOIN usuario AS vendedor ON vendedor.id = t.vendedor_id 
   INNER JOIN usuario AS comprador ON comprador.id = t.comprador_id
   INNER JOIN antiguedad AS ant ON ant.id = t.antiguedad_id
   INNER JOIN pago AS p ON p.transaccion_id = t.id
   WHERE t.fecha BETWEEN '2024-09-15' AND '2024-10-01';
   
   +-----------------+--------------+----------------+------------+--------------+
   | antiguedad      | vendedor     | comprador      | fecha      | precio_venta |
   +-----------------+--------------+----------------+------------+--------------+
   | Mesa de Roble   | María López  | Juan Contreras | 2024-09-15 |      5000.00 |
   | Pintura de Goya | María López  | Carlos Pérez   | 2024-09-16 |     12000.00 |
   | Anillo de Oro   | Carlos Pérez | Juan Contreras | 2024-09-16 |      8000.00 |
   +-----------------+--------------+----------------+------------+--------------+
   ```

8. Consulta para obtener un informe de inventario actual:

   - "Genera un informe del inventario actual de antigüedades disponibles para la venta,
     mostrando la cantidad de artículos por categoría."

   ```sql
   SELECT
       cat.nombre AS categoria,
       SUM(i.cantidad) AS total_cantidad
   FROM inventario AS i
   INNER JOIN antiguedad AS ant ON ant.id = i.antiguedad_id
   INNER JOIN categoria AS cat ON cat.id = ant.categoria_id
   GROUP BY cat.nombre
   ORDER BY total_cantidad DESC;
   
   +-----------+----------------+
   | categoria | total_cantidad |
   +-----------+----------------+
   | Muebles   |              5 |
   | Pinturas  |              2 |
   | Joyería   |              1 |
   +-----------+----------------+
   ```

   

​	



