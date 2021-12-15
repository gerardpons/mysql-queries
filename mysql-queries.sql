-- BASE DE DADES TIENDA

USE tienda;

SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, CONCAT(precio,' €') AS precio_eur, CONCAT('$ ',(CAST(precio*1.13 AS DECIMAL(7,2)))) AS precio_usd FROM producto;
SELECT nombre AS 'nom de producto', CONCAT(precio,' €') AS euros, CONCAT('$ ',(CAST(precio*1.13 AS DECIMAL(7,2)))) AS 'dòlars nord-americans' FROM producto;
SELECT UPPER(nombre) AS nombre, precio FROM producto;
SELECT LOWER(nombre) AS nombre, precio FROM producto;
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante;
SELECT nombre, ROUND(precio) FROM producto;
SELECT nombre, cast(precio AS DECIMAL(3,0)) FROM producto;
SELECT codigo_fabricante FROM producto;
SELECT DISTINCT(codigo_fabricante) FROM producto;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 3,2;
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC;
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto, fabricante;
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio ASC LIMIT 1;
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio DESC LIMIT 1;
SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo';
SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;
SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard'OR fabricante.nombre = 'Seagate';
SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre REGEXP 'e$';
SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre REGEXP 'w';
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;
SELECT DISTINCT(f.codigo), f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo;
SELECT f.nombre, p.nombre FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante = f.codigo;
SELECT f.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.codigo_fabricante IS NULL;
SELECT p.nombre FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';
SELECT * FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio = (SELECT MAX(p.precio) FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');
SELECT p.nombre, MAX(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';
SELECT p.nombre, MIN(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Hewlett-Packard';
SELECT * FROM producto p WHERE p.precio >= (SELECT MAX(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' AND p.precio > (SELECT AVG(p.precio) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus');


-- BASE DE DADES UNIVERSIDAD

USE universidad;

SELECT apellido1, apellido2, nombre FROM persona p WHERE tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
SELECT nombre, apellido1, apellido2 FROM persona p WHERE tipo = 'alumno' AND telefono IS NULL;
SELECT nombre, apellido1, apellido2 FROM persona p WHERE tipo = 'alumno' AND fecha_nacimiento REGEXP '1999';
SELECT nombre, apellido1, apellido2 FROM persona p WHERE tipo ='profesor' AND telefono IS NULL AND nif REGEXP 'K$';
SELECT nombre FROM asignatura WHERE id_grado = 7 AND curso = 3 AND cuatrimestre = 1;
SELECT pa.apellido1, pa.apellido2, pa.nombre, dp.nombre FROM persona pa JOIN profesor pr ON pa.id = pr.id_profesor JOIN departamento dp ON pr.id_departamento = dp.id ORDER BY pa.apellido1 ASC, pa.apellido2 ASC, pa.nombre ASC;
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM alumno_se_matricula_asignatura asma JOIN persona pa ON asma.id_alumno = pa.id JOIN curso_escolar ce ON asma.id_curso_escolar = ce.id JOIN asignatura a ON asma.id_asignatura = a.id WHERE pa.nif = '26902806M';
SELECT DISTINCT(d.nombre) FROM departamento d JOIN profesor pr ON pr.id_departamento = d.id JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id_grado = 4;
SELECT DISTINCT(pa.nombre) FROM persona pa JOIN alumno_se_matricula_asignatura asma ON pa.id = asma.id_alumno JOIN curso_escolar ce ON ce.id = asma.id_curso_escolar JOIN asignatura a ON a.id = asma.id_asignatura WHERE ce.id = 5;

-- Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

SELECT dp.nombre, pa.apellido1, pa.apellido2, pa.nombre FROM departamento dp LEFT JOIN profesor pr ON dp.id = pr.id_departamento LEFT JOIN persona pa ON pr.id_profesor = pa.id ORDER BY dp.nombre ASC, pa.apellido1 ASC, pa.apellido2 ASC, pa.nombre ASC;
SELECT * FROM profesor p WHERE p.id_departamento IS NULL;
SELECT * FROM departamento dp LEFT JOIN profesor pr ON dp.id = pr.id_departamento WHERE id_profesor IS NULL;
SELECT p.id_profesor FROM profesor p LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;
SELECT a.nombre FROM asignatura a LEFT JOIN profesor p ON a.id_profesor = p.id_profesor WHERE a.id_profesor IS NULL;
SELECT DISTINCT dp.nombre FROM departamento dp LEFT JOIN profesor pr ON dp.id = pr.id_departamento LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor LEFT JOIN alumno_se_matricula_asignatura asma ON a.id = asma.id_asignatura WHERE a.id IS NULL;

-- Consultes resum:

SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento REGEXP '^1999';
SELECT COUNT(*) FROM departamento dp JOIN profesor pf ON dp.id = pf.id_departamento;
SELECT dp.nombre, COUNT(*) FROM departamento dp LEFT JOIN profesor pf ON dp.id = pf.id_departamento GROUP BY dp.nombre;
SELECT g.nombre, COUNT(*) FROM asignatura a LEFT JOIN grado g ON a.id_grado = g.id GROUP BY g.nombre ORDER BY COUNT(*);
SELECT g.nombre, COUNT(*) FROM asignatura a LEFT JOIN grado g ON a.id_grado = g.id GROUP BY g.nombre ORDER BY COUNT(*) DESC LIMIT 1;
SELECT g.nombre, a.tipo, COUNT(a.creditos) FROM asignatura a LEFT JOIN grado g ON a.id_grado = g.id GROUP BY a.nombre;
SELECT ce.anyo_inicio, COUNT(asma.id_alumno) FROM curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura asma ON ce.id = asma.id_curso_escolar GROUP BY ce.anyo_inicio;
SELECT pa.id, pa.nombre, pa.apellido1, pa.apellido2, COUNT(a.id) FROM profesor pf LEFT JOIN persona pa ON pf.id_profesor = pa.id LEFT JOIN asignatura a ON a.id_profesor = pf.id_profesor GROUP BY pa.id ORDER BY COUNT(a.id);
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');
SELECT * FROM asignatura a LEFT JOIN profesor pf ON pf.id_profesor = a.id_profesor WHERE id_departamento IS NOT NULL AND a.id_profesor IS NULL;