# TechZone - Sistema de Gestión de Ventas con PostgreSQL

## Descripción del Proyecto

**TechZone** es un sistema de gestión de productos, ventas, clientes y proveedores diseñado para una tienda de tecnología. Su propósito es organizar la información comercial y automatizar el proceso de venta, permitiendo controlar inventario, registrar ventas, consultar datos clave del negocio y validar operaciones mediante procedimientos almacenados en PostgreSQL.

Este proyecto incluye:
- Estructura de base de datos relacional con integridad referencial.
- Inserciones de datos realistas.
- Consultas SQL para análisis y reportes.
- Un procedimiento almacenado para registrar ventas con validaciones de stock y cliente.

---

## Requisitos

- PostgreSQL instalado (versión 12 o superior recomendada)
- Herramienta cliente como **pgAdmin**, **psql** o **DBeaver**

---

## 🚀 Instrucciones de uso

### 1. Crear la base de datos e importar tablas

```bash
psql -U tu_usuario -f db.sql
