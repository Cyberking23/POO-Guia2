<%--
  Autor: Gerardo Saz
  Fecha: 27/4/2025
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRM - Crear Nueva Venta</title>
    <script src="https://cdn.tailwindcss.com"></script> <!-- Importando TailwindCSS desde CDN -->
    <style>
        /* Estilo adicional para ajustar el fondo y bordes */
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
    </style>
</head>

<body class="bg-gray-100 font-sans leading-normal tracking-normal">

<!-- Contenedor principal -->
<div class="container bg-white shadow-lg rounded-lg p-8 mt-8">
    <!-- Título principal -->
    <h1 class="text-3xl font-bold text-center text-indigo-600 mb-6">Car Clean</h1>

    <!-- Descripción del sistema -->
    <p class="text-lg text-gray-700 mb-4 text-center">
        Administra tus ventas de manera fácil y rápida. <br>
        Crea nuevas ventas, gestiona clientes y servicios.
    </p>

    <!-- Botón para crear una nueva venta -->
    <div class="flex justify-center">
        <div class="text-center flex items-center gap-4">
            <a href="crear-venta.jsp" class="inline-block px-8 py-3 bg-indigo-600 text-white text-lg font-semibold rounded-lg hover:bg-indigo-700">
                Crear Nueva Venta
            </a>
            <a href="reporte.jsp" class="inline-block px-8 py-3 bg-green-600 text-white text-lg font-semibold rounded-lg hover:bg-green-700">
                Reporte de servicios
            </a>
        </div>
    </div>
</div>

</body>

</html>