DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

select pr.nombre 'Producto nombre', fab.nombre 'Fabricante nombre' from producto pr, fabricante fab 
where pr.codigo_fabricante = fab.codigo;

#1. Lista el nombre de todos los productos que hay en la tabla producto.
select nombre from producto;

#2. Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre, precio from producto;

#3. Lista todas las columnas de la tabla producto.
select * from producto;

/*4. Lista los nombres y los precios de todos los productos de la tabla producto,
redondeando el valor del precio.*/
select nombre, round(precio) from producto;

#5. Lista el código de los fabricantes que tienen productos en la tabla producto.
select fab.codigo from fabricante fab
inner join producto on fab.codigo = producto.codigo_fabricante;

/*10. Lista el código de los fabricantes que tienen productos en la tabla producto, sin
mostrar los repetidos.*/
select distinct fab.codigo from fabricante fab
inner join producto pr on fab.codigo = pr.codigo_fabricante;

#11. Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from fabricante order by nombre asc;

/*12. Lista los nombres de los productos ordenados en primer lugar por el nombre de
forma ascendente y en segundo lugar por el precio de forma descendente.*/
select nombre, precio from producto order by nombre asc, precio desc;

#13. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select * from fabricante limit 5;

/*14. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
ORDER BY y LIMIT)*/
select nombre, precio from producto order by precio asc limit 1;

/*15. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas
ORDER BY y LIMIT)*/
select nombre, precio from producto order by precio desc limit 1;

#16. Lista el nombre de los productos que tienen un precio menor o igual a $120.
select nombre from producto where precio <= 120;

/*17. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el
operador BETWEEN.*/
select * from producto where precio between 60 and 200;

/*18. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el
operador IN.*/
select * from producto where codigo_fabricante in (1, 3, 5); 

/*23. Devuelve una lista con el nombre de todos los productos que contienen la cadena
Portátil en el nombre.*/
select nombre from producto where nombre like '%Portátil%';

/*1. Devuelve una lista con el código del producto, nombre del producto, código del
fabricante y nombre del fabricante, de todos los productos de la base de datos.*/
select pr.codigo 'Código producto', pr.nombre 'Nombre producto',
 fab.codigo 'Código fabricante', fab.nombre 'Nombre fabricante'
 from producto pr , fabricante fab 
 where pr.codigo_fabricante = fab.codigo;
select pr.codigo 'Código producto', pr.nombre 'Nombre producto',
 fab.codigo 'Código fabricante', fab.nombre 'Nombre fabricante'
 from producto pr inner join fabricante fab 
 on pr.codigo_fabricante = fab.codigo;
 
/*2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de
todos los productos de la base de datos. Ordene el resultado por el nombre del
fabricante, por orden alfabético.*/
select p.nombre'Nombre producto', p.precio'Precio producto',
 f.nombre'Nombre fabricante' 
 from producto p, fabricante f
 where p.codigo_fabricante = f.codigo
 order by f.nombre asc;
 
/*3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del
producto más barato.*/
select p.nombre'Nombre Producto', p.precio'Precio Producto',
f.nombre'Nombre Fabricante'
from producto p, fabricante f
where p.codigo_fabricante = f.codigo
order by p.precio asc
limit 1;

select p.nombre'Nombre Producto', p.precio'Precio Producto',
f.nombre'Nombre Fabricante'
from producto p, fabricante f
where p.codigo_fabricante = f.codigo
and p.precio = (select min(p.precio) from producto p);

#4. Devuelve una lista de todos los productos del fabricante Lenovo.
select p.*, f.nombre from producto p
 inner join fabricante f
 on p.codigo_fabricante = f.codigo
 and f.nombre = 'Lenovo';
 
 /*5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un
precio mayor que $200.*/
select * from producto 
 where codigo_fabricante =(select codigo from fabricante 
 where nombre = 'Crucial')
 and precio > 200; 
 
/*6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-
Packard. Utilizando el operador IN.*/
select * from producto 
 where codigo_fabricante 
 in ((select codigo from fabricante where nombre = 'Asus'),
 (select codigo from fabricante where nombre = 'Hewlett-Packard')); 
select p.* from producto p, fabricante f
 where p.codigo_fabricante = f.codigo
 and f.nombre in('Asus','Hewlett-Packard');
 
/*7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de
todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado
en primer lugar por el precio (en orden descendente) y en segundo lugar por el
nombre (en orden ascendente)*/
select p.nombre'Nombre prod', p.precio'Precio prod',
 f.nombre'Nombre fab' 
 from producto p, fabricante f
 where p.codigo_fabricante = f.codigo
 and p.precio >= 180
 order by p.precio desc,
 p.nombre asc;
 
 /*1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto
con los productos que tiene cada uno de ellos. El listado deberá mostrar también
aquellos fabricantes que no tienen productos asociados.*/
select f.*, p.* from fabricante f left join producto p
on f.codigo = p.codigo_fabricante;

/*2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen
ningún producto asociado.*/
select * from fabricante 
where codigo not in(select f.codigo from fabricante f 
right join producto p
on f.codigo = p.codigo_fabricante);

#1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto 
 where codigo_fabricante = (select codigo from fabricante 
 where nombre = 'Lenovo');
select p.*, f.nombre'Nombre Fabricante' from producto p, fabricante f
 where p.codigo_fabricante = f.codigo
 and f.nombre = 'Lenovo';
 
/*2. Devuelve todos los datos de los productos que tienen el mismo precio que el
producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
select * from producto 
 where precio = (select max(p.precio) from producto p, fabricante f
 where p.codigo_fabricante = f.codigo
 and f.nombre = 'Lenovo');
 
 #3. Lista el nombre del producto más caro del fabricante Lenovo.
 select nombre from producto 
 where precio = (select max(p.precio) from producto p, fabricante f
 where p.codigo_fabricante = f.codigo
 and f.nombre = 'Lenovo');
 
/*4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio
medio de todos sus productos.*/
select p.*, f.nombre from producto p, fabricante f
 where p.codigo_fabricante = f.codigo
 and p.precio > (select avg(p.precio) from producto p, fabricante f
 where p.codigo_fabricante = f.codigo
 and f.nombre = 'Asus')
 and f.nombre = 'Asus';
 
/*1. Devuelve los nombres de los fabricantes que tienen productos asociados.
(Utilizando IN o NOT IN).*/
select distinct nombre from fabricante
 where codigo in (select f.codigo from fabricante f,
 producto p where f.codigo = p.codigo_fabricante);
 
/*2. Devuelve los nombres de los fabricantes que no tienen productos asociados.
(Utilizando IN o NOT IN).*/ 
select nombre from fabricante
 where codigo not in (select f.codigo from fabricante f,
 producto p where f.codigo = p.codigo_fabricante);
 
/*1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo
número de productos que el fabricante Lenovo.*/
 select count(p.codigo), f.nombre from fabricante f, producto p
  where f.codigo = p.codigo_fabricante
  group by f.nombre
  having count(p.codigo) = (select count(p.codigo) from producto p, fabricante f
  where p.codigo_fabricante = f.codigo
  and f.nombre = 'Lenovo');
