--Procedimientos y Funciones
--1 
CREATE OR REPLACE PROCEDURE registrar_venta(
    p_id_cliente INTEGER,
    p_id_producto INTEGER,
    p_cantidad INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock_actual INTEGER;
    v_precio_unitario NUMERIC(10,2);
    v_subtotal NUMERIC(10,2);
    v_cliente_existe BOOLEAN;
    v_id_venta INTEGER;
BEGIN
    -- Validar que el cliente exista
    SELECT EXISTS(SELECT 1 FROM clientes WHERE id_clientes = p_id_cliente) INTO v_cliente_existe;
    
    IF NOT v_cliente_existe THEN
        RAISE EXCEPTION 'El cliente con ID % no existe en la base de datos', p_id_cliente;
    END IF;
    
    -- Verificar stock disponible
    SELECT stock, precio INTO v_stock_actual, v_precio_unitario
    FROM productos
    WHERE id_productos = p_id_producto;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El producto con ID % no existe en la base de datos', p_id_producto;
    END IF;
    
    -- Verificar que el stock sea suficiente
    IF v_stock_actual < p_cantidad THEN
        RAISE NOTICE 'Stock insuficiente. Stock actual: %, Cantidad solicitada: %', v_stock_actual, p_cantidad;
        RAISE EXCEPTION 'No hay suficiente stock disponible para realizar la venta';
    END IF;
    
    -- Calcular subtotal
    v_subtotal := p_cantidad * v_precio_unitario;
    
    -- Crear una nueva venta
    INSERT INTO ventas (fecha, id_clientes)
    VALUES (CURRENT_TIMESTAMP, p_id_cliente)
    RETURNING id_ventas INTO v_id_venta;
    
    -- Registrar detalle de la venta
    INSERT INTO registro_venta (cantidad, subtotal, id_ventas, id_productos)
    VALUES (p_cantidad, v_subtotal, v_id_venta, p_id_producto);
    
    -- Actualizar el stock
    UPDATE productos
    SET stock = stock - p_cantidad
    WHERE id_productos = p_id_producto;
    
    COMMIT;
    
    RAISE NOTICE 'Venta registrada exitosamente con ID: %', v_id_venta;
    RAISE NOTICE 'Cliente: %, Producto: %, Cantidad: %, Subtotal: $%', 
                 p_id_cliente, p_id_producto, p_cantidad, v_subtotal;
END;
$$;

--2
CREATE OR REPLACE FUNCTION validar_cliente(p_id_cliente INTEGER)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_cliente_existe BOOLEAN;
BEGIN
    SELECT EXISTS(SELECT 1 FROM clientes WHERE id_clientes = p_id_cliente) INTO v_cliente_existe;
    
    IF NOT v_cliente_existe THEN
        RAISE EXCEPTION 'El cliente con ID % no existe en la base de datos', p_id_cliente;
    END IF;
    
    RETURN TRUE;
END;
$$;

--3
CREATE OR REPLACE FUNCTION verificar_stock(p_id_producto INTEGER, p_cantidad INTEGER)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock_actual INTEGER;
BEGIN
    -- Verificar stock disponible
    SELECT stock INTO v_stock_actual
    FROM productos
    WHERE id_productos = p_id_producto;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'El producto con ID % no existe en la base de datos', p_id_producto;
    END IF;
    
    -- Verificar que el stock sea suficiente
    IF v_stock_actual < p_cantidad THEN
        RETURN FALSE;
    END IF;
    
    RETURN TRUE;
END;
$$;

--4
CREATE OR REPLACE PROCEDURE notificar_stock_insuficiente(
    p_id_producto INTEGER,
    p_cantidad_solicitada INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock_actual INTEGER;
    v_nombre_producto VARCHAR(50);
BEGIN
    SELECT stock, nombre INTO v_stock_actual, v_nombre_producto
    FROM productos
    WHERE id_productos = p_id_producto;
    
    RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE 'NOTIFICACIÓN DE STOCK INSUFICIENTE';
    RAISE NOTICE 'Producto: % (ID: %)', v_nombre_producto, p_id_producto;
    RAISE NOTICE 'Stock disponible: %', v_stock_actual;
    RAISE NOTICE 'Cantidad solicitada: %', p_cantidad_solicitada;
    RAISE NOTICE 'Faltante: % unidades', p_cantidad_solicitada - v_stock_actual;
    RAISE NOTICE '----------------------------------------------';
    
    -- También se podría enviar esta notificación a un log o generar una alerta
END;
$$;

--5
CREATE OR REPLACE PROCEDURE realizar_registro_venta(
    p_id_cliente INTEGER,
    p_id_producto INTEGER,
    p_cantidad INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_precio_unitario NUMERIC(10,2);
    v_subtotal NUMERIC(10,2);
    v_id_venta INTEGER;
    v_nombre_cliente VARCHAR(50);
    v_nombre_producto VARCHAR(50);
BEGIN
    -- Obtener información del producto
    SELECT precio, nombre INTO v_precio_unitario, v_nombre_producto
    FROM productos
    WHERE id_productos = p_id_producto;
    
    -- Obtener información del cliente
    SELECT nombre INTO v_nombre_cliente
    FROM clientes
    WHERE id_clientes = p_id_cliente;
    
    -- Calcular subtotal
    v_subtotal := p_cantidad * v_precio_unitario;
    
    -- Crear una nueva venta
    INSERT INTO ventas (fecha, id_clientes)
    VALUES (CURRENT_TIMESTAMP, p_id_cliente)
    RETURNING id_ventas INTO v_id_venta;
    
    -- Registrar detalle de la venta
    INSERT INTO registro_venta (cantidad, subtotal, id_ventas, id_productos)
    VALUES (p_cantidad, v_subtotal, v_id_venta, p_id_producto);
    
    -- Actualizar el stock
    UPDATE productos
    SET stock = stock - p_cantidad
    WHERE id_productos = p_id_producto;
    
    COMMIT;
    
    RAISE NOTICE '----------------------------------------------';
    RAISE NOTICE 'VENTA REGISTRADA EXITOSAMENTE';
    RAISE NOTICE 'ID de venta: %', v_id_venta;
    RAISE NOTICE 'Cliente: % (ID: %)', v_nombre_cliente, p_id_cliente;
    RAISE NOTICE 'Producto: % (ID: %)', v_nombre_producto, p_id_producto;
    RAISE NOTICE 'Cantidad: %', p_cantidad;
    RAISE NOTICE 'Subtotal: $%.2f', v_subtotal;
    RAISE NOTICE 'Fecha: %', CURRENT_TIMESTAMP;
    RAISE NOTICE '----------------------------------------------';
END;
$$;