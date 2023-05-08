--distinct

-- Se quiere saber a qué paises se les vende usar la tabla de clientes
SELECT DISTINCT country FROM customers;

-- Se quiere saber a qué ciudades se les vende usar la tabla de clientes
SELECT DISTINCT city FROM customers;

-- Se quiere saber a qué ciudades se les ha enviado una orden
SELECT DISTINCT ship_city FROM orders;

--Se quiere saber a qué ciudades se les vende en el pais USA usar la tabla de clientes
SELECT city FROM customers WHERE country = 'USA';


--Agrupacion

-- Se quiere saber a qué paises se les vende usar la tabla de clientes nota hacerla usando group by
SELECT country FROM customers GROUP BY country;

--Cuantos clientes hay por pais
SELECT COUNT(*) FROM customers GROUP BY country;

--Cuantos clientes hay por ciudad en el pais USA
SELECT COUNT(*) FROM customers WHERE country='USA' GROUP BY city;

--Cuantos productos hay por proveedor de la categoria 1
SELECT COUNT(*) FROM products WHERE category_id = 1 GROUP BY supplier_id;


--Filtro con having

-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos
SELECT supplier_id,COUNT(product_id) AS producto FROM products GROUP BY supplier_id HAVING COUNT(product_id) > 1;

-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos, pero únicamente de la categoria 1
SELECT supplier_id,COUNT(product_id) AS producto FROM products WHERE category_id = 1 GROUP BY supplier_id HAVING COUNT(product_id) > 1;

--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES USA, CANADA, SPAIN (ShipCountry) MOSTRAR UNICAMENTE LOS EMPLEADOS CUYO CONTADOR DE ORDENES SEA MAYOR A 20
SELECT employee_id, COUNT(order_id) as pedido FROM orders WHERE ship_country IN('USA','CANADA','SPAIN') GROUP BY employee_id HAVING COUNT(order_id) >20;

--OBTENER EL PRECIO PROMEDIO DE LOS PRODUCTOS POR PROVEEDOR UNICAMENTE DE AQUELLOS CUYO PROMEDIO SEA MAYOR A 20
SELECT supplier_id, AVG(unit_price) FROM products GROUP BY supplier_id HAVING AVG(unit_price) >20;

--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16 DICIONALMENTE CUYA SUMA POR CATEGORIA SEA MAYOR A 300
SELECT category_id,SUM(units_in_stock) FROM products WHERE supplier_id IN(17,19,16) GROUP BY category_id HAVING SUM(units_in_stock) > 300;

--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES (ShipCountry) SA, CANADA, SPAIN cuYO CONTADOR SEA MAYOR A 25
SELECT COUNT(order_id),employee_id FROM orders WHERE ship_country IN('SA','CANADA','SPAIN') GROUP BY employee_id HAVING COUNT(order_id) > 25;

--OBTENER LAS VENTAS (Quantity * UnitPrice) AGRUPADAS POR PRODUCTO (Orders details) Y CUYA SUMA DE VENTAS SEA MAYOR A 50.000
SELECT SUM(quantity*unit_price),product_id FROM order_details GROUP BY product_id HAVING SUM(quantity*unit_price) > 50000;


--Mas de una tabla 

--OBTENER EL NUMERO DE ORDEN, EL ID EMPLEADO, NOMBRE Y APELLIDO DE LAS TABLAS DE ORDENES Y EMPLEADOS
SELECT order_id, em.employee_id,first_name,last_name FROM orders AS os INNER JOIN employees AS em ON os.employee_id = em.employee_id;

--OBTENER EL PRODUCTID, PRODUCTNAME, SUPPLIERID, COMPANYNAME DE LAS TABLAS DE PRODUCTOS Y PROVEEDORES (SUPPLIERS)
SELECT product_id,product_name,su.company_name FROM products AS pr INNER JOIN suppliers AS su ON pr.supplier_id = su.supplier_id;

--OBTENER LOS DATOS DEL DETALLE DE ORDENES CON EL NOMBRE DEL PRODUCTO DE LAS TABLAS DE DETALLE DE ORDENES Y DE PRODUCTOS
SELECT *,pr.product_name FROM order_details AS oa INNER JOIN products AS pr ON oa.product_id = pr.product_id;

--OBTENER DE LAS ORDENES EL ID, SHIPPERID, NOMBRE DE LA COMPAÑÍA DE ENVIO (SHIPPERS)
SELECT order_id, sh.company_name FROM orders AS os INNER JOIN shippers AS sh ON os.ship_via = sh.shipper_id;

--Obtener el número de orden, país de envío (shipCountry) y el nombre del empleado de la tabla ordenes y empleados Queremos que salga el Nombre y Apellido del Empleado en una sola columna.
SELECT order_id,ship_country,first_name FROM orders AS os INNER JOIN employees AS em ON os.employee_id = em.employee_id;


--Combinando la mayoría de conceptos

--CONTAR EL NUMERO DE ORDENES POR EMPLEADO OBTENIENDO EL ID EMPLEADO Y EL NOMBRE COMPLETO DE LAS TABLAS DE ORDENES Y DE EMPLEADOS join y group by / columna calculada
SELECT COUNT(order_id),first_name,last_name FROM orders AS os INNER JOIN employees AS em ON os.employee_id = em.employee_id GROUP BY em.employee_id;

--OBTENER LA SUMA DE LA CANTIDAD VENDIDA Y EL PRECIO PROMEDIO POR NOMBRE DE PRODUCTO DE LA TABLA DE ORDERS DETAILS Y PRODUCTS
SELECT SUM(quantity), AVG(od.unit_price),product_name FROM order_details AS od INNER JOIN products AS pr ON od.product_id = pr.product_id GROUP BY pr.product_name;

--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR CLIENTE DE LAS TABLAS ORDER DETAILS, ORDERS
SELECT COUNT(unit_price*quantity),customer_id FROM order_details AS od INNER JOIN orders AS os ON od.order_id = os.order_id GROUP BY customer_id;

--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR EMPLEADO MOSTRANDO EL APELLIDO (LASTNAME)DE LAS TABLAS EMPLEADOS, ORDENES, DETALLE DE ORDENES
SELECT COUNT(unit_price*quantity),em.employee_id,last_name FROM order_details AS od INNER JOIN orders AS os ON od.order_id = os.order_id INNER JOIN employees AS em ON os.employee_id = em.employee_id GROUP BY em.employee_id;
