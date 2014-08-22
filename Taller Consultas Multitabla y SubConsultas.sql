
-- 10 Muestre una lista con nombre de ciudad y cantidad de afiliaciones por cada una
SELECT C.NOMBRE, COUNT(*) AS CANTIDAD 
FROM CIUDADES C JOIN AFILIACIONES ON CIUDAD = C.COD_CIUDAD
GROUP BY C.NOMBRE ORDER BY C.NOMBRE;

-- 11 Muestre la cantidad de veces que se ha consumido el producto de nombre: VODKA
SELECT NOMBRE, SUM(CONSUMOS.CANTIDAD) AS CONSUMOS
FROM CONSUMOS JOIN PRODUCTOS ON CODIGO = COD_PRODUCTO
WHERE NOMBRE = 'VODKA' 
GROUP BY NOMBRE;

-- 12 Muestre la cantidad de veces que se ha consumido productos tipo PASABOCAS
SELECT TP.NOMBRE, COUNT(*) AS CONSUMOS
FROM PRODUCTOS P 
	JOIN TIPOS_PRODUCTO TP ON P.TIPO = TP.CODIGO
	JOIN CONSUMOS C ON C.COD_PRODUCTO = P.CODIGO
WHERE TP.NOMBRE = 'PASABOCAS'
GROUP BY TP.NOMBRE;

-- 13 Muestre los nombres de los deportes practicados por el socio JUAN MIGUEL
SELECT DISTINCT D.NOMBRE
FROM SOCIOS S 
	JOIN DEPORTES_SOCIOS DS ON S.IDENTIFICACIÓN = DS.ID_SOCIO
	JOIN DEPORTES D ON DS.COD_DEPORTE = D.CODIGO
WHERE S.NOMBRES = 'JUAN MIGUEL';

-- 14 Muestre la suma de todos los consumos realizados
SELECT SUM(CANTIDAD) CONSUMOS FROM CONSUMOS;

-- 15 Consulte las afiliaciones hechas en diciembre de 2010
SELECT * 
FROM AFILIACIONES 
WHERE FECHA_AFILIACIÓN BETWEEN TO_DATE('2010-12-01', 'yyyy-mm-dd') AND TO_DATE('2010-12-31', 'yyyy-mm-dd');

-- 16 Consulte el promedio del valor de los consumos de las visitas del 6 de Junio de 2010
SELECT SUM(C.CANTIDAD * P.PRECIO) AS SUMA
FROM VISITAS V 
	JOIN CONSUMOS C ON V.CONS_VISITA = C.CONS_VISITA
	JOIN PRODUCTOS P ON P.CODIGO = C.COD_PRODUCTO
WHERE V.FECHA_HORA_INGRESO = TO_DATE('2010-06-06', 'yyyy-mm-dd');

SELECT AVG(SUMA) AS PROMEDIO_CONSUMOS FROM (
	SELECT SUM(C.CANTIDAD * P.PRECIO) AS SUMA
	FROM VISITAS V 
		JOIN CONSUMOS C ON V.CONS_VISITA = C.CONS_VISITA
		JOIN PRODUCTOS P ON P.CODIGO = C.COD_PRODUCTO
	WHERE V.FECHA_HORA_INGRESO = TO_DATE('2010-06-06', 'yyyy-mm-dd')
);

-- 17 Muestre los nombres y apellidos de los socios en solo una columna con un espacio de separación
SELECT NOMBRES || ' ' || APELLIDOS AS NOMBRE_Y_APELLIDO FROM SOCIOS;

-- 18 Muestre el nombre del producto(s) mas consumido(s)
SELECT P.NOMBRE, SUM(C.CANTIDAD) AS CONSUMOS
FROM PRODUCTOS P JOIN CONSUMOS C ON C.COD_PRODUCTO = P.CODIGO
GROUP BY P.NOMBRE
ORDER BY 2 DESC;

SELECT * FROM (
	SELECT P.NOMBRE, SUM(C.CANTIDAD) AS CONSUMOS
	FROM PRODUCTOS P JOIN CONSUMOS C ON C.COD_PRODUCTO = P.CODIGO
	GROUP BY P.NOMBRE
	ORDER BY 2 DESC
) WHERE rownum <= 1;

-- 19 Muestre el nombre de todos los acompañantes que ingresaron en Septiembre 07 de 2009
SELECT AV.NOMBRES FROM ACOMPAÑANTES_VISITA AV JOIN VISITAS V ON AV.CONS_VISITA = V.CONS_VISITA
WHERE V.FECHA_HORA_INGRESO = TO_DATE('2009-09-07', 'yyyy-mm-dd');

-- 20 Muestre nombres y a pellidos del socio que hizo la visita mas duradera
SELECT S.NOMBRES || ' ' || S.APELLIDOS AS NOMBRE_Y_APELLIDO 
FROM SOCIOS S JOIN VISITAS V ON S.IDENTIFICACIÓN = V.ID_SOCIO
ORDER BY (V.FECHA_HORA_SALIDA - V.FECHA_HORA_INGRESO) DESC; 

SELECT * FROM (
	SELECT S.NOMBRES || ' ' || S.APELLIDOS AS NOMBRE_Y_APELLIDO 
	FROM SOCIOS S JOIN VISITAS V ON S.IDENTIFICACIÓN = V.ID_SOCIO
	ORDER BY (V.FECHA_HORA_SALIDA - V.FECHA_HORA_INGRESO) DESC
) WHERE rownum <= 1;

-- 21 Muestre el nombr de la afiliación mas reciente
SELECT NOMBRE FROM AFILIACIONES
ORDER BY FECHA_AFILIACIÓN DESC;

SELECT * FROM (
	SELECT NOMBRE FROM AFILIACIONES
	ORDER BY FECHA_AFILIACIÓN DESC
) WHERE rownum <= 1;

-- 22 Muestre los datos de las visitas con un consumo superior a 100000

-- 23 Consulte el promedio de duración de todas las visitas

-- 24 Consulte la cantidad de socios registrados

-- 25 Liste los socios con nombre iniciado en M que hayan consumido aoguna vez el producto ALMURZO

-- 26 Muestre todos los datos de los socios con mas de 10 caracteres en sus apellidos

-- 27 Borre los productos tipo ALQUILER

-- 28 Haga una lista que muestre la cantidad de deportes que practica cada socio. La lista se debe ordenar alfabeticamente por nombre de socio

-- 29 Diga cuantas ciudades hay registradas en la base de datos

-- 30 Realizar unaconsulta para un reporte de consumos que muestre:
--    Nombre de la Afiliación, Nombre del Socio,Fecha de la Visita, Cantidad, Nombre de Producto, Tipo de Producto y Precio del Consumo