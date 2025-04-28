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
    <title>Crear Nueva Venta - CRM Car Clean</title>
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
    <h1 class="text-3xl font-bold text-center text-indigo-600 mb-6">Crear Nueva Venta</h1>

    <!-- Descripción -->
    <p class="text-lg text-gray-700 mb-4 text-center">
        ¿Qué desea hacer? Elija si desea crear un nuevo cliente o seleccionar uno existente para asociarlo a esta venta.
    </p>

    <!-- Opciones para crear o seleccionar cliente -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Opción para crear nuevo cliente -->
        <div class="bg-blue-100 p-6 rounded-lg text-center shadow-md">
            <h2 class="text-xl font-semibold text-blue-600 mb-4">Crear Nuevo Cliente</h2>
            <p class="text-gray-700 mb-4">Si el cliente no está registrado, puede crear uno nuevo aquí.</p>
            <a href="crear-cliente.jsp" class="inline-block px-6 py-3 bg-blue-600 text-white text-lg font-semibold rounded-lg hover:bg-blue-700">
                Crear Cliente
            </a>
        </div>

        <!-- Opción para seleccionar cliente existente -->
        <div class="bg-green-100 p-6 rounded-lg text-center shadow-md">
            <h2 class="text-xl font-semibold text-green-600 mb-4">Seleccionar Cliente Existente</h2>
            <p class="text-gray-700 mb-4">Si el cliente ya está registrado, selecciona uno de la lista.</p>
            <a href="seleccionarCliente.jsp" class="inline-block px-6 py-3 bg-green-600 text-white text-lg font-semibold rounded-lg hover:bg-green-700">
                Seleccionar Cliente
            </a>
        </div>
    </div>

    <!-- Información adicional o instrucciones -->
    <div class="mt-8 text-center">
        <p class="text-lg text-gray-600">
            Después de seleccionar o crear un cliente, podrás agregar el automotor y el servicio para completar la venta.
        </p>
    </div>
    <div class="mt-8 md:mt-10 text-center">
        <a href="index.jsp" class="text-blue-500 hover:text-blue-600 font-medium transition-colors">Volver al Inicio</a>
    </div>
</div>
</body>
</html>