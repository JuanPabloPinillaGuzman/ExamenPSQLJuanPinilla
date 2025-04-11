--Consultas
--1
SELECT nombre, stock
FROM productos
WHERE stock < 5;

--2
SELECT 
    EXTRACT(MONTH FROM fecha) AS mes,
    EXTRACT(YEAR FROM fecha) AS año,
    SUM(rv.subtotal) AS ventas_totales
FROM ventas v
JOIN registro_venta rv ON v.id_ventas = rv.id_ventas
WHERE EXTRACT(MONTH FROM fecha) = 1 AND EXTRACT(YEAR FROM fecha) = 2025
GROUP BY EXTRACT(MONTH FROM fecha), EXTRACT(YEAR FROM fecha);

--3
SELECT 
    c.id_clientes,
    c.nombre,
    COUNT(v.id_ventas) AS total_compras,
    SUM(rv.subtotal) AS monto_total
FROM clientes c
JOIN ventas v ON c.id_clientes = v.id_clientes
JOIN registro_venta rv ON v.id_ventas = rv.id_ventas
GROUP BY c.id_clientes, c.nombre
ORDER BY total_compras DESC
LIMIT 1;
--4
SELECT 
    p.id_productos,
    p.nombre,
    SUM(rv.cantidad) AS cantidad_vendida,
    SUM(rv.subtotal) AS ingresos_totales
FROM productos p
JOIN registro_venta rv ON p.id_productos = rv.id_productos
GROUP BY p.id_productos, p.nombre
ORDER BY cantidad_vendida DESC
LIMIT 5;

--5
SELECT 
    v.id_ventas,
    v.fecha,
    c.nombre AS cliente,
    SUM(rv.subtotal) AS total_venta
FROM ventas v
JOIN clientes c ON v.id_clientes = c.id_clientes
JOIN registro_venta rv ON v.id_ventas = rv.id_ventas
WHERE v.fecha BETWEEN '2025-01-05' AND '2025-01-08'
GROUP BY v.id_ventas, v.fecha, c.nombre
ORDER BY v.fecha;

--6
SELECT 
    c.id_clientes,
    c.nombre,
    c.correo,
    c.telefono,
    MAX(v.fecha) AS ultima_compra
FROM clientes c
LEFT JOIN ventas v ON c.id_clientes = v.id_clientes
GROUP BY c.id_clientes, c.nombre, c.correo, c.telefono
HAVING MAX(v.fecha) < (CURRENT_DATE - INTERVAL '6 months')
   OR MAX(v.fecha) IS NULL
ORDER BY ultima_compra NULLS FIRST;